tableextension 50037 "A01 Payment Line" extends "Payment Line"
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
