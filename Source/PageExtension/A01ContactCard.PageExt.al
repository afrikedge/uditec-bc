/// <summary>
/// PageExtension A01 Contact Card (ID 50005) extends Record Contact Card.
/// </summary>
pageextension 50005 "A01 Contact Card" extends "Contact Card"
{
    layout
    {
        addafter(Type)
        {
            field("A01 Legal Status"; Rec."A01 Legal Status")
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
            field("A01 Payment Method"; Rec."A01 Payment Method")
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
            field("A01 VAT Regime"; Rec."A01 VAT Regime")
            {
                ApplicationArea = Basic, Suite;
            }
            field("A01 Main Contact"; Rec."A01 Main Contact")
            {
                ApplicationArea = Basic, Suite;
            }
            field("A01 Prepayment required"; Rec."A01 Prepayment required")
            {
                ApplicationArea = Basic, Suite;
            }
            field("A01 Risk Level"; Rec."A01 Risk Level")
            {
                ApplicationArea = Basic, Suite;
            }
            field("A01 Score"; Rec."A01 Score")
            {
                ApplicationArea = Basic, Suite;
            }
            field("A01 Prospect Status"; Rec."A01 Prospect Status")
            {
                ApplicationArea = Basic, Suite;
            }
            field("A01 Preferred Reminder Mode"; Rec."A01 Preferred Reminder Mode")
            {
                ApplicationArea = Basic, Suite;
            }

            field("A01 Contract No."; Rec."A01 Contract No.")
            {
                ApplicationArea = Basic, Suite;
            }
            field("A01 NIF"; Rec."A01 NIF")
            {
                ApplicationArea = Basic, Suite;
            }
            field("A01 STAT"; Rec."A01 STAT")
            {
                ApplicationArea = Basic, Suite;
            }
            field("A01 CIF"; Rec."A01 CIF")
            {
                ApplicationArea = Basic, Suite;
            }
            field("A01 RCS"; Rec."A01 RCS")
            {
                ApplicationArea = Basic, Suite;
            }
            field("A01 ID Number"; Rec."A01 ID Number")
            {
                ApplicationArea = Basic, Suite;
            }
            field("A01 Credit Limit"; Rec."A01 Credit Limit")
            {
                ApplicationArea = Basic, Suite;
            }
        }
    }
    actions
    {
        addafter("Industry Groups")
        {
            // action(A01Criteria)
            // {
            //     ApplicationArea = Basic, Suite;
            //     Caption = 'Scoring criteria';
            //     Image = ViewDetails;
            //     RunObject = Page "A01 Cust Scoring Criteria";
            //     RunPageLink = "Customer No." = field("No.");
            // }
            action(A01Scoring)
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Scoring';
                Image = ViewDetails;
                RunObject = Page "A01 Customer Scoring List";
                RunPageLink = "Customer No." = field("No."), "Account Type" = const(Prospect);
            }
        }
    }
}
