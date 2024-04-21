pageextension 50031 "A01 Reminder Lines" extends "Reminder Lines"
{
    layout
    {
        addafter("Remaining Amount")
        {
            field("A01 Debt Status"; Rec."A01 Debt Status")
            {
                ApplicationArea = Basic, Suite;
            }
        }
    }
}
