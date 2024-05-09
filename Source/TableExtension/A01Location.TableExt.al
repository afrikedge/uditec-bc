tableextension 50029 "A01 Location" extends Location
{
    fields
    {
        field(50000; "A01 Sales Blocked"; Boolean)
        {
            Caption = 'Sales Blocked';
            DataClassification = CustomerContent;
        }
        field(50001; "A01 Transfer Val Required"; Boolean)
        {
            Caption = 'Transfer Validation Required';
            DataClassification = CustomerContent;
        }
        field(50002; "A01 Transfer Val Manager"; Code[50])
        {
            Caption = 'Transfer Validation Manager';
            DataClassification = CustomerContent;
            TableRelation = User."User Name";
            ValidateTableRelation = false;

            trigger OnValidate()
            var
                UserSelection: Codeunit "User Selection";
            begin
                UserSelection.ValidateUserName("A01 Transfer Val Manager");
            end;
        }
    }
}
