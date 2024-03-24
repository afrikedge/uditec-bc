/// <summary>
/// TableExtension A01 Purchase Header Archive (ID 50018) extends Record Purchase Header Archive.
/// </summary>
tableextension 50018 "A01 Purchase Header Archive" extends "Purchase Header Archive"
{
    fields
    {
        field(50000; "A01 Purchase Order Type"; Enum "A01 Purchase Order Type")
        {
            Caption = 'Purchase Order Type';
            DataClassification = CustomerContent;
        }
    }
}
