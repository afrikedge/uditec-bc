/// <summary>
/// Table A01 External User Company (ID 50002).
/// </summary>
table 50002 "A01 External User Company"
{
    Caption = 'External User Company';
    DataClassification = CustomerContent;
    DataPerCompany = false;

    fields
    {
        field(1; "User Code"; Code[50])
        {
            Caption = 'User Code';
        }
        field(2; "Company Code"; Text[30])
        {
            Caption = 'Company Code';
            TableRelation = Company;
        }
        field(3; Active; Boolean)
        {
            Caption = 'Active';
        }
        field(4; "Profile"; Code[20])
        {
            Caption = 'User profile';
            TableRelation = "A01 External Profile";
        }
    }
    keys
    {
        key(PK; "User Code", "Company Code")
        {
            Clustered = true;
        }
    }
}
