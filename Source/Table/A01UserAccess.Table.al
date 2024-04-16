/// <summary>
/// Table A01 User Access (ID 50036).
/// </summary>
table 50036 "A01 User Access"
{
    Caption = 'User Access';
    DataClassification = CustomerContent;

    fields
    {
        field(1; "User ID"; Code[50])
        {
            Caption = 'User ID';
            DataClassification = EndUserIdentifiableInformation;
            TableRelation = User."User Name";
            ValidateTableRelation = false;

            trigger OnValidate()
            var
                UserSelection: Codeunit "User Selection";
            begin
                UserSelection.ValidateUserName("User ID");
            end;
        }
        field(2; "Bank Account"; Code[20])
        {
            Caption = 'Bank Account';
            TableRelation = "Bank Account";
        }
    }
    keys
    {
        key(PK; "User Id", "Bank Account")
        {
            Clustered = true;
        }
    }
}
