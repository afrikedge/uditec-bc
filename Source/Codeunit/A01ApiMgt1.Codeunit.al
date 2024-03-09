/// <summary>
/// Codeunit LocalApi (ID 50005).
/// </summary>
codeunit 50006 "A01 Api Mgt1"
{
    procedure Ping(input: Integer): Integer
    begin
        exit(-input);
    end;

    procedure Delay(delayMilliseconds: Integer)
    begin
        Sleep(delayMilliseconds);
    end;

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


}
