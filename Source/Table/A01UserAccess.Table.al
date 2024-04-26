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
        field(2; "Ressource Code 1"; Code[20])
        {
            Caption = 'Ressource Code 1';
            TableRelation = if ("Access Type" = const("Bank Account")) "Bank Account"
            else
            if ("Access Type" = const("Journal")) "Gen. Journal Template";
            //ValidateTableRelation = false;
        }
        field(3; "Access Type"; Enum "A01 User Access Type")
        {
            Caption = 'Access Type';
            //TableRelation = "Bank Account";
        }
        field(4; "Ressource Code 2"; Code[20])
        {
            Caption = 'Ressource Code 2';
            TableRelation = if ("Access Type" = const("Journal")) "Gen. Journal Batch".Name where("Journal Template Name" = field("Ressource Code 1"));
            //ValidateTableRelation = false;
        }
    }
    keys
    {
        key(PK; "Access Type", "User Id", "Ressource Code 1", "Ressource Code 2")
        {
            Clustered = true;
        }
    }
}
