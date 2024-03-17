/// <summary>
/// PageExtension A01 Payment Class (ID 50012) extends Record Payment Class.
/// </summary>
pageextension 50012 "A01 Payment Class" extends "Payment Class"
{
    layout
    {
        addafter(Name)
        {
            field("A01 Responsibility Center"; Rec."A01 Responsibility Center")
            {
                ApplicationArea = Basic, Suite;
            }
        }
    }
}
