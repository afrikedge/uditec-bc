/// <summary>
/// Codeunit AFK01 ReportEventsSubr (ID 50007).
/// </summary>
codeunit 50007 "A01 EventsSubscribers_Report"
{
    [EventSubscriber(ObjectType::Codeunit, Codeunit::ReportManagement, 'OnAfterSubstituteReport', '', false, false)]
    local procedure OnAfterSubstituteReport_SalesQuote(ReportId: Integer; var NewReportId: Integer)
    begin
        if ReportId = Report::"Standard Sales - Quote" then
            NewReportId := Report::"A01 SalesQuotePrint";

        if ReportId = Report::"Standard Sales - Invoice" then
            NewReportId := Report::"A01 SalesInvoicePrint";

        if ReportId = Report::"Sales - Shipment" then
            NewReportId := Report::"A01 DeliveryNotePrint";

        if ReportId = Report::"Transfer Order" then
            NewReportId := Report::"A01 TransferOrderPrint";
    end;
}