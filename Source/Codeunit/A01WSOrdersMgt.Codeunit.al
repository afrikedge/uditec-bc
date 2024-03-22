codeunit 50009 "A01 WS OrdersMgt"
{
    var
        WS: codeunit "A01 Api Mgt";
        LblErrorQuoteNotExists: Label 'The order N° %1 does not exists', Comment = '%1 = QuoteNo';

    /// <summary>
    /// Run.
    /// </summary>
    /// <param name="input">JsonObject.</param>
    /// <param name="IsDeletion">Boolean.</param>
    /// <returns>Return value of type Text.</returns>
    procedure Run(input: JsonObject; IsDeletion: Boolean): Text
    var
        NoOrder: text;
    //ToDelete: Boolean;
    begin
        //input.ReadFrom(inputJson);
        NoOrder := ws.GetText('OrderNo', input);
        if (NoOrder <> '') then begin

            //ToDelete := ws.GetBool('IsDeletion', input);
            if (IsDeletion) then
                exit(DeleteOrder(NoOrder))
            else
                exit(ModifyOrder(NoOrder, input))

        end else
            exit(AddOrder(input));
    end;

    local procedure ModifyOrder(OrderNo: Text; input: JsonObject): Text
    var
        SalesOrder: Record "Sales Header";
        SalesOrderLine: Record "Sales Line";
    begin

        SalesOrder.Get(SalesOrder."Document Type"::Order, OrderNo);

        ProcessSalesOrderHeader(SalesOrder, input);

        processOrdersLines(SalesOrder, SalesOrderLine, input);

        exit(Ws.CreateResponseSuccess(SalesOrder."No."));

    end;

    local procedure AddOrder(input: JsonObject): Text
    var
        SalesOrder: Record "Sales Header";
        SalesOrderLine: Record "Sales Line";
    begin

        SalesOrder.Init();
        SalesOrder."Document Type" := SalesOrder."Document Type"::Order;
        SalesOrder."No." := '';

        SalesOrderLine.LockTable();
        SalesOrder.Insert(true);

        ProcessSalesOrderHeader(SalesOrder, input);

        processOrdersLines(SalesOrder, SalesOrderLine, input);

        exit(Ws.CreateResponseSuccess(SalesOrder."No."));

    end;

    local procedure DeleteOrder(OrderNo: Text): Text
    var
        SalesOrder: Record "Sales Header";
    begin

        SalesOrder.Get(SalesOrder."Document Type"::Order, OrderNo);

        SalesOrder.Delete(true);

        exit(Ws.CreateResponseSuccess(SalesOrder."No."));

    end;

    local procedure AddOrInsertSalesOrderLine(SalesOrder: Record "Sales Header"; var SalesLine: Record "Sales Line"; input: JsonObject)
    var
        SalesL: Record "Sales Line";
    begin


        SalesL.Reset();
        SalesL.SetRange("Document Type", SalesOrder."Document Type");
        SalesL.SetRange("Document No.", SalesOrder."No.");
        SalesL.SetRange("Line No.", WS.GetInt('Line No_', input));
        if (SalesL.IsEmpty) then begin

            SalesLine.Init();

            processSalesOrderLine(SalesOrder, SalesLine, input);

            SalesLine.Insert();

        end else begin

            processSalesOrderLine(SalesOrder, SalesLine, input);

        end;
        ;

    end;

    local procedure ProcessSalesOrderHeader(var SalesOrder: Record "Sales Header"; input: JsonObject)
    begin

        if (SalesOrder."Sell-to Customer No." <> WS.GetText('customerNo', input)) then
            SalesOrder.Validate("Sell-to Customer No.", WS.GetText('customerNo', input));

        if (SalesOrder."Sell-to Contact No." <> WS.GetText('customerContactCode', input)) then
            SalesOrder.Validate("Sell-to Contact No.", WS.GetText('customerContactCode', input));

        if (SalesOrder."Sell-to Address" <> WS.GetText('customerAddrese', input)) then
            SalesOrder.Validate("Sell-to Address", WS.GetText('customerAddrese', input));

        if (SalesOrder."Sell-to Address 2" <> WS.GetText('customerAddresse2', input)) then
            SalesOrder.Validate("Sell-to Address 2", WS.GetText('customerAddresse2', input));

        if (SalesOrder."Sell-to City" <> WS.GetText('customerCity', input)) then
            SalesOrder.Validate("Sell-to City", WS.GetText('customerCity', input));

        if (SalesOrder."Sell-to Phone No." <> WS.GetText('customerPhoneNo', input)) then
            SalesOrder.Validate("Sell-to Phone No.", WS.GetText('customerPhoneNo', input));

        if (SalesOrder."Sell-to Address" <> WS.GetText('customerEmailAddress', input)) then
            SalesOrder.Validate("Sell-to Address", WS.GetText('customerEmailAddress', input));

        if (SalesOrder."Sell-to Address" <> WS.GetText('saleOrderOrderDate', input)) then
            SalesOrder.Validate("Sell-to Address", WS.GetText('saleOrderOrderDate', input));

        if (SalesOrder."Sell-to Address" <> WS.GetText('saleOrderDocumentDate', input)) then
            SalesOrder.Validate("Sell-to Address", WS.GetText('saleOrderDocumentDate', input));

        //if (SalesOrder."Quote Valid Until Date" <> WS.GetDate('saleOrderValidUntilDate', input)) then
        //    SalesOrder.Validate("Quote Valid Until Date", WS.GetDate('saleOrderValidUntilDate', input));

        if (SalesOrder."Requested Delivery Date" <> WS.GetDate('saleOrderShipRequestedDate', input)) then
            SalesOrder.Validate("Requested Delivery Date", WS.GetDate('saleOrderShipRequestedDate', input));

        if (SalesOrder."Responsibility Center" <> WS.GetText('saleOrderResponsibilityCenter', input)) then
            SalesOrder.Validate("Responsibility Center", WS.GetText('saleOrderResponsibilityCenter', input));

        if (SalesOrder."Gen. Bus. Posting Group" <> WS.GetText('customerGenBusPostingGroup', input)) then
            SalesOrder.Validate("Gen. Bus. Posting Group", WS.GetText('customerGenBusPostingGroup', input));

        if (SalesOrder."VAT Bus. Posting Group" <> WS.GetText('customerVATBusPostingGroup', input)) then
            SalesOrder.Validate("VAT Bus. Posting Group", WS.GetText('customerVATBusPostingGroup', input));

        if (SalesOrder."Shipment Method Code" <> WS.GetText('customerShipmentMethodCode', input)) then
            SalesOrder.Validate("Shipment Method Code", WS.GetText('customerShipmentMethodCode', input));

        if (SalesOrder."Ship-to Code" <> WS.GetText('saleOrderShipToCode', input)) then
            SalesOrder.Validate("Ship-to Code", WS.GetText('saleOrderShipToCode', input));

        if (SalesOrder."Location Code" <> WS.GetText('saleOrderLocationCode', input)) then
            SalesOrder.Validate("Location Code", WS.GetText('saleOrderLocationCode', input));

        if (SalesOrder."Payment Method Code" <> WS.GetText('customerPaymentMethodCode', input)) then
            SalesOrder.Validate("Payment Method Code", WS.GetText('customerPaymentMethodCode', input));

        if (SalesOrder."Payment Terms Code" <> WS.GetText('customerPaymentTermsCode', input)) then
            SalesOrder.Validate("Payment Terms Code", WS.GetText('customerPaymentTermsCode', input));

        if (SalesOrder."Due Date" <> WS.GetDate('saleOrderDueDate', input)) then
            SalesOrder.Validate("Due Date", WS.GetDate('saleOrderDueDate', input));

        if (SalesOrder."A01 Web User Id" <> WS.GetText('webUserName', input)) then
            SalesOrder.Validate("A01 Web User Id", WS.GetText('webUserName', input));


        SalesOrder.Modify();
    end;

    local procedure processSalesOrderLine(SalesOrder: Record "Sales Header"; var SalesLine: Record "Sales Line"; input: JsonObject)
    begin

        if (SalesLine."Document No." <> SalesOrder."No.") then
            SalesLine."Document No." := SalesOrder."No.";

        if (SalesLine."Document Type" <> SalesLine."Document Type"::Order) then
            SalesLine."Document Type" := SalesLine."Document Type"::Order;

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

    local procedure processOrdersLines(SalesOrder: Record "Sales Header"; var SalesOrderLine: Record "Sales Line"; input: JsonObject)
    var
        c: JsonToken;
        LinesArray: JsonArray;
        LineInput: JsonObject;
    begin
        input.Get('saleOrderLines', c);
        LinesArray := c.AsArray();
        foreach c in LinesArray do begin
            LineInput := c.AsObject();
            AddOrInsertSalesOrderLine(SalesOrder, SalesOrderLine, LineInput);
        end;
    end;

    /// <summary>
    /// ValidateDraft.
    /// </summary>
    /// <param name="input">JsonObject.</param>
    /// <returns>Return value of type Text.</returns>
    procedure ValidateDraft(input: JsonObject): Text
    var
        NoOrder: text;
    //WebUser: text;
    begin
        NoOrder := ws.GetText('OrderNo', input);
        //WebUser := ws.GetText('webUserName', input);
        if (NoOrder <> '') then
            exit(ProcessOrder(NoOrder));
    end;

    local procedure ProcessOrder(NoOrder: text): Text
    var
        SalesQuote: Record "Sales Header";
        OrderMgt: Codeunit "A01 Sales Order Processing";

    begin
        if (SalesQuote.get(SalesQuote."Document Type"::Order, NoOrder)) then begin

            OrderMgt.ValidateDraft(SalesQuote);
            exit(Ws.CreateResponseSuccess(SalesQuote."No."));

        end else
            exit(Ws.CreateResponseError(StrSubstNo(LblErrorQuoteNotExists, NoOrder)));
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
    begin
        QuoteNo := CopyStr(ws.GetText('OrderNo', input), 1, 20);
        itemCode := CopyStr(ws.GetText('itemCode', input), 1, 20);
        exit(GetPrice(QuoteNo, itemCode));
    end;

    local procedure GetPrice(OrderNo: Code[20]; ItemNo: Code[20]): Text
    var
        TempSalesLine: Record "Sales Line" temporary;
        PriceText: Code[20];
    begin

        TempSalesLine.Init();
        TempSalesLine."Document Type" := TempSalesLine."Document Type"::Order;
        TempSalesLine."Document No." := OrderNo;

        TempSalesLine.Validate(Type, TempSalesLine.Type::Item);
        TempSalesLine.Validate("No.", ItemNo);

        PriceText := Format(TempSalesLine."Unit Price");
        exit(Ws.CreateResponseSuccess(PriceText));
    end;

}
