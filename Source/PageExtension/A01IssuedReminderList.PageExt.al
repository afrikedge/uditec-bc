pageextension 50053 "A01 Issued Reminder List" extends "Issued Reminder List"
{
    layout
    {
        addafter("Canceled")
        {
            field("A01 Activity Type"; Rec."A01 Activity Type")
            {
                ApplicationArea = Basic, Suite;
            }
            field("A01 Description"; Rec."A01 Description")
            {
                ApplicationArea = Basic, Suite;
            }
            field("A01 Created By"; Rec."A01 Created By")
            {
                ApplicationArea = Basic, Suite;
            }
            field("A01 Expected Start Datetime"; Rec."A01 Expected Start Datetime")
            {
                ApplicationArea = Basic, Suite;
            }
            field("A01 Expected End Datetime"; Rec."A01 Expected End Datetime")
            {
                ApplicationArea = Basic, Suite;
            }
            field("A01 Actual Start Datetime"; Rec."A01 Actual Start Datetime")
            {
                ApplicationArea = Basic, Suite;
            }
            field("A01 Actual End Datetime"; Rec."A01 Actual End Datetime")
            {
                ApplicationArea = Basic, Suite;
            }
            field("A01 Reminder Datetime"; Rec."A01 Reminder Datetime")
            {
                ApplicationArea = Basic, Suite;
            }
            field("A01 Related activity"; Rec."A01 Related activity")
            {
                ApplicationArea = Basic, Suite;
            }
            field("A01 Subject"; Rec."A01 Subject")
            {
                ApplicationArea = Basic, Suite;
            }
            field("A01 Web User Id"; Rec."A01 Web User Id")
            {
                ApplicationArea = Basic, Suite;
            }
            field("A01 Activity Feedback"; Rec."A01 Activity Feedback")
            {
                ApplicationArea = Basic, Suite;
            }
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
