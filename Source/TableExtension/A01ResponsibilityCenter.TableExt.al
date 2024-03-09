/// <summary>
/// TableExtension A01 Responsibility Center (ID 50003) extends Record Responsibility Center.
/// </summary>
tableextension 50003 "A01 Responsibility Center" extends "Responsibility Center"
{
    fields
    {
        field(50000; "A01 Default Customer"; Code[20])
        {
            Caption = 'Default Customer';
            DataClassification = CustomerContent;
        }
        field(50001; "A01 Theme Color 1"; Text[30])
        {
            Caption = 'Theme Color 1';
            DataClassification = CustomerContent;
        }
        field(50002; "A01 Theme Color 2"; Text[30])
        {
            Caption = 'Theme Color 2';
            DataClassification = CustomerContent;
        }
        field(50003; "A01 Theme Color 3"; Text[30])
        {
            Caption = 'Theme Color 3';
            DataClassification = CustomerContent;
        }
        field(50004; "A01 Logo"; Blob)
        {
            Caption = 'Logo';
            DataClassification = CustomerContent;
        }
    }
}
