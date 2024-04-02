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
        field(8; "Payment Method"; Code[20])
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
    }
    keys
    {
        key(PK; "No.")
        {
            Clustered = true;
        }
    }
}
