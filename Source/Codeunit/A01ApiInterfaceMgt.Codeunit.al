/// <summary>
/// Codeunit A01 Api Interface Mgt (ID 50008).
/// </summary>
codeunit 50008 "A01 Api Interface Mgt"
{
    var
        WS: codeunit "A01 Api Mgt";
        QuotesMgt: Codeunit "A01 WS QuotesMgt";
        LblUnknownParameter: Label 'Unkwnown parameter : %1', Comment = '%1 = parameter';
    /// <summary>
    /// 
    /// </summary>
    /// <param name="inputJson"></param>
    /// <returns></returns>
    procedure Run(inputJson: Text): Text
    var
        input: JsonObject;
        param: text;

    begin
        input.ReadFrom(inputJson);
        param := ws.GetText('Parameter', input);

        case param of
            'quotes_insert':
                exit(QuotesMgt.Run(input, false));
            'quotes_modify':
                exit(QuotesMgt.Run(input, false));
            'quotes_detele':
                exit(QuotesMgt.Run(input, true));


            else
                exit(StrSubstNo(LblUnknownParameter, param));
        end;

    end;
}
