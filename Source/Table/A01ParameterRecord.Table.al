/// <summary>
/// Table A01 Parameter Record (ID 50008).
/// </summary>
table 50008 "A01 Parameter Record"
{
    Caption = 'Parameter Record';
    DataClassification = CustomerContent;

    fields
    {
        field(1; "Type"; Enum "A01 Parameter Record Type")
        {
            Caption = 'Type';
        }
        field(2; "Code"; Code[20])
        {
            Caption = 'Code';
        }
        field(3; Description; Text[50])
        {
            Caption = 'Description';
        }
    }
    keys
    {
        key(PK; "Type", "Code")
        {
            Clustered = true;
        }
    }
}
