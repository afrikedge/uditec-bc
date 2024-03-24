/// <summary>
/// Codeunit LocalApi (ID 50005).
/// </summary>
codeunit 50006 "A01 Api Mgt"
{

    procedure GetLengthOfStringWithConfirmation(inputJson: Text): Integer
    var
        c: JsonToken;
        input: JsonObject;
    begin
        input.ReadFrom(inputJson);
        if input.Get('confirm', c) and c.AsValue().AsBoolean() = true and input.Get('str', c) then
            exit(StrLen(c.AsValue().AsText()))
        else
            exit(-1);
    end;

    /// <summary>
    /// 
    /// </summary>
    /// <returns></returns>
    procedure CreateJsonResponse(): Text
    var
        SalesLine: Record "Sales Line";
        SalesHeader: Record "Sales Header";
        HeaderJson: JsonObject;
        LineJson: JsonObject;
        TabArray: JsonArray;

    begin
        SalesHeader.Get(SalesHeader."Document Type"::Order, '101005 ');
        HeaderJson.Add('DocumentType', SalesHeader."Document Type".AsInteger());
        HeaderJson.Add('No.', SalesHeader."No.");
        HeaderJson.Add('SellToCustNo', SalesHeader."Sell-to Customer No.");
        HeaderJson.Add('PostingDate', SalesHeader."Posting Date");

        SalesLine.SetRange(SalesLine."Document Type", SalesLine."Document Type"::Order);
        SalesLine.SetRange(SalesLine."Document No.", SalesHeader."No.");
        if SalesLine.FindSet() then
            repeat
                Clear(LineJson);
                LineJson.Add('LineNo', SalesLine."No.");
                LineJson.Add('LineType', SalesLine.Type.AsInteger());
                LineJson.Add('No', SalesLine."No.");
                LineJson.Add('Qty', SalesLine.Quantity);
                LineJson.Add('UnitPrice', SalesLine."Unit Price");
                TabArray.Add(LineJson);
            until SalesLine.Next() < 1;

        HeaderJson.Add('Lines', TabArray);
        exit(format(HeaderJson));
    end;

    procedure CreateResponseSuccess(PostedDocNo: Code[20]): Text
    var
        HeaderJson: JsonObject;
    begin
        HeaderJson.Add('error', false);
        HeaderJson.Add('message', PostedDocNo);
        exit(format(HeaderJson));
    end;

    procedure CreateResponseError(ErrorMessage: Text): Text
    var
        HeaderJson: JsonObject;
    begin
        HeaderJson.Add('error', true);
        HeaderJson.Add('message', ErrorMessage);
        exit(format(HeaderJson));
    end;

    procedure GetText("key": Text; input: JsonObject): Text
    var
        c: JsonToken;
    begin
        input.Get("key", c);
        exit(c.AsValue().AsText());
    end;

    procedure GetDate("key": Text; input: JsonObject): Date
    var
        c: JsonToken;
        actualDate: Date;
    begin
        input.Get("key", c);
        actualDate := c.AsValue().AsDate();
        if (Date2DMY(actualDate, 3) = 1753) then
            exit(0D)
        else
            exit(c.AsValue().AsDate());
    end;

    procedure GetBool("key": Text; input: JsonObject): Boolean
    var
        c: JsonToken;
    begin
        input.Get("key", c);
        exit(c.AsValue().AsBoolean());
    end;

    procedure GetInt("key": Text; input: JsonObject): Integer
    var
        c: JsonToken;
    begin
        input.Get("key", c);
        exit(c.AsValue().AsInteger());
    end;

    procedure GetDecimal("key": Text; input: JsonObject): Decimal
    var
        c: JsonToken;
    begin
        input.Get("key", c);
        exit(c.AsValue().AsDecimal());
    end;

    /// <summary>
    /// DebugApiFunction
    /// </summary>
    procedure DebugApiFunction()
    var
        ApiInterface: Codeunit "A01 Api Interface Mgt";
        jsonText: Text;
    begin
        jsonText := '{"inputJson":"{\"Parameter\":\"item_getPrice\",\"itemCode\":\"0902075\",\"CustomerCode\":\"CMZCASH\",\"CampaignCode\":\"\"}"}';
        ApiInterface.Run(jsonText);
    end;


}
