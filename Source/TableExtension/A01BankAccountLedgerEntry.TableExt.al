tableextension 50036 "A01 Bank Account Ledger Entry" extends "Bank Account Ledger Entry"
{
    fields
    {
        field(50000; "A01 Payment Reference"; Code[30])
        {
            Caption = 'A01 Payment Reference';
            DataClassification = CustomerContent;
        }
    }
}
