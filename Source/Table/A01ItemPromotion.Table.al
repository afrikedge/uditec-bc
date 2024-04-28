/// <summary>
/// Table A01 Item Promotion (ID 50041).
/// </summary>
table 50041 "A01 Item Promotion"
{
    Caption = 'Item Promotion';
    DataClassification = CustomerContent;

    fields
    {
        field(1; "Entry No."; Integer)
        {
            Caption = 'Entry No.';
            AutoIncrement = true;
        }
        field(2; "Promoted Item No."; Code[20])
        {
            Caption = 'Promoted Item No.';
            TableRelation = Item;
        }
        field(3; "Item Name"; Text[100])
        {
            Caption = 'Item Name';
            FieldClass = FlowField;
            CalcFormula = lookup(Item.Description where("No." = field("Promoted Item No.")));
            Editable = false;
        }
        field(4; "Starting Date"; Date)
        {
            Caption = 'Starting Date';
            DataClassification = CustomerContent;
        }
        field(5; "Ending Date"; Date)
        {
            Caption = 'Ending Date';
            DataClassification = CustomerContent;
        }
        field(6; "Additional Items Nomber"; Integer)
        {
            Caption = 'Number of additional items (Promotion)';
            DataClassification = CustomerContent;
        }
        field(7; "Deactivated"; Boolean)
        {
            Caption = 'Deactivated';
            DataClassification = CustomerContent;
        }
        field(8; "Responsilibity Center Filter"; Text[250])
        {
            Caption = 'Responsilibity Center Filter';
            DataClassification = CustomerContent;
            TableRelation = "Responsibility Center";
            ValidateTableRelation = false;
        }
    }
    keys
    {
        key(PK; "Entry No.")
        {
            Clustered = true;

        }
    }
}
