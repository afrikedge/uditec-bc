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
            field("A01 Contract No."; Rec."A01 Contract No.")
            {
                ApplicationArea = Basic, Suite;
            }

            field("A01 ID Number"; Rec."A01 ID Number")
            {
                ApplicationArea = Basic, Suite;
            }

            field("A01 Employee Number"; Rec."A01 Employee Number")
            {
                ApplicationArea = Basic, Suite;
            }
            field("A01 Employee Function"; Rec."A01 Employee Function")
            {
                ApplicationArea = Basic, Suite;
            }
            field("A01 Employee Salary"; Rec."A01 Employee Salary")
            {
                ApplicationArea = Basic, Suite;
            }
            field("A01 Calc Risk Level"; Rec."A01 Calc Risk Level")
            {
                ApplicationArea = Basic, Suite;
            }
            field("A01 Gender"; Rec."A01 Gender")
            {
                ApplicationArea = Basic, Suite;
            }
        }

        addafter("SIREN No.")
        {
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
                RunPageLink = "Customer No." = field("No."), "Account Type" = const(Customer);
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
        addafter(ApplyTemplate)
        {
            action(A01CalcStatus)
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Calculate status';
                Image = Calculate;
                trigger OnAction()
                var
                begin
                    Rec."A01 Calc Risk Level" := Rec.A01CalcCustStatus();
                    Rec.Modify();
                end;
            }
        }

    }
}
