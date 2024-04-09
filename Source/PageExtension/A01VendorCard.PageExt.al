/// <summary>
/// PageExtension A01 Vendor Card (ID 50028) extends Record Vendor Card.
/// </summary>
pageextension 50028 "A01 Vendor Card" extends "Vendor Card"
{
    layout
    {
        addafter("SIREN No.")
        {
            field("A01 NIF"; Rec."A01 NIF")
            {
                ApplicationArea = Basic, Suite;
            }
            field("A01 STAT"; Rec."A01 STAT")
            {
                ApplicationArea = Basic, Suite;
            }
            field("A01 CIF"; Rec."A01 CIF")
            {
                ApplicationArea = Basic, Suite;
            }
            field("A01 RCS"; Rec."A01 RCS")
            {
                ApplicationArea = Basic, Suite;
            }
        }
    }
}
