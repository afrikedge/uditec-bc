/// <summary>
/// Codeunit AFK01 TableEventsSubr (ID 50001).
/// </summary>
codeunit 50001 "A01 EventsSubscribers_Table"
{
    [EventSubscriber(ObjectType::Table, Database::"Sales Header", 'OnAfterInitRecord', '', true, true)]
    local procedure OnAfterInitRecord_SalesHeader(var SalesHeader: Record "Sales Header")
    var
        SOProcess: codeunit "A01 Sales Order Processing";
    begin
        SalesHeader."A01 User Id" := CopyStr(USERID, 1, 50);
        SOProcess.InsertNewStep(SalesHeader."No.", "A01 ActionStepHistory"::Creation, FORMAT(SalesHeader."A01 Processing Status"), '');
    end;

    [EventSubscriber(ObjectType::Table, Database::"Sales Header", 'OnDeleteOnBeforeArchiveSalesDocument', '', true, true)]
    local procedure OnDeleteOnBeforeArchiveSalesDocument_SalesHeader(var SalesHeader: Record "Sales Header"; xSalesHeader: Record "Sales Header")
    begin
        //Prevent normal deletion of order
        if not SalesHeader."A01 Allow Deletion" then
            if SalesHeader."Document Type" = SalesHeader."Document Type"::Order then
                SalesHeader.testfield("A01 Processing Status", SalesHeader."A01 Processing Status"::Draft);
    end;


}
