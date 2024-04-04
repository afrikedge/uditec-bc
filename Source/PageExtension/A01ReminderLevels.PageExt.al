/// <summary>
/// PageExtension A01 Reminder Levels (ID 50023) extends Record Reminder Levels.
/// </summary>
pageextension 50023 "A01 Reminder Levels" extends "Reminder Levels"
{
    layout
    {
        addafter("Calculate Interest")
        {
            field("A01 Report Usage"; Rec."A01 Report Usage")
            {
                ApplicationArea = Basic, Suite;
            }

        }
    }
}
