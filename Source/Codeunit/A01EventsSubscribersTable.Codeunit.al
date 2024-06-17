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

        ReminderLevel.Get(IssuedReminderHeader."Reminder Terms Code", IssuedReminderHeader."Reminder Level");

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


    [EventSubscriber(ObjectType::Table, Database::"Sales Header", 'OnCheckCustomerCreatedOnBeforeConfirmProcess', '', true, true)]
    local procedure SalesHeader_OnCheckCustomerCreatedOnBeforeConfirmProcess(SalesHeader: Record "Sales Header"; var Prompt: Boolean; var Result: Boolean; var IsHandled: Boolean)
    begin
        //Prevent normal deletion of order
        if (SalesHeader."A01 Web User Id" <> '') then begin
            Prompt := false;
            IsHandled := false;
        end;

    end;


    [EventSubscriber(ObjectType::Table, Database::"Contact", 'OnCreateCustomerOnBeforeCustomerModify', '', true, true)]
    local procedure SalesHeader_OnCreateCustomerOnBeforeCustomerModify(var Customer: Record Customer; Contact: Record Contact)
    var
        ScoringCriteria: Record "A01 Cust Scoring Criteria";
        CustScoring: Record "A01 Customer Scoring";
        ScoringCriteriaNew: Record "A01 Cust Scoring Criteria";
        CustScoringNew: Record "A01 Customer Scoring";
    begin

        ScoringCriteria.Reset();
        ScoringCriteria.SetRange("Account Type", ScoringCriteria."Account Type"::Prospect);
        ScoringCriteria.SetRange("Customer No.", Contact."No.");
        if ScoringCriteria.FindSet(true) then
            repeat
                ScoringCriteriaNew.Init();
                ScoringCriteriaNew.TransferFields(ScoringCriteria);
                ScoringCriteriaNew."Account Type" := ScoringCriteria."Account Type"::Customer;
                ScoringCriteriaNew."Customer No." := Customer."No.";
                ScoringCriteriaNew.insert();
            until ScoringCriteria.Next() < 1;

        CustScoring.Reset();
        CustScoring.SetRange("Account Type", CustScoring."Account Type"::Prospect);
        CustScoring.SetRange("Customer No.", Contact."No.");
        if CustScoring.FindSet(true) then
            repeat
                CustScoringNew.Init();
                CustScoringNew.TransferFields(CustScoring);
                CustScoringNew."Account Type" := CustScoring."Account Type"::Customer;
                CustScoringNew."Customer No." := Customer."No.";
                CustScoringNew.insert();
            until CustScoring.Next() < 1;

    end;

    [EventSubscriber(ObjectType::Table, Database::"Sales Line", 'OnBeforeValidateEvent', 'Prepayment %', true, true)]
    local procedure OnBeforeValidateEvent_SalesLine(var Rec: Record "Sales Line"; xRec: Record "Sales Line")
    var
        Item1: Record Item;
    begin
        if (Item1.get(Rec."No.")) then
            if (Item1."A01 Cancel Prepayment") then
                rec."Prepayment %" := 0;
    end;


    // [IntegrationEvent(false, false)]
    // local procedure OnCreateCustomerOnBeforeCustomerModify(var Customer: Record Customer; Contact: Record Contact)
    // begin
    // end;

    // [IntegrationEvent(false, false)]
    // local procedure OnCheckCustomerCreatedOnBeforeConfirmProcess(SalesHeader: Record "Sales Header"; var Prompt: Boolean; var Result: Boolean; var IsHandled: Boolean)
    // begin
    // end;


    // [EventSubscriber(ObjectType::Table, Database::"Sales Header", 'OnAfterInitPostingNoSeries', '', true, true)]
    // local procedure SalesHeader_OnAfterInitPostingNoSeries(var SalesHeader: Record "Sales Header"; xSalesHeader: Record "Sales Header")
    // var
    //     AfkSetup: Record "A01 Afk Setup";
    //     GLSetup: Record "General Ledger Setup";
    //     SalesSetup: Record "Sales & Receivables Setup";
    //     NoSeriesMgt: Codeunit NoSeriesManagement;
    // begin
    //     GLSetup.GetRecordOnce();

    //     if GLSetup."Journal Templ. Name Mandatory" then exit;

    //     if ((SalesHeader."A01 Sales Order Type" = SalesHeader."A01 Sales Order Type"::Exempt)
    //             and (SalesHeader."Document Type" = SalesHeader."Document Type"::Order)) then begin
    //         AfkSetup.GetRecordOnce();
    //         NoSeriesMgt.SetDefaultSeries(SalesHeader."Posting No. Series", AfkSetup."Exempt Post Invoices Nos");
    //         NoSeriesMgt.SetDefaultSeries(SalesHeader."Shipping No. Series", AfkSetup."Exempt Post Shipment Nos");
    //     end;
    //     if ((SalesHeader."A01 Sales Order Type" = SalesHeader."A01 Sales Order Type"::Normal)
    //             and (SalesHeader."Document Type" = SalesHeader."Document Type"::Order)) then begin
    //         SalesSetup.GetRecordOnce();
    //         NoSeriesMgt.SetDefaultSeries(SalesHeader."Posting No. Series", AfkSetup."Exempt Post Invoices Nos");
    //         NoSeriesMgt.SetDefaultSeries(SalesHeader."Shipping No. Series", AfkSetup."Exempt Post Shipment Nos");
    //     end;
    // end;

    // [IntegrationEvent(false, false)]
    //     local procedure OnAfterInitPostingNoSeries(var SalesHeader: Record "Sales Header"; xSalesHeader: Record "Sales Header")
    //     begin
    //     end;



}
