tableextension 50035 "A01 Vendor Bank Account" extends "Vendor Bank Account"
{
    fields
    {
        field(50000; "A01 Beneficiairy Name"; Text[250])
        {
            Caption = 'Beneficiairy Name';
            DataClassification = CustomerContent;
        }
    }
}
