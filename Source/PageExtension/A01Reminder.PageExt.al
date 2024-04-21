/// <summary>
/// PageExtension A01 Reminder (ID 50032) extends Record Reminder.
/// </summary>
pageextension 50032 "A01 Reminder" extends Reminder
{
    layout
    {
        addafter("Reminder Level")
        {
            field("A01 Assignment No."; Rec."A01 Assignment No.")
            {
                ApplicationArea = Basic, Suite;
            }
            field("A01 Activity Status"; Rec."A01 Activity Status")
            {
                ApplicationArea = Basic, Suite;
            }
        }
    }
}
