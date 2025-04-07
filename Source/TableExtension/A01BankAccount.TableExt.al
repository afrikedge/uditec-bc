/// <summary>
/// TableExtension A01 Bank Account (ID 50026) extends Record Bank Account.
/// </summary>
tableextension 50026 "A01 Bank Account" extends "Bank Account"
{
    fields
    {
        field(50000; "A01 Bank Account Type"; Enum "A01 Bank Account Type")
        {
            Caption = 'A01 Bank Account Type';
            DataClassification = CustomerContent;
        }
        // field(50001; "A01 Beneficiairy Name"; Text[100])
        // {
        //     Caption = 'Beneficiairy Name';
        //     DataClassification = CustomerContent;
        // }
        modify("Check Report ID")
        {
            Caption = 'Check Report ID';
        }
        field(50002; "A01 Starting Check No."; Code[20])
        {
            DataClassification = CustomerContent;
            AccessByPermission = TableData 272 = R;
            Caption = 'N° début plage chèque';
        }
        field(50004; "A01 Ending Check No."; Code[20])
        {
            DataClassification = CustomerContent;
            AccessByPermission = TableData 272 = R;
            Caption = 'N° fin plage chèque';
        }
    }
}
