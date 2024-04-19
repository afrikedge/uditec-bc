/// <summary>
/// Codeunit A01 Document Request Mgt (ID 50016).
/// </summary>
codeunit 50016 "A01 Document Request Mgt"
{
    var
        LblDescrDiscount: label 'Discount request';
        LblDescrUnblocking: label 'Unblocking request';
        LblDescrPayment: label 'Payment to validate';
        LblDescrPOSPayment: label 'Payment at POS to be validated';

    procedure AddDiscountRequest(SalesHeader: Record "Sales Header"; RequestedDiscount: Decimal)
    var
        Request: Record "A01 Request On Document";
    begin
        Request.Init();
        if (SalesHeader."Document Type" = SalesHeader."Document Type"::Quote) then
            Request.Validate("Request Type", Request."Request Type"::"Discount on quote");
        if (SalesHeader."Document Type" = SalesHeader."Document Type"::Order) then
            Request.Validate("Request Type", Request."Request Type"::"Discount on order");
        Request.Validate("Request No.", SalesHeader."No.");
        Request.Validate("Customer No.", SalesHeader."Sell-to Customer No.");
        Request.Validate("Sales Person", SalesHeader."Salesperson Code");
        Request.Validate("Requested Discount (%)", RequestedDiscount);
        Request.Object := LblDescrDiscount;
        Request.Insert(true);
    end;

    procedure AddUnBlockingRequest(SalesHeader: Record "Sales Header")
    var
        Request: Record "A01 Request On Document";
    begin
        SalesHeader.TestField("A01 Processing Status", SalesHeader."A01 Processing Status"::Blocked);
        Request.Init();
        Request.Validate("Request Type", Request."Request Type"::Unblocking);
        Request.Validate("Request No.", SalesHeader."No.");
        Request.Validate("Customer No.", SalesHeader."Sell-to Customer No.");
        Request.Validate("Sales Person", SalesHeader."Salesperson Code");
        Request.Object := LblDescrUnblocking;
        Request.Insert(true);
    end;

    procedure AddPOSPaymentRequest(SalesHeader: Record "Sales Header")
    var
        Request: Record "A01 Request On Document";
    begin

        CheckPOSPaymentOnCreation(SalesHeader);

        Request.Init();
        Request.Validate("Request Type", Request."Request Type"::"POS Payment");
        Request.Validate("Request No.", SalesHeader."No.");
        Request.Validate("Customer No.", SalesHeader."Sell-to Customer No.");
        Request.Validate("Sales Person", SalesHeader."Salesperson Code");
        Request.Object := LblDescrPOSPayment;
        Request.Insert(true);
    end;

    procedure AddPaymentRequest(PaymentDoc: Record "A01 Payment Document")
    var
        Request: Record "A01 Request On Document";
    begin

        CheckDocPaymentOnCreation(PaymentDoc);

        Request.Init();
        Request.Validate("Request Type", Request."Request Type"::"Payment Document");
        Request.Validate("Request No.", PaymentDoc."No.");
        Request.Validate("Customer No.", PaymentDoc."Partner No.");
        //Request.Validate("Sales Person",SalesHeader."Salesperson Code");
        Request.Object := LblDescrPayment;
        Request.Insert(true);
    end;

    local procedure PayNeedsValidation(PayHeader: Record "A01 Payment Document"): Boolean
    var
        PayLine: Record "A01 Payment Document Line";
    begin
        PayLine.Reset();
        PayLine.SetRange("Document No.", PayHeader."No.");
        if PayLine.FindSet() then
            repeat
                if (PayLine.Amount <> PayLine."Validated Amount") then
                    exit(true);
            until PayLine.Next() < 1;
    end;

    local procedure POSPaymentNeedsValidation(Salesheader: Record "Sales Header"): Boolean
    var
        PayLine: Record "A01 Sales Payment Method";
    begin
        PayLine.Reset();
        PayLine.SetRange(PayLine."Document Type", Salesheader."Document Type");
        PayLine.SetRange("Document No.", Salesheader."No.");
        if PayLine.FindSet() then
            repeat
                if (PayLine.Amount <> PayLine."Validated Amount") then
                    exit(true);
            until PayLine.Next() < 1;
    end;

    local procedure CheckDocPaymentOnCreation(PayHeader: Record "A01 Payment Document")
    var
        ErrLbl01: Label 'The amount to validate does not exist on this document';
    begin
        if (not PayNeedsValidation(PayHeader)) then
            Error(ErrLbl01);
    end;

    local procedure CheckPOSPaymentOnCreation(Salesheader: Record "Sales Header")
    var
        ErrLbl01: Label 'The amount to validate does not exist on this document';
    begin
        if (not POSPaymentNeedsValidation(Salesheader)) then
            Error(ErrLbl01);
    end;

    procedure CheckSameRequestAlreadyExists(OriginDoc: Record "A01 Request On Document")
    var
        Request: Record "A01 Request On Document";
        LblAnotherRecExists: label 'A pending request already exists for this document';
    begin
        Request.SetRange("Request Type", OriginDoc."Request Type");
        Request.SetRange("Request No.", OriginDoc."Request No.");
        if Request.FindSet() then
            repeat
                if (Request.IsOnHold()) then
                    Error(LblAnotherRecExists);
            until Request.Next() < 1;
    end;

    procedure CheckIfValidationRequestExists(PayDoc: Record "A01 Payment Document")
    var
        Request: Record "A01 Request On Document";
        LblAnotherRecExists: label 'A pending request already exists for this document';
    begin
        Request.SetRange("Request Type", Request."Request Type"::"Payment Document");
        Request.SetRange("Request No.", PayDoc."No.");
        if Request.FindSet() then
            repeat
                if (Request.IsOnHold()) then
                    Error(LblAnotherRecExists);
            until Request.Next() < 1;
    end;

    procedure CheckIfValidationRequestExists(SalesHeader: Record "Sales Header")
    var
        Request: Record "A01 Request On Document";
        LblAnotherRecExists02: label 'A pending request already exists for this document';
    begin
        Request.SetRange("Request Type", Request."Request Type"::"POS Payment");
        Request.SetRange("Request No.", SalesHeader."No.");
        if Request.FindSet() then
            repeat
                if (Request.IsOnHold()) then
                    Error(LblAnotherRecExists02);
            until Request.Next() < 1;
    end;

}
