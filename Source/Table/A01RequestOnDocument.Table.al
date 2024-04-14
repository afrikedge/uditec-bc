/// <summary>
/// Table A01 Request On Sales Document (ID 50031).
/// </summary>
table 50031 "A01 Request On Document"
{
    Caption = 'Request On Document';
    DataClassification = CustomerContent;

    fields
    {
        field(1; "Request Type"; Enum "A01 Request On Document Type")
        {
            Caption = 'Request Type';
        }
        field(2; "Request No."; Code[20])
        {
            Caption = 'Request No.';
            Editable = false;
        }
        field(3; Object; Text[100])
        {
            Caption = 'Object';
        }
        field(4; Status; Enum "A01 Approval Status")
        {
            Caption = 'Status';
            Editable = false;
        }
        field(5; "Document Type"; Enum "Sales Document Type")
        {
            Caption = 'Document Type';
        }
        field(6; "Document No."; Code[20])
        {
            Caption = 'Document No.';
        }
        field(7; "Modified By"; Code[50])
        {
            Caption = 'Modified By';
            TableRelation = "A01 External User";
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(8; "Requested Discount (%)"; Decimal)
        {
            Caption = 'Requested Discount (%)';
        }
        field(9; "Validated Discount (%)"; Decimal)
        {
            Caption = 'Validated Discount (%)';
        }
        field(10; "Customer No."; Code[20])
        {
            Caption = 'Customer No.';
            TableRelation = Customer;
            trigger OnValidate()
            var
                Cust: Record Customer;
            begin
                if (Cust.get("Customer No.")) then begin
                    "Credit Limit" := Cust."Credit Limit (LCY)";
                    "Due Balance" := Cust.CalcOverdueBalance();
                    "In progress Balance" := Cust."Balance (LCY)";
                    "Risk level" := Cust."A01 Risk Level";
                end;
            end;
        }
        field(11; "Sales Person"; Code[20])
        {
            Caption = 'Sales Person';
            TableRelation = "Salesperson/Purchaser";
        }
        field(12; "Credit Limit"; Decimal)
        {
            Caption = 'Credit Limit';
            Editable = false;
        }
        field(13; "In progress Balance"; Decimal)
        {
            Caption = 'In progress Balance';
            Editable = false;
        }
        field(14; "Due Balance"; Decimal)
        {
            Caption = 'Due Balance';
            Editable = false;
        }
        field(15; "Worst Current Status"; Code[10])
        {
            Caption = 'Worst Current Status';
            TableRelation = "A01 Customer Debt Status";

        }
        field(16; "Gross exposure"; Decimal)
        {
            Caption = 'Gross exposure';
        }
        field(17; "Risk level"; Code[20])
        {
            Caption = 'Risk level';
            TableRelation = "A01 Parameter Record".Code where(Type = const(RiskLevel));
            Editable = false;
        }
        field(18; Exceeding; Decimal)
        {
            Caption = 'Exceeding';
        }
        field(19; "Sequence No."; Integer)
        {
            Caption = 'Sequence No.';
            Editable = false;
        }
        field(20; "Created By"; Code[50])
        {
            Caption = 'Modified By';
            TableRelation = "A01 External User";
            DataClassification = CustomerContent;
            Editable = false;
        }

    }
    keys
    {
        key(PK; "Request Type", "Request No.", "Sequence No.")
        {
            Clustered = true;
        }
    }
    var
        LblAnotherRecExists: label 'A pending request already exists for this document';
        LblDescrDiscount: label 'Discount request';
        LblDescrUnblocking: label 'Unblocking request';
        LblDescrPayment: label 'Payment to validate';
        LblDescrPOSPayment: label 'Payment at POS to be validated';

    trigger OnInsert()
    var

    begin
        CheckOtherRequestExists();

        if "Sequence No." = 0 then
            "Sequence No." := GetNextSequenceNo();

        InitHeader();
    end;

    local procedure InitHeader()
    begin

    end;

    // value(0; Initialization)
    // value(1; "File on hold")
    // value(2; "Waiting for Analyst")
    // value(3; "Waiting for investigation")
    // value(4; "Waiting for collection")
    // value(5; "Waiting for manager")
    // value(6; "Waiting for committee")
    // value(7; "Validated under conditions")
    // value(8; Validated)
    // value(9; Canceled)
    // value(10; Rejected)
    // value(11; Closed)
    local procedure CheckOtherRequestExists()
    var
        Request: Record "A01 Request On Document";
    begin
        Request.SetRange("Request Type", Rec."Request Type");
        Request.SetRange("Document No.", Rec."Document No.");
        if Request.FindSet() then
            repeat
                if (Request.IsOnHold()) then
                    Error(LblAnotherRecExists);
            until Request.Next() < 1;
    end;

    local procedure GetNextSequenceNo(): Integer
    var
        Request: Record "A01 Request On Document";
    begin
        Request.SetRange("Request Type", Rec."Request Type");
        Request.SetRange("Document No.", Rec."Document No.");
        if Request.FindLast() then
            exit(Request."Sequence No." + 1)
        else
            exit(1);
    end;

    procedure IsOnHold(): Boolean
    begin
        if (Status = Status::Initialization) then exit(true);
        if (Status = Status::"File on hold") then exit(true);
        if (Status = Status::"Waiting for Analyst") then exit(true);
        if (Status = Status::"Waiting for investigation") then exit(true);
        if (Status = Status::"Waiting for collection") then exit(true);
        if (Status = Status::"Waiting for manager") then exit(true);
        if (Status = Status::"Waiting for committee") then exit(true);
        if (Status = Status::"Validated") then exit(true);
    end;

    procedure AddDiscountRequest(SalesHeader: Record "Sales Header"; RequestedDiscount: Decimal)
    var
        Request: Record "A01 Request On Document";
    begin
        Request.Init();
        Request.Validate("Request Type", Request."Request Type"::Discount);
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
        Request.Init();
        Request.Validate("Request Type", Request."Request Type"::"Payment Document");
        Request.Validate("Request No.", PaymentDoc."No.");
        Request.Validate("Customer No.", PaymentDoc."Partner No.");
        //Request.Validate("Sales Person",SalesHeader."Salesperson Code");
        Request.Object := LblDescrPayment;
        Request.Insert(true);
    end;
}
