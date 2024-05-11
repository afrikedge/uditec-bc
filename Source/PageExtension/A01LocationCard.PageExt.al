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
            field("A01 Transfer Val Required"; Rec."A01 Transfer Val Required")
            {
                ApplicationArea = Basic, Suite;
            }
            field("A01 Transfer Val Manager"; Rec."A01 Transfer Val Manager")
            {
                ApplicationArea = Basic, Suite;
            }
        }
    }
}
