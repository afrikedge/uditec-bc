/// <summary>
/// PageExtension A01 Customer Card (ID 50006) extends Record Customer Card.
/// </summary>
pageextension 50006 "A01 Customer Card" extends "Customer Card"
{
    layout
    {
        addafter("Responsibility Center")
        {
            field("A01 Customer Type"; Rec."A01 Customer Type")
            {
                ApplicationArea = Basic, Suite;
            }
            field("A01 Legal Status"; Rec."A01 Legal Status")
            {
                ApplicationArea = Basic, Suite;
            }
        }
    }
}
