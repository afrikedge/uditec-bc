/// <summary>
/// Page A01 Posted Credit Amort Lines (ID 50086).
/// </summary>
page 50086 "A01 Posted Credit Amort Lines"
{
    ApplicationArea = All;
    Caption = 'Posted Credit Amort Lines';
    PageType = List;
    SourceTable = "A01 Credit Depreciation Table";
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("Line No."; Rec."Line No.")
                {
                }
                field("Due Date"; Rec."Due Date")
                {
                }
                field("Document Type"; Rec."Document Type")
                {
                }
                field("Document No."; Rec."Document No.")
                {
                }
                field(Interest; Rec.Interest)
                {
                }
                field("Calculation factor"; Rec."Calculation factor")
                {
                }
                field("Abandoned interests"; Rec."Abandoned interests")
                {
                }
                field(Depreciation; Rec.Depreciation)
                {
                }
                field("Cust Ledger Entry No."; Rec."Cust Ledger Entry No.")
                {
                }
                field("Interest Posted"; Rec."Interest Posted")
                {
                }
                field("Monthly payment"; Rec."Monthly payment")
                {
                }
                field("Order No."; Rec."Order No.")
                {
                }
                field("Payment balance"; Rec."Payment balance")
                {
                }
                field("Quote No."; Rec."Quote No.")
                {
                }
                field("Remaining debt"; Rec."Remaining debt")
                {
                }
                field("Dimension Set ID"; Rec."Dimension Set ID")
                {
                }
            }
        }
    }
}