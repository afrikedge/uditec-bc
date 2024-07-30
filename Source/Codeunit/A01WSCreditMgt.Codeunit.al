/// <summary>
/// Codeunit A01 WS Credit Mgt (ID 50011).
/// </summary>
codeunit 50011 "A01 WS Credit Mgt"
{
    var
        WS: codeunit "A01 Api Mgt";

    /// <summary>
    /// ModifyRemindder.
    /// </summary>
    /// <param name="input">JsonObject.</param>
    /// <param name="IsDeletion">Boolean.</param>
    /// <returns>Return value of type Text.</returns>
    procedure RunRecoveryActivities(input: JsonObject; IsDeletion: Boolean): Text
    var
        NoOrder: text;
    begin
        NoOrder := ws.GetText('No_', input);
        if (NoOrder <> '') then begin

            if (IsDeletion) then
                exit(DeleteReminder(NoOrder))
            else
                exit(ModifyRemindder(NoOrder, input))

        end else
            exit(AddReminder(input));
    end;

    /// <summary>
    /// RunReposessionRequest.
    /// </summary>
    /// <param name="input">JsonObject.</param>
    /// <param name="IsDeletion">Boolean.</param>
    /// <returns>Return value of type Text.</returns>
    procedure RunReposessionRequest(input: JsonObject; IsDeletion: Boolean): Text
    var
        NoOrder: text;
    begin
        NoOrder := ws.GetText('No_', input);
        if (NoOrder <> '') then begin

            if (IsDeletion) then
                exit(DeleteReposession(NoOrder))
            else
                exit(ModifyReposession(NoOrder, input))

        end else
            exit(AddReposession(input));
    end;

    /// <summary>
    /// RunRPaymentPromise.
    /// </summary>
    /// <param name="input">JsonObject.</param>
    /// <param name="IsDeletion">Boolean.</param>
    /// <returns>Return value of type Text.</returns>
    procedure RunRPaymentPromise(input: JsonObject; IsDeletion: Boolean): Text
    var
        NoOrder: text;
    begin
        NoOrder := ws.GetText('No_', input);
        if (NoOrder <> '') then begin

            if (IsDeletion) then
                exit(DeletePaymentPromise(NoOrder))
            else
                exit(ModifyPaymentPromise(NoOrder, input))

        end else
            exit(AddPaymentPromise(input));
    end;






    local procedure ModifyRemindder(OrderNo: Text; input: JsonObject): Text
    var
        Reminder: Record "Reminder Header";
    //ReminderLine: Record "Reminder Line";
    begin

        Reminder.Get(OrderNo);

        ProcessReminderHeader(Reminder, input);

        //processReminderLines(Reminder, ReminderLine, input);

        exit(Ws.CreateResponseSuccess(Reminder."No."));

    end;

    local procedure AddReminder(input: JsonObject): Text
    var
        Reminder: Record "Reminder Header";
        ReminderLine: Record "Reminder Line";
    begin

        Reminder.Init();
        Reminder."No." := '';

        ReminderLine.LockTable();
        Reminder.Insert(true);

        ProcessReminderHeader(Reminder, input);

        processReminderLines(Reminder, input);

        exit(Ws.CreateResponseSuccess(Reminder."No."));

    end;

    local procedure DeleteReminder(OrderNo: Text): Text
    var
        Reminder: Record "Reminder Header";
    begin

        Reminder.Get(OrderNo);

        Reminder.Delete(true);

        exit(Ws.CreateResponseSuccess(Reminder."No."));

    end;

    local procedure processReminderLines(Reminder: Record "Reminder Header"; input: JsonObject)
    var
        ReminderLine1: Record "Reminder Line";
        ReminderLine: Record "Reminder Line";
        c: JsonToken;
        LinesArray: JsonArray;
        LineInput: JsonObject;
    begin
        ReminderLine1.Reset();
        ReminderLine1.SetRange("Reminder No.", Reminder."No.");
        if (not ReminderLine1.IsEmpty) then
            ReminderLine1.DeleteAll();

        input.Get('RecoveryActivityLine', c);
        LinesArray := c.AsArray();
        foreach c in LinesArray do begin
            LineInput := c.AsObject();
            ReminderLine.Init();
            processReminderLine(Reminder, ReminderLine, LineInput);
        end;
    end;

    local procedure ProcessReminderHeader(var Reminder: Record "Reminder Header"; input: JsonObject)
    begin

        if (Reminder."A01 Web User Id" <> WS.GetText('webUserName', input)) then
            Reminder.Validate("A01 Web User Id", WS.GetText('webUserName', input));

        if (Reminder."Customer No." <> WS.GetText('Customer No_', input)) then
            Reminder.Validate("Customer No.", WS.GetText('Customer No_', input));

        if (Reminder.Name <> WS.GetText('Name', input)) then
            Reminder.Validate("Name", WS.GetText('Name', input));

        if (Reminder."A01 Activity Type".AsInteger() <> WS.GetInt('Activity Type', input)) then
            Reminder.Validate("A01 Activity Type", WS.GetInt('Activity Type', input));

        if (Reminder."A01 Subject" <> WS.GetText('Subject', input)) then
            Reminder.Validate("A01 Subject", WS.GetText('Subject', input));

        if (Reminder."A01 Description" <> WS.GetText('Description', input)) then
            Reminder.Validate("A01 Description", WS.GetText('Description', input));

        if (Reminder."A01 Expected Start Datetime" <> WS.GetDateTime('Scheduled Start Date', input)) then
            Reminder.Validate("A01 Expected Start Datetime", WS.GetDateTime('Scheduled Start Date', input));

        if (Reminder."A01 Expected End Datetime" <> WS.GetDateTime('Scheduled End Date', input)) then
            Reminder.Validate("A01 Expected End Datetime", WS.GetDateTime('Scheduled End Date', input));

        if (Reminder."A01 Actual Start Datetime" <> WS.GetDateTime('Actual Start Date', input)) then
            Reminder.Validate("A01 Actual Start Datetime", WS.GetDateTime('Actual Start Date', input));

        if (Reminder."A01 Actual Start Datetime" <> WS.GetDateTime('Actual End Date', input)) then
            Reminder.Validate("A01 Actual Start Datetime", WS.GetDateTime('Actual End Date', input));

        if (Reminder."A01 Actual End Datetime" <> WS.GetDateTime('Actual End Date', input)) then
            Reminder.Validate("A01 Actual End Datetime", WS.GetDateTime('Actual End Date', input));

        if (Reminder."A01 Reminder Datetime" <> WS.GetDateTime('Reminder Date', input)) then
            Reminder.Validate("A01 Reminder Datetime", WS.GetDateTime('Reminder Date', input));

        if (Reminder."A01 Related activity" <> WS.GetText('Linked Activity', input)) then
            Reminder.Validate("A01 Related activity", WS.GetText('Linked Activity', input));

        if (Reminder."A01 Activity Status".AsInteger() <> WS.GetInt('Activity Status', input)) then
            Reminder.Validate("A01 Activity Status", WS.GetInt('Activity Status', input));

        if (Reminder."A01 Observations" <> WS.GetText('Comment', input)) then
            Reminder.Validate("A01 Observations", WS.GetText('Comment', input));

        if (Reminder."A01 Assignment No." <> WS.GetText('Assignment No_', input)) then
            Reminder.Validate("A01 Assignment No.", WS.GetText('Assignment No_', input));

        if (Reminder."A01 Created By" <> WS.GetText('Created by', input)) then
            Reminder.Validate("A01 Created By", WS.GetText('Created by', input));

        if (Reminder."Reminder Level" <> WS.GetInt('Activity Level', input)) then
            Reminder.Validate("Reminder Level", WS.GetInt('Activity Level', input));

        if WS.KeyExists('Activity Feedback', input) then
            if (Reminder."A01 Activity Feedback" <> WS.GetText('Activity Feedback', input)) then
                Reminder.Validate("A01 Activity Feedback", WS.GetText('Activity Feedback', input));

        if WS.KeyExists('Feedback Description', input) then
            if (Reminder."A01 Feedback Description" <> WS.GetText('Feedback Description', input)) then
                Reminder.Validate("A01 Feedback Description", WS.GetText('Feedback Description', input));



        Reminder.Modify();
    end;

    local procedure processReminderLine(Reminder: Record "Reminder Header"; var ReminderLine: Record "Reminder Line"; input: JsonObject)
    begin

        if (ReminderLine."Reminder No." <> Reminder."No.") then
            ReminderLine."Reminder No." := Reminder."No.";

        if (ReminderLine."Line No." <> WS.GetInt('Line No_', input)) then
            ReminderLine."Line No." := WS.GetInt('Line No_', input);

        ReminderLine.Type := ReminderLine.Type::"Customer Ledger Entry";


        if (ReminderLine."Document Type".AsInteger() <> WS.GetInt('Document Type', input)) then
            ReminderLine.Validate("Document Type", WS.GetInt('Document Type', input));

        if (ReminderLine."Document No." <> WS.GetText('Document No_', input)) then
            ReminderLine.Validate("Document No.", Copystr(WS.GetText('Document No_', input), 1, 20));

        // if (ReminderLine."Posting Date" <> WS.GetDate('Posting Date', input)) then
        //     ReminderLine."Posting Date" := WS.GetDate('Posting Date', input);

        // if (ReminderLine."Due Date" <> WS.GetDate('Due Date', input)) then
        //     ReminderLine."Due Date" := WS.GetDate('Due Date', input);

        // if (ReminderLine."Document Date" <> WS.GetDate('Document Date', input)) then
        //     ReminderLine."Document Date" := WS.GetDate('Document Date', input);

        if (ReminderLine.Description <> WS.GetText('Description', input)) then
            ReminderLine."Description" := Copystr(WS.GetText('Description', input), 1, 100);

        // if (ReminderLine."Original Amount" <> WS.GetDecimal('Original Amount', input)) then
        //     ReminderLine."Original Amount" := WS.GetDecimal('Original Amount', input);

        // if (ReminderLine."Remaining Amount" <> WS.GetDecimal('Document Date', input)) then
        //     ReminderLine."Remaining Amount" := WS.GetDecimal('Document Date', input);

        if (ReminderLine."A01 Debt Status" <> WS.GetText('Debt Status', input)) then
            ReminderLine."A01 Debt Status" := Copystr(WS.GetText('Debt Status', input), 1, 20);

        if WS.KeyExists('Sales Code', input) then
            if (ReminderLine."A01 Sales Mode" <> WS.GetText('Sales Code', input)) then
                ReminderLine.Validate("A01 Sales Mode", WS.GetText('Sales Code', input));

        if WS.KeyExists('Store Code', input) then
            if (ReminderLine."A01 Sales Store" <> WS.GetText('Store Code', input)) then
                ReminderLine.Validate("A01 Sales Store", WS.GetText('Store Code', input));


        if WS.KeyExists('Amount Due', input) then
            if (ReminderLine."A01 Amount Due" <> WS.getdecimal('Amount Due', input)) then
                ReminderLine.Validate("A01 Amount Due", WS.getdecimal('Amount Due', input));

        if WS.KeyExists('Installment', input) then
            if (ReminderLine."A01 Installment" <> WS.getdecimal('Installment', input)) then
                ReminderLine.Validate("A01 Installment", WS.getdecimal('Installment', input));



        ReminderLine.insert(true);
    end;




    local procedure ModifyReposession(OrderNo: Text; input: JsonObject): Text
    var
        Reminder: Record "A01 Reposession Request";
    begin

        Reminder.Get(OrderNo);

        ProcessReposessionHeader(Reminder, input);

        exit(Ws.CreateResponseSuccess(Reminder."No."));

    end;

    local procedure AddReposession(input: JsonObject): Text
    var
        Reminder: Record "A01 Reposession Request";
    begin

        Reminder.Init();
        Reminder."No." := '';

        Reminder.Insert(true);

        ProcessReposessionHeader(Reminder, input);

        exit(Ws.CreateResponseSuccess(Reminder."No."));

    end;

    local procedure DeleteReposession(OrderNo: Text): Text
    var
        Reminder: Record "A01 Reposession Request";
    begin

        Reminder.Get(OrderNo);

        Reminder.Delete(true);

        exit(Ws.CreateResponseSuccess(Reminder."No."));

    end;

    local procedure ProcessReposessionHeader(var Repossession: Record "A01 Reposession Request"; input: JsonObject)
    begin

        if (Repossession."Modified By" <> WS.GetText('webUserName', input)) then
            Repossession.Validate("Modified By", WS.GetText('webUserName', input));

        if (Repossession."Customer No." <> WS.GetText('Customer No_', input)) then
            Repossession.Validate("Customer No.", WS.GetText('Customer No_', input));

        if (Repossession."Created By" = '') then
            Repossession.Validate("Created By", WS.GetText('webUserName', input));

        if (Repossession."Document No." <> WS.GetText('Document No_', input)) then
            Repossession.Validate("Document No.", WS.GetText('Document No_', input));

        if (Repossession."Item No." <> WS.GetText('Item No_', input)) then
            Repossession.Validate("Item No.", WS.GetText('Item No_', input));

        if (Repossession."Serial Number" <> WS.GetText('Serial No_', input)) then
            Repossession.Validate("Serial Number", WS.GetText('Serial No_', input));

        if (Repossession.Origin.AsInteger() <> WS.GetInt('Reposs Source', input)) then
            Repossession.Validate("Origin", WS.GetInt('Reposs Source', input));

        //if (Reminder. <> WS.GetText('Created by', input)) then
        //    Reminder.Validate("A01 Description", WS.GetText('Created by', input));

        if (Repossession.Reason <> WS.GetText('Motivation', input)) then
            Repossession.Validate(Reason, WS.GetText('Motivation', input));

        if (Repossession."Acceptance Status".AsInteger() <> WS.GetInt('Reposs Status', input)) then
            Repossession.Validate("Acceptance Status", WS.GetInt('Reposs Status', input));

        if (Repossession."Reposession Type".AsInteger() <> WS.GetInt('Reposs Type', input)) then
            Repossession.Validate("Reposession Type", WS.GetInt('Reposs Type', input));

        if (Repossession."Reposession Item Status".AsInteger() <> WS.GetInt('Reposs Item Status', input)) then
            Repossession.Validate("Reposession Item Status", WS.GetInt('Reposs Item Status', input));

        if (Repossession."Document Ref." <> WS.GetText('Document Ref.', input)) then
            Repossession.Validate("Document Ref.", WS.GetText('Document Ref.', input));

        if (Repossession."Item Value" <> WS.GetDecimal('Value', input)) then
            Repossession.Validate("item Value", WS.GetDecimal('Value', input));


        Repossession.Modify();
    end;






    local procedure ModifyPaymentPromise(OrderNo: Text; input: JsonObject): Text
    var
        Reminder: Record "A01 Payment Promise";
    begin

        Reminder.Get(OrderNo);

        ProcessPaymentPromise(Reminder, input);

        exit(Ws.CreateResponseSuccess(Reminder."No."));

    end;

    local procedure AddPaymentPromise(input: JsonObject): Text
    var
        Reminder: Record "A01 Payment Promise";
    begin

        Reminder.Init();
        Reminder."No." := '';

        Reminder.Insert(true);

        ProcessPaymentPromise(Reminder, input);

        exit(Ws.CreateResponseSuccess(Reminder."No."));

    end;

    local procedure DeletePaymentPromise(OrderNo: Text): Text
    var
        Reminder: Record "A01 Payment Promise";
    begin

        Reminder.Get(OrderNo);

        Reminder.Delete(true);

        exit(Ws.CreateResponseSuccess(Reminder."No."));

    end;

    local procedure ProcessPaymentPromise(var PaymentPromise: Record "A01 Payment Promise"; input: JsonObject)
    begin

        if (PaymentPromise."Modified By" <> WS.GetText('webUserName', input)) then
            PaymentPromise.Validate("Modified By", WS.GetText('webUserName', input));

        if (PaymentPromise."Created By" = '') then
            PaymentPromise.Validate("Created By", WS.GetText('webUserName', input));

        if (PaymentPromise.Object <> WS.GetText('Subject', input)) then
            PaymentPromise.Validate("Object", WS.GetText('Subject', input));

        if (PaymentPromise."Customer No." <> WS.GetText('Customer No_', input)) then
            PaymentPromise.Validate("Customer No.", WS.GetText('Customer No_', input));

        if (PaymentPromise."Contact No." <> WS.GetText('Contact No_', input)) then
            PaymentPromise.Validate("Contact No.", WS.GetText('Contact No_', input));

        if (PaymentPromise.Description <> WS.GetText('Description', input)) then
            PaymentPromise.Validate("Description", WS.GetText('Description', input));

        if (PaymentPromise."Promise Date" <> WS.GetDate('Promise Date', input)) then
            PaymentPromise.Validate("Promise Date", WS.GetDate('Promise Date', input));

        if (PaymentPromise."Followed by" <> WS.GetText('Assigned to', input)) then
            PaymentPromise.Validate("Followed by", WS.GetText('Assigned to', input));

        if (PaymentPromise."Amount promised" <> WS.GetDecimal('Promised amount', input)) then
            PaymentPromise.Validate("Amount promised", WS.GetDecimal('Promised amount', input));

        if (PaymentPromise."Amount honored" <> WS.GetDecimal('Honored amount', input)) then
            PaymentPromise.Validate("Amount honored", WS.GetDecimal('Honored amount', input));

        if (PaymentPromise.Origin <> WS.GetText('Originated activity', input)) then
            PaymentPromise.Validate("Origin", WS.GetText('Originated activity', input));

        if (PaymentPromise."Reminder".AsInteger() <> WS.GetInt('Activity Type', input)) then
            PaymentPromise.Validate("Reminder", WS.GetInt('Activity Type', input));

        if (PaymentPromise."Reminder date" <> WS.GetDate('Riminding Date', input)) then
            PaymentPromise.Validate("Reminder date", WS.GetDate('Riminding Date', input));

        if (PaymentPromise."Reminder deadline" <> WS.GetDate('Reminding Due Date', input)) then
            PaymentPromise.Validate("Reminder deadline", WS.GetDate('Reminding Due Date', input));

        if (PaymentPromise.Status.AsInteger() <> WS.GetInt('Promise Status', input)) then
            PaymentPromise.Validate("Status", WS.GetInt('Promise Status', input));

        if (PaymentPromise."Honoration Date" <> WS.GetDate('Honoration Date', input)) then
            PaymentPromise.Validate("Honoration Date", WS.GetDate('Honoration Date', input));

        if (PaymentPromise.Observations <> WS.GetText('Observations', input)) then
            PaymentPromise.Validate("Observations", WS.GetText('Observations', input));





        PaymentPromise.Modify();
    end;

}
