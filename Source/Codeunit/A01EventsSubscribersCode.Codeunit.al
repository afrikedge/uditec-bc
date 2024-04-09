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

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Sales-Post", 'OnAfterUpdateAfterPosting', '', true, true)]
    local procedure OnAfterUpdateAfterPosting_SalesPost(var SalesHeader: Record "Sales Header"; var TempSalesLine: Record "Sales Line" temporary)
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

    // [Obsolete('Moved to Sales Invoice Posting implementation. Use the new event OnBeforePostLedgerEntry in codeunit 825 "Sales Post Invoice Events".', '19.0')]
    // [IntegrationEvent(false, false)]
    // local procedure OnBeforeRunPostCustomerEntry(var SalesHeader: Record "Sales Header"; var TotalSalesLine2: Record "Sales Line"; var TotalSalesLineLCY2: Record "Sales Line"; CommitIsSuppressed: Boolean; PreviewMode: Boolean; DocType: Enum "Gen. Journal Document Type"; DocNo: Code[20]; ExtDocNo: Code[35]; SourceCode: Code[10]; var GenJnlPostLine: Codeunit "Gen. Jnl.-Post Line"; var IsHandled: Boolean)
    // begin
    // end;










}
