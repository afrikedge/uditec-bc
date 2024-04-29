pageextension 50036 "A01 Location Card" extends "Location Card"
{
    layout
    {
        addafter("Use As In-Transit")
        {
            field("A01 Sales Blocked"; Rec."A01 Sales Blocked")
            {
                ApplicationArea = Basic, Suite;
            }
        }
    }
}
