/// <summary>
/// PageExtension A01 Contact Card (ID 50005) extends Record Contact Card.
/// </summary>
pageextension 50005 "A01 Contact Card" extends "Contact Card"
{
    layout
    {
        addafter(Type)
        {
            field("A01 Legal Status"; Rec."A01 Legal Status")
            {
                ApplicationArea = Basic, Suite;
            }
        }
    }
}
