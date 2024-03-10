/// <summary>
/// Table A01 Warranty Plan (ID 50005).
/// </summary>
table 50005 "A01 Warranty Plan"
{
    Caption = 'Warranty Plan';
    DataClassification = CustomerContent;

    fields
    {
        field(1; "Code"; Code[20])
        {
            Caption = 'Code';
        }
        field(2; Name; Text[50])
        {
            Caption = 'Name';
        }
        field(3; "Type"; Enum "A01 Warranty Plan Type")
        {
            Caption = 'Type';
        }
        field(4; Status; Enum "A01 Warranty Plan Status")
        {
            Caption = 'Status';
        }
        field(5; "Duration (months)"; Integer)
        {
            Caption = 'Duration (months)';
        }
        field(6; Coverage; Text[100])
        {
            Caption = 'Coverage';
        }
        field(7; Exclusions; Text[100])
        {
            Caption = 'Exclusions';
        }
        field(8; Limitations; Text[100])
        {
            Caption = 'Limitations';
        }
        field(9; Transferable; Boolean)
        {
            Caption = 'Transferable';
        }
        field(10; "Item Code"; Code[20])
        {
            Caption = 'Item Code';
            TableRelation = if (Type = const(Extension)) "Item";
        }
        field(11; "Pricing Mode"; Enum "A01 Warranty Plan Pricing Mode")
        {
            Caption = 'Pricing Mode';
        }
        field(12; Percentage; Decimal)
        {
            Caption = 'Percentage';
            MinValue = 0;
            MaxValue = 100;
        }
        field(13; "Amount (LCY)"; Decimal)
        {
            Caption = 'Amount (LCY)';
        }
    }
    keys
    {
        key(PK; "Code")
        {
            Clustered = true;
        }
    }
}
