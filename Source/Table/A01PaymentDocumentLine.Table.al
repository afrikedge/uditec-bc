/// <summary>
/// Table A01 Payment Document Line (ID 50033).
/// </summary>
table 50033 "A01 Payment Document Line"
{
    Caption = 'Payment Document Line';
    DataClassification = CustomerContent;

    fields
    {
        field(1; "Document No."; Code[20])
        {
            Caption = 'Document No.';
        }
        field(2; "Payment Method"; Code[10])
        {
            Caption = 'Payment Method';
            TableRelation = "A01 RC Payment Method"."Payment Method" where("Responsability Center" = field("Responsibility Center"));
        }
        field(3; Reference; Text[30])
        {
            Caption = 'Reference';
        }
        field(4; Amount; Decimal)
        {
            Caption = 'Amount';
            trigger OnValidate()
            var
                PayMethod: Record "Payment Method";
            begin
                TestField("Payment Method");
                PayMethod.Get("Payment Method");
                if (not PayMethod."A01 Approval required") then
                    "Validated Amount" := Amount;
            end;
        }
        field(5; "Validated Amount"; Decimal)
        {
            Caption = 'Validated Amount';
            //Editable = false;
        }
        field(6; "Responsibility Center"; Code[20])
        {
            Caption = 'Responsibility Center';
            TableRelation = "Responsibility Center";
        }
        field(7; "Applies-to ID"; Code[50])
        {
            Caption = 'Applies-to ID';
            Editable = false;
        }
        field(8; "Applies-to Doc. Type"; Enum "Gen. Journal Document Type")
        {
            Caption = 'Applies-to Doc. Type';
            Editable = false;
        }
        field(9; "Applies-to Doc. No."; Code[20])
        {
            Caption = 'Applies-to Doc. No.';
            Editable = false;
        }
        field(480; "Dimension Set ID"; Integer)
        {
            Caption = 'Dimension Set ID';
            Editable = false;
            TableRelation = "Dimension Set Entry";

            // trigger OnLookup()
            // begin
            //     Rec.ShowDimensions();
            // end;
        }





        field(50000; "Account Type"; enum "Gen. Journal Account Type")
        {
            Caption = 'Account Type';
            Editable = false;
        }
        field(50001; "Account No."; Code[20])
        {
            Caption = 'Account No.';
            Editable = false;
        }
        field(50002; "Amount (LCY)"; Decimal)
        {
            Caption = 'Amount (LCY)';
            Editable = false;
        }
        field(50003; "Currency Code"; Code[10])
        {
            Caption = 'Currency Code';
            TableRelation = Currency;
            Editable = false;
        }
        field(50004; "Due Date"; Date)
        {
            Caption = 'Due Date';
            //Editable = false;
        }


    }
    keys
    {
        key(PK; "Document No.", "Responsibility Center", "Payment Method")
        {
            Clustered = true;
        }
    }
    trigger OnInsert()
    begin
        GetHeader();
        if (PaymentDoc."Partner Type" = PaymentDoc."Partner Type"::Customer) then
            "Account Type" := "Account Type"::Customer;
        if (PaymentDoc."Partner Type" = PaymentDoc."Partner Type"::Vendor) then
            "Account Type" := "Account Type"::Vendor;
        "Account No." := PaymentDoc."Partner No.";
        "Currency Code" := PaymentDoc."Currency Code";

        RequestMgt.CheckIfValidationRequestExists(PaymentDoc);
    end;

    trigger OnModify()
    var
    begin
        GetHeader();
        RequestMgt.CheckIfValidationRequestExists(PaymentDoc);
    end;

    trigger OnDelete()
    var
    begin
        GetHeader();
        RequestMgt.CheckIfValidationRequestExists(PaymentDoc);
    end;

    var
        PaymentDoc: record "A01 Payment Document";
        Currency: Record Currency;
        RequestMgt: Codeunit "A01 Document Request Mgt";
    // CustLedgEntry: Record "Cust. Ledger Entry";

    [Scope('OnPrem')]
    procedure GetAppliedDocNoList(LenToCut: Integer) List: Text
    var
        CustLedgEntry: Record "Cust. Ledger Entry";
        VendLedgEntry: Record "Vendor Ledger Entry";
        DocumentNo: Code[35];
    begin

        GetHeader();

        if ("Applies-to Doc. No." = '') and ("Applies-to ID" = '') then
            exit('');
        case PaymentDoc."Partner Type" of
            PaymentDoc."Partner Type"::Customer:
                begin
                    CustLedgEntry.SetRange("Customer No.", PaymentDoc."Partner No.");
                    if "Applies-to Doc. No." <> '' then begin
                        CustLedgEntry.SetRange("Document Type", "Applies-to Doc. Type");
                        CustLedgEntry.SetRange("Document No.", "Applies-to Doc. No.");
                    end else
                        CustLedgEntry.SetRange("Applies-to ID", "Applies-to ID");
                    if CustLedgEntry.FindSet() then
                        repeat
                            AddDocumentNoToList(List, CustLedgEntry."Document No.", LenToCut);
                        until CustLedgEntry.Next() = 0;
                end;
            PaymentDoc."Partner Type"::Vendor:
                begin
                    VendLedgEntry.SetRange("Vendor No.", PaymentDoc."Partner No.");
                    if "Applies-to Doc. No." <> '' then begin
                        VendLedgEntry.SetRange("Document Type", "Applies-to Doc. Type");
                        VendLedgEntry.SetRange("Document No.", "Applies-to Doc. No.");
                    end else
                        VendLedgEntry.SetRange("Applies-to ID", "Applies-to ID");
                    if VendLedgEntry.FindSet() then
                        repeat
                            if VendLedgEntry."External Document No." = '' then
                                DocumentNo := VendLedgEntry."Document No."
                            else
                                DocumentNo := VendLedgEntry."External Document No.";
                            AddDocumentNoToList(List, DocumentNo, LenToCut);
                        until VendLedgEntry.Next() = 0;
                end;
            else
                exit('');
        end;
        exit(List);
    end;

    local procedure AddDocumentNoToList(var List: Text; DocumentNo: Code[35]; LenToCut: Integer)
    var
        Delimiter: Text[2];
        PrevLen: Integer;
    begin
        PrevLen := StrLen(List);
        if PrevLen <> 0 then
            Delimiter := ', ';
        List += Delimiter + DocumentNo;
        if (PrevLen <= LenToCut) and (StrLen(List) > LenToCut) then
            List := CopyStr(List, 1, PrevLen) + PadStr('', LenToCut - PrevLen) + CopyStr(List, PrevLen + StrLen(Delimiter) + 1);
    end;

    [Scope('OnPrem')]
    procedure GetAppliesToDocCustLedgEntry(var CustLedgEntry: Record "Cust. Ledger Entry")
    begin

        GetHeader();

        if PaymentDoc."Partner Type" <> PaymentDoc."Partner Type"::Customer then
            exit;

        CustLedgEntry.SetRange("Customer No.", PaymentDoc."Partner No.");
        CustLedgEntry.SetRange(Open, true);
        if "Applies-to Doc. No." <> '' then begin
            CustLedgEntry.SetRange("Document Type", "Applies-to Doc. Type");
            CustLedgEntry.SetRange("Document No.", "Applies-to Doc. No.");
            if CustLedgEntry.FindFirst() then;
        end else
            if "Applies-to ID" <> '' then begin
                CustLedgEntry.SetRange("Applies-to ID", "Applies-to ID");
                if CustLedgEntry.FindSet() then;
            end;
    end;

    local procedure GetHeader()
    var
    begin
        Rec.TestField("Document No.");
        PaymentDoc.Get("Document No.")
    end;


    procedure GetCurrency()
    begin
        GetHeader();
        if (PaymentDoc."Currency Code" = '') then begin
            Clear(Currency);
            Currency.InitRoundingPrecision();
        end else
            Currency.Get(PaymentDoc."Currency Code");
    end;
}


