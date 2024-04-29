tableextension 50029 "A01 Location" extends Location
{
    fields
    {
        field(50000; "A01 Sales Blocked"; Boolean)
        {
            Caption = 'Sales Blocked';
            DataClassification = CustomerContent;
        }
    }
}
