/// <summary>
/// Table A01 Responsibility Matrix (ID 50019).
/// </summary>
table 50019 "A01 Responsibility Matrix"
{
    Caption = 'Responsibility Matrix';
    DataClassification = CustomerContent;

    fields
    {
        field(1; Object; Code[20])
        {
            Caption = 'Object';
            TableRelation = "A01 Parameter Record".Code where(Type = const(Object));
        }
        field(2; "Sales Mode"; Code[20])
        {
            Caption = 'Sales Mode';
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(3));
        }
        field(3; "Responsibility Center"; Code[20])
        {
            Caption = 'Responsibility Center';
            TableRelation = "Responsibility Center";
        }
        field(4; Status; Enum "A01 Approval Status")
        {
            Caption = 'Status';
        }
        field(5; Validator; Code[20])
        {
            Caption = 'Validator';
            TableRelation = "A01 External User";
        }
        field(6; Substitute; Code[20])
        {
            Caption = 'Substitute';
            TableRelation = "A01 External User";
        }
        field(7; "Minimal Value"; Decimal)
        {
            Caption = 'Minimal Value';
        }
        field(8; "Maximal Value"; Decimal)
        {
            Caption = 'Maximal Value';
        }
        field(9; Required; Boolean)
        {
            Caption = 'Required';
        }
        field(10; Parallel; Boolean)
        {
            Caption = 'Parallel';
        }
    }
    keys
    {
        key(PK; Object, "Sales Mode", "Responsibility Center")
        {
            Clustered = true;
        }
    }
}
