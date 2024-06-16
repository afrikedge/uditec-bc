tableextension 50039 "A01 Detailed Cust. Ledg. Entry" extends "Detailed Cust. Ledg. Entry"
{
    fields
    {
        field(50000; A01CreditProcessed; Boolean)
        {
            Caption = 'CreditProcessed';
            DataClassification = CustomerContent;
        }
    }
}
