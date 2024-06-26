/// <summary>
/// Codeunit AFK01 ReportEventsSubr (ID 50007).
/// </summary>
codeunit 50010 "A01 EventsSubscribers_Report"
{
    [EventSubscriber(ObjectType::Codeunit, Codeunit::ReportManagement, 'OnAfterSubstituteReport', '', false, false)]
    local procedure OnAfterSubstitute_Reports(ReportId: Integer; var NewReportId: Integer)
    begin
        if ReportId = Report::"Standard Sales - Quote" then
            NewReportId := Report::"A01 SalesQuotePrint";

        if ReportId = Report::"Standard Sales - Invoice" then
            NewReportId := Report::"A01 SalesInvoicePrint";

        if ReportId = Report::"Sales - Shipment" then
            NewReportId := Report::"A01 DeliveryNotePrint";

        // if ReportId = Report::"Transfer Order" then
        //     NewReportId := Report::"A01 TransferOrderPrint";

        if ReportId = Report::"Standard Purchase - Order" then
            NewReportId := Report::"A01 PurchaseOrderPrint";

        if ReportId = Report::"Standard Sales - Pro Forma Inv" then
            NewReportId := Report::"A01 SalesOrderPrint";

        if ReportId = Report::"Purchase - Quote" then
            NewReportId := Report::"A01 PurchaseQuotePrint";

        if ReportId = Report::"Purchase - Receipt" then
            NewReportId := Report::"A01 PurchaseReceiptPrint";

        if ReportId = Report::"Sales - Return Receipt" then
            NewReportId := Report::"A01 SalesReturnReceiptPrint";

        if ReportId = Report::"Inventory Movement" then
            NewReportId := Report::"A01 OutputStockPrint";

        if ReportId = Report::"Phys. Inventory List" then
            NewReportId := Report::"A01 InventoryListPrint";
    end;



    [EventSubscriber(ObjectType::Report, Report::"Calculate Inventory", 'OnBeforeInsertItemJnlLine', '', true, true)]
    local procedure CalculateInventoryt_OnBeforeInsertItemJnlLine(var ItemJournalLine: Record "Item Journal Line"; var InventoryBuffer: Record "Inventory Buffer")
    begin
        ItemJournalLine.Validate("Qty. (Phys. Inventory)", 0);
    end;

    //  [IntegrationEvent(false, false)]
    //     local procedure OnBeforeInsertItemJnlLine(var ItemJournalLine: Record "Item Journal Line"; var InventoryBuffer: Record "Inventory Buffer");
    //     begin
    //     end;
}