/// <summary>
/// Codeunit A01 EventsSubscribers_Page (ID 50003).
/// </summary>
codeunit 50003 "A01 EventsSubscribers_Page"
{
    [EventSubscriber(ObjectType::Page, Page::"Report Selection - Reminder", 'OnSetUsageFilterOnAfterSetFiltersByReportUsage', '', false, false)]
    local procedure ReportSelectionReminder_OnSetUsageFilterOnAfterSetFiltersByReportUsage(var Rec: Record "Report Selections"; ReportUsage2: Enum "Report Selection Usage Reminder")
    begin
        case ReportUsage2 of
            Enum::"Report Selection Usage Reminder"::"A01 Reminder 1":
                Rec.SetRange(Usage, Enum::"Report Selection Usage"::"A01 Reminder 1");
            Enum::"Report Selection Usage Reminder"::"A01 Reminder 2":
                Rec.SetRange(Usage, Enum::"Report Selection Usage"::"A01 Reminder 2");
            Enum::"Report Selection Usage Reminder"::"A01 Reminder 3":
                Rec.SetRange(Usage, Enum::"Report Selection Usage"::"A01 Reminder 3");
        end;
    end;

    [EventSubscriber(ObjectType::Page, Page::"Report Selection - Reminder", 'OnInitUsageFilterOnElseCase', '', false, false)]
    local procedure ReportSelectionReminder_OnInitUsageFilterOnElseCase(ReportUsage: Enum "Report Selection Usage"; var ReportUsage2: Enum "Report Selection Usage Reminder")
    begin
        case ReportUsage2 of
            Enum::"Report Selection Usage"::"A01 Reminder 1":
                ReportUsage2 := ReportUsage2::"A01 Reminder 1";
            Enum::"Report Selection Usage"::"A01 Reminder 2":
                ReportUsage2 := ReportUsage2::"A01 Reminder 2";
            Enum::"Report Selection Usage"::"A01 Reminder 3":
                ReportUsage2 := ReportUsage2::"A01 Reminder 3";
        end;
    end;

    [EventSubscriber(ObjectType::Page, Page::"Navigate", 'OnAfterFindLedgerEntries', '', false, false)]
    local procedure Navigate_OnAfterFindLedgerEntries(var DocumentEntry: Record "Document Entry"; DocNoFilter: Text; PostingDateFilter: Text)
    var
        VoucherLedgEntry: Record "A01 Purchase Voucher Entry";
    begin
        if (DocNoFilter = '') and (PostingDateFilter = '') then
            exit;
        if VoucherLedgEntry.ReadPermission() then begin
            VoucherLedgEntry.Reset();
            VoucherLedgEntry.SetCurrentKey("Document No.", "Posting Date");
            VoucherLedgEntry.SetFilter("Document No.", DocNoFilter);
            VoucherLedgEntry.SetFilter("Posting Date", PostingDateFilter);
            InsertIntoDocEntry(DocumentEntry, Database::"A01 Purchase Voucher Entry", Enum::"Document Entry Document Type"::" ", VoucherLedgEntry.TableCaption(), VoucherLedgEntry.Count);
        end;
    end;

    [EventSubscriber(ObjectType::Page, Page::"Navigate", 'OnBeforeNavigateShowRecords', '', false, false)]
    local procedure Navigate_OnBeforeNavigateShowRecords(TableID: Integer; DocNoFilter: Text; PostingDateFilter: Text; ItemTrackingSearch: Boolean; var TempDocumentEntry: Record "Document Entry" temporary; var IsHandled: Boolean; var SalesInvoiceHeader: Record "Sales Invoice Header"; var SalesCrMemoHeader: Record "Sales Cr.Memo Header"; var PurchInvHeader: Record "Purch. Inv. Header"; var PurchCrMemoHdr: Record "Purch. Cr. Memo Hdr."; var ServiceInvoiceHeader: Record "Service Invoice Header"; var ServiceCrMemoHeader: Record "Service Cr.Memo Header"; var SOSalesHeader: Record "Sales Header"; var SISalesHeader: Record "Sales Header"; var SCMSalesHeader: Record "Sales Header"; var SROSalesHeader: Record "Sales Header"; var GLEntry: Record "G/L Entry"; var VATEntry: Record "VAT Entry"; var VendLedgEntry: Record "Vendor Ledger Entry"; var WarrantyLedgerEntry: Record "Warranty Ledger Entry"; var NewSourceRecVar: Variant; var SalesShipmentHeader: Record "Sales Shipment Header"; var ReturnReceiptHeader: Record "Return Receipt Header"; var ReturnShipmentHeader: Record "Return Shipment Header"; var PurchRcptHeader: Record "Purch. Rcpt. Header"; var CustLedgerEntry: Record "Cust. Ledger Entry"; var DetailedCustLedgEntry: Record "Detailed Cust. Ledg. Entry")
    var
    // VoucherLedgEntry: Record "A01 Purchase Voucher Entry";
    begin
        // case TableID of

        //     DATABASE::"A01 Purchase Voucher Entry":
        //         begin
        //             IsHandled := true;
        //             PAGE.Run(0, PaymentLineArchive);
        //         end;

        // end;
    end;

    local procedure InsertIntoDocEntry(var TempDocumentEntry: Record "Document Entry" temporary; DocTableID: Integer; DocType: Enum "Document Entry Document Type"; DocTableName: Text; DocNoOfRecords: Integer)
    begin
        if DocNoOfRecords = 0 then
            exit;

        TempDocumentEntry.Init();
        TempDocumentEntry."Entry No." := TempDocumentEntry."Entry No." + 1;
        TempDocumentEntry."Table ID" := DocTableID;
        TempDocumentEntry."Document Type" := DocType;
        TempDocumentEntry."Table Name" := CopyStr(DocTableName, 1, MaxStrLen(TempDocumentEntry."Table Name"));
        TempDocumentEntry."No. of Records" := DocNoOfRecords;
        TempDocumentEntry.Insert();
    end;



    // [IntegrationEvent(true, false)]
    //     local procedure OnBeforeNavigateShowRecords(TableID: Integer; DocNoFilter: Text; PostingDateFilter: Text; ItemTrackingSearch: Boolean; var TempDocumentEntry: Record "Document Entry" temporary; var IsHandled: Boolean; var SalesInvoiceHeader: Record "Sales Invoice Header"; var SalesCrMemoHeader: Record "Sales Cr.Memo Header"; var PurchInvHeader: Record "Purch. Inv. Header"; var PurchCrMemoHdr: Record "Purch. Cr. Memo Hdr."; var ServiceInvoiceHeader: Record "Service Invoice Header"; var ServiceCrMemoHeader: Record "Service Cr.Memo Header"; var SOSalesHeader: Record "Sales Header"; var SISalesHeader: Record "Sales Header"; var SCMSalesHeader: Record "Sales Header"; var SROSalesHeader: Record "Sales Header"; var GLEntry: Record "G/L Entry"; var VATEntry: Record "VAT Entry"; var VendLedgEntry: Record "Vendor Ledger Entry"; var WarrantyLedgerEntry: Record "Warranty Ledger Entry"; var NewSourceRecVar: Variant; var SalesShipmentHeader: Record "Sales Shipment Header"; var ReturnReceiptHeader: Record "Return Receipt Header"; var ReturnShipmentHeader: Record "Return Shipment Header"; var PurchRcptHeader: Record "Purch. Rcpt. Header"; var CustLedgerEntry: Record "Cust. Ledger Entry"; var DetailedCustLedgEntry: Record "Detailed Cust. Ledg. Entry")
    //     begin
    //     end;
}
