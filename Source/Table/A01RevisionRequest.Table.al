/// <summary>
/// Table A01 Revision Request (ID 50023).
/// </summary>
table 50023 "A01 Revision Request"
{
    Caption = 'Revision Request';
    DataClassification = CustomerContent;

    fields
    {
        field(1; "No."; Code[20])
        {
            Caption = 'No.';
        }
        field(2; Status; Enum "A01 Propect Validation Status")
        {
            Caption = 'Status';
        }
        field(3; "Customer No."; Code[20])
        {
            Caption = 'Customer No.';
            TableRelation = Customer;
            trigger OnValidate()
            var
                Cust: Record Customer;
            begin
                if (Cust.Get("Customer No.")) then begin
                    "Customer Name" := cust.Name;
                    "Sales Mode" := Cust."A01 Sales Mode";
                    "Payment Terms" := Cust."Payment Terms Code";
                    "Payment Method" := Cust."Payment Method Code";
                    "Credit Limit" := Cust."Credit Limit (LCY)";
                    "VAT Regime" := Cust."VAT Bus. Posting Group";
                    "Prepayment Required" := Cust."Prepayment %";
                end;
            end;
        }
        field(4; "Customer Name"; Text[100])
        {
            Caption = 'Customer Name';
        }
        field(5; "Sales Mode"; Code[20])
        {
            Caption = 'Sales Mode';
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(3));
        }
        field(6; "Payment Terms"; Code[20])
        {
            Caption = 'Payment Terms';
            TableRelation = "Payment Terms";
        }
        field(7; "Credit Limit"; Decimal)
        {
            Caption = 'Credit Limit';
        }
        field(8; "Payment Method"; Code[10])
        {
            Caption = 'Payment Method';
            TableRelation = "Payment Method";
        }
        field(9; "VAT Regime"; Code[20])
        {
            Caption = 'VAT Regime';
            TableRelation = "VAT Business Posting Group";
        }
        field(10; "Prepayment Required"; Decimal)
        {
            Caption = 'Prepayment Required (%)';
        }
        field(11; "Payment Terms (Proposed)"; Code[20])
        {
            Caption = 'Payment Terms (Proposed)';
            TableRelation = "Payment Terms";
        }
        field(12; "Credit Limit (Proposed)"; Decimal)
        {
            Caption = 'Credit Limit (Proposed)';
        }
        field(13; "Payment Method (Proposed)"; Code[10])
        {
            Caption = 'Payment Method (Proposed)';
            TableRelation = "Payment Method";
        }
        field(14; "VAT Regime (Proposed)"; Code[20])
        {
            Caption = 'VAT Regime (Proposed)';
            TableRelation = "VAT Business Posting Group";
        }
        field(15; "Prepayment Required (Proposed)"; Decimal)
        {
            Caption = 'Prepayment Required % (Proposed)';
            MinValue = 0;
            MaxValue = 100;
        }
        field(16; "Payment Terms (Validated)"; Code[20])
        {
            Caption = 'Payment Terms (Validated)';
            TableRelation = "Payment Terms";
        }
        field(17; "Credit Limit (Validated)"; Decimal)
        {
            Caption = 'Credit Limit (Validated)';
        }
        field(18; "Payment Method (Validated)"; Code[10])
        {
            Caption = 'Payment Method (Validated)';
            TableRelation = "Payment Method";
        }
        field(19; "VAT Regime (Validated)"; Code[20])
        {
            Caption = 'VAT Regime (Validated)';
            TableRelation = "VAT Business Posting Group";
        }
        field(20; "Prepay. Required (Validated)"; Decimal)
        {
            Caption = 'Prepayment Required % (Validated)';
            MinValue = 0;
            MaxValue = 100;
        }
    }
    keys
    {
        key(PK; "No.")
        {
            Clustered = true;
        }
    }
}
