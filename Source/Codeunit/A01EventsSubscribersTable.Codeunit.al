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

    [EventSubscriber(ObjectType::Table, Database::"Issued Reminder Header", 'OnBeforePrintRecords', '', true, true)]
    local procedure OnBeforePrintRecords_IssuedReminderHeader(var IssuedReminderHeader: Record "Issued Reminder Header"; ShowRequestForm: Boolean; SendAsEmail: Boolean; HideDialog: Boolean; var IsHandled: Boolean)
    var
        DocumentSendingProfile: Record "Document Sending Profile";
        //DummyReportSelections: Record "Report Selections";
        ReminderLevel: Record "Reminder Level";
        ReminderHeader: Record "Issued Reminder Header";
        IssuedReminderHeaderToSend: Record "Issued Reminder Header";
        ReportDistributionMgt: Codeunit "Report Distribution Management";
        SuppresSendDialogQst: Label 'Do you want to suppress send dialog?';

    begin
        IsHandled := true;

        ReminderLevel.Get(IssuedReminderHeader."Reminder Level");

        if SendAsEmail then begin
            ReminderHeader.Copy(IssuedReminderHeader);
            if (not HideDialog) and (ReminderHeader.Count > 1) then
                if Confirm(SuppresSendDialogQst) then
                    HideDialog := true;
            if ReminderHeader.FindSet() then
                repeat
                    IssuedReminderHeaderToSend.Copy(IssuedReminderHeader);
                    IssuedReminderHeaderToSend.SetRecFilter();
                    DocumentSendingProfile.TrySendToEMail(
                      ReminderLevel."A01 Report Usage".AsInteger(), IssuedReminderHeaderToSend, IssuedReminderHeaderToSend.FieldNo("No."),
                      ReportDistributionMgt.GetFullDocumentTypeText(IssuedReminderHeader), IssuedReminderHeaderToSend.FieldNo("Customer No."), not HideDialog)
                until ReminderHeader.Next() = 0;
        end else
            DocumentSendingProfile.TrySendToPrinter(
              ReminderLevel."A01 Report Usage".AsInteger(), IssuedReminderHeader,
              IssuedReminderHeaderToSend.FieldNo("Customer No."), ShowRequestForm);

    end;




}
