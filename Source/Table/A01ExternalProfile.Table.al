/// <summary>
/// Table A01 External Profile (ID 50003).
/// </summary>
table 50003 "A01 External Profile"
{
    Caption = 'External Profile';
    DataClassification = CustomerContent;
    DataPerCompany = false;

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
        field(3; Active; Boolean)
        {
            Caption = 'Active';
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
