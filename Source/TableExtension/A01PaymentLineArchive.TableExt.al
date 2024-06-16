tableextension 50038 "A01 Payment Line Archive" extends "Payment Line Archive"
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
