/// <summary>
/// Codeunit A01 Api Interface Mgt (ID 50008).
/// </summary>
codeunit 50008 "A01 Api Interface Mgt"
{
    var
        WS: codeunit "A01 Api Mgt";
        QuotesMgt: Codeunit "A01 WS QuotesMgt";
        OrdersMgt: Codeunit "A01 WS OrdersMgt";
        CreditMgt: Codeunit "A01 WS Credit Mgt";
        MasterFilesMgt: Codeunit "A01WSMasterFilesMgt";
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
            'salesQuotes_reopen':
                exit(QuotesMgt.Run_Open(input));
            'quotes_item_getPrice':
                exit(QuotesMgt.GetUnitPrice(input));
            'quotes_requestApproval':
                exit(QuotesMgt.RequestApproval(input));
            'creditRequests_insert':
                exit(QuotesMgt.RunCreditRequest(input, false));
            'creditRequests_modify':
                exit(QuotesMgt.RunCreditRequest(input, false));
            'creditRequests_reject':
                exit(QuotesMgt.RunRejectCreditRequest(input));

            'orders_insert':
                exit(OrdersMgt.Run(input, false));
            'orders_modify':
                exit(OrdersMgt.Run(input, false));
            'orders_delete':
                exit(OrdersMgt.Run(input, true));
            'salesOrders_reopen':
                exit(OrdersMgt.Run_Open(input));
            'orders_requestApproval':
                exit(OrdersMgt.ValidateDraft(input));
            'orders_item_getPrice':
                exit(OrdersMgt.GetUnitPrice(input));
            'orders_payment_save':
                exit(OrdersMgt.SaveOrderPaymentLines(input));
            'orders_payment_validate':
                exit(OrdersMgt.PostSalesOrder(input));
            'salesOrderUnclocking_insert':
                exit(OrdersMgt.Run_CreateUnBlockingRequest(input));
            'discountRequest_insert':
                exit(OrdersMgt.Run_CreateDiscountRequest(input));
            'paymentRequest_insert':
                exit(OrdersMgt.Run_CreatePOSPaymentRequest(input));
            'request_validate':
                exit(OrdersMgt.Run_ModifyRequestStatus(input));


            'recoveryActivities_insert':
                exit(CreditMgt.RunRecoveryActivities(input, false));
            'recoveryActivities_modify':
                exit(CreditMgt.RunRecoveryActivities(input, false));
            'recoveryActivities_delete':
                exit(CreditMgt.RunRecoveryActivities(input, true));


            'repossessionRequests_insert':
                exit(CreditMgt.RunReposessionRequest(input, false));
            'repossessionRequests_modify':
                exit(CreditMgt.RunReposessionRequest(input, false));
            'repossessionRequests_delete':
                exit(CreditMgt.RunReposessionRequest(input, true));


            'paymentPromises_insert':
                exit(CreditMgt.RunRPaymentPromise(input, false));
            'paymentPromises_modify':
                exit(CreditMgt.RunRPaymentPromise(input, false));
            'paymentPromises_delete':
                exit(CreditMgt.RunRPaymentPromise(input, true));


            'customers_modify':
                exit(MasterFilesMgt.RunCustomers(input, false));

            'leads_modify':
                exit(MasterFilesMgt.RunLeads(input, false));
            'leads_insert':
                exit(MasterFilesMgt.RunLeads(input, false));
            'leads_createcustomer':
                exit(MasterFilesMgt.RunCreateCustomer(input));

            'contacts_insert':
                exit(MasterFilesMgt.RunContacts(input, false));
            'contacts_modify':
                exit(MasterFilesMgt.RunContacts(input, false));

            'creditContracts_insert':
                exit(MasterFilesMgt.RunCreditContracts(input, false));
            'creditContracts_modify':
                exit(MasterFilesMgt.RunCreditContracts(input, false));

            'shipToAddress_insert':
                exit(MasterFilesMgt.RunShipToAddress(input, false));
            'shipToAddress_modify':
                exit(MasterFilesMgt.RunShipToAddress(input, false));

            'documentlink_insert':
                exit(MasterFilesMgt.RunLinkDocument(input, false));
            'documentlink_delete':
                exit(MasterFilesMgt.RunLinkDocument(input, true));


            'changeUserPassword':
                exit(MasterFilesMgt.RunUpdatePassword(input));



            else
                exit(StrSubstNo(LblUnknownParameter, param));
        end;

    end;
}
