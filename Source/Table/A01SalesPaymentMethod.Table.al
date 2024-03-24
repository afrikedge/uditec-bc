/// <summary>
/// Table A01 Sales Payment Method (ID 50020).
/// </summary>
table 50020 "A01 Sales Payment Method"
{
    Caption = 'Sales Payment Method';
    DataClassification = CustomerContent;

    fields
    {
        field(1; "Document Type"; Enum "Sales Document Type")
        {
            Caption = 'Document Type';
        }
        field(2; "Document No."; Code[20])
        {
            Caption = 'Document No.';
        }
        field(4; "Payment Method"; Code[20])
        {
            Caption = 'Payment Method';
            TableRelation = "Payment Method";
        }
        field(5; Reference; Text[50])
        {
            Caption = 'Reference';
        }
        field(6; Amount; Decimal)
        {
            Caption = 'Amount';
        }
        field(7; "Validated Amount"; Decimal)
        {
            Caption = 'Validated Amount';
        }
        field(8; "Archived"; Boolean)
        {
            Caption = 'Archived';
            Editable = false;
        }
    }
    keys
    {
        key(PK; "Document Type", "Document No.", "Payment Method")
        {
            Clustered = true;
        }
    }
}
