/// <summary>
/// TableExtension A01 Purchase Header (ID 50017) extends Record Purchase Header.
/// </summary>
tableextension 50017 "A01 Purchase Header" extends "Purchase Header"
{
    fields
    {
        field(50000; "A01 Purchase Order Type"; Enum "A01 Purchase Order Type")
        {
            Caption = 'Purchase Order Type';
            DataClassification = CustomerContent;
        }
        // modify("Buy-from Vendor No.")
        // {

        // }
    }
}
