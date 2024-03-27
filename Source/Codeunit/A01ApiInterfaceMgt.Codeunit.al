/// <summary>
/// Codeunit A01 Api Interface Mgt (ID 50008).
/// </summary>
codeunit 50008 "A01 Api Interface Mgt"
{
    var
        WS: codeunit "A01 Api Mgt";
        QuotesMgt: Codeunit "A01 WS QuotesMgt";
        OrdersMgt: Codeunit "A01 WS OrdersMgt";
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
            'quotes_delete':
                exit(QuotesMgt.Run(input, true));
            'quotes_makeorder':
                exit(QuotesMgt.MakeOrder(input));
            'quotes_item_getPrice':
                exit(QuotesMgt.GetUnitPrice(input));
            'quotes_requestApproval':
                exit(QuotesMgt.RequestApproval(input));

            'orders_insert':
                exit(OrdersMgt.Run(input, false));
            'orders_modify':
                exit(OrdersMgt.Run(input, false));
            'orders_delete':
                exit(OrdersMgt.Run(input, true));
            'orders_requestApproval':
                exit(OrdersMgt.ValidateDraft(input));
            'orders_item_getPrice':
                exit(OrdersMgt.GetUnitPrice(input));
            'orders_payment_save':
                exit(OrdersMgt.SaveOrderPaymentLines(input));
            'orders_payment_validate':
                exit(OrdersMgt.PostSalesOrder(input));

            else
                exit(StrSubstNo(LblUnknownParameter, param));
        end;

    end;
}
