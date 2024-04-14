/// <summary>
/// Codeunit A01WSMasterFilesMgt (ID 50015).
/// </summary>
codeunit 50015 A01WSMasterFilesMgt
{
    var
        WS: codeunit "A01 Api Mgt";
        AddOnSetup: record "A01 Afk Setup";

    /// <summary>
    /// RunCustomers.
    /// </summary>
    /// <param name="input">JsonObject.</param>
    /// <param name="IsDeletion">Boolean.</param>
    /// <returns>Return value of type Text.</returns>
    procedure RunCustomers(input: JsonObject; IsDeletion: Boolean): Text
    var
        RecNo: text;
    //ToDelete: Boolean;
    begin
        //input.ReadFrom(inputJson);
        RecNo := ws.GetText('No_', input);
        if (RecNo <> '') then begin

            //ToDelete := ws.GetBool('IsDeletion', input);
            if (IsDeletion) then
                exit(DeleteCustomer(RecNo))
            else
                exit(ModifyCustomer(RecNo, input))

        end else
            exit(AddCustomer(input));
    end;

    /// <summary>
    /// RunLeads.
    /// </summary>
    /// <param name="input">JsonObject.</param>
    /// <param name="IsDeletion">Boolean.</param>
    /// <returns>Return value of type Text.</returns>
    procedure RunLeads(input: JsonObject; IsDeletion: Boolean): Text
    var
        RecNo: text;
    //ToDelete: Boolean;
    begin
        //input.ReadFrom(inputJson);
        RecNo := ws.GetText('No_', input);
        if (RecNo <> '') then begin

            //ToDelete := ws.GetBool('IsDeletion', input);
            if (IsDeletion) then
                exit(DeleteLead(RecNo))
            else
                exit(ModifyLead(RecNo, input))

        end else
            exit(AddLead(input));
    end;

    /// <summary>
    /// ModifyCustomer.
    /// </summary>
    /// <param name="input">JsonObject.</param>
    /// <param name="IsDeletion">Boolean.</param>
    /// <returns>Return value of type Text.</returns>
    procedure RunContacts(input: JsonObject; IsDeletion: Boolean): Text
    var
        RecNo: text;
    begin
        RecNo := ws.GetText('No_', input);
        if (RecNo <> '') then begin
            if (IsDeletion) then
                exit(DeleteContact(RecNo))
            else
                exit(ModifyContact(RecNo, input))

        end else
            exit(AddContact(input));
    end;

    /// <summary>
    /// RunCreditContracts.
    /// </summary>
    /// <param name="input">JsonObject.</param>
    /// <param name="IsDeletion">Boolean.</param>
    /// <returns>Return value of type Text.</returns>
    procedure RunCreditContracts(input: JsonObject; IsDeletion: Boolean): Text
    var
        RecNo: text;
    begin
        RecNo := ws.GetText('No_', input);
        if (RecNo <> '') then begin
            if (IsDeletion) then
                exit(DeleteCreditContract(RecNo))
            else
                exit(ModifyCreditContract(RecNo, input))

        end else
            exit(AddCreditContract(input));
    end;

    procedure RunShipToAddress(input: JsonObject; IsDeletion: Boolean): Text
    var
        RecNo: text;
        CustNo: text;
    begin
        RecNo := ws.GetText('No_', input);
        CustNo := ws.GetText('Customer No_', input);
        if (RecNo <> '') then begin
            if (IsDeletion) then
                exit(DeleteShipToAddress(CustNo, RecNo))
            else
                exit(ModifyShipToAddress(CustNo, RecNo, input))

        end else
            exit(AddShipToAddress(CustNo, input));
    end;

    #region Customers

    local procedure ModifyCustomer(CustNo: Text; input: JsonObject): Text
    var
        Cust: Record "Customer";
    // CustRequirement: Record "A01 Cust Scoring Requirement";
    // CustScoring: Record "A01 Customer Scoring";
    begin

        Cust.Get(CustNo);

        ProcessCustomer(Cust, input);

        processCustomerRequirements(Cust, input);

        processCustomerScorings(Cust, input);

        exit(Ws.CreateResponseSuccess(Cust."No."));

    end;

    local procedure AddCustomer(input: JsonObject): Text
    var
        Cust: Record "Customer";
    begin

        Cust.Init();
        Cust."No." := '';

        //SalesOrderLine.LockTable();
        Cust.Insert(true);

        ProcessCustomer(Cust, input);

        processCustomerRequirements(Cust, input);

        processCustomerScorings(Cust, input);

        exit(Ws.CreateResponseSuccess(Cust."No."));

    end;

    local procedure DeleteCustomer(CustNo: Text): Text
    var
        Cust: Record "Customer";
    begin

        Cust.Get(CustNo);

        Cust.Delete(true);

        exit(Ws.CreateResponseSuccess(Cust."No."));

    end;

    local procedure ProcessCustomer(var Cust: Record "Customer"; input: JsonObject)
    begin

        if (Cust."A01 Created By" = '') then
            Cust.Validate("A01 Created By", WS.GetText('webUserName', input));

        if (Cust."A01 Modified By" <> WS.GetText('webUserName', input)) then
            Cust.Validate("A01 Modified By", WS.GetText('webUserName', input));

        if (Cust."Name" <> WS.GetText('Name', input)) then
            Cust.Validate("Name", WS.GetText('Name', input));

        if (Cust."Search Name" <> WS.GetText('Search Name', input)) then
            Cust.Validate("Search Name", WS.GetText('Search Name', input));

        if (Cust."A01 Customer Type".AsInteger() <> WS.GetInt('Customer Type', input)) then
            Cust.Validate("A01 Customer Type", WS.GetInt('Customer Type', input));

        if (Cust."A01 Legal Status".AsInteger() <> WS.GetInt('Legal Status', input)) then
            Cust.Validate("A01 Legal Status", WS.GetInt('Legal Status', input));

        if (Cust."A01 Identification Mode".AsInteger() <> WS.GetInt('Identification Mode', input)) then
            Cust.Validate("A01 Identification Mode", WS.GetInt('Identification Mode', input));

        // if (Cust."Location Code" <> WS.GetText('saleOrderLocationCode', input)) then
        //     Cust.Validate("Location Code", WS.GetText('saleOrderLocationCode', input));

        if (Cust."Address" <> WS.GetText('Address', input)) then
            Cust.Validate("Address", WS.GetText('Address', input));

        if (Cust."Address 2" <> WS.GetText('Address 2', input)) then
            Cust.Validate("Address 2", WS.GetText('Address 2', input));

        if (Cust."Post Code" <> WS.GetText('Post Code', input)) then
            Cust.Validate("Post Code", WS.GetText('Post Code', input));

        if (Cust."City" <> WS.GetText('City', input)) then
            Cust.Validate("City", WS.GetText('City', input));

        if (Cust."Phone No." <> WS.GetText('Phone No_', input)) then
            Cust.Validate("Phone No.", WS.GetText('Phone No_', input));

        if (Cust."Home Page" <> WS.GetText('Home Page', input)) then
            Cust.Validate("Home Page", WS.GetText('Home Page', input));

        if (Cust."A01 Parent Customer" <> WS.GetText('Parent Account No_', input)) then
            Cust.Validate("A01 Parent Customer", WS.GetText('Parent Account No_', input));

        if (Cust."A01 Allowed Item Category" <> WS.GetText('Item Category', input)) then
            Cust.Validate("A01 Allowed Item Category", WS.GetText('Item Category', input));

        if (Cust."A01 Allowed Item Category" <> WS.GetText('Primary Contact No_', input)) then
            Cust.Validate("A01 Allowed Item Category", WS.GetText('Primary Contact No_', input));

        if (Cust."A01 Preferred Reminder Mode".AsInteger() <> WS.GetInt('Activity Type', input)) then
            Cust.Validate("A01 Preferred Reminder Mode", WS.GetInt('Activity Type', input));

        if (Cust."A01 NIF" <> WS.GetText('NIF', input)) then
            Cust.Validate("A01 NIF", WS.GetText('NIF', input));

        if (Cust."A01 STAT" <> WS.GetText('STAT', input)) then
            Cust.Validate("A01 STAT", WS.GetText('STAT', input));

        if (Cust."A01 RCS" <> WS.GetText('RCS', input)) then
            Cust.Validate("A01 RCS", WS.GetText('RCS', input));

        if (Cust."A01 CIF" <> WS.GetText('CIF', input)) then
            Cust.Validate("A01 CIF", WS.GetText('CIF', input));

        if (Cust."A01 ID Number" <> WS.GetText('ID Number', input)) then
            Cust.Validate("A01 ID Number", WS.GetText('ID Number', input));

        if (Cust."A01 Contract No." <> WS.GetText('Contract No_', input)) then
            Cust.Validate("A01 Contract No.", WS.GetText('Contract No_', input));



        // if (Cust."A01 Sales Mode" <> WS.GetText('Sales Mode', input)) then
        //     Cust.Validate("A01 Sales Mode", WS.GetText('Sales Mode', input));

        // if (Cust."Payment Terms Code" <> WS.GetText('Payment Terms Code', input)) then
        //     Cust.Validate("Payment Terms Code", WS.GetText('Payment Terms Code', input));

        // if (Cust."Credit Limit (LCY)" <> WS.GetDecimal('Credit limit (LCY)', input)) then
        //     Cust.Validate("Credit Limit (LCY)", WS.GetDecimal('Credit limit (LCY)', input));

        // if (Cust."Payment Method Code" <> WS.GetText('Payment Method Code', input)) then
        //     Cust.Validate("Payment Method Code", WS.GetText('Payment Method Code', input));

        // if (Cust."VAT Bus. Posting Group" <> WS.GetText('VAT Bus_ Posting Group', input)) then
        //     Cust.Validate("VAT Bus. Posting Group", WS.GetText('VAT Bus_ Posting Group', input));

        // if (Cust."Prepayment %" <> WS.GetDecimal('Prepayment _', input)) then
        //     Cust.Validate("Prepayment %", WS.GetDecimal('Prepayment _', input));

        // if (Cust."A01 Risk Level" <> WS.GetText('Risk Level', input)) then
        //     Cust.Validate("A01 Risk Level", WS.GetText('Risk Level', input));

        // if (Cust.A01 <> WS.GetDecimal('Score', input)) then
        // Cust.Validate("Credit Limit (LCY)", WS.GetDecimal('Score', input));



        Cust.Modify();
    end;

    local procedure processCustomerRequirements(Cust: Record "Customer"; input: JsonObject)
    var
        SalesLine: record "A01 Cust Scoring Criteria";
        NewCustCriteria: record "A01 Cust Scoring Criteria";
        c: JsonToken;
        LinesArray: JsonArray;
        LineInput: JsonObject;
    begin

        SalesLine.Reset();
        SalesLine.SetRange("Account Type", SalesLine."Account Type"::Customer);
        SalesLine.SetRange("Customer No.", Cust."No.");
        if (not SalesLine.IsEmpty) then
            SalesLine.DeleteAll();

        input.Get('CustomerRequirement', c);
        LinesArray := c.AsArray();
        foreach c in LinesArray do begin
            LineInput := c.AsObject();
            NewCustCriteria.Init();
            ProcessCustScoringCriteria(Cust, NewCustCriteria, LineInput);
            NewCustCriteria.Insert(true);
        end;
    end;

    local procedure ProcessCustScoringCriteria(Cust: Record "Customer"; var CustCriteria: Record "A01 Cust Scoring Criteria"; input: JsonObject)
    begin

        if (CustCriteria."Account Type" <> CustCriteria."Account Type"::Customer) then
            CustCriteria."Account Type" := CustCriteria."Account Type"::Customer;

        if (CustCriteria."Customer No." <> Cust."No.") then
            CustCriteria."Customer No." := Cust."No.";

        // if (CustCriteria.le <> WS.GetInt('Lead No', input)) then
        //     CustCriteria."Lead No" := WS.GetInt('Lead No', input);

        if (CustCriteria.Criteria <> WS.GetText('Criteria', input)) then
            CustCriteria."Criteria" := Copystr(WS.GetText('Criteria', input), 1, 20);

        // if (CustCriteria."Criteria Description" <> WS.GetText('Criteria Description', input)) then
        //    CustCriteria.Validate("Criteria Description", WS.GetText('Criteria Description', input));

        // if (CustCriteria."Type".AsInteger() <> WS.GetInt('Value Type', input)) then
        //     CustCriteria.Validate("Type", WS.GetInt('Value Type', input));

        // if (CustCriteria.va.AsInteger() <> WS.GetInt('Value Length', input)) then
        //             CustCriteria.Validate("Type", WS.GetInt('Value Length', input));

        // if (CustCriteria.Requirement.AsInteger() <> WS.GetInt('Requirement', input)) then
        //     CustCriteria.Validate("Requirement", WS.GetInt('Requirement', input));

        if (CustCriteria."Numeric Value" <> WS.GetDecimal('Numeric Value', input)) then
            CustCriteria.Validate("Numeric Value", WS.GetDecimal('Numeric Value', input));

        if (CustCriteria."Aplhanumeric Value" <> WS.GetText('Aplha Value', input)) then
            CustCriteria.Validate("Aplhanumeric Value", WS.GetText('Aplha Value', input));

        // if (CustCriteria.Validity.AsInteger() <> WS.GetInt('Validity', input)) then
        //     CustCriteria.Validate("Validity", WS.GetInt('Validity', input));

        //TODO TEST JSON HERE
        //if (CustCriteria."Validity Date" <> WS.GetDate('Validity Date', input)) then
        //    CustCriteria.Validate("Validity Date", WS.GetDate('Validity Date', input));

        // if (CustCriteria."Document Required" <> WS.GetBool('Document required', input)) then
        //     CustCriteria.Validate("Document Required", WS.GetBool('Document required', input));

        if (CustCriteria.DocumentLink <> WS.GetText('Document Link', input)) then
            CustCriteria.Validate("DocumentLink", WS.GetText('Document Link', input));

        if (CustCriteria.Valid <> WS.GetBool('Valid', input)) then
            CustCriteria.Validate("Valid", WS.GetBool('Valid', input));

        if (CustCriteria."Modified By" <> WS.GetText('Updated by', input)) then
            CustCriteria.Validate("Modified By", WS.GetText('Updated by', input));

    end;

    local procedure processCustomerScorings(Cust: Record "Customer"; input: JsonObject)
    var
        SalesLine: record "A01 Customer Scoring";
        NewCustCriteria: record "A01 Customer Scoring";
        c: JsonToken;
        LinesArray: JsonArray;
        LineInput: JsonObject;
    begin

        SalesLine.Reset();
        SalesLine.SetRange("Account Type", SalesLine."Account Type"::Customer);
        SalesLine.SetRange("Customer No.", Cust."No.");
        if (not SalesLine.IsEmpty) then
            SalesLine.DeleteAll();

        input.Get('CustomerScoring', c);
        LinesArray := c.AsArray();
        foreach c in LinesArray do begin
            LineInput := c.AsObject();
            NewCustCriteria.Init();
            ProcesCustomerScoring(Cust, NewCustCriteria, LineInput);
            NewCustCriteria.Insert(true);
        end;
    end;

    local procedure ProcesCustomerScoring(Cust: Record "Customer"; var CustScoring: Record "A01 Customer Scoring"; input: JsonObject)
    begin

        if (CustScoring."Account Type" <> CustScoring."Account Type"::Customer) then
            CustScoring."Account Type" := CustScoring."Account Type"::Customer;

        if (CustScoring."Customer No." <> Cust."No.") then
            CustScoring."Customer No." := Cust."No.";

        if (CustScoring.Criteria <> WS.GetText('Criteria', input)) then
            CustScoring."Criteria" := Copystr(WS.GetText('Criteria', input), 1, 20);

        //TODO activate here
        // if (CustScoring."Type".AsInteger() <> WS.GetInt('Value Type', input)) then
        //     CustScoring.Validate("Type", WS.GetInt('Value Type', input));


        if (CustScoring."Criteria Value" <> WS.GetText('Criteria Value', input)) then
            CustScoring.Validate("Criteria Value", WS.GetText('Criteria Value', input));

        if (CustScoring."Validity Date" <> WS.GetDate('Validity Date', input)) then
            CustScoring.Validate("Validity Date", WS.GetDate('Validity Date', input));

        if (CustScoring.DocumentLink <> WS.GetText('Document Link', input)) then
            CustScoring.Validate("DocumentLink", WS.GetText('Document Link', input));

        if (CustScoring.Valid <> WS.GetBool('Valid', input)) then
            CustScoring.Validate("Valid", WS.GetBool('Valid', input));

        if (CustScoring.Score <> WS.GetDecimal('Point', input)) then
            CustScoring.Validate("Score", WS.GetDecimal('Point', input));

        if (CustScoring.Coefficient <> WS.GetDecimal('Coefficient', input)) then
            CustScoring.Validate("Coefficient", WS.GetDecimal('Coefficient', input));

        if (CustScoring."Weighted Score" <> WS.GetDecimal('Weighed Point', input)) then
            CustScoring.Validate("Weighted Score", WS.GetDecimal('Weighed Point', input));

        if (CustScoring."Modified By" <> WS.GetText('Updated by', input)) then
            CustScoring.Validate("Modified By", WS.GetText('Updated by', input));

    end;

    #endregion Customers

    #region Leads

    local procedure ModifyLead(CustNo: Text; input: JsonObject): Text
    var
        Cust: Record "Contact";
    // CustRequirement: Record "A01 Cust Scoring Requirement";
    // CustScoring: Record "A01 Customer Scoring";
    begin

        Cust.Get(CustNo);

        ProcessLead(Cust, input);

        processLeadRequirements(Cust, input);

        processLeadScorings(Cust, input);

        exit(Ws.CreateResponseSuccess(Cust."No."));

    end;

    local procedure AddLead(input: JsonObject): Text
    var
        Cust: Record "Contact";
    begin

        Cust.Init();
        Cust."No." := '';

        //SalesOrderLine.LockTable();
        Cust.Insert(true);

        ProcessLead(Cust, input);

        processLeadRequirements(Cust, input);

        processLeadScorings(Cust, input);

        exit(Ws.CreateResponseSuccess(Cust."No."));

    end;

    local procedure DeleteLead(CustNo: Text): Text
    var
        Cust: Record "Contact";
    begin

        Cust.Get(CustNo);

        Cust.Delete(true);

        exit(Ws.CreateResponseSuccess(Cust."No."));

    end;

    local procedure ProcessLead(var Cont: Record "Contact"; input: JsonObject)
    begin


        //if (Cont."Name" <> WS.GetText('Name', input)) then
        //    Cont.Validate("Name", WS.GetText('Name', input));

        if (Cont."A01 Created By" = '') then
            Cont.Validate("A01 Created By", WS.GetText('webUserName', input));

        if (Cont."A01 Modified By" <> WS.GetText('webUserName', input)) then
            Cont.Validate("A01 Modified By", WS.GetText('webUserName', input));

        if (Cont."Name" <> WS.GetText('Name', input)) then
            Cont.Validate("Name", WS.GetText('Name', input));

        if (Cont."Search Name" <> WS.GetText('Search Name', input)) then
            Cont.Validate("Search Name", WS.GetText('Search Name', input));

        if (Cont."A01 Customer Type".AsInteger() <> WS.GetInt('Customer Type', input)) then
            Cont.Validate("A01 Customer Type", WS.GetInt('Customer Type', input));

        if (Cont."A01 Legal Status".AsInteger() <> WS.GetInt('Legal Status', input)) then
            Cont.Validate("A01 Legal Status", WS.GetInt('Legal Status', input));

        if (Cont."A01 Identification Mode".AsInteger() <> WS.GetInt('Identification Mode', input)) then
            Cont.Validate("A01 Identification Mode", WS.GetInt('Identification Mode', input));


        if (Cont."Address" <> WS.GetText('Address', input)) then
            Cont.Validate("Address", WS.GetText('Address', input));

        if (Cont."Address 2" <> WS.GetText('Address 2', input)) then
            Cont.Validate("Address 2", WS.GetText('Address 2', input));

        if (Cont."Post Code" <> WS.GetText('Post Code', input)) then
            Cont.Validate("Post Code", WS.GetText('Post Code', input));

        if (Cont."City" <> WS.GetText('City', input)) then
            Cont.Validate("City", WS.GetText('City', input));

        if (Cont."Phone No." <> WS.GetText('Phone No_', input)) then
            Cont.Validate("Phone No.", WS.GetText('Phone No_', input));

        if (Cont."Home Page" <> WS.GetText('Home Page', input)) then
            Cont.Validate("Home Page", WS.GetText('Home Page', input));

        if (Cont."A01 Parent Customer" <> WS.GetText('Parent Account No_', input)) then
            Cont.Validate("A01 Parent Customer", WS.GetText('Parent Account No_', input));

        if (Cont."A01 Allowed Item Category" <> WS.GetText('Item Category', input)) then
            Cont.Validate("A01 Allowed Item Category", WS.GetText('Item Category', input));

        if (Cont."A01 Main Contact" <> WS.GetText('Primary Contact No_', input)) then
            Cont.Validate("A01 Main Contact", WS.GetText('Primary Contact No_', input));

        if (Cont."A01 Preferred Reminder Mode".AsInteger() <> WS.GetInt('Activity Type', input)) then
            Cont.Validate("A01 Preferred Reminder Mode", WS.GetInt('Activity Type', input));

        if (Cont."A01 NIF" <> WS.GetText('NIF', input)) then
            Cont.Validate("A01 NIF", WS.GetText('NIF', input));

        if (Cont."A01 STAT" <> WS.GetText('STAT', input)) then
            Cont.Validate("A01 STAT", WS.GetText('STAT', input));

        if (Cont."A01 RCS" <> WS.GetText('RCS', input)) then
            Cont.Validate("A01 RCS", WS.GetText('RCS', input));

        if (Cont."A01 CIF" <> WS.GetText('CIF', input)) then
            Cont.Validate("A01 CIF", WS.GetText('CIF', input));

        if (Cont."A01 ID Number" <> WS.GetText('ID Number', input)) then
            Cont.Validate("A01 ID Number", WS.GetText('ID Number', input));

        if (Cont."A01 Contract No." <> WS.GetText('Contract No_', input)) then
            Cont.Validate("A01 Contract No.", WS.GetText('Contract No_', input));


        if (Cont."A01 Sales Mode" <> WS.GetText('Sales Mode', input)) then
            Cont.Validate("A01 Sales Mode", WS.GetText('Sales Mode', input));

        if (Cont."A01 Payment Terms Code" <> WS.GetText('Payment Terms Code', input)) then
            Cont.Validate("A01 Payment Terms Code", WS.GetText('Payment Terms Code', input));

        if (Cont."A01 Credit Limit" <> WS.GetDecimal('Credit limit (LCY)', input)) then
            Cont.Validate("A01 Credit Limit", WS.GetDecimal('Credit limit (LCY)', input));

        if (Cont."A01 Payment Method" <> WS.GetText('Payment Method Code', input)) then
            Cont.Validate("A01 Payment Method", WS.GetText('Payment Method Code', input));

        if (Cont."A01 VAT Regime" <> WS.GetText('VAT Bus_ Posting Group', input)) then
            Cont.Validate("A01 VAT Regime", WS.GetText('VAT Bus_ Posting Group', input));

        if (Cont."A01 Prepayment required" <> WS.GetDecimal('Prepayment _', input)) then
            Cont.Validate("A01 Prepayment required", WS.GetDecimal('Prepayment _', input));

        if (Cont."A01 Risk Level" <> WS.GetText('Risk Level', input)) then
            Cont.Validate("A01 Risk Level", WS.GetText('Risk Level', input));

        if (Cont."A01 Score" <> WS.GetDecimal('Score', input)) then
            Cont.Validate("A01 Score", WS.GetDecimal('Score', input));


        Cont.Modify();
    end;

    local procedure processLeadRequirements(Cont: Record "Contact"; input: JsonObject)
    var
        SalesLine: record "A01 Cust Scoring Criteria";
        NewCustCriteria: record "A01 Cust Scoring Criteria";
        c: JsonToken;
        LinesArray: JsonArray;
        LineInput: JsonObject;
    begin

        SalesLine.Reset();
        SalesLine.SetRange("Account Type", SalesLine."Account Type"::Prospect);
        SalesLine.SetRange("Customer No.", Cont."No.");
        if (not SalesLine.IsEmpty) then
            SalesLine.DeleteAll();

        input.Get('CustomerRequirement', c);
        LinesArray := c.AsArray();
        foreach c in LinesArray do begin
            LineInput := c.AsObject();
            NewCustCriteria.Init();
            ProcessLeadScoringCriteria(Cont, NewCustCriteria, LineInput);
            NewCustCriteria.Insert(true);
        end;
    end;

    local procedure ProcessLeadScoringCriteria(Cont: Record "Contact"; var CustCriteria: Record "A01 Cust Scoring Criteria"; input: JsonObject)
    begin

        if (CustCriteria."Account Type" <> CustCriteria."Account Type"::Prospect) then
            CustCriteria."Account Type" := CustCriteria."Account Type"::Prospect;

        if (CustCriteria."Customer No." <> Cont."No.") then
            CustCriteria."Customer No." := Cont."No.";

        // if (CustCriteria.le <> WS.GetInt('Lead No', input)) then
        //     CustCriteria."Lead No" := WS.GetInt('Lead No', input);

        if (CustCriteria.Criteria <> WS.GetText('Criteria', input)) then
            CustCriteria."Criteria" := Copystr(WS.GetText('Criteria', input), 1, 20);

        // if (CustCriteria."Criteria Description" <> WS.GetText('Criteria Description', input)) then
        //     CustCriteria.Validate("Criteria Description", WS.GetText('Criteria Description', input));

        //if (CustCriteria."Type".AsInteger() <> WS.GetInt('Value Type', input)) then
        //    CustCriteria.Validate("Type", WS.GetInt('Value Type', input));

        // if (CustCriteria.va.AsInteger() <> WS.GetInt('Value Length', input)) then
        //             CustCriteria.Validate("Type", WS.GetInt('Value Length', input));

        // if (CustCriteria.Requirement.AsInteger() <> WS.GetInt('Requirement', input)) then
        //     CustCriteria.Validate("Requirement", WS.GetInt('Requirement', input));

        if (CustCriteria."Numeric Value" <> WS.GetDecimal('Numeric Value', input)) then
            CustCriteria.Validate("Numeric Value", WS.GetDecimal('Numeric Value', input));

        if (CustCriteria."Aplhanumeric Value" <> WS.GetText('Aplha Value', input)) then
            CustCriteria.Validate("Aplhanumeric Value", WS.GetText('Aplha Value', input));

        // if (CustCriteria.Validity.AsInteger() <> WS.GetInt('Validity', input)) then
        //     CustCriteria.Validate("Validity", WS.GetInt('Validity', input));

        //TODO REACTIVATE THIS CODE
        //if (CustCriteria."Validity Date" <> WS.GetDate('Validity Date', input)) then
        //    CustCriteria.Validate("Validity Date", WS.GetDate('Validity Date', input));

        // if (CustCriteria."Document Required" <> WS.GetBool('Document required', input)) then
        //     CustCriteria.Validate("Document Required", WS.GetBool('Document required', input));

        if (CustCriteria.DocumentLink <> WS.GetText('Document Link', input)) then
            CustCriteria.Validate("DocumentLink", WS.GetText('Document Link', input));

        if (CustCriteria.Valid <> WS.GetBool('Valid', input)) then
            CustCriteria.Validate("Valid", WS.GetBool('Valid', input));

        if (CustCriteria."Modified By" <> WS.GetText('Updated by', input)) then
            CustCriteria.Validate("Modified By", WS.GetText('Updated by', input));

    end;

    local procedure processLeadScorings(Cont: Record "Contact"; input: JsonObject)
    var
        SalesLine: record "A01 Customer Scoring";
        NewCustCriteria: record "A01 Customer Scoring";
        c: JsonToken;
        LinesArray: JsonArray;
        LineInput: JsonObject;
    begin

        SalesLine.Reset();
        SalesLine.SetRange("Account Type", SalesLine."Account Type"::Prospect);
        SalesLine.SetRange("Customer No.", Cont."No.");
        if (not SalesLine.IsEmpty) then
            SalesLine.DeleteAll();

        input.Get('CustomerScoring', c);
        LinesArray := c.AsArray();
        foreach c in LinesArray do begin
            LineInput := c.AsObject();
            NewCustCriteria.Init();
            ProcesLeadScoring(Cont, NewCustCriteria, LineInput);
            NewCustCriteria.Insert(true);
        end;
    end;

    local procedure ProcesLeadScoring(Cont: Record "Contact"; var CustScoring: Record "A01 Customer Scoring"; input: JsonObject)
    begin

        if (CustScoring."Account Type" <> CustScoring."Account Type"::Prospect) then
            CustScoring."Account Type" := CustScoring."Account Type"::Prospect;

        if (CustScoring."Customer No." <> Cont."No.") then
            CustScoring."Customer No." := Cont."No.";

        if (CustScoring.Criteria <> WS.GetText('Criteria', input)) then
            CustScoring."Criteria" := Copystr(WS.GetText('Criteria', input), 1, 20);

        if (CustScoring."Criteria Value" <> WS.GetText('Criteria Value', input)) then
            CustScoring.Validate("Criteria Value", WS.GetText('Criteria Value', input));

        if (CustScoring."Validity Date" <> WS.GetDate('Validity Date', input)) then
            CustScoring.Validate("Validity Date", WS.GetDate('Validity Date', input));

        if (CustScoring.DocumentLink <> WS.GetText('Document Link', input)) then
            CustScoring.Validate("DocumentLink", WS.GetText('Document Link', input));

        if (CustScoring.Valid <> WS.GetBool('Valid', input)) then
            CustScoring.Validate("Valid", WS.GetBool('Valid', input));

        if (CustScoring.Score <> WS.GetDecimal('Point', input)) then
            CustScoring.Validate("Score", WS.GetDecimal('Point', input));

        if (CustScoring.Coefficient <> WS.GetDecimal('Coefficient', input)) then
            CustScoring.Validate("Coefficient", WS.GetDecimal('Coefficient', input));

        if (CustScoring."Weighted Score" <> WS.GetDecimal('Weighed Point', input)) then
            CustScoring.Validate("Weighted Score", WS.GetDecimal('Weighed Point', input));

        if (CustScoring."Modified By" <> WS.GetText('Updated by', input)) then
            CustScoring.Validate("Modified By", WS.GetText('Updated by', input));

    end;

    #endregion leads

    #region Contacts

    local procedure ModifyContact(CustNo: Text; input: JsonObject): Text
    var
        Cust: Record "Contact";
    // CustRequirement: Record "A01 Cust Scoring Requirement";
    // CustScoring: Record "A01 Customer Scoring";
    begin

        Cust.Get(CustNo);

        ProcessContact(Cust, input);

        exit(Ws.CreateResponseSuccess(Cust."No."));

    end;

    local procedure AddContact(input: JsonObject): Text
    var
        Cust: Record "Contact";
    begin

        Cust.Init();
        Cust."No." := '';

        //SalesOrderLine.LockTable();
        Cust.Insert(true);

        Cust.Type := Cust.Type::Person;
        ProcessContact(Cust, input);

        exit(Ws.CreateResponseSuccess(Cust."No."));

    end;

    local procedure DeleteContact(ContNo: Text): Text
    var
        Cont: Record "Contact";
    begin

        Cont.Get(ContNo);

        Cont.Delete(true);

        exit(Ws.CreateResponseSuccess(Cont."No."));

    end;

    local procedure ProcessContact(var Cont: Record "Contact"; input: JsonObject)
    begin

        if (Cont."A01 Created By" = '') then
            Cont.Validate("A01 Created By", WS.GetText('webUserName', input));

        if (Cont."A01 Modified By" <> WS.GetText('webUserName', input)) then
            Cont.Validate("A01 Modified By", WS.GetText('webUserName', input));

        if (Cont."Salutation Code" <> WS.GetText('Salutation Code', input)) then
            Cont.Validate("Salutation Code", WS.GetText('Salutation Code', input));

        // if (Cont.cust <> WS.GetText('Customer No_', input)) then
        //     Cont.Validate("Name", WS.GetText('Customer No_', input));


        if (Cont."First Name" <> WS.GetText('First Name', input)) then
            Cont.Validate("First Name", WS.GetText('First Name', input));

        if (Cont."Middle Name" <> WS.GetText('Middle Name', input)) then
            Cont.Validate("Middle Name", WS.GetText('Middle Name', input));

        if (Cont.Surname <> WS.GetText('Surname', input)) then
            Cont.Validate("Surname", WS.GetText('Surname', input));

        if (Cont.Name <> WS.GetText('Name', input)) then
            Cont.Validate("Name", WS.GetText('Name', input));

        // if (Cont.Name <> WS.GetText('Image', input)) then
        //             Cont.Validate("Name", WS.GetText('Image', input));

        if (Cont."Job Title" <> WS.GetText('Job Title', input)) then
            Cont.Validate("Job Title", WS.GetText('Job Title', input));

        if (Cont."Address" <> WS.GetText('Address', input)) then
            Cont.Validate("Address", WS.GetText('Address', input));

        if (Cont."Address 2" <> WS.GetText('Address 2', input)) then
            Cont.Validate("Address 2", WS.GetText('Address 2', input));

        if (Cont."Post Code" <> WS.GetText('Post Code', input)) then
            Cont.Validate("Post Code", WS.GetText('Post Code', input));

        if (Cont."City" <> WS.GetText('City', input)) then
            Cont.Validate("City", WS.GetText('City', input));

        if (Cont."Phone No." <> WS.GetText('Phone No_', input)) then
            Cont.Validate("Phone No.", WS.GetText('Phone No_', input));

        if (Cont."Mobile Phone No." <> WS.GetText('Mobile Phone No_', input)) then
            Cont.Validate("Mobile Phone No.", WS.GetText('Mobile Phone No_', input));

        if (Cont."E-Mail" <> WS.GetText('E-Mail', input)) then
            Cont.Validate("E-Mail", WS.GetText('E-Mail', input));

        Cont.Modify();
    end;

    #endregion contacts

    #region Credit contract

    local procedure ModifyCreditContract(CustNo: Text; input: JsonObject): Text
    var
        CreditContract: Record "A01 AGP Contrat";
    begin

        CreditContract.Get(CustNo);

        ProcessCreditContract(CreditContract, input);

        exit(Ws.CreateResponseSuccess(CreditContract."No."));

    end;

    local procedure AddCreditContract(input: JsonObject): Text
    var
        CreditContract: Record "A01 AGP Contrat";
    begin

        CreditContract.Init();
        CreditContract."No." := '';

        //SalesOrderLine.LockTable();
        CreditContract.Insert(true);

        ProcessCreditContract(CreditContract, input);

        exit(Ws.CreateResponseSuccess(CreditContract."No."));

    end;

    local procedure DeleteCreditContract(ContNo: Text): Text
    var
        CreditContract: Record "A01 AGP Contrat";
    begin

        CreditContract.Get(ContNo);

        CreditContract.Delete(true);

        exit(Ws.CreateResponseSuccess(CreditContract."No."));

    end;

    local procedure ProcessCreditContract(var CreditContract: Record "A01 AGP Contrat"; input: JsonObject)
    begin

        if (CreditContract."Created By" = '') then
            CreditContract.Validate("Created By", WS.GetText('webUserName', input));

        if (CreditContract."Modified By" <> WS.GetText('webUserName', input)) then
            CreditContract.Validate("Modified By", WS.GetText('webUserName', input));

        if (CreditContract."Account Type".AsInteger() <> WS.GetInt('Account Type', input)) then
            CreditContract.Validate("Account Type", WS.GetInt('Account Type', input));

        if (CreditContract."Customer No." <> WS.GetText('Customer No_', input)) then
            CreditContract.Validate("Customer No.", WS.GetText('Customer No_', input));

        if (CreditContract."OP Starting Date" <> WS.GetDate('OP Starting Date', input)) then
            CreditContract.Validate("OP Starting Date", WS.GetDate('OP Starting Date', input));

        if (CreditContract."OP Duration (Month)" <> WS.GetInt('OP Duration (Month)', input)) then
            CreditContract.Validate("OP Duration (Month)", WS.GetInt('OP Duration (Month)', input));

        if (CreditContract."OP Ending Date" <> WS.GetDate('OP Ending Date', input)) then
            CreditContract.Validate("OP Ending Date", WS.GetDate('OP Ending Date', input));

        if (CreditContract."Duration (Month)" <> WS.GetInt('Duration (Month)', input)) then
            CreditContract.Validate("Duration (Month)", WS.GetInt('Duration (Month)', input));

        if (CreditContract."Commitment Type".AsInteger() <> WS.GetInt('Commitment Type', input)) then
            CreditContract.Validate("Commitment Type", WS.GetInt('Commitment Type', input));

        if (CreditContract."Payment Terms Code" <> WS.GetText('Payment Terms Code', input)) then
            CreditContract.Validate("Payment Terms Code", WS.GetText('Payment Terms Code', input));

        if (CreditContract."First Terms Date" <> WS.GetDate('First Terms Date', input)) then
            CreditContract.Validate("First Terms Date", WS.GetDate('First Terms Date', input));

        if (CreditContract."Payment Method Code" <> WS.GetText('Payment Method Code', input)) then
            CreditContract.Validate("Payment Method Code", WS.GetText('Payment Method Code', input));

        if (CreditContract."Approval Status".AsInteger() <> WS.GetInt('Approval Status', input)) then
            CreditContract.Validate("Approval Status", WS.GetInt('Approval Status', input));

        CreditContract.Modify();
    end;

    #endregion credit contract


    #region Ship To Address

    local procedure ModifyShipToAddress(CustNo: Text; Code: Text; input: JsonObject): Text
    var
        ShipTo: Record "Ship-to Address";
    begin

        ShipTo.Get(CustNo, Code);

        ProcessShipToAddress(ShipTo, input);

        exit(Ws.CreateResponseSuccess(ShipTo.Code));

    end;

    local procedure AddShipToAddress(CustNo: Text; input: JsonObject): Text
    var
        ShipTo: Record "Ship-to Address";
        NosSeriesMgt: Codeunit NoSeriesManagement;
    begin

        ShipTo.Init();
        ShipTo."Customer No." := CopyStr(CustNo, 1, 20);
        AddOnSetup.Testfield("ShipToAddress Code Nos");
        ShipTo."Code" := CopyStr(NosSeriesMgt.GetNextNo(AddOnSetup."ShipToAddress Code Nos", today, true), 1, 10);

        ShipTo.Insert(true);

        ProcessShipToAddress(ShipTo, input);

        exit(Ws.CreateResponseSuccess(ShipTo."Code"));

    end;

    local procedure DeleteShipToAddress(CustNo: Text; Code: Text): Text
    var
        ShipTo: Record "Ship-to Address";
    begin

        ShipTo.Get(CustNo, Code);

        ShipTo.Delete(true);

        exit(Ws.CreateResponseSuccess(ShipTo."Code"));

    end;

    local procedure ProcessShipToAddress(var ShipTo: Record "Ship-to Address"; input: JsonObject)
    begin

        if (ShipTo."A01 Created By" = '') then
            ShipTo.Validate("A01 Created By", WS.GetText('webUserName', input));

        if (ShipTo."A01 Modified By" <> WS.GetText('webUserName', input)) then
            ShipTo.Validate("A01 Modified By", WS.GetText('webUserName', input));

        // if (ShipTo."Contact No." <> WS.GetText('Customer No_', input)) then
        //     ShipTo.Validate("Contact No_", WS.GetText('Customer No_', input));

        if (ShipTo.Name <> WS.GetText('Name', input)) then
            ShipTo.Validate(Name, WS.GetText('Name', input));

        if (ShipTo.Address <> WS.GetText('Address', input)) then
            ShipTo.Validate(Address, WS.GetText('Address', input));

        if (ShipTo."Address 2" <> WS.GetText('Address 2', input)) then
            ShipTo.Validate("Address 2", WS.GetText('Address 2', input));

        if (ShipTo."City" <> WS.GetText('City', input)) then
            ShipTo.Validate("City", WS.GetText('City', input));

        if (ShipTo."Phone No." <> WS.GetText('Phone No_', input)) then
            ShipTo.Validate("Phone No.", WS.GetText('Phone No_', input));

        // if (ShipTo.ph <> WS.GetText('Mobile Phone No_', input)) then
        //     ShipTo.Validate("Mobile Phone No.", WS.GetText('Mobile Phone No_', input));

        if (ShipTo."A01 Place" <> WS.GetText('Place', input)) then
            ShipTo.Validate("A01 Place", WS.GetText('Place', input));

        if (ShipTo."A01 Neighborhood" <> WS.GetText('Neighborhood', input)) then
            ShipTo.Validate("A01 Neighborhood", WS.GetText('Neighborhood', input));

        if (ShipTo."Service Zone Code" <> WS.GetText('Service Zone Code', input)) then
            ShipTo.Validate("Service Zone Code", WS.GetText('Service Zone Code', input));

        if (ShipTo."A01 Road Type".AsInteger() <> WS.GetInt('Road Type', input)) then
            ShipTo.Validate("A01 Road Type", WS.GetInt('Road Type', input));

        if (ShipTo."A01 Road Type (Others)" <> WS.GetText('Road Type (Others)', input)) then
            ShipTo.Validate("A01 Road Type (Others)", WS.GetText('Road Type (Others)', input));

        if (ShipTo."A01 Walking distance".AsInteger() <> WS.GetInt('Walking distance', input)) then
            ShipTo.Validate("A01 Walking distance", WS.GetInt('Walking distance', input));

        if (ShipTo."A01 Walking distance (Others)" <> WS.GetText('Walking distance (Others)', input)) then
            ShipTo.Validate("A01 Walking distance (Others)", WS.GetText('Walking distance (Others)', input));

        if (ShipTo."A01 Delivery Location".AsInteger() <> WS.GetInt('Delivery Location', input)) then
            ShipTo.Validate("A01 Delivery Location", WS.GetInt('Delivery Location', input));

        if (ShipTo."A01 Motorcycle Access" <> WS.GetBool('Motorcycle Access', input)) then
            ShipTo.Validate("A01 Motorcycle Access", WS.GetBool('Motorcycle Access', input));

        if (ShipTo."A01 Access Plan".AsInteger() <> WS.GetInt('Access Plan', input)) then
            ShipTo.Validate("A01 Access Plan", WS.GetInt('Access Plan', input));

        if (ShipTo."A01 Access Type".AsInteger() <> WS.GetInt('Access Type', input)) then
            ShipTo.Validate("A01 Access Type", WS.GetInt('Access Type', input));

        if (ShipTo."A01 Truck Type".AsInteger() <> WS.GetInt('Truck Type', input)) then
            ShipTo.Validate("A01 Truck Type", WS.GetInt('Truck Type', input));

        if (ShipTo."A01 Public parking presence" <> WS.GetBool('Public parking presence', input)) then
            ShipTo.Validate("A01 Public parking presence", WS.GetBool('Public parking presence', input));

        if (ShipTo."A01 Remarks" <> WS.GetText('Remarks', input)) then
            ShipTo.Validate("A01 Remarks", WS.GetText('Remarks', input));

        // if (ShipTo."A01 Ground plan" <> WS.GetText('Ground plan', input)) then
        //     ShipTo.Validate("A01 Ground plan", WS.GetText('Ground plan', input));


        ShipTo.Modify();
    end;

    #endregion ship to address



}
