/// <summary>
/// Page A01 Revision Request List (ID 50050).
/// </summary>
page 50050 "A01 Revision Request List"
{
    ApplicationArea = All;
    Caption = 'Revision Request List';
    PageType = List;
    SourceTable = "A01 Revision Request";
    UsageCategory = Lists;
    Editable = false;
    CardPageId = "A01 Revision Request";

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("Document No."; Rec."No.")
                {
                }
                field(Status; Rec.Status)
                {
                }
                field("Customer No."; Rec."Customer No.")
                {
                }
                field("Customer Name"; Rec."Customer Name")
                {
                }
                field("Payment Terms"; Rec."Payment Terms")
                {
                }
                field("Credit Limit"; Rec."Credit Limit")
                {
                }
                field("Payment Method"; Rec."Payment Method")
                {
                }
                field("VAT Regime"; Rec."VAT Regime")
                {
                }
                field("Prepayment Required"; Rec."Prepayment Required")
                {
                }
                field("Sales Mode"; Rec."Sales Mode")
                {
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
