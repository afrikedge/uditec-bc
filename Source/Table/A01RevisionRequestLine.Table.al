/// <summary>
/// Table A01 Revision Request Line (ID 50024).
/// </summary>
table 50024 "A01 Revision Request Line"
{
    Caption = 'Revision Request Line';
    DataClassification = CustomerContent;

    fields
    {
        field(1; "Document No."; Code[20])
        {
            Caption = 'Document No.';
        }
        field(2; "Line No."; Integer)
        {
            Caption = 'Line No.';
        }
        field(3; "Payment Terms (Proposed)"; Code[20])
        {
            Caption = 'Payment Terms (Proposed)';
            TableRelation = "Payment Terms";
        }
        field(4; "Credit Limit (Proposed)"; Decimal)
        {
            Caption = 'Credit Limit (Proposed)';
        }
        field(5; "Payment Method (Proposed)"; Code[20])
        {
            Caption = 'Payment Method (Proposed)';
            TableRelation = "Payment Method";
        }
        field(6; "VAT Regime (Proposed)"; Code[20])
        {
            Caption = 'VAT Regime (Proposed)';
            TableRelation = "VAT Business Posting Group";
        }
        field(7; "Prepayment Required (Proposed)"; Decimal)
        {
            Caption = 'Prepayment Required % (Proposed)';
            MinValue = 0;
            MaxValue = 100;
        }
        field(8; "Payment Terms (Validated)"; Code[20])
        {
            Caption = 'Payment Terms (Validated)';
            TableRelation = "Payment Terms";
        }
        field(9; "Credit Limit (Validated)"; Decimal)
        {
            Caption = 'Credit Limit (Validated)';
        }
        field(10; "Payment Method (Validated)"; Code[20])
        {
            Caption = 'Payment Method (Validated)';
            TableRelation = "Payment Method";
        }
        field(11; "VAT Regime (Validated)"; Code[20])
        {
            Caption = 'VAT Regime (Validated)';
            TableRelation = "VAT Business Posting Group";
        }
        field(12; "Prepay. Required (Validated)"; Decimal)
        {
            Caption = 'Prepayment Required % (Validated)';
            MinValue = 0;
            MaxValue = 100;
        }
    }
    keys
    {
        key(PK; "Document No.", "Line No.")
        {
            Clustered = true;
        }
    }
}
