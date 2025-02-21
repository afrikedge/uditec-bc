pageextension 50033 "A01 Bank Account Card" extends "Bank Account Card"
{
    layout
    {
        addafter("Our Contact Code")
        {
            field("A01 Bank Account Type"; Rec."A01 Bank Account Type")
            {
                ApplicationArea = Basic, Suite;
            }
            // field("A01 Beneficiairy Name"; Rec."A01 Beneficiairy Name")
            // {
            //     ApplicationArea = Basic, Suite;
            // }
        }
        addafter("Last Check No.")
        {
            field("A01 Starting Check No."; Rec."A01 Starting Check No.")
            {
                ApplicationArea = Basic, Suite;
            }
            field("A01 Ending Check No."; Rec."A01 Ending Check No.")
            {
                ApplicationArea = Basic, Suite;
            }
            field("A01 Check Report ID"; Rec."Check Report ID")
            {
                ApplicationArea = Basic, Suite;
            }
        }
    }
}
