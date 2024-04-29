/// <summary>
/// Codeunit AFK01 Sales Order Processing (ID 50000).
/// </summary>
codeunit 50000 "A01 Sales Order Processing"
{
    TableNo = "Sales Header";

    trigger OnRun()
    begin
        case Rec."A01 Processing Status" of

            Rec."A01 Processing Status"::Draft:
                begin
                    Selection := dialog.StrMenu(LblAction01, 1);
                    if Selection = 0 then exit;
                    if Selection = 1 then ValidateDraft(Rec);
                    if Selection = 2 then DeleteDraft(Rec);
                    exit;
                end;


            Rec."A01 Processing Status"::"Stock out":
                begin
                    Selection := dialog.StrMenu(LblOptionsValidateStock, 1);
                    if Selection = 0 then exit;
                    if Selection = 1 then CheckIsOutOfStock(Rec);
                    if Selection = 2 then SetStatusToDraft(Rec);
                    exit;
                end;

            Rec."A01 Processing Status"::"Waiting for prepayment":
                begin
                    Selection := dialog.StrMenu(LblOptionsValidatePrepayment, 1);
                    if Selection = 0 then exit;
                    if Selection = 1 then CheckIsAwaitingPrepayment(Rec);
                    if Selection = 2 then SetStatusToDraft(Rec);
                    exit;
                end;


            Rec."A01 Processing Status"::"Blocked",
             Rec."A01 Processing Status"::"Waiting for delivery":
                begin
                    Selection := dialog.StrMenu(LblOptionsCancel, 1);
                    if Selection = 0 then exit;
                    if Selection = 1 then CancelSalesOrder(Rec);
                    exit;
                end;

            Rec."A01 Processing Status"::"Partially shipped", Rec."A01 Processing Status"::"Totally shipped",
            Rec."A01 Processing Status"::"Partially invoiced":
                begin
                    Selection := dialog.StrMenu(LblOptionsClose, 1);
                    if Selection = 0 then exit;
                    if Selection = 1 then CloseSalesOrder(Rec);
                    exit;
                end;

        end;

    end;


    var
        ArchiveManagement: Codeunit ArchiveManagement;
        Selection: Integer;
        LblAction01: Label '&Send for processing,&Delete order';
        QstDeleteDraft: Label 'The order will be deleted. Do you want to continue ?';
        QstCancelledOrder: Label 'Do you want to cancel order %1. \If yes, the order will no longer be processed.', Comment = '%1=Order No';
        ErrOnCancelledOrder: Label 'The order can no longer be canceled because it has already been delivered';
        ErrOnCloseOrder_Qty: Label 'You cannot close this order because the quantity delivered has not been completely invoiced for item %1', Comment = '%1=Item No';
        QstSetAsDraft: label 'The order will be returned for edition. Do you want to continue ?';
        ErrDocumentStatusOnValidation: Label 'The document is not at a status where it can be validated.';
        LblOptionsValidateStock: Label '&Check inventory,&Resend to edition';
        LblOptionsValidatePrepayment: Label '&Check prepayment,&Resend to edition';
        LblOptionsCancel: Label '&Cancel order';
        LblOptionsClose: Label '&Close order';


    /// <summary>
    /// ValidateDraft.
    /// </summary>
    /// <param name="SalesH">Record "Sales Header".</param>
    procedure ValidateDraft(var SalesH: Record "Sales Header")
    begin
        SalesH.TestField("Sell-to Customer No.");
        //SalesH.TestField("Ship-to Code");
        //SalesH.TestField("Shipment Method Code");
        //SalesH.TestField("Requested Delivery Date");
        //SalesH.TestField("Currency Code");
        SalesH.TestField("Order Date");
        CheckLocaltionOnLines(SalesH);

        CheckIsOutOfStock(SalesH)

    end;

    local procedure CheckIsOutOfStock(var SalesH: Record "Sales Header")
    var
        isTotallyOutOfStock: Boolean;
    begin
        if IsOutOfStock(SalesH, isTotallyOutOfStock) then begin
            if ((SalesH."A01 Processing Status" <> SalesH."A01 Processing Status"::"Stock out") and
            (SalesH."A01 Processing Status" <> SalesH."A01 Processing Status"::"Partially out of stock")) then begin

                if (isTotallyOutOfStock) then begin
                    SalesH."A01 Processing Status" := SalesH."A01 Processing Status"::"Stock out";
                    InsertNewStep(SalesH."No.", "A01 ActionStepHistory"::"Change Status", FORMAT(SalesH."A01 Processing Status"::"Stock out"), '');
                end else begin
                    SalesH."A01 Processing Status" := SalesH."A01 Processing Status"::"Partially out of stock";
                    InsertNewStep(SalesH."No.", "A01 ActionStepHistory"::"Change Status", FORMAT(SalesH."A01 Processing Status"::"Partially out of stock"), '');
                end;
                SalesH.Modify();
            end;
        end else
            CheckIsBlocked(SalesH);
    end;

    local procedure CheckIsBlocked(var SalesH: Record "Sales Header")
    begin
        if IsOutOfCreditLimit(SalesH) then begin
            if (SalesH."A01 Processing Status" <> SalesH."A01 Processing Status"::"Blocked") then begin
                SalesH."A01 Processing Status" := SalesH."A01 Processing Status"::Blocked;
                SalesH.Modify();

                InsertNewStep(SalesH."No.", "A01 ActionStepHistory"::"Change Status", FORMAT(SalesH."A01 Processing Status"::Blocked), '');
            end;
        end else
            CheckIsAwaitingPrepayment(SalesH);
    end;

    procedure SetIsWaitingForDiscount(var SalesH: Record "Sales Header")
    var
        ErrLab01: label 'Order document %1 has no lines', Comment = '%1=rr';
    begin
        if (not LineExists(SalesH)) then
            Error(ErrLab01, SalesH."No.");
        SalesH.TestField("Sell-to Customer No.");
        SalesH."A01 Processing Status" := SalesH."A01 Processing Status"::"Waiting for discount";
        InsertNewStep(SalesH."No.", "A01 ActionStepHistory"::"Change Status", FORMAT(SalesH."A01 Processing Status"::"Waiting for discount"), '');
        SalesH.Modify();
    end;

    /// <summary>
    /// NeedPrepayment.
    /// </summary>
    /// <param name="SalesH">Record "Sales Header".</param>
    /// <returns>Return value of type Boolean.</returns>
    procedure CheckIsAwaitingPrepayment(var SalesH: Record "Sales Header")
    var
    begin
        if NeedPrepayment(SalesH) then begin
            if (SalesH."A01 Processing Status" <> SalesH."A01 Processing Status"::"Waiting for prepayment") then begin
                PostPrePayment(SalesH);
                SalesH."A01 Processing Status" := SalesH."A01 Processing Status"::"Waiting for prepayment";
                InsertNewStep(SalesH."No.", "A01 ActionStepHistory"::"Change Status", FORMAT(SalesH."A01 Processing Status"::"Waiting for prepayment"), '');
                SalesH.Modify();
            end;
        end else
            CheckIsDeliverable(SalesH);
    end;

    local procedure NeedPrepayment(SalesH: Record "Sales Header"): Boolean
    var
        PrepaymentMgt: Codeunit "Prepayment Mgt.";
    begin
        if PrepaymentMgt.TestSalesPrepayment(SalesH) then
            exit(true);
        if PrepaymentMgt.TestSalesPayment(SalesH) then
            exit(true);
    end;

    local procedure IsOutOfStock(SalesH: Record "Sales Header"; var isTotally: Boolean): Boolean
    var
        SalesL: Record "Sales Line";
        ItemCheckAvail: Codeunit "Item-Check Avail.";
        outOfStock: boolean;
    begin
        isTotally := true;
        SalesL.SetRange(SalesL."Document Type", SalesH."Document Type");
        SalesL.SetRange(SalesL."Document No.", SalesH."No.");
        if SalesL.FindSet() then
            repeat
                if (SalesL.Type = SalesL.Type::Item) then begin
                    if ItemCheckAvail.SalesLineShowWarning(SalesL) then
                        outOfStock := true
                    else
                        isTotally := false;
                end;
            until SalesL.Next() < 1;
        exit(outOfStock);
    end;

    local procedure DeleteDraft(var SalesH: Record "Sales Header")
    var
        ReleaseMgt: Codeunit "Release Sales Document";
    begin
        if not confirm(StrSubstNo(QstDeleteDraft)) then
            exit;

        ReleaseMgt.PerformManualReopen(SalesH);

        InsertNewStep(SalesH."No.", "A01 ActionStepHistory"::Deletion, FORMAT(SalesH."A01 Processing Status"::Draft), '');

        ArchiveManagement.ArchSalesDocumentNoConfirm(SalesH);

        SalesH.Delete(true);
    end;

    local procedure IsOutOfCreditLimit(SalesH: Record "Sales Header"): Boolean
    var
        CheckCreditLimit: Page "Check Credit Limit";
    begin
        exit(CheckCreditLimit.SalesHeaderShowWarning(SalesH));
    end;

    local procedure CheckLocaltionOnLines(SalesH: Record "Sales Header"): Boolean
    var
        SalesL: Record "Sales Line";
        DocumentErrorsMgt: Codeunit "Document Errors Mgt.";
    begin
        SalesL.SetRange(SalesL."Document Type", SalesH."Document Type");
        SalesL.SetRange(SalesL."Document No.", SalesH."No.");
        if (SalesL.IsEmpty) then
            Error(DocumentErrorsMgt.GetNothingToPostErrorMsg());
        if SalesL.FindSet() then
            repeat
                if (SalesL.Type <> SalesL.Type::" ") then
                    SalesL.TestField("Unit Price");
                if (SalesL.Type = SalesL.Type::Item) then begin
                    SalesL.TestField("Location Code");
                    SalesL.TestField(Quantity);
                end;

            until SalesL.Next() < 1;
    end;

    /// <summary>
    /// CheckIsDeliverable.
    /// </summary>
    /// <param name="SalesH">VAR Record "Sales Header".</param>
    procedure CheckIsDeliverable(var SalesH: Record "Sales Header")
    begin
        SalesH."A01 Processing Status" := SalesH."A01 Processing Status"::"Waiting for delivery";
        SalesH.Modify();
        InsertNewStep(SalesH."No.", "A01 ActionStepHistory"::"Change Status", format(SalesH."A01 Processing Status"::"Waiting for delivery"), '');
    end;

    /// <summary>
    /// ChangeStatusOnSalesPosting.
    /// </summary>
    /// <param name="SalesH">VAR Record "Sales Header".</param>
    procedure CancelSalesOrder(var SalesH: Record "Sales Header")
    var
        ReleaseMgt: Codeunit "Release Sales Document";
        SecurityMgt: Codeunit "A01 Security Mgt";
    begin

        SecurityMgt.CheckIfUserCanCancelSalesOrder();

        if not confirm(StrSubstNo(QstCancelledOrder, SalesH."No.")) then exit;
        if ShippedLineExists(SalesH) then Error(ErrOnCancelledOrder);


        ReleaseMgt.PerformManualReopen(SalesH);
        SalesH."A01 Processing Status" := SalesH."A01 Processing Status"::Cancelled;
        SalesH.Modify();

        InsertNewStep(SalesH."No.", "A01 ActionStepHistory"::"Change Status", format(SalesH."A01 Processing Status"::Cancelled), '');

        ArchiveManagement.ArchSalesDocumentNoConfirm(SalesH);

        //SalesH.AFK_AllowDeletion(TRUE);//TODO check here for deletion
        SalesH."A01 Allow Deletion" := true;
        SalesH.Delete(true);
    end;

    /// <summary>
    /// CloseSalesOrder.
    /// </summary>
    /// <param name="SalesH">VAR Record "Sales Header".</param>
    procedure CloseSalesOrder(var SalesH: Record "Sales Header")
    var
        SalesLine: record "Sales Line";
        ReleaseMgt: Codeunit "Release Sales Document";
        SecurityMgt: Codeunit "A01 Security Mgt";
    begin

        SecurityMgt.CheckIfUserCanCloseSalesOrder();

        ReleaseMgt.PerformManualReopen(SalesH);

        SalesLine.Reset();
        SalesLine.SetRange("Document Type", SalesLine."Document Type"::Order);
        SalesLine.SetRange("Document No.", SalesH."No.");
        if SalesLine.FindSet() then
            repeat

                if SalesLine."Quantity Invoiced" <> SalesLine."Quantity Shipped" then
                    Error(ErrOnCloseOrder_Qty, SalesLine."No.");

                SalesLine.Validate(Quantity, SalesLine."Quantity Shipped");
                SalesLine.Modify();

            UNTIL SalesLine.Next() = 0;


        SalesH."A01 Processing Status" := SalesH."A01 Processing Status"::Closed;
        SalesH.Modify();
        InsertNewStep(SalesH."No.", "A01 ActionStepHistory"::"Change Status", FORMAT(SalesH."A01 Processing Status"::Closed), '');

        ArchiveManagement.ArchSalesDocumentNoConfirm(SalesH);

        //SalesH.AFK_AllowDeletion(TRUE); TODO Check here
        SalesH."A01 Allow Deletion" := true;
        SalesH.Delete(true);
    end;

    /// <summary>
    /// CheckCanPostSalesOrder.
    /// </summary>
    /// <param name="SalesH">Record "Sales Header".</param>
    procedure CheckCanPostSalesOrder(SalesH: Record "Sales Header")
    begin

        if SalesH."Document Type" <> SalesH."Document Type"::Order then
            exit;

        if not (SalesH."A01 Processing Status" in [SalesH."A01 Processing Status"::"Waiting for delivery",
          SalesH."A01 Processing Status"::"Totally shipped", SalesH."A01 Processing Status"::"Partially invoiced",
          SalesH."A01 Processing Status"::"Partially shipped"]) then
            Error(ErrDocumentStatusOnValidation);
    end;

    /// <summary>
    /// ChangeStatusOnSalesPosting.
    /// </summary>
    /// <param name="SalesH">VAR Record "Sales Header".</param>
    procedure ChangeStatusOnSalesPosting(var SalesH: Record "Sales Header")
    begin
        SalesH.CalcFields("Completely Shipped");
        if SalesH.InvoicedLineExists() then begin
            SalesH."A01 Processing Status" := SalesH."A01 Processing Status"::"Partially invoiced";
            SalesH.Modify();
            InsertNewStepShipOrInvoice(SalesH."No.", Format(SalesH."A01 Processing Status"::"Partially invoiced"),
                SalesH."Last Posting No.", SalesH."Last Shipping No.", SalesH.Invoice, SalesH.Ship);
        end else
            if SalesH."Completely Shipped" then begin
                SalesH."A01 Processing Status" := SalesH."A01 Processing Status"::"Totally shipped";
                SalesH.Modify();
                InsertNewStepShipOrInvoice(SalesH."No.", Format(SalesH."A01 Processing Status"::"Totally shipped"),
                SalesH."Last Posting No.", SalesH."Last Shipping No.", SalesH.Invoice, SalesH.Ship);
            end else
                if ShippedLineExists(SalesH) then begin
                    SalesH."A01 Processing Status" := SalesH."A01 Processing Status"::"Partially shipped";
                    SalesH.Modify();
                    InsertNewStepShipOrInvoice(SalesH."No.", Format(SalesH."A01 Processing Status"::"Partially shipped"),
                    SalesH."Last Posting No.", SalesH."Last Shipping No.", SalesH.Invoice, SalesH.Ship);
                end;
    end;

    local procedure ShippedLineExists(SalesH: Record "Sales Header"): Boolean
    var
        SalesLine: Record "Sales Line";
    begin
        SalesLine.Reset();
        SalesLine.SetRange("Document Type", SalesH."Document Type");
        SalesLine.SetRange("Document No.", SalesH."No.");
        SalesLine.SetFilter(Type, '<>%1', SalesLine.Type::" ");
        SalesLine.SetFilter("Quantity Shipped", '<>%1', 0);
        exit(not SalesLine.IsEmpty);
    end;

    local procedure LineExists(SalesH: Record "Sales Header"): Boolean
    var
        SalesLine: Record "Sales Line";
    begin
        SalesLine.Reset();
        SalesLine.SetRange("Document Type", SalesH."Document Type");
        SalesLine.SetRange("Document No.", SalesH."No.");
        exit(not SalesLine.IsEmpty);
    end;

    /// <summary>
    /// InsertNewStepShipOrInvoice.
    /// </summary>
    /// <param name="SalesH">VAR Record "Sales Header".</param>
    procedure SetStatusToCompletelyInvoiced(var SalesH: Record "Sales Header")
    begin
        SalesH."A01 Processing Status" := SalesH."A01 Processing Status"::"Totally invoiced";
        SalesH.Modify();
        InsertNewStepShipOrInvoice(SalesH."No.", Format(SalesH."A01 Processing Status"::"Totally invoiced"), SalesH."Last Posting No.",
          SalesH."Last Shipping No.", SalesH.Invoice, SalesH.Ship);
    end;

    /// <summary>
    /// SetStatusToDraft.
    /// </summary>
    /// <param name="SalesH">VAR Record "Sales Header".</param>
    /// <returns>Return value of type Boolean.</returns>
    procedure CanUpdateOrderHeaderAfterValidation(SalesH: Record "Sales Header"): Boolean
    var
        UserSetup: record "User Setup";
    begin
        if SalesH."A01 Processing Status" in [SalesH."A01 Processing Status"::Draft,
        SalesH."A01 Processing Status"::"Partially out of stock",
        SalesH."A01 Processing Status"::"Stock out"] then
            exit(true);

        if UserSetup.Get(UserId) then
            exit(UserSetup."A01 CanUpdateSalesOrderVal");
    end;

    /// <summary>
    /// CanUpdateOrderLineAfterValidation.
    /// </summary>
    /// <param name="SalesH">Record "Sales Header".</param>
    /// <returns>Return value of type Boolean.</returns>
    procedure CanUpdateOrderLineAfterValidation(SalesH: Record "Sales Header"): Boolean
    var
        SecurityMgt: Codeunit "A01 Security Mgt";
    begin
        if SalesH."A01 Processing Status" in [SalesH."A01 Processing Status"::Draft,
        SalesH."A01 Processing Status"::"Partially out of stock",
        SalesH."A01 Processing Status"::"Stock out"] then
            exit(true);

        exit(SecurityMgt.CheckIfUserCanUpdateOrderAfterValidation());
    end;


    local procedure SetStatusToDraft(var SalesH: Record "Sales Header")
    begin
        SalesH.TestField(SalesH."A01 Return Reason");
        if not Confirm(StrSubstNo(QstSetAsDraft)) then exit;
        SalesH."A01 Processing Status" := SalesH."A01 Processing Status"::Draft;
        SalesH.Modify();

        InsertNewStep(SalesH."No.", "A01 ActionStepHistory"::"Change Status", format(SalesH."A01 Processing Status"::Draft), '');
    end;

    local procedure InsertNewStepShipOrInvoice(OrderNo: Code[20]; NewStatus: Text[50]; InvoiceDocument: Code[20]; ShipmentDocument: Code[20]; Invoice: Boolean; Ship: Boolean)
    begin
        if ((Ship) and (ShipmentDocument <> '')) then
            InsertNewStep(OrderNo, "A01 ActionStepHistory"::Ship, NewStatus, ShipmentDocument);

        if ((Invoice) and (InvoiceDocument <> '')) then
            InsertNewStep(OrderNo, "A01 ActionStepHistory"::Invoice, NewStatus, InvoiceDocument);
    end;

    /// <summary>
    /// InsertNewStep.
    /// </summary>
    /// <param name="OrderNo">Code[20].</param>
    /// <param name="Action">Enum "AFK01 ActionStepHistory".</param>
    /// <param name="NewStatus">Text[50].</param>
    /// <param name="CreatedDocument">Code[20].</param>
    procedure InsertNewStep(OrderNo: Code[20]; Action: Enum "A01 ActionStepHistory"; NewStatus: Text[50]; CreatedDocument: Code[20])
    var
        StepEntry: Record "A01 Document Step History";
        NextStepId: Integer;
    begin
        StepEntry.SetRange("Document Type", StepEntry."Document Type"::"Sales Order");
        StepEntry.SetRange(StepEntry."Document No.", OrderNo);
        if StepEntry.FindLast() then
            NextStepId := StepEntry."Step ID" + 1
        ELSE
            NextStepId := 1;

        StepEntry.Init();
        StepEntry."Document Type" := StepEntry."Document Type"::"Sales Order";
        StepEntry."Document No." := OrderNo;
        StepEntry."Step ID" := NextStepId;
        StepEntry.Action := Action;
        StepEntry."New Status" := NewStatus;
        StepEntry."Created Document" := CreatedDocument;
        StepEntry."User ID" := CopyStr(UserId, 1, 50);
        StepEntry."Action Date" := CREATEDATETIME(TODAY, TIME);
        StepEntry.Insert();
    end;

    procedure ChangePostingNosSeries(var SalesHeader: Record "Sales Header")
    var
        AfkSetup: Record "A01 Afk Setup";
        GLSetup: Record "General Ledger Setup";
        SalesSetup: Record "Sales & Receivables Setup";
        NoSeriesMgt: Codeunit NoSeriesManagement;
    begin
        GLSetup.GetRecordOnce();
        if GLSetup."Journal Templ. Name Mandatory" then exit;

        if ((SalesHeader."A01 Sales Order Type" = SalesHeader."A01 Sales Order Type"::Exempt)
                and (SalesHeader."Document Type" = SalesHeader."Document Type"::Order)) then begin
            AfkSetup.GetRecordOnce();
            NoSeriesMgt.SetDefaultSeries(SalesHeader."Posting No. Series", AfkSetup."Exempt Post Invoices Nos");
            NoSeriesMgt.SetDefaultSeries(SalesHeader."Shipping No. Series", AfkSetup."Exempt Post Shipment Nos");
        end;
        if ((SalesHeader."A01 Sales Order Type" = SalesHeader."A01 Sales Order Type"::Normal)
                and (SalesHeader."Document Type" = SalesHeader."Document Type"::Order)) then begin
            SalesSetup.GetRecordOnce();
            NoSeriesMgt.SetDefaultSeries(SalesHeader."Posting No. Series", SalesSetup."Posted Invoice Nos.");
            NoSeriesMgt.SetDefaultSeries(SalesHeader."Shipping No. Series", SalesSetup."Posted Shipment Nos.");
        end;
    end;

    local procedure PostPrePayment(var SalesHeader: Record "Sales Header")
    var
        SalesPostYNPrepmt: Codeunit "Sales-Post Prepayment (Yes/No)";
    begin
        SalesPostYNPrepmt.PostPrepmtInvoiceYN(SalesHeader, false);
    end;

    procedure CheckCanPostGL()
    var
        myInt: Integer;
    begin

    end;

}
