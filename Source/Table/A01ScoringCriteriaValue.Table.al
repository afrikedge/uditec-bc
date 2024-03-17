/// <summary>
/// Table A01 Criteria Value (ID 50011).
/// </summary>
table 50011 "A01 Scoring Criteria Value"
{
    Caption = 'Criteria Value';
    DataClassification = CustomerContent;

    fields
    {
        field(1; "Code"; Code[20])
        {
            Caption = 'Code';
        }
        field(2; Description; Text[50])
        {
            Caption = 'Description';
        }
        field(3; "Type"; Enum "A01 Scoring Crit Value Type")
        {
            Caption = 'Type';
        }
        field(4; Criteria; Code[20])
        {
            Caption = 'Criteria';
            TableRelation = "A01 Scoring Criteria";
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
