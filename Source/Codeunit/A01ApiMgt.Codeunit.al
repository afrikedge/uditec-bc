/// <summary>
/// Codeunit LocalApi (ID 50005).
/// </summary>
codeunit 50006 "A01 Api Mgt"
{

    /// <summary>
    /// GetLengthOfStringWithConfirmation
    /// </summary>
    /// <returns></returns>
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

    /// <summary>
    /// CreateResponseSuccess.
    /// </summary>
    /// <param name="PostedDocNo">Code[20].</param>
    /// <returns>Return value of type Text.</returns>
    procedure CreateResponseSuccess(PostedDocNo: Code[20]): Text
    var
        HeaderJson: JsonObject;
    begin
        HeaderJson.Add('error', false);
        HeaderJson.Add('message', PostedDocNo);
        exit(format(HeaderJson));
    end;

    /// <summary>
    /// GetText.
    /// </summary>
    /// <param name="key">Text.</param>
    /// <param name="input">JsonObject.</param>
    /// <returns>Return value of type Text.</returns>
    procedure CreateResponseError(ErrorMessage: Text): Text
    var
        HeaderJson: JsonObject;
    begin
        HeaderJson.Add('error', true);
        HeaderJson.Add('message', ErrorMessage);
        exit(format(HeaderJson));
    end;

    /// <summary>
    /// GetText.
    /// </summary>
    /// <param name="key">Text.</param>
    /// <param name="input">JsonObject.</param>
    /// <returns>Return value of type Text.</returns>
    procedure GetText("key": Text; input: JsonObject): Text
    var
        c: JsonToken;
    begin
        input.Get("key", c);
        exit(c.AsValue().AsText());
    end;

    /// <summary>
    /// GetDate.
    /// </summary>
    /// <param name="key">Text.</param>
    /// <param name="input">JsonObject.</param>
    /// <returns>Return value of type Date.</returns>
    procedure GetDate("key": Text; input: JsonObject): Date
    var
        c: JsonToken;
        actualDate: DateTime;
    begin
        input.Get("key", c);

        actualDate := ParseDateTime(c);
        exit(DT2Date(actualDate));
        //actualDate := c.AsValue().AsDate();
        // if (Date2DMY(actualDate, 3) = 1753) then
        //     exit(0D)
        // else
        //     exit(actualDate);
    end;
    /// <summary>
    /// GetDateTime.
    /// </summary>
    /// <param name="key">Text.</param>
    /// <param name="input">JsonObject.</param>
    /// <returns>Return value of type DateTime.</returns>
    procedure GetDateTime("key": Text; input: JsonObject): DateTime
    var
        c: JsonToken;
        actualDate: DateTime;
    begin
        input.Get("key", c);
        Evaluate(actualDate, c.AsValue().AsText());
        //actualDate := c.AsValue().AsDate();
        if (Date2DMY(DT2Date(actualDate), 3) = 1753) then
            exit(CreateDateTime(0D, 0T))
        else
            exit(actualDate);
    end;

    /// <summary>
    /// GetInt.
    /// </summary>
    /// <param name="key">Text.</param>
    /// <param name="input">JsonObject.</param>
    /// <returns>Return value of type Integer.</returns>
    procedure GetBool("key": Text; input: JsonObject): Boolean
    var
        c: JsonToken;
    begin
        input.Get("key", c);
        exit(c.AsValue().AsBoolean());
    end;

    /// <summary>
    /// GetDecimal.
    /// </summary>
    /// <param name="key">Text.</param>
    /// <param name="input">JsonObject.</param>
    /// <returns>Return value of type Decimal.</returns>
    procedure GetInt("key": Text; input: JsonObject): Integer
    var
        c: JsonToken;
    begin
        input.Get("key", c);
        exit(c.AsValue().AsInteger());
    end;

    /// <summary>
    /// DebugApiFunction
    /// </summary>
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

    local procedure ParseDateTime(Token: JsonToken): DateTime
    var
        Splits: List of [Text];
        Year: Integer;
        Month: Integer;
        Day: Integer;
        DateTimePart: Text;
        DatePart: Text;
        TimePart: Text;
        response: DateTime;
        responseDate: Date;
        responseTime: Time;
    begin
        //YYYY-MM-DDTHH:mm:ss.sssZ
        Splits := Token.AsValue().AsText().Split('.');
        DateTimePart := Splits.Get(1);

        Splits := DateTimePart.Split('T');
        DatePart := Splits.Get(1);
        TimePart := Splits.Get(2);

        Splits := DatePart.Split('-');
        Evaluate(Day, Splits.Get(3));
        Evaluate(Month, Splits.Get(2));
        Evaluate(Year, Splits.Get(1));
        if (Year = 1753) then
            exit(CreateDateTime(0D, 0T));
        responseDate := DMY2Date(Day, Month, Year);

        // Splits := TimePart.Split('.');
        // Evaluate(Hour, Splits.Get(1));
        // Evaluate(Minute, Splits.Get(2));
        // Evaluate(Seconds, Splits.Get(3));
        Evaluate(responseTime, TimePart);

        response := CreateDateTime(responseDate, responseTime);

        exit(response);
    end;


}
