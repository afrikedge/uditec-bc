/// <summary>
/// Table A01 Resp Center Item Category (ID 50004).
/// </summary>
table 50004 "A01 Resp Center Item Category"
{
    Caption = 'Resp Center Item Category';
    DataClassification = CustomerContent;
    LookupPageId = "A01 Resp Center Categories";

    fields
    {
        field(1; "Responsability Center Code"; Code[10])
        {
            Caption = 'Responsability Center Code';
        }
        field(2; "Item Category Code"; Code[10])
        {
            Caption = 'Item Category Code';
            TableRelation = "Item Category";
        }
        field(3; Blocked; Boolean)
        {
            Caption = 'Blocked';
        }
    }
    keys
    {
        key(PK; "Responsability Center Code", "Item Category Code")
        {
            Clustered = true;
        }
    }
}
