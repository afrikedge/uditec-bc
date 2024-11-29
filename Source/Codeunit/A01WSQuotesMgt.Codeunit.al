/// <summary>
/// Codeunit A01 WS QuotesMgt (ID 50005). ApiQuotes
/// </summary>
codeunit 50005 "A01 WS QuotesMgt"
{

    var
        WS: codeunit "A01 Api Mgt";
        LblErrorQuoteNotExists: Label 'The Quote N° %1 does not exists', Comment = '%1 = QuoteNo';

    /// <summary>
    /// Run.
    /// </summary>
    /// <param name="input">JsonObject.</param>
    /// <param name="IsDeletion">Boolean.</param>
    /// <returns>Return value of type Text.</returns>
    procedure Run(input: JsonObject; IsDeletion: Boolean): Text
    var
        NoQuote: text;
    //ToDelete: Boolean;
    begin
        //input.ReadFrom(inputJson);
        NoQuote := ws.GetText('QuoteNo', input);
        if (NoQuote <> '') then begin

            //ToDelete := ws.GetBool('IsDeletion', input);
            if (IsDeletion) then
                exit(DeleteQuote(NoQuote))
            else
                exit(ModifyQuote(NoQuote, input))

        end else
            exit(AddQuote(input));
    end;

    procedure Run_Open(input: JsonObject): Text
    var
        SalesOrder: Record "Sales Header";
        NoOrder: text;
        WebUser: text;
    begin
        NoOrder := ws.GetText('No_', input);
        WebUser := ws.GetText('webUserName', input);

        SalesOrder.Get(SalesOrder."Document Type"::Quote, NoOrder);

        SalesOrder."A01 Web User Id" := copystr(WebUser, 1, 50);

        SalesOrder.PerformManualReopen(SalesOrder);

        exit(Ws.CreateResponseSuccess(SalesOrder."No."));

    end;


    /// <summary>
    /// ModifyQuote.
    /// </summary>
    /// <param name="input">JsonObject.</param>
    /// <param name="IsDeletion">Boolean.</param>
    /// <returns>Return value of type Text.</returns>
    procedure RunCreditRequest(input: JsonObject; IsDeletion: Boolean): Text
    var
        NoQuote: text;
    //ToDelete: Boolean;
    begin
        //input.ReadFrom(inputJson);
        NoQuote := ws.GetText('QuoteNo', input);
        if (NoQuote <> '') then begin

            //ToDelete := ws.GetBool('IsDeletion', input);
            if (IsDeletion) then
                exit(DeleteQuote(NoQuote))
            else
                exit(ModifyQuote_CreditRequest(NoQuote, input))

        end else
            exit(AddQuote_CreditRequest(input));
    end;

    procedure RunRejectCreditRequest(input: JsonObject): Text
    var
        SalesQuote: Record "Sales Header";
        NoQuote: text;
        WebUser: text;
        RejectionReason: text;
    begin
        NoQuote := ws.GetText('No_', input);
        WebUser := ws.GetText('webUserName', input);
        RejectionReason := ws.GetText('reason for rejection', input);

        SalesQuote.Get(SalesQuote."Document Type"::Quote, NoQuote);
        SalesQuote."A01 Request Status" := SalesQuote."A01 Request Status"::Rejected;
        SalesQuote."A01 Credit Validation Status" := SalesQuote."A01 Credit Validation Status"::Rejected;
        SalesQuote."A01 Return Reason" := CopyStr(RejectionReason, 1, 250);
        SalesQuote.Modify();
        exit(Ws.CreateResponseSuccess(SalesQuote."No."));
    end;

    local procedure ModifyQuote(QuoteNo: Text; input: JsonObject): Text
    var
        SalesQuote: Record "Sales Header";
        SalesQuoteLine: Record "Sales Line";
    begin

        SalesQuote.Get(SalesQuote."Document Type"::Quote, QuoteNo);

        ProcessSalesQuoteHeader(SalesQuote, input);
        SalesQuote.Modify(true);

        processQuotesLines(SalesQuote, SalesQuoteLine, input);

        exit(Ws.CreateResponseSuccess(SalesQuote."No."));

    end;


    local procedure AddQuote(input: JsonObject): Text
    var
        SalesQuote: Record "Sales Header";
        SalesQuoteLine: Record "Sales Line";
    begin

        SalesQuote.Init();
        SalesQuote."Document Type" := SalesQuote."Document Type"::Quote;
        SalesQuote."No." := '';

        SalesQuoteLine.LockTable();
        SalesQuote.Insert(true);

        ProcessSalesQuoteHeader(SalesQuote, input);
        SalesQuote.Modify(true);

        processQuotesLines(SalesQuote, SalesQuoteLine, input);

        exit(Ws.CreateResponseSuccess(SalesQuote."No."));

    end;

    /// <summary>
    /// AddQuote_CreditRequest.
    /// </summary>
    /// <param name="input">JsonObject.</param>
    /// <returns>Return value of type Text.</returns>
    local procedure AddQuote_CreditRequest(input: JsonObject): Text
    var
        SalesQuote: Record "Sales Header";
        SalesQuoteLine: Record "Sales Line";
    begin

        SalesQuote.Init();
        SalesQuote."Document Type" := SalesQuote."Document Type"::Quote;
        SalesQuote."No." := '';

        SalesQuoteLine.LockTable();
        SalesQuote.Insert(true);

        ProcessSalesQuoteHeader(SalesQuote, input);
        ProcessCreditRequestFields(SalesQuote, input);
        SalesQuote.Modify(true);


        processQuotesLines(SalesQuote, SalesQuoteLine, input);
        processCreditAmortisationLines(SalesQuote, input);
        processCustScoringLines(SalesQuote, input);
        processCustomerRequirements(SalesQuote, input);

        exit(Ws.CreateResponseSuccess(SalesQuote."No."));

    end;

    /// <summary>
    /// ModifyQuote_CreditRequest.
    /// </summary>
    /// <param name="QuoteNo">Text.</param>
    /// <param name="input">JsonObject.</param>
    /// <returns>Return value of type Text.</returns>
    local procedure ModifyQuote_CreditRequest(QuoteNo: Text; input: JsonObject): Text
    var
        SalesQuote: Record "Sales Header";
        SalesQuoteLine: Record "Sales Line";
    begin

        SalesQuote.Get(SalesQuote."Document Type"::Quote, QuoteNo);

        ProcessSalesQuoteHeader(SalesQuote, input);
        ProcessCreditRequestFields(SalesQuote, input);
        SalesQuote.Modify(true);

        processQuotesLines(SalesQuote, SalesQuoteLine, input);
        processCreditAmortisationLines(SalesQuote, input);
        processCustScoringLines(SalesQuote, input);
        processCustomerRequirements(SalesQuote, input);

        processSaleQuoteApprovalFlows(SalesQuote, input);

        exit(Ws.CreateResponseSuccess(SalesQuote."No."));

    end;

    local procedure DeleteQuote(QuoteNo: Text): Text
    var
        SalesQuote: Record "Sales Header";
    begin

        SalesQuote.Get(SalesQuote."Document Type"::Quote, QuoteNo);

        SalesQuote.Delete(true);

        exit(Ws.CreateResponseSuccess(SalesQuote."No."));

    end;

    local procedure AddOrInsertSalesQuoteLine(SalesQuote: Record "Sales Header"; var SalesLine: Record "Sales Line"; input: JsonObject)
    var
        SalesL: Record "Sales Line";
    begin


        SalesL.Reset();
        SalesL.SetRange("Document Type", SalesQuote."Document Type");
        SalesL.SetRange("Document No.", SalesQuote."No.");
        SalesL.SetRange("Line No.", WS.GetInt('Line No_', input));
        if (not SalesL.FindFirst()) then begin

            SalesLine.Init();

            processSalesQuoteLine(SalesQuote, SalesLine, input);

            SalesLine.Insert();

        end else begin

            processSalesQuoteLine(SalesQuote, SalesL, input);
            SalesL.Modify(true);

        end;
        ;

    end;

    local procedure ProcessSalesQuoteHeader(var SalesQuote: Record "Sales Header"; input: JsonObject)
    var
        Cust: record Customer;
        jsonkey: Text;
    begin

        //SalesQuote.Validate("Sell-to Customer No.", GetText('customerNo', input));

        if (SalesQuote."A01 Web User Id" <> WS.GetText('webUserName', input)) then
            SalesQuote.Validate("A01 Web User Id", WS.GetText('webUserName', input));

        if (SalesQuote."Sell-to Customer Templ. Code" <> WS.GetText('Customer Template Code', input)) then
            SalesQuote.Validate("Sell-to Customer Templ. Code", WS.GetText('Customer Template Code', input));

        if (SalesQuote."Sell-to Customer No." <> WS.GetText('saleQuoteCustomerNo', input)) then
            SalesQuote.Validate("Sell-to Customer No.", WS.GetText('saleQuoteCustomerNo', input));

        if (Cust.get(SalesQuote."Sell-to Customer No.")) then begin
            if (Cust."A01 Customer Type" = Cust."A01 Customer Type"::Miscellaneous) then begin
                if (SalesQuote."A01 Miscellaneous Contact" <> WS.GetText('saleQuoteCustomerContactCode', input)) then
                    SalesQuote.Validate("A01 Miscellaneous Contact", WS.GetText('saleQuoteCustomerContactCode', input));
            end else begin
                if (SalesQuote."Sell-to Contact No." <> WS.GetText('saleQuoteCustomerContactCode', input)) then
                    SalesQuote.Validate("Sell-to Contact No.", WS.GetText('saleQuoteCustomerContactCode', input));
            end;
        end else begin
            if (SalesQuote."Sell-to Contact No." <> WS.GetText('saleQuoteCustomerContactCode', input)) then
                SalesQuote.Validate("Sell-to Contact No.", WS.GetText('saleQuoteCustomerContactCode', input));
        end;

        if (SalesQuote."Responsibility Center" <> WS.GetText('saleQuoteResponsibilityCenter', input)) then
            SalesQuote.Validate("Responsibility Center", WS.GetText('saleQuoteResponsibilityCenter', input));

        if (SalesQuote."Salesperson Code" <> WS.GetText('saleQuoteSalesperson', input)) then
            SalesQuote.Validate("Salesperson Code", WS.GetText('saleQuoteSalesperson', input));

        if (SalesQuote."Campaign No." <> WS.GetText('saleQuoteCampaignNo', input)) then
            SalesQuote.Validate("Campaign No.", WS.GetText('saleQuoteCampaignNo', input));

        if (SalesQuote."Location Code" <> WS.GetText('saleQuoteLocationCode', input)) then
            SalesQuote.Validate("Location Code", WS.GetText('saleQuoteLocationCode', input));

        if (SalesQuote."Shortcut Dimension 2 Code" <> WS.GetText('saleQuoteSalesChannel', input)) then
            SalesQuote.Validate("Shortcut Dimension 2 Code", WS.GetText('saleQuoteSalesChannel', input));

        if (SalesQuote."A01 Sales Mode" <> WS.GetText('saleQuoteSalesMode', input)) then
            SalesQuote.Validate("A01 Sales Mode", WS.GetText('saleQuoteSalesMode', input));

        if (SalesQuote."Customer Price Group" <> WS.GetText('saleQuoteCustomerPriceGroup', input)) then
            SalesQuote.Validate("Customer Price Group", WS.GetText('saleQuoteCustomerPriceGroup', input));

        if (SalesQuote."VAT Bus. Posting Group" <> WS.GetText('saleQuoteVATBusPostingGroup', input)) then
            SalesQuote.Validate("VAT Bus. Posting Group", WS.GetText('saleQuoteVATBusPostingGroup', input));

        if (SalesQuote."Document Date" <> WS.GetDate('saleQuoteDocumentDate', input)) then
            SalesQuote.Validate("Document Date", WS.GetDate('saleQuoteDocumentDate', input));

        if (SalesQuote."Quote Valid Until Date" <> WS.GetDate('saleQuoteValidUntilDate', input)) then
            SalesQuote.Validate("Quote Valid Until Date", WS.GetDate('saleQuoteValidUntilDate', input));

        if (SalesQuote."Requested Delivery Date" <> WS.GetDate('saleQuoteShipRequestedDate', input)) then
            SalesQuote.Validate("Requested Delivery Date", WS.GetDate('saleQuoteShipRequestedDate', input));

        if (SalesQuote."Promised Delivery Date" <> WS.GetDate('saleQuotePromisedDeliveryDate', input)) then
            SalesQuote.Validate("Promised Delivery Date", WS.GetDate('saleQuotePromisedDeliveryDate', input));

        if (SalesQuote."Payment Method Code" <> WS.Gettext('saleQuotePaymentMethodCode', input)) then
            SalesQuote.Validate("Payment Method Code", WS.Gettext('saleQuotePaymentMethodCode', input));

        if (SalesQuote."Payment Terms Code" <> WS.Gettext('saleQuotePaymentTermsCode', input)) then
            SalesQuote.Validate("Payment Terms Code", WS.Gettext('saleQuotePaymentTermsCode', input));

        if (SalesQuote."Prepayment %" <> WS.GetDecimal('saleQuotePrepayment', input)) then
            SalesQuote.Validate("Prepayment %", WS.GetDecimal('saleQuotePrepayment', input));

        if (SalesQuote."Ship-to Code" <> WS.Gettext('saleQuoteCustomerShipToCode', input)) then
            SalesQuote.Validate("Ship-to Code", WS.Gettext('saleQuoteCustomerShipToCode', input));

        if (SalesQuote."Shipment Method Code" <> WS.GetText('saleQuoteShipmentMethodCode', input)) then
            SalesQuote.Validate("Shipment Method Code", WS.GetText('saleQuoteShipmentMethodCode', input));


        if (SalesQuote."A01 Analyst comments" <> WS.GetText('Analyst comments', input)) then
            SalesQuote.Validate("A01 Analyst comments", WS.GetText('Analyst comments', input));

        if (SalesQuote."A01 System Decision".AsInteger() <> WS.GetInt('System Decision', input)) then
            SalesQuote.Validate("A01 System Decision", WS.GetInt('System Decision', input));

        if (SalesQuote."A01 Analyst Opinion".AsInteger() <> WS.GetInt('Analyst Opinion', input)) then
            SalesQuote.Validate("A01 Analyst Opinion", WS.GetInt('Analyst Opinion', input));

        if (SalesQuote."A01 Investigator Opinion".AsInteger() <> WS.GetInt('Investigator Opinion', input)) then
            SalesQuote.Validate("A01 Investigator Opinion", WS.GetInt('Investigator Opinion', input));


        jsonkey := 'External Document No_';
        if (WS.KeyExists(jsonkey, input)) then
            if (SalesQuote."External Document No." <> WS.GetText(jsonkey, input)) then
                SalesQuote.Validate("External Document No.", WS.GetText(jsonkey, input));

    end;

    local procedure ProcessCreditRequestFields(var SalesQuote: Record "Sales Header"; input: JsonObject)
    var
        jsonKey: Text;
    begin
        if (SalesQuote."A01 Credit Validation Status".AsInteger() <> WS.Getint('Approval Status', input)) then
            SalesQuote.Validate("A01 Credit Validation Status", WS.Getint('Approval Status', input));

        if (SalesQuote."A01 Interest rate" <> WS.GetDecimal('Interest rate', input)) then
            SalesQuote.Validate("A01 Interest rate", WS.GetDecimal('Interest rate', input));

        if (SalesQuote."A01 Credit Duration (Month)" <> WS.Getint('Duration (Month)', input)) then
            SalesQuote.Validate("A01 Credit Duration (Month)", WS.Getint('Duration (Month)', input));

        if (SalesQuote."A01 Joint Type".AsInteger() <> WS.GetInt('Joint Type', input)) then
            SalesQuote.Validate("A01 Joint Type", WS.GetInt('Joint Type', input));

        if (SalesQuote."A01 Joint Code" <> WS.GetText('Joint Code', input)) then
            SalesQuote.Validate("A01 Joint Code", WS.GetText('Joint Code', input));

        if (SalesQuote."A01 Investigator Comments" <> WS.GetText('Investigator comments', input)) then
            SalesQuote.Validate("A01 Investigator Comments", WS.GetText('Investigator comments', input));

        if (SalesQuote."A01 Collection Opinion".AsInteger() <> WS.GetInt('Recovery Opinion', input)) then
            SalesQuote.Validate("A01 Collection Opinion", WS.GetInt('Recovery Opinion', input));

        if (SalesQuote."A01 Collection Comments" <> WS.GetText('Recovery comments', input)) then
            SalesQuote.Validate("A01 Collection Comments", WS.GetText('Recovery comments', input));

        if (SalesQuote."A01 Manager Opinion".AsInteger() <> WS.GetInt('Manager Opinion', input)) then
            SalesQuote.Validate("A01 Manager Opinion", WS.GetInt('Manager Opinion', input));

        if (SalesQuote."A01 Manager Comments" <> WS.GetText('Manager comments', input)) then
            SalesQuote.Validate("A01 Manager Comments", WS.GetText('Manager comments', input));

        if WS.KeyExists('Monthly Capacity', input) then
            if (SalesQuote."A01 Monthly Capacity" <> WS.GetDecimal('Monthly Capacity', input)) then
                SalesQuote.Validate("A01 Monthly Capacity", WS.GetDecimal('Monthly Capacity', input));

        if WS.KeyExists('Max Approved Rate (%)', input) then
            if (SalesQuote."A01 Max Approved Rate (%)" <> WS.GetDecimal('Max Approved Rate (%)', input)) then
                SalesQuote.Validate("A01 Max Approved Rate (%)", WS.GetDecimal('Max Approved Rate (%)', input));

        if WS.KeyExists('Max Referred Rate (%)', input) then
            if (SalesQuote."A01 Max Referred Rate (%)" <> WS.GetDecimal('Max Referred Rate (%)', input)) then
                SalesQuote.Validate("A01 Max Referred Rate (%)", WS.GetDecimal('Max Referred Rate (%)', input));

        if WS.KeyExists('Joint Required', input) then
            if (SalesQuote."A01 Joint Required" <> WS.GetBool('Joint Required', input)) then
                SalesQuote.Validate("A01 Joint Required", WS.GetBool('Joint Required', input));

        if WS.KeyExists('Rec. Amount', input) then
            if (SalesQuote."A01 Rec. Amount" <> WS.GetDecimal('Rec. Amount', input)) then
                SalesQuote.Validate("A01 Rec. Amount", WS.GetDecimal('Rec. Amount', input));

        if WS.KeyExists('Rec. Duration', input) then
            if (SalesQuote."A01 Rec. Duration" <> WS.GetDecimal('Rec. Duration', input)) then
                SalesQuote.Validate("A01 Rec. Duration", WS.GetDecimal('Rec. Duration', input));

        if WS.KeyExists('Rec. Deposit (%)', input) then
            if (SalesQuote."A01 Rec. Deposit (%)" <> WS.GetDecimal('Rec. Deposit (%)', input)) then
                SalesQuote.Validate("A01 Rec. Deposit (%)", WS.GetDecimal('Rec. Deposit (%)', input));

        if WS.KeyExists('General Comment', input) then
            if (SalesQuote."A01 General Comment" <> WS.GetText('General Comment', input)) then
                SalesQuote.Validate("A01 General Comment", WS.GetText('General Comment', input));

        jsonKey := 'Other Conditions';
        if WS.KeyExists(jsonKey, input) then
            if (SalesQuote."A01 Other Conditions" <> WS.GetText(jsonKey, input)) then
                SalesQuote.Validate("A01 Other Conditions", WS.GetText(jsonKey, input));

        jsonKey := 'HO Receipt Date';
        if WS.KeyExists(jsonKey, input) then
            if (SalesQuote."A01 HO Receipt Date" <> WS.GetDate(jsonKey, input)) then
                SalesQuote.Validate("A01 HO Receipt Date", WS.GetDate(jsonKey, input));

        jsonKey := 'Archive';
        if WS.KeyExists(jsonKey, input) then
            if (SalesQuote."A01 Archive" <> WS.GetBool(jsonKey, input)) then
                SalesQuote.Validate("A01 Archive", WS.GetBool(jsonKey, input));




        //[Monthly Capacity],[Max Approved Rate (%)],[Max Referred Rate (%)],[Joint Required],[Rec. Amount],[Rec. Duration],[Rec. Deposit (%)]
        //[Investigator comments] (text),  [Recovery Opinion] (optionlist), [Recovery comments] (text), [Manager Opinion] (optionlist), [Manager comments] (text)
    end;

    local procedure processSalesQuoteLine(SalesQuote: Record "Sales Header"; var SalesLine: Record "Sales Line"; input: JsonObject)
    var
        jsonKey: Text;
    begin

        if (SalesLine."Document No." <> SalesQuote."No.") then
            SalesLine."Document No." := SalesQuote."No.";

        if (SalesLine."Document Type" <> SalesLine."Document Type"::Quote) then
            SalesLine."Document Type" := SalesLine."Document Type"::Quote;

        if (SalesLine."Line No." <> WS.GetInt('Line No_', input)) then
            SalesLine."Line No." := WS.GetInt('Line No_', input);

        if (SalesLine.Type.AsInteger() <> WS.GetInt('Type', input)) then
            SalesLine.Validate(Type, WS.GetInt('Type', input));

        if (SalesLine.Type = SalesLine.Type::" ") then
            SalesLine.Description := CopyStr(WS.GetText('Description', input), 1, 100);

        if (SalesLine.Type = SalesLine.Type::Item) then begin

            if (SalesLine."No." <> WS.GetText('No_', input)) then
                SalesLine.Validate("No.", WS.GetText('No_', input));

            if (SalesLine."Variant Code" <> WS.GetText('Variant Code', input)) then
                SalesLine.Validate("Variant Code", WS.GetText('Variant Code', input));

            SalesLine.Description := CopyStr(WS.GetText('Description', input), 1, 100);

            SalesLine."Description 2" := CopyStr(WS.GetText('Description 2', input), 1, 50);


            if (SalesLine."Location Code" <> WS.GetText('Location Code', input)) then
                SalesLine.Validate("Location Code", WS.GetText('Location Code', input));

            if (SalesLine."Bin Code" <> WS.GetText('Bin Code', input)) then
                SalesLine.Validate("Bin Code", WS.GetText('Bin Code', input));


            if (SalesLine.Quantity <> WS.GetDecimal('Quantity', input)) then
                SalesLine.Validate(Quantity, WS.GetDecimal('Quantity', input));

            if (SalesLine."Unit of Measure Code" <> WS.GetText('Unit of Measure', input)) then
                SalesLine.Validate("Unit of Measure Code", WS.GetText('Unit of Measure', input));

            if (SalesLine."A01 Shipment Method Code" <> WS.GetText('Shipment Method Code', input)) then
                SalesLine.Validate("A01 Shipment Method Code", WS.GetText('Shipment Method Code', input));

            if (SalesLine."Unit Price" <> WS.GetDecimal('Unit Price', input)) then
                SalesLine.Validate("Unit Price", WS.GetDecimal('Unit Price', input));

            if (SalesLine."Prepayment %" <> WS.GetDecimal('Prepayment _', input)) then
                SalesLine.Validate("Prepayment %", WS.GetDecimal('Prepayment _', input));

            //if (SalesLine."Line Discount %" <> WS.GetDecimal('Line Discount _', input)) then
            //    SalesLine.Validate("Line Discount %", WS.GetDecimal('Line Discount _', input));

            jsonKey := 'Markup';
            if WS.KeyExists(jsonKey, input) then
                if (SalesLine."A01 Markup" <> WS.GetDecimal(jsonKey, input)) then
                    SalesLine.Validate("A01 Markup", WS.GetDecimal(jsonKey, input));

            jsonKey := 'Line Discount Amount';
            if WS.KeyExists(jsonKey, input) then
                if (SalesLine."Line Discount Amount" <> WS.GetDecimal(jsonKey, input)) then
                    SalesLine.Validate("Line Discount Amount", WS.GetDecimal(jsonKey, input));


            jsonKey := 'Free';
            if WS.KeyExists(jsonKey, input) then
                if (SalesLine."A01 Free" <> WS.GetBool(jsonKey, input)) then
                    SalesLine.Validate("A01 Free", WS.GetBool(jsonKey, input));

            jsonKey := 'Linked Line No_';
            if WS.KeyExists(jsonKey, input) then
                if (SalesLine."A01 Linked Line No." <> WS.GetInt(jsonKey, input)) then
                    SalesLine.Validate("A01 Linked Line No.", WS.GetInt(jsonKey, input));

            jsonKey := 'Additionnal Qty';
            if WS.KeyExists(jsonKey, input) then
                if (SalesLine."A01 Additionnal Qty" <> WS.GetDecimal(jsonKey, input)) then
                    SalesLine.Validate("A01 Additionnal Qty", WS.GetDecimal(jsonKey, input));

        end;
    end;

    local procedure processQuotesLines(SalesQuote: Record "Sales Header"; var SalesQuoteLine: Record "Sales Line"; input: JsonObject)
    var
        SalesLine: record "Sales Line";
        c: JsonToken;
        LinesArray: JsonArray;
        LineInput: JsonObject;
    begin

        SalesLine.Reset();
        SalesLine.SetRange("Document Type", SalesLine."Document Type"::Quote);
        SalesLine.SetRange("Document No.", SalesQuote."No.");
        if (not SalesLine.IsEmpty) then
            SalesLine.DeleteAll();

        input.Get('saleQuoteLines', c);
        LinesArray := c.AsArray();
        foreach c in LinesArray do begin
            LineInput := c.AsObject();
            AddOrInsertSalesQuoteLine(SalesQuote, SalesQuoteLine, LineInput);
        end;
    end;

    local procedure processCreditAmortisationLines(SalesQuote: Record "Sales Header"; input: JsonObject)
    var
        CreditAmortizationLine: Record "A01 Credit Depreciation Table";
        c: JsonToken;
        LinesArray: JsonArray;
        LineInput: JsonObject;
    begin

        CreditAmortizationLine.Reset();
        CreditAmortizationLine.SetRange("Document Type", CreditAmortizationLine."Document Type"::"Sales Quote");
        CreditAmortizationLine.SetRange("Document No.", SalesQuote."No.");
        if (not CreditAmortizationLine.IsEmpty) then
            CreditAmortizationLine.DeleteAll();

        input.Get('CreditAmortization', c);
        LinesArray := c.AsArray();
        foreach c in LinesArray do begin
            LineInput := c.AsObject();
            AddCreditAmortizationLine(SalesQuote, LineInput);
        end;
    end;

    local procedure processCustScoringLines(SalesQuote: Record "Sales Header"; input: JsonObject)
    var
        CustScoring: Record "A01 Customer Scoring";
        c: JsonToken;
        LinesArray: JsonArray;
        LineInput: JsonObject;
    begin

        if (SalesQuote."Sell-to Customer No." <> '') then begin
            CustScoring.Reset();
            CustScoring.SetRange("Customer No.", SalesQuote."Sell-to Customer No.");
            //CustScoring.SetRange("Document No.", SalesQuote."No.");
            if (not CustScoring.IsEmpty) then
                CustScoring.DeleteAll();
        end else begin
            CustScoring.Reset();
            CustScoring.SetRange("Customer No.", SalesQuote."Sell-to Contact No.");
            //CustScoring.SetRange("Document No.", SalesQuote."No.");
            if (not CustScoring.IsEmpty) then
                CustScoring.DeleteAll();
        end;

        input.Get('CustomerScoring', c);
        LinesArray := c.AsArray();
        foreach c in LinesArray do begin
            LineInput := c.AsObject();
            AddCustScoring(LineInput);
        end;
    end;


    local procedure processCustomerRequirements(SalesQuote: Record "Sales Header"; input: JsonObject)
    var
        CustCriteria: record "A01 Cust Scoring Criteria";
        NewCustCriteria: record "A01 Cust Scoring Criteria";
        Cust: Record "Customer";
        Cont: Record "Contact";
        c: JsonToken;
        LinesArray: JsonArray;
        LineInput: JsonObject;
        IsCust: Boolean;
        CustContactNo: Code[20];
    begin

        IsCust := SalesQuote."Sell-to Customer No." <> '';
        if (IsCust) then begin
            CustContactNo := SalesQuote."Sell-to Customer No.";
            Cust.Get(CustContactNo);
        end else begin
            CustContactNo := SalesQuote."Sell-to Contact No.";
            Cont.Get(CustContactNo);
        end;

        //Cust.Get(SalesQuote."Sell-to Customer No.");//
        if (IsCust) then begin
            CustCriteria.Reset();
            CustCriteria.SetRange("Account Type", CustCriteria."Account Type"::Customer);
            CustCriteria.SetRange("Customer No.", CustContactNo);
            if (not CustCriteria.IsEmpty) then
                CustCriteria.DeleteAll();
        end else begin
            CustCriteria.Reset();
            CustCriteria.SetRange("Account Type", CustCriteria."Account Type"::Prospect);
            CustCriteria.SetRange("Customer No.", CustContactNo);
            if (not CustCriteria.IsEmpty) then
                CustCriteria.DeleteAll();
        end;


        input.Get('CustomerRequirement', c);
        LinesArray := c.AsArray();
        foreach c in LinesArray do begin
            LineInput := c.AsObject();
            NewCustCriteria.Init();
            ProcessCustScoringCriteria(IsCust, CustContactNo, NewCustCriteria, '', LineInput);
            NewCustCriteria.Insert(true);
        end;
    end;

    local procedure ProcessCustScoringCriteria(IsCust: Boolean; CustContactNo: Code[20]; var CustScoringCriteria: Record "A01 Cust Scoring Criteria"; WebUser: Code[20]; input: JsonObject)
    begin

        if (IsCust) then
            if (CustScoringCriteria."Account Type" <> CustScoringCriteria."Account Type"::Customer) then
                CustScoringCriteria."Account Type" := CustScoringCriteria."Account Type"::Customer;

        if (not IsCust) then
            if (CustScoringCriteria."Account Type" <> CustScoringCriteria."Account Type"::Prospect) then
                CustScoringCriteria."Account Type" := CustScoringCriteria."Account Type"::Prospect;

        if (CustScoringCriteria."Customer No." <> CustContactNo) then
            CustScoringCriteria."Customer No." := CustContactNo;

        // if (CustCriteria.le <> WS.GetInt('Lead No', input)) then
        //     CustCriteria."Lead No" := WS.GetInt('Lead No', input);

        if (CustScoringCriteria.Criteria <> WS.GetText('Criteria', input)) then
            CustScoringCriteria."Criteria" := Copystr(WS.GetText('Criteria', input), 1, 20);

        // if (CustCriteria."Criteria Description" <> WS.GetText('Criteria Description', input)) then
        //    CustCriteria.Validate("Criteria Description", WS.GetText('Criteria Description', input));

        // if (CustCriteria."Type".AsInteger() <> WS.GetInt('Value Type', input)) then
        //     CustCriteria.Validate("Type", WS.GetInt('Value Type', input));

        // if (CustCriteria.va.AsInteger() <> WS.GetInt('Value Length', input)) then
        //             CustCriteria.Validate("Type", WS.GetInt('Value Length', input));

        // if (CustCriteria.Requirement.AsInteger() <> WS.GetInt('Requirement', input)) then
        //     CustCriteria.Validate("Requirement", WS.GetInt('Requirement', input));

        if (CustScoringCriteria."Numeric Value" <> WS.GetDecimal('Numeric Value', input)) then
            CustScoringCriteria.Validate("Numeric Value", WS.GetDecimal('Numeric Value', input));

        if (CustScoringCriteria."Aplhanumeric Value" <> WS.GetText('Alpha Value', input)) then
            CustScoringCriteria.Validate("Aplhanumeric Value", WS.GetText('Alpha Value', input));

        if WS.KeyExists('Date Value', input) then
            if (CustScoringCriteria."Date Value" <> WS.GetDate('Date Value', input)) then
                CustScoringCriteria.Validate("Date Value", WS.GetDate('Date Value', input));

        // if (CustCriteria.Validity.AsInteger() <> WS.GetInt('Validity', input)) then
        //     CustCriteria.Validate("Validity", WS.GetInt('Validity', input));

        //TODO TEST JSON HERE
        if (CustScoringCriteria."Validity Date" <> WS.GetDate('Validity Date', input)) then
            CustScoringCriteria.Validate("Validity Date", WS.GetDate('Validity Date', input));

        // if (CustCriteria."Document Required" <> WS.GetBool('Document required', input)) then
        //     CustCriteria.Validate("Document Required", WS.GetBool('Document required', input));

        if (CustScoringCriteria.DocumentLink <> WS.GetText('Document Link', input)) then
            CustScoringCriteria.Validate("DocumentLink", WS.GetText('Document Link', input));

        if (CustScoringCriteria.Valid <> WS.GetBool('Valid', input)) then
            CustScoringCriteria.Validate("Valid", WS.GetBool('Valid', input));

        //if (CustCriteria."Modified By" <> WS.GetText('Updated by', input)) then
        CustScoringCriteria.Validate("Modified By", WebUser);
        if (CustScoringCriteria."Created By" = '') then
            CustScoringCriteria.Validate("Created By", WebUser);

    end;

    /// ///JSON conversion devis renvoie le numéro de la commande générée
    //{"inputJson":"{\"Parameter\":\"quotes_makeorder\",\"webUserName\":\"\",\"QuoteNo\":\"101005\",\"IsDeletion\":0}"}
    /// <summary>
    /// 
    /// </summary>
    /// <param name="input"></param>
    /// <returns>Return value of type Text.</returns>
    procedure MakeOrder(input: JsonObject): Text
    var
        NoQuote: text;
        WebUser: text;
        DeferredMonth: integer;
    begin
        NoQuote := ws.GetText('QuoteNo', input);
        WebUser := ws.GetText('webUserName', input);
        DeferredMonth := ws.GetInt('Deferred month', input);
        if (NoQuote <> '') then
            exit(QuoteToOrder(NoQuote, WebUser, DeferredMonth));
    end;

    ///JSON demande d'approbation devis: renvoie le nouveau statut du devis
    //{"inputJson":"{\"Parameter\":\"quotes_requestApproval\",\"webUserName\":\"GERALD\",\"webUserResponsibilityCenter\":\"CG001\",\"QuoteNo\":\"101005\"}"}
    /// <summary>
    /// RequestApproval.
    /// </summary>
    /// <param name="input">JsonObject.</param>
    /// <returns>Return value of type Text.</returns>
    procedure RequestApproval(input: JsonObject): Text
    var
        NoQuote: text;
    //WebUser: text;
    begin
        NoQuote := ws.GetText('QuoteNo', input);
        //WebUser := ws.GetText('webUserName', input);
        if (NoQuote <> '') then
            exit(SendApprovalRequest(NoQuote));
    end;


    local procedure QuoteToOrder(NoQuote: text; WebUserId: text; DeferredMonths: integer): Text
    var
        SalesQuote: Record "Sales Header";
        SalesOrder: Record "Sales Header";
        SalesQuoteToOrder: Codeunit "Sales-Quote to Order";
        ApprovalsMgmt: Codeunit "Approvals Mgmt.";

    begin
        if (SalesQuote.get(SalesQuote."Document Type"::Quote, NoQuote)) then begin

            if (ApprovalsMgmt.PrePostApprovalCheckSales(SalesQuote)) then begin
                SalesQuote."A01 Order Web User Id" := CopyStr(WebUserId, 1, 50);
                SalesQuote."A01 Deferred month" := DeferredMonths;
                SalesQuote.Modify();

                if SalesQuote.CheckCustomerCreated(false) then
                    SalesQuote.Get(SalesQuote."Document Type"::Quote, SalesQuote."No.")
                else
                    exit;

                //Copy scoring and criteria

                SalesQuoteToOrder.Run(SalesQuote);
                SalesQuoteToOrder.GetSalesOrderHeader(SalesOrder);
                //Commit();
                exit(Ws.CreateResponseSuccess(SalesOrder."No."));
            end

        end else
            exit(Ws.CreateResponseError(StrSubstNo(LblErrorQuoteNotExists, NoQuote)));
    end;

    ///JSON demande de prix : renvoie le prix
    //{"inputJson":"{\"Parameter\":\"item_getPrice\",\"itemCode\":\"54555\",\"CustomerCode\":\"CMZCASH\",\"CampaignCode\":\"\"}"}
    /// <summary>
    /// GetUnitPrice.
    /// </summary>
    /// <param name="input">JsonObject.</param>
    /// <returns>Return value of type Text.</returns>
    procedure GetUnitPrice(input: JsonObject): Text
    var
        QuoteNo: Code[20];
        itemCode: Code[20];
    //CampaignCode: Code[20];
    begin
        QuoteNo := CopyStr(ws.GetText('QuoteNo', input), 1, 20);
        itemCode := CopyStr(ws.GetText('itemCode', input), 1, 20);
        //CampaignCode := CopyStr(ws.GetText('CampaignCode', input), 1, 20);
        exit(GetPrice(QuoteNo, itemCode));
    end;

    local procedure GetPrice(QuoteNo: Code[20]; ItemNo: Code[20]): Text
    var
        TempSalesLine: Record "Sales Line" temporary;
        //TempSalesHeader: Record "Sales Header" temporary;
        PriceText: Code[20];
    begin
        /*TempSalesHeader.Init();
        TempSalesHeader."Document Type" := TempSalesHeader."Document Type"::Quote;
        TempSalesHeader."No." := '';
        TempSalesHeader.Insert(true);

        TempSalesHeader.Validate("Sell-to Customer No.", CustNo);
        if (CampainNo = '') then
            TempSalesHeader.Validate("Campaign No.", CampainNo);*/

        TempSalesLine.Init();
        TempSalesLine."Document Type" := TempSalesLine."Document Type"::Quote;
        TempSalesLine."Document No." := QuoteNo;

        TempSalesLine.Validate(Type, TempSalesLine.Type::Item);
        TempSalesLine.Validate("No.", ItemNo);
        //TempSalesLine.Validate(Quantity, 1);
        PriceText := Format(TempSalesLine."Unit Price");
        exit(Ws.CreateResponseSuccess(PriceText));
    end;

    local procedure SendApprovalRequest(NoQuote: text): Text
    var
        SalesQuote: Record "Sales Header";
        ApprovalsMgmt: Codeunit "Approvals Mgmt.";

    begin
        if (SalesQuote.get(SalesQuote."Document Type"::Quote, NoQuote)) then begin

            if ApprovalsMgmt.CheckSalesApprovalPossible(SalesQuote) then
                ApprovalsMgmt.OnSendSalesDocForApproval(SalesQuote);
            exit(Ws.CreateResponseSuccess(SalesQuote."No."));

        end else
            exit(Ws.CreateResponseError(StrSubstNo(LblErrorQuoteNotExists, NoQuote)));
    end;

    // local procedure ReOpen(NoQuote: text): Text
    // var
    //     SalesQuote: Record "Sales Header";
    //     ApprovalsMgmt: Codeunit "Sales Manual Reopen";

    // begin
    //     if (SalesQuote.get(SalesQuote."Document Type"::Quote, NoQuote)) then begin

    //         if ApprovalsMgmt.CheckSalesApprovalPossible(SalesQuote) then
    //             ApprovalsMgmt.OnSendSalesDocForApproval(SalesQuote);
    //         exit(Ws.CreateResponseSuccess(SalesQuote."No."));

    //     end else
    //         exit(Ws.CreateResponseError(StrSubstNo(LblErrorQuoteNotExists, NoQuote)));
    // end;

    local procedure AddCreditAmortizationLine(CreditRequest: Record "Sales Header"; input: JsonObject)
    var
        CreditAmortizationLine: Record "A01 Credit Depreciation Table";
    begin
        CreditAmortizationLine.Init();
        processCreditAmortizationLine(CreditRequest, CreditAmortizationLine, input);
        CreditAmortizationLine.Insert();
    end;

    local procedure processCreditAmortizationLine(CreditRequest: Record "Sales Header"; var CreditAmortizationLine: Record "A01 Credit Depreciation Table"; input: JsonObject)
    begin

        if (CreditRequest."Document Type" = CreditRequest."Document Type"::Quote) then
            CreditAmortizationLine."Document Type" := CreditAmortizationLine."Document Type"::"Sales Quote";
        if (CreditRequest."Document Type" = CreditRequest."Document Type"::Order) then
            CreditAmortizationLine."Document Type" := CreditAmortizationLine."Document Type"::"Sales order";
        if (CreditRequest."Document Type" = CreditRequest."Document Type"::Invoice) then
            CreditAmortizationLine."Document Type" := CreditAmortizationLine."Document Type"::"Posted Sales invoice";

        CreditAmortizationLine."Document No." := CreditRequest."No.";

        if (CreditAmortizationLine."Line No." <> WS.GetInt('Line No_', input)) then
            CreditAmortizationLine."Line No." := WS.GetInt('Line No_', input);

        if (CreditAmortizationLine."Calculation factor" <> WS.GetDecimal('Calculation factor', input)) then
            CreditAmortizationLine."Calculation factor" := WS.GetDecimal('Calculation factor', input);

        if (CreditAmortizationLine."Monthly payment" <> WS.GetDecimal('Monthly payment', input)) then
            CreditAmortizationLine."Monthly payment" := WS.GetDecimal('Monthly payment', input);

        if (CreditAmortizationLine."Interest" <> WS.GetDecimal('Interest', input)) then
            CreditAmortizationLine."Interest" := WS.GetDecimal('Interest', input);

        if (CreditAmortizationLine."Depreciation" <> WS.GetDecimal('Depreciation', input)) then
            CreditAmortizationLine."Depreciation" := WS.GetDecimal('Depreciation', input);

        if (CreditAmortizationLine."Remaining debt" <> WS.GetDecimal('Remaining debt', input)) then
            CreditAmortizationLine."Remaining debt" := WS.GetDecimal('Remaining debt', input);

        if (CreditAmortizationLine."Abandoned interests" <> WS.GetDecimal('Abandoned interests', input)) then
            CreditAmortizationLine."Abandoned interests" := WS.GetDecimal('Abandoned interests', input);

        if (CreditAmortizationLine."Payment balance" <> WS.GetDecimal('Payment balance', input)) then
            CreditAmortizationLine."Payment balance" := WS.GetDecimal('Payment balance', input);

    end;

    local procedure AddCustScoring(input: JsonObject)
    var
        CustScoring: Record "A01 Customer Scoring";
    begin
        CustScoring.Init();
        processCustomerScoring(CustScoring, input);
        CustScoring.Insert();
    end;

    local procedure processCustomerScoring(var CustScoring: Record "A01 Customer Scoring"; input: JsonObject)
    var
        CustRec: Record Customer;
        ContactRec: Record Contact;
        validityValue: Integer;
    begin

        if (CustRec.Get(WS.GetText('Customer No_', input))) then
            if (CustScoring."Account Type" <> CustScoring."Account Type"::Customer) then
                CustScoring."Account Type" := CustScoring."Account Type"::Customer;
        if (ContactRec.Get(WS.GetText('Customer No_', input))) then
            if (CustScoring."Account Type" <> CustScoring."Account Type"::Prospect) then
                CustScoring."Account Type" := CustScoring."Account Type"::Prospect;


        if (CustScoring."Customer No." <> WS.GetText('Customer No_', input)) then
            CustScoring."Customer No." := CopyStr(WS.GetText('Customer No_', input), 1, 20);

        if (CustScoring.Criteria <> WS.GetText('Criteria', input)) then
            CustScoring.Criteria := CopyStr(WS.GetText('Criteria', input), 1, 20);

        validityValue := WS.GetInt('Validity', input);
        if (validityValue = 0) then
            CustScoring."Validity" := CustScoring."Validity"::Limited;
        if (validityValue = 1) then
            CustScoring."Validity" := CustScoring."Validity"::Unlimited;

        if (CustScoring.Valid <> WS.GetBool('Valid', input)) then
            CustScoring."Valid" := WS.GetBool('Valid', input);

        if (CustScoring."Validity Date" <> WS.GetDate('Validity Date', input)) then
            CustScoring."Validity Date" := WS.GetDate('Validity Date', input);

        if (CustScoring.Coefficient <> WS.GetDecimal('Coefficient', input)) then
            CustScoring.Coefficient := WS.GetDecimal('Coefficient', input);

        if (CustScoring."Document Required" <> WS.GetBool('Document required', input)) then
            CustScoring."Document Required" := WS.GetBool('Document required', input);

        // if (CustScoring.Type <> WS.GetText('Type', input)) then
        //CustScoring."Type" := WS.GetText('Type', input);

        if (CustScoring."DocumentLink" <> WS.GetText('Document Link', input)) then
            CustScoring."DocumentLink" := CopyStr(WS.GetText('Document Link', input), 1, 100);

        if (CustScoring.Precision <> WS.GetText('Precision', input)) then
            CustScoring."Precision" := CopyStr(WS.GetText('Precision', input), 1, 50);

        if (CustScoring."Criteria Value" <> WS.GetText('List Value', input)) then
            CustScoring."Criteria Value" := CopyStr(WS.GetText('List Value', input), 1, 20);

        if (CustScoring.Score <> WS.GetDecimal('Point', input)) then
            CustScoring."Score" := WS.GetDecimal('Point', input);

        if (CustScoring."Weighted Score" <> WS.GetDecimal('Weighed Point', input)) then
            CustScoring."Weighted Score" := WS.GetDecimal('Weighed Point', input);

        if (CustScoring."Modified By" <> WS.GetText('Updated by', input)) then
            CustScoring."Modified By" := CopyStr(WS.GetText('Updated by', input), 1, 50);

    end;

    local procedure processSaleQuoteApprovalFlows(SalesQuote: Record "Sales Header"; input: JsonObject)
    var
        ApprovalFlow: Record "A01 Approval Flow";
        c: JsonToken;
        LinesArray: JsonArray;
        LineInput: JsonObject;
    begin

        ApprovalFlow.Reset();
        ApprovalFlow.SetRange("Document Type", ApprovalFlow."Document Type"::Quote);
        ApprovalFlow.SetRange("Document No.", SalesQuote."No.");
        if (not ApprovalFlow.IsEmpty) then
            ApprovalFlow.DeleteAll();


        input.Get('saleQuoteApprovalFlow', c);
        LinesArray := c.AsArray();
        foreach c in LinesArray do begin
            LineInput := c.AsObject();
            AddSaleQuoteApprovalFlow(LineInput);
        end;
    end;

    local procedure AddSaleQuoteApprovalFlow(input: JsonObject)
    var
        ApprFlow: Record "A01 Approval Flow";
    begin
        ApprFlow.Init();
        processSaleQuoteApprovalFlow(ApprFlow, input);
        ApprFlow.Insert();
    end;

    local procedure processSaleQuoteApprovalFlow(var ApprFlow: Record "A01 Approval Flow"; input: JsonObject)
    var
    begin

        if (ApprFlow."Document Type".AsInteger() <> WS.GetInt('Document Type', input)) then
            ApprFlow.Validate("Document Type", WS.GetInt('Document Type', input));

        if (ApprFlow."Document No." <> WS.GetText('Document No_', input)) then
            ApprFlow.Validate("Document No.", WS.GetText('Document No_', input));

        if (ApprFlow."Sequence No." <> WS.GetInt('Approval Sequence', input)) then
            ApprFlow.Validate("Sequence No.", WS.GetInt('Approval Sequence', input));

        if (ApprFlow.Method.AsInteger() <> WS.GetInt('Approval Mode', input)) then
            ApprFlow.Validate("Method", WS.GetInt('Approval Mode', input));

        if (ApprFlow."Approved On" <> WS.GetDatetime('Approved On', input)) then
            ApprFlow.Validate("Approved On", WS.GetDatetime('Approved On', input));

        if (ApprFlow."Approved By" <> WS.GetText('Approved by', input)) then
            ApprFlow.Validate("Approved By", WS.GetText('Approved by', input));

        if (ApprFlow."Approved As" <> WS.GetText('Approved as', input)) then
            ApprFlow.Validate("Approved As", WS.GetText('Approved as', input));

        if (ApprFlow."Actual Status".AsInteger() <> WS.GetInt('Actual Status', input)) then
            ApprFlow.Validate("Actual Status", WS.GetInt('Actual Status', input));

        if (ApprFlow."Next Status".AsInteger() <> WS.GetInt('Next Status', input)) then
            ApprFlow.Validate("Next Status", WS.GetInt('Next Status', input));

        if (ApprFlow.Comments <> WS.GetText('Comments', input)) then
            ApprFlow.Validate("Comments", WS.GetText('Comments', input));

    end;


}
