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
    }
}
