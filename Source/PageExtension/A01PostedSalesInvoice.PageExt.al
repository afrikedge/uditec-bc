/// <summary>
/// PageExtension A01 Posted Sales Invoice (ID 50023) extends Posted Sales Invoice.
/// </summary>
pageextension 50000 "A01 Posted Sales Invoice" extends "Posted Sales Invoice"
{
    layout
    {
        addafter("Sell-to")
        {
            field("A01 Miscellaneous Contact"; Rec."A01 Miscellaneous Contact")
            {
                ApplicationArea = Basic, Suite;
            }
        }

        addafter("Foreign Trade")
        {
            part(A01PaymentMethods; "A01 Sales Posted Pay Methods")
            {
                ApplicationArea = All;
                // Editable = IsSalesLinesEditable;
                // Enabled = IsSalesLinesEditable;
                SubPageLink = "Document No." = field("No."), "Responsibility Center" = field("Responsibility Center");
                UpdatePropagation = Both;
            }
            group(A01Credit)
            {
                Caption = 'Credit';
                field("A01 Credit Validation Status"; Rec."A01 Credit Validation Status")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("A01 Credit Duration (Month)"; Rec."A01 Credit Duration (Month)")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("A01 Interest rate"; Rec."A01 Interest rate")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("A01 Sales Mode"; Rec."A01 Sales Mode")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("A01 Analyst comments"; Rec."A01 Analyst comments")
                {
                    ApplicationArea = Basic, Suite;
                    MultiLine = true;
                }
                field("A01 System Decision"; Rec."A01 System Decision")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("A01 Analyst Opinion"; Rec."A01 Analyst Opinion")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("A01 Investigator Opinion"; Rec."A01 Investigator Opinion")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("A01 Joint Type"; Rec."A01 Joint Type")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("A01 Joint Code"; Rec."A01 Joint Code")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("A01 AGP Contract No."; Rec."A01 AGP Contract No.")
                {
                    ApplicationArea = Basic, Suite;
                }
            }
        }
    }

    actions
    {
        addafter(Print)
        {
            action("A01 Sales Invoice Credit")
            {
                ApplicationArea = All;
                Image = PrintForm;
                Caption = 'Print Sales Invoice Credit';
                trigger OnAction()
                var
                    SalesInvRec: Record "Sales Invoice Header";
                begin
                    SalesInvRec.SetRange("No.", Rec."No.");
                    SalesInvRec.SetRange("Sell-to Customer No.", Rec."Sell-to Customer No.");
                    Report.Run(50010, true, false, SalesInvRec);
                end;
            }
            action("A01 Sales Invoice Uditec")
            {
                ApplicationArea = All;
                Image = PrintForm;
                Caption = 'Print Sales Invoice Uditec';
                trigger OnAction()
                var
                    SalesInvRec: Record "Sales Invoice Header";
                begin
                    SalesInvRec.SetRange("No.", Rec."No.");
                    SalesInvRec.SetRange("Sell-to Customer No.", Rec."Sell-to Customer No.");
                    Report.Run(50030, true, false, SalesInvRec);
                end;
            }
        }
        addafter(Statistics)
        {
            action("A01AGPDueLine")
            {
                ApplicationArea = All;
                Image = AllLines;
                Caption = 'Credit Amortisation Lines';
                RunObject = page "A01 Posted Credit Amort Lines";
                RunPageLink = "Document Type" = const("Posted Sales invoice"), "Document No." = field("No.");
            }
            action("A01CustScoring")
            {
                ApplicationArea = All;
                Image = AllLines;
                Caption = 'Customer Scoring Lines';
                RunObject = page "A01 Posted Customer Scoring";
                RunPageLink = "Document No." = field("No.");
            }
            action("A01CustScoringCriteria")
            {
                ApplicationArea = All;
                Image = AllLines;
                Caption = 'Customer Scoring Criteria Lines';
                RunObject = page "A01 Post Cust Scoring Criteria";
                RunPageLink = "Document No." = field("No.");
            }
        }
    }
}