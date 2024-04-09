/// <summary>
/// TableExtension A01 Vendor (ID 50024) extends Record Vendor.
/// </summary>
tableextension 50024 "A01 Vendor" extends Vendor
{
    fields
    {
        field(50000; "A01 NIF"; Code[30])
        {
            Caption = 'NIF';
            DataClassification = CustomerContent;
        }
        field(50001; "A01 STAT"; Code[30])
        {
            Caption = 'STAT';
            DataClassification = CustomerContent;
        }
        field(50002; "A01 RCS"; Code[30])
        {
            Caption = 'RCS';
            DataClassification = CustomerContent;
        }
        field(50003; "A01 CIF"; Code[30])
        {
            Caption = 'CIF';
            DataClassification = CustomerContent;
        }
    }
}
