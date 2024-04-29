/// <summary>
/// Codeunit AFK01 CodeEventsSubscribers (ID 50002).
/// </summary>
codeunit 50002 "A01 EventsSubscribers_Code"
{

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Item-Check Avail.", 'OnBeforeShowWarningForThisItem', '', true, true)]
    local procedure OnBeforeShowWarningForThisItem_ItemCheckAvail(Item: Record Item; var ShowWarning: Boolean; var IsHandled: Boolean)
    begin
        ShowWarning := true;
        IsHandled := true;
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Sales-Post", 'OnFinalizePostingOnBeforeDeleteApprovalEntries', '', true, true)]
    local procedure SalesPost_OnFinalizePostingOnBeforeDeleteApprovalEntries(var SalesHeader: Record "Sales Header"; var EverythingInvoiced: Boolean)
    var
        SalesOrderProcess: Codeunit "A01 Sales Order Processing";
    begin
        //Set invoice or ship status
        SalesOrderProcess.ChangeStatusOnSalesPosting(SalesHeader)
    end;



    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Sales-Post", 'OnDeleteAfterPostingOnBeforeDeleteSalesHeader', '', true, true)]
    local procedure OnDeleteAfterPostingOnBeforeDeleteSalesHeader_SalesPost(var SalesHeader: Record "Sales Header")
    var
        SalesOrderProcess: Codeunit "A01 Sales Order Processing";
        ArchiveMgt: Codeunit ArchiveManagement;
    begin
        //Set Totally invoiced status and archive
        SalesOrderProcess.SetStatusToCompletelyInvoiced(SalesHeader);
        ArchiveMgt.ArchSalesDocumentNoConfirm(SalesHeader);
    end;


    [EventSubscriber(ObjectType::Codeunit, Codeunit::"ArchiveManagement", 'OnBeforeAutoArchiveSalesDocument', '', true, true)]
    local procedure OnBeforeAutoArchiveSalesDocument_ArchiveManagement(var SalesHeader: Record "Sales Header"; var IsHandled: Boolean)
    begin
        //Desactivate Auto-archive on Sales Order
        if (SalesHeader."Document Type" = SalesHeader."Document Type"::Order) then
            IsHandled := true;
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Gen. Jnl.-Post Batch", 'OnAfterPostGenJnlLine', '', true, true)]
    local procedure OnAfterPostGenJnlLine_GenJnlPostBatch(var GenJournalLine: Record "Gen. Journal Line"; CommitIsSuppressed: Boolean; var GenJnlPostLine: Codeunit "Gen. Jnl.-Post Line"; IsPosted: Boolean; var PostingGenJournalLine: Record "Gen. Journal Line")
    var
        TresoMgt: Codeunit "A01 Treso Mgt";
    begin
        TresoMgt.A01_ProcessFeuilleReglementCCL(GenJournalLine);
    end;

    // [EventSubscriber(ObjectType::Codeunit, Codeunit::"Release Sales Document", 'OnCodeOnBeforeSetStatusReleased', '', true, true)]
    // local procedure OnCodeOnBeforeSetStatusReleased_ReleaseSalesDocument(var SalesHeader: Record "Sales Header")
    // var
    //     SalesOrderMgt: Codeunit "A01 Sales Order Processing";
    // begin
    //     if (SalesHeader.Status = SalesHeader.Status::"Pending Prepayment") then
    //         SalesOrderMgt.CheckIsDeliverable(SalesHeader);
    // end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Gen. Jnl.-Post Line", 'OnAfterApplyCustLedgEntry', '', true, true)]
    local procedure OnAfterApplyCustLedgEntry_GenJnlPostLine(var GenJnlLine: Record "Gen. Journal Line"; var NewCVLedgEntryBuf: Record "CV Ledger Entry Buffer"; var OldCustLedgEntry: Record "Cust. Ledger Entry"; NewRemainingAmtBeforeAppln: Decimal)
    var
        PostedSalesH: Record "Sales Invoice Header";
        SalesHeader: Record "Sales Header";
        SalesOrderMgt: Codeunit "A01 Sales Order Processing";

    begin
        // if (PostedSalesH.Get(GenJournalLine."Document No.")) then
        //     if (PostedSalesH."Prepayment Invoice") then
        //         if (SalesHeader.Get(SalesHeader."Document Type"::Order, PostedSalesH."Order No.")) then
        //             if (SalesHeader.Status = SalesHeader.Status::"Pending Prepayment") then
        //                 SalesOrderMgt.CheckIsAwaitingPrepayment(SalesHeader);
        if (OldCustLedgEntry.Prepayment) then
            if (OldCustLedgEntry."Document Type" = OldCustLedgEntry."Document Type"::Invoice) then
                if (PostedSalesH.Get(OldCustLedgEntry."Document No.")) then
                    if (PostedSalesH."Prepayment Invoice") then
                        if (SalesHeader.Get(SalesHeader."Document Type"::Order, PostedSalesH."Prepayment Order No.")) then
                            if (SalesHeader.Status = SalesHeader.Status::"Pending Prepayment") then
                                SalesOrderMgt.CheckIsDeliverable(SalesHeader);
    end;



    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Sales-Post", 'OnAfterPostGLAndCustomer', '', true, true)]
    local procedure OnAfterPostGLAndCustomer_SalesPost(var SalesHeader: Record "Sales Header"; var GenJnlPostLine: Codeunit "Gen. Jnl.-Post Line"; TotalSalesLine: Record "Sales Line"; TotalSalesLineLCY: Record "Sales Line"; CommitIsSuppressed: Boolean;
        WhseShptHeader: Record "Warehouse Shipment Header"; WhseShip: Boolean; var TempWhseShptHeader: Record "Warehouse Shipment Header"; var SalesInvHeader: Record "Sales Invoice Header"; var SalesCrMemoHeader: Record "Sales Cr.Memo Header";
        var CustLedgEntry: Record "Cust. Ledger Entry"; var SrcCode: Code[10]; GenJnlLineDocNo: Code[20]; GenJnlLineExtDocNo: Code[35]; var GenJnlLineDocType: Enum "Gen. Journal Document Type"; PreviewMode: Boolean; DropShipOrder: Boolean)
    var
        TresoMgt: Codeunit "A01 Treso Mgt";

    begin
        TresoMgt.PostBalancingEntries(SalesHeader, GenJnlLineDocNo, GenJnlLineExtDocNo, SrcCode, GenJnlPostLine);
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Sales-Post", 'OnBeforeRunPostCustomerEntry', '', true, true)]
    local procedure OnBeforeRunPostCustomerEntry_SalesPost(var SalesHeader: Record "Sales Header"; var TotalSalesLine2: Record "Sales Line"; var TotalSalesLineLCY2: Record "Sales Line"; CommitIsSuppressed: Boolean; PreviewMode: Boolean; DocType: Enum "Gen. Journal Document Type"; DocNo: Code[20]; ExtDocNo: Code[35]; SourceCode: Code[10]; var GenJnlPostLine: Codeunit "Gen. Jnl.-Post Line"; var IsHandled: Boolean)
    var
        TresoMgt: Codeunit "A01 Treso Mgt";
    begin
        TresoMgt.PostMultiDeadlinesPaymentLines(SalesHeader, TotalSalesLine2, TotalSalesLineLCY2, CommitIsSuppressed, PreviewMode, DocType, DocNo, ExtDocNo, SourceCode, GenJnlPostLine, IsHandled);
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Sales-Post", 'OnBeforeSalesInvHeaderInsert', '', true, true)]
    local procedure OnBeforeSalesInvHeaderInsert_SalesPost(var SalesInvHeader: Record "Sales Invoice Header"; var SalesHeader: Record "Sales Header"; CommitIsSuppressed: Boolean; var IsHandled: Boolean; WhseShip: Boolean; WhseShptHeader: Record "Warehouse Shipment Header"; InvtPickPutaway: Boolean)
    var
        TresoMgt: Codeunit "A01 Treso Mgt";
    begin
        if (TresoMgt.IsMultiMeadlinesInvoice(SalesHeader)) then
            SalesInvHeader."External Document No." := SalesInvHeader."No.";
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Gen. Jnl.-Post Line", 'OnAfterRunWithCheck', '', true, true)]
    local procedure GenJnlPostLine_OnAfterRunWithCheck(var GenJnlLine: Record "Gen. Journal Line")
    var
        TresoMgt: Codeunit "A01 Treso Mgt";
        VoucherMgt: Codeunit "A01 Voucher Mgt";
    begin
        TresoMgt.ConfirmGenerationOnInterestOnCreditDue(GenJnlLine);
        VoucherMgt.PostVoucherConsumption(GenJnlLine);
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Sales-Quote to Order", 'OnAfterCreateSalesHeader', '', true, true)]
    local procedure SalesQuoteToOrder_OnAfterCreateSalesHeader(var SalesOrderHeader: Record "Sales Header"; SalesHeader: Record "Sales Header")
    var
        TresoMgt: Codeunit "A01 Treso Mgt";
    begin
        TresoMgt.TransferCreditDueLinesFromQuoteToOrder(SalesOrderHeader, SalesHeader);
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Item Jnl.-Check Line", 'OnBeforeCheckLocation', '', true, true)]
    local procedure ItemJnlCheckLine_OnBeforeCheckLocation(var ItemJournalLine: Record "Item Journal Line"; var IsHandled: Boolean)
    var
        SecMgt: Codeunit "A01 Security Mgt";
    begin
        SecMgt.CheckWharehouseUser(ItemJournalLine);
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Gen. Jnl.-Check Line", 'OnBeforeCheckAccountNo', '', true, true)]
    local procedure GenJnlCheckLine_OnBeforeCheckAccountNo(var GenJnlLine: Record "Gen. Journal Line"; var CheckDone: Boolean)
    var
        SecMgt: Codeunit "A01 Security Mgt";
    begin
        SecMgt.ChecksOnBeforePosting(GenJnlLine);
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"User Setup Management", 'OnBeforeIsPostingDateValidWithSetup', '', true, true)]
    local procedure UserSetupManagement_OnBeforeIsPostingDateValidWithSetup(PostingDate: Date; var Result: Boolean; var IsHandled: Boolean; var SetupRecordID: RecordID)
    var
        UserSetup: Record "User Setup";
        GLSetup: Record "General Ledger Setup";
        GLPeriodUserGroup: Record "A01 GL Period User Group";
        AllowPostingFrom: Date;
        AllowPostingTo: Date;
    begin
        if UserId <> '' then
            if UserSetup.Get(UserId) then begin
                UserSetup.CheckAllowedPostingDates(1);
                AllowPostingFrom := UserSetup."Allow Posting From";
                AllowPostingTo := UserSetup."Allow Posting To";
                SetupRecordID := UserSetup.RecordId;
            end;

        if (AllowPostingFrom = 0D) and (AllowPostingTo = 0D) then begin
            if UserId <> '' then
                if UserSetup.Get(UserId) then begin
                    if GLPeriodUserGroup.Get(UserSetup."A01 GL Period Group") then begin
                        GLPeriodUserGroup.CheckAllowedPostingDates(1);
                        AllowPostingFrom := GLPeriodUserGroup."Allow Posting From";
                        AllowPostingTo := GLPeriodUserGroup."Allow Posting To";
                        SetupRecordID := GLPeriodUserGroup.RecordId;
                    end;
                end;
        end;

        if (AllowPostingFrom = 0D) and (AllowPostingTo = 0D) then begin
            GLSetup.GetRecordOnce();
            GLSetup.CheckAllowedPostingDates(1);
            AllowPostingFrom := GLSetup."Allow Posting From";
            AllowPostingTo := GLSetup."Allow Posting To";
            SetupRecordID := GLSetup.RecordId;
        end;
        if AllowPostingTo = 0D then
            AllowPostingTo := DMY2Date(31, 12, 9999);

        Result := (PostingDate in [AllowPostingFrom .. AllowPostingTo]);
        IsHandled := true;
    end;


    //[EventSubscriber(ObjectType::Codeunit, Codeunit::"Item Jnl.-Post Line", 'OnAfterInsertValueEntry', '', true, true)]
    // local procedure ItemJnlPostLine_OnAfterInsertValueEntry(var ValueEntry: Record "Value Entry"; ItemJournalLine: Record "Item Journal Line"; var ItemLedgerEntry: Record "Item Ledger Entry"; var ValueEntryNo: Integer)
    // var
    //     VoucherMgt: Codeunit "A01 Voucher Mgt";
    // begin
    //     //ItemLedgerEntry.CalcFields("Sales Amount (Actual)");
    //     //ItemLedgerEntry.TestField("Sales Amount (Actual)");
    //     VoucherMgt.PostVoucherEmission(ItemLedgerEntry, Abs(ValueEntry."Sales Amount (Actual)"));
    // end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Item Jnl.-Post Line", 'OnBeforeInsertValueEntry', '', true, true)]
    local procedure ItemJnlPostLine_OnBeforeInsertValueEntry(var ValueEntry: Record "Value Entry"; ItemJournalLine: Record "Item Journal Line"; var ItemLedgerEntry: Record "Item Ledger Entry"; var ValueEntryNo: Integer; var InventoryPostingToGL: Codeunit "Inventory Posting To G/L"; CalledFromAdjustment: Boolean; var OldItemLedgEntry: Record "Item Ledger Entry"; var Item: Record Item; TransferItem: Boolean; var GlobalValueEntry: Record "Value Entry")
    var
        VoucherMgt: Codeunit "A01 Voucher Mgt";
    begin
        //ItemLedgerEntry.CalcFields("Sales Amount (Actual)");
        //ItemLedgerEntry.TestField("Sales Amount (Actual)");
        VoucherMgt.PostVoucherEmission(ItemLedgerEntry, InventoryPostingToGL, Abs(ValueEntry."Sales Amount (Actual)"));
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Sales-Post Prepayment (Yes/No)", 'OnPostPrepmtInvoiceYNOnBeforeConfirm', '', true, true)]
    local procedure SalesPostPrepaymentYesNo_OnPostPrepmtInvoiceYNOnBeforeConfirm(var SalesHeader: Record "Sales Header"; var IsHandled: Boolean)
    var
    begin
        IsHandled := true;
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Sales-Post (Yes/No)", 'OnBeforeConfirmSalesPost', '', true, true)]
    local procedure SalesPostYesNo_OnBeforeConfirmSalesPost(var SalesHeader: Record "Sales Header"; var IsHandled: Boolean)
    var
        SalesOrderValidation: Codeunit "A01 Sales Order Processing";
    begin
        SalesOrderValidation.CheckCanPostSalesOrder(SalesHeader);
    end;

    // [IntegrationEvent(false, false)]
    // local procedure OnBeforeConfirmSalesPost(var SalesHeader: Record "Sales Header"; var HideDialog: Boolean; var IsHandled: Boolean; var DefaultOption: Integer; var PostAndSend: Boolean)
    // begin
    // end;


    //    [IntegrationEvent(false, false)]
    //     local procedure OnPostPrepmtInvoiceYNOnBeforeConfirm(var SalesHeader: Record "Sales Header"; var IsHandled: Boolean);
    //     begin
    //     end;

}
