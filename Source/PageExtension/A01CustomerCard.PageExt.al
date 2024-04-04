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
            field("A01 Risk Level"; Rec."A01 Risk Level")
            {
                ApplicationArea = Basic, Suite;
            }
            field("A01 Identification Mode"; Rec."A01 Identification Mode")
            {
                ApplicationArea = Basic, Suite;
            }
            field("A01 Sales Mode"; Rec."A01 Sales Mode")
            {
                ApplicationArea = Basic, Suite;
            }
            field("A01 Parent Customer"; Rec."A01 Parent Customer")
            {
                ApplicationArea = Basic, Suite;
            }
            field("A01 Allowed Item Category"; Rec."A01 Allowed Item Category")
            {
                ApplicationArea = Basic, Suite;
            }
            field("A01 Preferred Reminder Mode"; Rec."A01 Preferred Reminder Mode")
            {
                ApplicationArea = Basic, Suite;
            }
        }
    }
    actions
    {
        addafter(ShipToAddresses)
        {
            action(A01Criteria)
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Scoring criteria';
                Image = ViewDetails;
                RunObject = Page "A01 Cust Scoring Criteria";
                RunPageLink = "Customer No." = field("No.");
            }
            action(A01Scoring)
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Scoring';
                Image = ViewDetails;
                RunObject = Page "A01 Customer Scoring List";
                RunPageLink = "Customer No." = field("No."), "Account Type" = const(Customer);
            }
        }
    }
}
