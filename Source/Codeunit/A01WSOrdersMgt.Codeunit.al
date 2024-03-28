codeunit 50009 "A01 WS OrdersMgt"
{
    var
        WS: codeunit "A01 Api Mgt";
        LblErrorOrderNotExists: Label 'The order N° %1 does not exists', Comment = '%1 = QuoteNo';

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
        if (not SalesL.FindFirst()) then begin

            SalesLine.Init();

            processSalesOrderLine(SalesOrder, SalesLine, input);

            SalesLine.Insert();

        end else begin

            processSalesOrderLine(SalesOrder, SalesL, input);
            SalesL.Modify(true);

        end;
        ;

    end;

    local procedure ProcessSalesOrderHeader(var SalesOrder: Record "Sales Header"; input: JsonObject)
    begin

        if (SalesOrder."A01 Web User Id" <> WS.GetText('webUserName', input)) then
            SalesOrder.Validate("A01 Web User Id", WS.GetText('webUserName', input));

        if (SalesOrder."Sell-to Customer No." <> WS.GetText('saleOrderCustomerNo', input)) then
            SalesOrder.Validate("Sell-to Customer No.", WS.GetText('saleOrderCustomerNo', input));

        if (SalesOrder."Sell-to Contact No." <> WS.GetText('saleOrderCustomerContactCode', input)) then
            SalesOrder.Validate("Sell-to Contact No.", WS.GetText('saleOrderCustomerContactCode', input));

        if (SalesOrder."Responsibility Center" <> WS.GetText('saleOrderResponsibilityCenter', input)) then
            SalesOrder.Validate("Responsibility Center", WS.GetText('saleOrderResponsibilityCenter', input));

        if (SalesOrder."Salesperson Code" <> WS.GetText('saleOrderSalesperson', input)) then
            SalesOrder.Validate("Salesperson Code", WS.GetText('saleOrderSalesperson', input));

        if (SalesOrder."Campaign No." <> WS.GetText('saleOrderCampaignNo', input)) then
            SalesOrder.Validate("Campaign No.", WS.GetText('saleOrderCampaignNo', input));

        if (SalesOrder."Location Code" <> WS.GetText('saleOrderLocationCode', input)) then
            SalesOrder.Validate("Location Code", WS.GetText('saleOrderLocationCode', input));

        if (SalesOrder."Shortcut Dimension 2 Code" <> WS.GetText('saleOrderSalesChannel', input)) then
            SalesOrder.Validate("Shortcut Dimension 2 Code", WS.GetText('saleOrderSalesChannel', input));

        if (SalesOrder."A01 Sales Mode" <> WS.GetText('saleOrderSalesMode', input)) then
            SalesOrder.Validate("A01 Sales Mode", WS.GetText('saleOrderSalesMode', input));

        if (SalesOrder."Customer Price Group" <> WS.GetText('saleOrderCustomerPriceGroup', input)) then
            SalesOrder.Validate("Customer Price Group", WS.GetText('saleOrderCustomerPriceGroup', input));

        if (SalesOrder."VAT Bus. Posting Group" <> WS.GetText('saleOrderVATBusPostingGroup', input)) then
            SalesOrder.Validate("VAT Bus. Posting Group", WS.GetText('saleOrderVATBusPostingGroup', input));

        if (SalesOrder."Gen. Bus. Posting Group" <> WS.GetText('saleOrderGenBusPostingGroup', input)) then
            SalesOrder.Validate("Gen. Bus. Posting Group", WS.GetText('saleOrderGenBusPostingGroup', input));


        if (SalesOrder."Document Date" <> WS.GetDate('saleOrderDocumentDate', input)) then
            SalesOrder.Validate("Document Date", WS.GetDate('saleOrderDocumentDate', input));

        //if (SalesOrder."Quote Valid Until Date" <> WS.GetDate('saleQuoteValidUntilDate', input)) then
        //    SalesOrder.Validate("Order Valid Until Date", WS.GetDate('saleOrderValidUntilDate', input));

        if (SalesOrder."Requested Delivery Date" <> WS.GetDate('saleOrderShipRequestedDate', input)) then
            SalesOrder.Validate("Requested Delivery Date", WS.GetDate('saleOrderShipRequestedDate', input));

        if (SalesOrder."Promised Delivery Date" <> WS.GetDate('saleOrderPromisedDeliveryDate', input)) then
            SalesOrder.Validate("Promised Delivery Date", WS.GetDate('saleOrderPromisedDeliveryDate', input));

        if (SalesOrder."Payment Method Code" <> WS.Gettext('saleOrderPaymentMethodCode', input)) then
            SalesOrder.Validate("Payment Method Code", WS.Gettext('saleOrderPaymentMethodCode', input));

        if (SalesOrder."Payment Terms Code" <> WS.Gettext('saleOrderPaymentTermsCode', input)) then
            SalesOrder.Validate("Payment Terms Code", WS.Gettext('saleOrderPaymentTermsCode', input));

        if (SalesOrder."Prepayment %" <> WS.GetDecimal('saleOrderPrepayment', input)) then
            SalesOrder.Validate("Prepayment %", WS.GetDecimal('saleOrderPrepayment', input));

        if (SalesOrder."Ship-to Code" <> WS.Gettext('saleOrderCustomerShipToCode', input)) then
            SalesOrder.Validate("Ship-to Code", WS.Gettext('saleOrderCustomerShipToCode', input));

        if (SalesOrder."Shipment Method Code" <> WS.GetText('saleOrderShipmentMethodCode', input)) then
            SalesOrder.Validate("Shipment Method Code", WS.GetText('saleOrderShipmentMethodCode', input));

        //if (SalesOrder.store <> WS.GetText('saleOrderCustomerStoreCode', input)) then
        // SalesOrder.Validate("Shipment Method Code", WS.GetText('saleOrderCustomerStoreCode', input));




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
        SalesOrder: Record "Sales Header";
        OrderMgt: Codeunit "A01 Sales Order Processing";

    begin
        if (SalesOrder.get(SalesOrder."Document Type"::Order, NoOrder)) then begin

            OrderMgt.ValidateDraft(SalesOrder);
            exit(Ws.CreateResponseSuccess(SalesOrder."No."));

        end else
            exit(Ws.CreateResponseError(StrSubstNo(LblErrorOrderNotExists, NoOrder)));
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


    /// <summary>
    /// SaveOrderPaymentLines.
    /// </summary>
    /// <param name="input">JsonObject.</param>
    /// <returns>Return value of type Text.</returns>
    procedure SaveOrderPaymentLines(input: JsonObject): Text
    var
        OrderNo: text;
    begin
        OrderNo := ws.GetText('OrderNo', input);
        if (OrderNo <> '') then
            exit(UpdatePaymentLinesOnOrder(OrderNo, input));
    end;

    local procedure processSalesOrderPaymentLine(SalesOrder: Record "Sales Header"; var SalesPayLine: Record "A01 Sales Payment Method"; input: JsonObject)

    begin

        if (SalesPayLine."Document No." <> SalesOrder."No.") then
            SalesPayLine."Document No." := SalesOrder."No.";

        if (SalesPayLine."Document Type" <> SalesPayLine."Document Type"::Order) then
            SalesPayLine."Document Type" := SalesPayLine."Document Type"::Order;

        if (SalesPayLine."Payment Method" <> WS.GetText('Payment Method Code', input)) then
            SalesPayLine."Payment Method" := CopyStr(WS.GetText('Payment Method Code', input), 1, 20);

        if (SalesPayLine.Reference <> WS.GetText('Reference', input)) then
            SalesPayLine.Validate(Reference, WS.GetText('Reference', input));

        if (SalesPayLine.Amount <> WS.GetDecimal('Amount (LCY)', input)) then
            SalesPayLine.Validate(Amount, WS.GetDecimal('Amount (LCY)', input));

        if (SalesPayLine."Validated Amount" <> WS.GetDecimal('Accepted Amount (LCY)', input)) then
            SalesPayLine.Validate("Validated Amount", WS.GetDecimal('Accepted Amount (LCY)', input));

        SalesPayLine."Responsibility Center" := SalesOrder."Responsibility Center";

    end;

    local procedure UpdatePaymentLinesOnOrder(OrderNo: Text; input: JsonObject): Text
    var
        SalesOrder: Record "Sales Header";
        PaymentLine: Record "A01 Sales Payment Method";
    begin

        SalesOrder.Get(SalesOrder."Document Type"::Order, OrderNo);

        PaymentLine.Reset();
        PaymentLine.SetRange("Document Type", PaymentLine."Document Type"::Order);
        PaymentLine.SetRange("Document No.", SalesOrder."No.");
        if (not PaymentLine.IsEmpty) then
            PaymentLine.DeleteAll();

        processOrderPaymentLines(SalesOrder, input);

        exit(Ws.CreateResponseSuccess(SalesOrder."No."));

    end;

    local procedure processOrderPaymentLines(SalesOrder: Record "Sales Header"; input: JsonObject)
    var
        c: JsonToken;
        LinesArray: JsonArray;
        LineInput: JsonObject;
    begin
        input.Get('saleOrderPaymentLines', c);
        LinesArray := c.AsArray();
        foreach c in LinesArray do begin
            LineInput := c.AsObject();
            AddOrderPaymentLine(SalesOrder, LineInput);
        end;
    end;

    local procedure AddOrderPaymentLine(SalesOrder: Record "Sales Header"; input: JsonObject)
    var
        PaymentLine: Record "A01 Sales Payment Method";
    begin
        PaymentLine.Init();

        processSalesOrderPaymentLine(SalesOrder, PaymentLine, input);

        PaymentLine.Insert();
    end;

    /// <summary>
    /// Sport2000 case
    /// </summary>
    /// <param name="input"></param>
    /// <returns></returns>
    procedure PostSalesOrder(input: JsonObject): Text
    var
        OrderNo: Code[20];
    begin
        OrderNo := CopyStr(ws.GetText('OrderNo', input), 1, 20);
        if (OrderNo <> '') then
            exit(PostSalesOrderInternal(OrderNo));
    end;

    local procedure PostSalesOrderInternal(SalesOrderNo: Code[20]): Text
    var
        SalesOrder: Record "Sales Header";
        SalesPost: Codeunit "Sales-Post";
    begin
        SalesOrder.Get(SalesOrder."Document Type"::Order, SalesOrderNo);
        SalesOrder.Ship := true;
        SalesOrder.invoice := true;
        SalesOrder.Validate("Prepayment %", 0);
        SalesOrder.modify();
        SalesPost.Run(SalesOrder);
        exit(Ws.CreateResponseSuccess(SalesOrder."No."));
    end;


}
