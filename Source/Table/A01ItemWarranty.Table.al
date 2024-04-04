/// <summary>
/// Table A01 Item Warranty (ID 50006).
/// </summary>
table 50006 "A01 Item Warranty"
{
    Caption = 'Item Warranty';
    DataClassification = CustomerContent;

    fields
    {
        field(1; "Item No."; Code[20])
        {
            Caption = 'Item No.';
        }
        field(2; "Warranty Plan Code"; Code[20])
        {
            Caption = 'Warranty Plan Code';
        }
        field(3; Default; Boolean)
        {
            Caption = 'Default';
        }
        field(5; "Warranty Plan Name"; Text[50])
        {
            Caption = 'Warranty Plan Name';
            FieldClass = FlowField;
            CalcFormula = lookup("A01 Warranty Plan".Name where(Code = field("Warranty Plan Code")));
            Editable = false;
        }
        field(4; "Warranty Plan Type"; enum "A01 Warranty Plan Type")
        {
            FieldClass = FlowField;
            CalcFormula = lookup("A01 Warranty Plan".Type where(Code = field("Warranty Plan Code")));
            Caption = 'Warranty Plan Type';
            Editable = false;
        }
        field(17; "Modified By"; Code[50])
        {
            Caption = 'Modified By';
            TableRelation = "A01 External User";
            DataClassification = CustomerContent;
        }
    }
    keys
    {
        key(PK; "Item No.", "Warranty Plan Code")
        {
            Clustered = true;
        }
    }
}
