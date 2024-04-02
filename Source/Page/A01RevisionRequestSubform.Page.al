/// <summary>
/// Page A01 Revision Request Subform (ID 50049).
/// </summary>
page 50049 "A01 Revision Request Subform"
{
    ApplicationArea = All;
    Caption = 'Revision Request Subform';
    PageType = ListPart;
    SourceTable = "A01 Revision Request Line";
    AutoSplitKey = true;
    DelayedInsert = true;


    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("Line No."; Rec."Line No.")
                {
                    Visible = false;
                }
                field("Payment Terms (Proposed)"; Rec."Payment Terms (Proposed)")
                {
                }
                field("Credit Limit (Proposed)"; Rec."Credit Limit (Proposed)")
                {
                }
                field("Payment Method (Proposed)"; Rec."Payment Method (Proposed)")
                {
                }
                field("Prepayment Required (Proposed)"; Rec."Prepayment Required (Proposed)")
                {
                }
                field("Payment Terms (Validated)"; Rec."Payment Terms (Validated)")
                {
                }
                field("Credit Limit (Validated)"; Rec."Credit Limit (Validated)")
                {
                }
                field("Payment Method (Validated)"; Rec."Payment Method (Validated)")
                {
                }
                field("Prepay. Required (Validated)"; Rec."Prepay. Required (Validated)")
                {
                }
                field("VAT Regime (Proposed)"; Rec."VAT Regime (Proposed)")
                {
                }
                field("VAT Regime (Validated)"; Rec."VAT Regime (Validated)")
                {
                }
            }
        }
    }
}
