/// <summary>
/// Table A01 External User (ID 50001).
/// </summary>
table 50001 "A01 External User"
{
    Caption = 'External User';
    DataClassification = CustomerContent;
    DataPerCompany = false;
    DataCaptionFields = Code, Name;

    fields
    {
        field(1; Code; Code[50])
        {
            Caption = 'Code';
        }
        field(2; Email; Text[50])
        {
            Caption = 'Email';
            ExtendedDatatype = EMail;
        }
        field(3; Name; Text[100])
        {
            Caption = 'Name';
        }
        field(4; Password; Text[255])
        {
            Editable = false;
            Caption = 'Password';
        }
        field(5; PasswordIsSet; Boolean)
        {
            Editable = false;
            Caption = 'Password Exists';
        }

        field(6; "Default Company"; Text[30])
        {
            Caption = 'Default Company';
            TableRelation = Company;
        }
        field(7; "Last Used Company"; Text[30])
        {
            Caption = 'Last Used Company';
            TableRelation = Company;
            Editable = false;
        }
        field(8; Active; Boolean)
        {
            Caption = 'Active';
        }
        field(9; UserMustChangePassword; Boolean)
        {
            Editable = false;
            Caption = 'User must change password';
        }
        field(10; BCUserId; Code[50])
        {
            Editable = false;
            Caption = 'BC User Id';
        }
    }
    keys
    {
        key(PK; Code)
        {
            Clustered = true;
        }
        key(PK2; Email)
        {
            //Unique = true;
        }
    }
}
