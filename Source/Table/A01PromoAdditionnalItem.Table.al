/// <summary>
/// Table A01 Promo Additionnal Item (ID 50040).
/// </summary>
table 50040 "A01 Promo Additionnal Item"
{
    Caption = 'Promo Additionnal Item';
    DataClassification = CustomerContent;

    fields
    {
        field(1; "Promoted Item No."; Code[20])
        {
            Caption = 'Promoted Item No.';
            TableRelation = Item;
        }
        field(2; "Additionnal Item No."; Code[20])
        {
            Caption = 'Additionnal Item No.';
            TableRelation = Item;
        }
        field(3; "Discount (%)"; Decimal)
        {
            Caption = 'Discount (%)';
            MinValue = 0;
            MaxValue = 100;
        }
        field(4; Exclude; Boolean)
        {
            Caption = 'Exclude';
        }
        field(5; "Quantity"; Decimal)
        {
            Caption = 'Quantity';
            MinValue = 0;
        }
    }
    keys
    {
        key(PK; "Promoted Item No.", "Additionnal Item No.")
        {
            Clustered = true;
        }
    }
}
