/// <summary>
/// Table A01 Purchase Voucher (ID 50028).
/// </summary>
table 50028 "A01 Purchase Voucher"
{
    Caption = 'Purchase voucher';
    DataClassification = CustomerContent;

    fields
    {
        field(1; "No."; Code[50])
        {
            Caption = 'No.';
            Editable = false;
        }
        field(2; Reference; Text[30])
        {
            Caption = 'Reference';
        }
        field(3; "Initial Amount"; Decimal)
        {
            Caption = 'Initial Amount';
            Editable = false;
        }
        field(4; Balance; Decimal)
        {
            Caption = 'Balance';
            Editable = false;
            FieldClass = FlowField;
            CalcFormula = sum("A01 Purchase Voucher Entry".Amount where("Voucher No." = field("No.")));
        }
        field(5; "Emission By"; Code[50])
        {
            Caption = 'Emission By';
            Editable = false;
        }
        field(6; "Emission Date"; Date)
        {
            Caption = 'Emission Date';
            Editable = false;
        }
        field(7; "Validity Date"; Date)
        {
            Caption = 'Validity Date';
        }
        field(8; Observation; Text[150])
        {
            Caption = 'Observation';
        }
        field(9; "Item Ledger Entry Id"; Integer)
        {
            Caption = 'Item Ledger Entry Id';
            Editable = false;
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
