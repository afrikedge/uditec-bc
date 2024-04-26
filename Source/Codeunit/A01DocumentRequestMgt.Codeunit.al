/// <summary>
/// Codeunit A01 Document Request Mgt (ID 50016).
/// </summary>
codeunit 50016 "A01 Document Request Mgt"
{
    var
        LblDescrDiscount: label 'Discount request';
        LblDescrUnblocking: label 'Unblocking request';
        LblDescrPayment: label 'Payment to validate';
        LblDescrPOSPayment: label 'Payment at POS to be validated';

    procedure AddDiscountRequest(var SalesHeader: Record "Sales Header"; RequestedDiscount: Decimal;
    WebUser: Text; Status: Enum "A01 Approval Status"): Code[20]
    var
        RequestHdr: Record "A01 Request On Document";
        ValidationOrder: Codeunit "A01 Sales Order Processing";
    begin
        RequestHdr.Init();
        if (SalesHeader."Document Type" = SalesHeader."Document Type"::Quote) then
            RequestHdr.Validate("Request Type", RequestHdr."Request Type"::"Discount on quote");
        if (SalesHeader."Document Type" = SalesHeader."Document Type"::Order) then
            RequestHdr.Validate("Request Type", RequestHdr."Request Type"::"Discount on order");
        RequestHdr.Validate("Request No.", SalesHeader."No.");
        RequestHdr.Validate("Customer No.", SalesHeader."Sell-to Customer No.");
        RequestHdr.Validate("Sales Person", SalesHeader."Salesperson Code");
        RequestHdr.Validate("Requested Discount (%)", RequestedDiscount);
        RequestHdr.Object := LblDescrDiscount;
        RequestHdr."Created By" := CopyStr(WebUser, 1, 50);
        RequestHdr.Status := Status;
        RequestHdr.Insert(true);


        ValidationOrder.SetIsWaitingForDiscount(SalesHeader);

        SalesHeader."A01 Request Status" := Status;
        SalesHeader.Modify();


        exit(RequestHdr."Request No.");
    end;

    procedure AddUnBlockingRequest(var SalesHeader: Record "Sales Header"; WebUser: Text; Status: Enum "A01 Approval Status"): Code[20]
    var
        Request: Record "A01 Request On Document";
    begin
        SalesHeader.TestField("A01 Processing Status", SalesHeader."A01 Processing Status"::Blocked);
        Request.Init();
        Request.Validate("Request Type", Request."Request Type"::Unblocking);
        Request.Validate("Request No.", SalesHeader."No.");
        Request.Validate("Customer No.", SalesHeader."Sell-to Customer No.");
        Request.Validate("Sales Person", SalesHeader."Salesperson Code");
        Request.Object := LblDescrUnblocking;
        Request."Created By" := CopyStr(WebUser, 1, 50);
        Request.Status := Status;
        Request.Insert(true);

        SalesHeader."A01 Request Status" := Status;
        SalesHeader.Modify();

        exit(Request."Request No.");
    end;

    procedure AddPOSPaymentRequest(var SalesHeader: Record "Sales Header"; WebUser: Text; Status: Enum "A01 Approval Status"): Code[20]
    var
        Request: Record "A01 Request On Document";
    begin

        CheckPOSPaymentOnCreation(SalesHeader);

        Request.Init();
        Request.Validate("Request Type", Request."Request Type"::"POS Payment");
        Request.Validate("Request No.", SalesHeader."No.");
        Request.Validate("Customer No.", SalesHeader."Sell-to Customer No.");
        Request.Validate("Sales Person", SalesHeader."Salesperson Code");
        Request.Object := LblDescrPOSPayment;
        Request."Created By" := CopyStr(WebUser, 1, 50);
        Request.Status := Status;
        Request.Insert(true);

        SalesHeader."A01 Request Status" := Status;
        SalesHeader.Modify();

        exit(Request."Request No.");
    end;

    procedure AddPaymentRequest(var PaymentDoc: Record "A01 Payment Document")
    var
        Request: Record "A01 Request On Document";
    begin

        CheckDocPaymentOnCreation(PaymentDoc);

        Request.Init();
        Request.Validate("Request Type", Request."Request Type"::"Payment Document");
        Request.Validate("Request No.", PaymentDoc."No.");
        Request.Validate("Customer No.", PaymentDoc."Partner No.");
        //Request.Validate("Sales Person",SalesHeader."Salesperson Code");
        Request.Object := LblDescrPayment;
        Request.Status := Request.Status::"Waiting for committee";
        Request.Insert(true);

        //TODO Set Status here
        PaymentDoc."Approval Status" := Request.Status;
        PaymentDoc.Modify();

    end;

    procedure ModifyStatus(var Request: Record "A01 Request On Document"; WebUser: Text;
    NewStatus: Enum "A01 Approval Status"): Code[20]
    var
        SalesOrder: Record "Sales Header";
        PayDoc: Record "A01 Payment Document";
    begin

        Request.Status := NewStatus;
        Request."Modified By" := CopyStr(WebUser, 1, 50);
        Request.Modify();

        if ((Request."Request Type" = Request."Request Type"::"Discount on order")
         or (Request."Request Type" = Request."Request Type"::"Discount on quote")
         or (Request."Request Type" = Request."Request Type"::"POS Payment")) then begin
            SalesOrder.get(Request."Request No.");
            SalesOrder."A01 Request Status" := NewStatus;
            SalesOrder.Modify();
        end;

        if (Request."Request Type" = Request."Request Type"::"Payment Document") then begin
            PayDoc.get(Request."Request No.");
            PayDoc."Approval Status" := NewStatus;
            PayDoc.Modify();
        end;

        if (Request.Status = Request.Status::Validated) then
            CloseRequest(Request);

        exit(Request."Request No.");
    end;

    local procedure CloseRequest(var Request: Record "A01 Request On Document")
    var
        SalesOrder: Record "Sales Header";
        Salesline: Record "Sales Line";
        POSPaymentLine: Record "A01 Sales Payment Method";
        PaymentLine: Record "A01 Payment Document Line";
        OrderValidationMgt: codeunit "A01 Sales Order Processing";
    begin
        case Request."Request Type" of
            Request."Request Type"::"Discount on order":
                begin
                    SalesOrder.get(SalesOrder."Document Type"::Order, Request."Request No.");

                    Salesline.Reset();
                    Salesline.SetRange("Document Type", SalesOrder."Document Type");
                    Salesline.SetRange("Document No.", Salesline."No.");
                    if Salesline.FindSet(true) then
                        repeat
                            if (Salesline.Type <> Salesline.Type::" ") then
                                Salesline.Validate(Salesline."Line Discount %", Request."Validated Discount (%)");
                        until Salesline.Next() < 1;

                    OrderValidationMgt.ValidateDraft(SalesOrder);

                end;

            Request."Request Type"::"Discount on quote":
                begin
                    SalesOrder.get(SalesOrder."Document Type"::Quote, Request."Request No.");

                    Salesline.Reset();
                    Salesline.SetRange("Document Type", SalesOrder."Document Type");
                    Salesline.SetRange("Document No.", Salesline."No.");
                    if Salesline.FindSet(true) then
                        repeat
                            if (Salesline.Type <> Salesline.Type::" ") then
                                Salesline.Validate(Salesline."Line Discount %", Request."Validated Discount (%)");
                        until Salesline.Next() < 1;
                end;

            Request."Request Type"::"Payment Document":

                begin
                    PaymentLine.Reset();
                    PaymentLine.SetRange(PaymentLine."Document No.", Request."Request No.");
                    if POSPaymentLine.FindSet(true) then
                        repeat
                            if (PaymentLine."Validated Amount" <> PaymentLine.Amount) then begin
                                PaymentLine.Validate("Validated Amount", PaymentLine.Amount);
                                PaymentLine.Modify();
                            end;
                        until PaymentLine.Next() < 1;
                end;

            Request."Request Type"::"POS Payment":
                begin
                    SalesOrder.get(SalesOrder."Document Type"::Order, Request."Request No.");

                    POSPaymentLine.Reset();
                    POSPaymentLine.SetRange(POSPaymentLine."Document Type", POSPaymentLine."Document Type"::Order);
                    POSPaymentLine.SetRange(POSPaymentLine."Document No.", SalesOrder."No.");
                    if POSPaymentLine.FindSet(true) then
                        repeat
                            if (POSPaymentLine."Validated Amount" <> POSPaymentLine.Amount) then begin
                                POSPaymentLine.Validate("Validated Amount", POSPaymentLine.Amount);
                                POSPaymentLine.Modify();
                            end;
                        until POSPaymentLine.Next() < 1;
                end;
            Request."Request Type"::Unblocking:
                begin

                end;
            else
                Error('Unknown Type');
        end;
    end;

    local procedure PayNeedsValidation(PayHeader: Record "A01 Payment Document"): Boolean
    var
        PayLine: Record "A01 Payment Document Line";
    begin
        PayLine.Reset();
        PayLine.SetRange("Document No.", PayHeader."No.");
        if PayLine.FindSet() then
            repeat
                if (PayLine.Amount <> PayLine."Validated Amount") then
                    exit(true);
            until PayLine.Next() < 1;
    end;

    local procedure POSPaymentNeedsValidation(Salesheader: Record "Sales Header"): Boolean
    var
        PayLine: Record "A01 Sales Payment Method";
    begin
        PayLine.Reset();
        PayLine.SetRange(PayLine."Document Type", Salesheader."Document Type");
        PayLine.SetRange("Document No.", Salesheader."No.");
        if PayLine.FindSet() then
            repeat
                if (PayLine.Amount <> PayLine."Validated Amount") then
                    exit(true);
            until PayLine.Next() < 1;
    end;

    local procedure CheckDocPaymentOnCreation(PayHeader: Record "A01 Payment Document")
    var
        ErrLbl01: Label 'The amount to validate does not exist on this document';
    begin
        if (not PayNeedsValidation(PayHeader)) then
            Error(ErrLbl01);
    end;

    local procedure CheckPOSPaymentOnCreation(Salesheader: Record "Sales Header")
    var
        ErrLbl01: Label 'The amount to validate does not exist on this document';
    begin
        if (not POSPaymentNeedsValidation(Salesheader)) then
            Error(ErrLbl01);
    end;

    procedure CheckSameRequestAlreadyExists(OriginDoc: Record "A01 Request On Document")
    var
        Request: Record "A01 Request On Document";
        LblAnotherRecExists: label 'A pending request already exists for this document';
    begin
        Request.SetRange("Request Type", OriginDoc."Request Type");
        Request.SetRange("Request No.", OriginDoc."Request No.");
        if Request.FindSet() then
            repeat
                if (Request.IsOnHold()) then
                    Error(LblAnotherRecExists);
            until Request.Next() < 1;
    end;

    procedure CheckIfValidationRequestExists(PayDoc: Record "A01 Payment Document")
    var
        Request: Record "A01 Request On Document";
        LblAnotherRecExists: label 'A pending request already exists for this document';
    begin
        Request.SetRange("Request Type", Request."Request Type"::"Payment Document");
        Request.SetRange("Request No.", PayDoc."No.");
        if Request.FindSet() then
            repeat
                if (Request.IsOnHold()) then
                    Error(LblAnotherRecExists);
            until Request.Next() < 1;
    end;

    procedure CheckIfValidationRequestExists(SalesHeader: Record "Sales Header")
    var
        Request: Record "A01 Request On Document";
        LblAnotherRecExists02: label 'A pending request already exists for this document';
    begin
        Request.SetRange("Request Type", Request."Request Type"::"POS Payment");
        Request.SetRange("Request No.", SalesHeader."No.");
        if Request.FindSet() then
            repeat
                if (Request.IsOnHold()) then
                    Error(LblAnotherRecExists02);
            until Request.Next() < 1;
    end;

}