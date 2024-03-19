/// <summary>
/// Codeunit A01 WS QuotesMgt (ID 50005). ApiQuotes
/// </summary>
codeunit 50005 "A01 WS QuotesMgt"
{

    var
        WS: codeunit "A01 Api Mgt";

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

    local procedure ModifyQuote(QuoteNo: Text; input: JsonObject): Text
    var
        SalesQuote: Record "Sales Header";
        SalesQuoteLine: Record "Sales Line";
    begin

        SalesQuote.Get(SalesQuote."Document Type"::Quote, QuoteNo);

        ProcessSalesQuoteHeader(SalesQuote, input);

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

        processQuotesLines(SalesQuote, SalesQuoteLine, input);

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
        if (SalesL.IsEmpty) then begin

            SalesLine.Init();

            processSalesQuoteLine(SalesQuote, SalesLine, input);

            SalesLine.Insert();

        end else begin

            processSalesQuoteLine(SalesQuote, SalesLine, input);

        end;
        ;

    end;

    local procedure ProcessSalesQuoteHeader(var SalesQuote: Record "Sales Header"; input: JsonObject)
    begin

        //SalesQuote.Validate("Sell-to Customer No.", GetText('customerNo', input));
        if (SalesQuote."Sell-to Customer No." <> WS.GetText('customerNo', input)) then
            SalesQuote.Validate("Sell-to Customer No.", WS.GetText('customerNo', input));

        if (SalesQuote."Sell-to Contact No." <> WS.GetText('customerContactCode', input)) then
            SalesQuote.Validate("Sell-to Contact No.", WS.GetText('customerContactCode', input));

        if (SalesQuote."Sell-to Address" <> WS.GetText('customerAddrese', input)) then
            SalesQuote.Validate("Sell-to Address", WS.GetText('customerAddrese', input));

        if (SalesQuote."Sell-to Address 2" <> WS.GetText('customerAddresse2', input)) then
            SalesQuote.Validate("Sell-to Address 2", WS.GetText('customerAddresse2', input));

        if (SalesQuote."Sell-to City" <> WS.GetText('customerCity', input)) then
            SalesQuote.Validate("Sell-to City", WS.GetText('customerCity', input));

        if (SalesQuote."Sell-to Phone No." <> WS.GetText('customerPhoneNo', input)) then
            SalesQuote.Validate("Sell-to Phone No.", WS.GetText('customerPhoneNo', input));

        if (SalesQuote."Sell-to Address" <> WS.GetText('customerEmailAddress', input)) then
            SalesQuote.Validate("Sell-to Address", WS.GetText('customerEmailAddress', input));

        if (SalesQuote."Sell-to Address" <> WS.GetText('saleQuoteOrderDate', input)) then
            SalesQuote.Validate("Sell-to Address", WS.GetText('saleQuoteOrderDate', input));

        if (SalesQuote."Sell-to Address" <> WS.GetText('saleQuoteDocumentDate', input)) then
            SalesQuote.Validate("Sell-to Address", WS.GetText('saleQuoteDocumentDate', input));

        if (SalesQuote."Quote Valid Until Date" <> WS.GetDate('saleQuoteValidUntilDate', input)) then
            SalesQuote.Validate("Quote Valid Until Date", WS.GetDate('saleQuoteValidUntilDate', input));

        if (SalesQuote."Requested Delivery Date" <> WS.GetDate('saleQuoteShipRequestedDate', input)) then
            SalesQuote.Validate("Requested Delivery Date", WS.GetDate('saleQuoteShipRequestedDate', input));

        if (SalesQuote."Responsibility Center" <> WS.GetText('saleQuoteResponsibilityCenter', input)) then
            SalesQuote.Validate("Responsibility Center", WS.GetText('saleQuoteResponsibilityCenter', input));

        if (SalesQuote."Gen. Bus. Posting Group" <> WS.GetText('customerGenBusPostingGroup', input)) then
            SalesQuote.Validate("Gen. Bus. Posting Group", WS.GetText('customerGenBusPostingGroup', input));

        if (SalesQuote."VAT Bus. Posting Group" <> WS.GetText('customerVATBusPostingGroup', input)) then
            SalesQuote.Validate("VAT Bus. Posting Group", WS.GetText('customerVATBusPostingGroup', input));

        if (SalesQuote."Shipment Method Code" <> WS.GetText('customerShipmentMethodCode', input)) then
            SalesQuote.Validate("Shipment Method Code", WS.GetText('customerShipmentMethodCode', input));

        if (SalesQuote."Ship-to Code" <> WS.GetText('saleQuoteShipToCode', input)) then
            SalesQuote.Validate("Ship-to Code", WS.GetText('saleQuoteShipToCode', input));

        if (SalesQuote."Location Code" <> WS.GetText('saleQuoteLocationCode', input)) then
            SalesQuote.Validate("Location Code", WS.GetText('saleQuoteLocationCode', input));

        if (SalesQuote."Payment Method Code" <> WS.GetText('customerPaymentMethodCode', input)) then
            SalesQuote.Validate("Payment Method Code", WS.GetText('customerPaymentMethodCode', input));

        if (SalesQuote."Payment Terms Code" <> WS.GetText('customerPaymentTermsCode', input)) then
            SalesQuote.Validate("Payment Terms Code", WS.GetText('customerPaymentTermsCode', input));

        if (SalesQuote."Due Date" <> WS.GetDate('saleQuoteDueDate', input)) then
            SalesQuote.Validate("Due Date", WS.GetDate('saleQuoteDueDate', input));

        if (SalesQuote."A01 User Id" <> WS.GetText('webUserName', input)) then
            SalesQuote.Validate("A01 User Id", WS.GetText('webUserName', input));


        SalesQuote.Modify();
    end;

    local procedure processSalesQuoteLine(SalesQuote: Record "Sales Header"; var SalesLine: Record "Sales Line"; input: JsonObject)
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

            SalesLine.Description := CopyStr(WS.GetText('Description', input), 1, 100);

            SalesLine."Description 2" := CopyStr(WS.GetText('Description 2', input), 1, 50);

            if (SalesLine."Location Code" <> WS.GetText('Location Code', input)) then
                SalesLine.Validate("Location Code", WS.GetText('Location Code', input));

            if (SalesLine.Quantity <> WS.GetDecimal('Quantity', input)) then
                SalesLine.Validate(Quantity, WS.GetDecimal('Quantity', input));

            if (SalesLine."Unit of Measure Code" <> WS.GetText('Unit of Measure', input)) then
                SalesLine.Validate("Unit of Measure Code", WS.GetText('Unit of Measure', input));

            if (SalesLine."Unit Price" <> WS.GetDecimal('Unit Price', input)) then
                SalesLine.Validate("Unit Price", WS.GetDecimal('Unit Price', input));

            if (SalesLine."Line Discount %" <> WS.GetDecimal('Line Discount _', input)) then
                SalesLine.Validate("Line Discount %", WS.GetDecimal('Line Discount _', input));

        end;
    end;

    local procedure processQuotesLines(SalesQuote: Record "Sales Header"; var SalesQuoteLine: Record "Sales Line"; input: JsonObject)
    var
        c: JsonToken;
        LinesArray: JsonArray;
        LineInput: JsonObject;
    begin
        input.Get('saleQuoteLines', c);
        LinesArray := c.AsArray();
        foreach c in LinesArray do begin
            LineInput := c.AsObject();
            AddOrInsertSalesQuoteLine(SalesQuote, SalesQuoteLine, LineInput);
        end;
    end;

    /// <summary>
    /// 
    /// </summary>
    /// <param name="input"></param>
    /// <returns>Return value of type Text.</returns>
    procedure MakeOrder(input: JsonObject): Text
    var
        NoQuote: text;
    begin
        NoQuote := ws.GetText('QuoteNo', input);
        if (NoQuote <> '') then
            exit(QuoteToOrder(NoQuote));
    end;

    local procedure QuoteToOrder(NoQuote: text): Text
    var
        SalesQuote: Record "Sales Header";
        SalesOrder: Record "Sales Header";
        SalesQuoteToOrder: Codeunit "Sales-Quote to Order";

    begin
        if (SalesQuote.get(SalesQuote."Document Type"::Quote, NoQuote)) then begin
            SalesQuoteToOrder.Run(SalesQuote);
            SalesQuoteToOrder.GetSalesOrderHeader(SalesOrder);
            Commit();
            exit(Ws.CreateResponseSuccess(SalesOrder."No."));
        end;
    end;
}
