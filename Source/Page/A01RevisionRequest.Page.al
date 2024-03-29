/// <summary>
/// Page A01 Revision Request (ID 50051).
/// </summary>
page 50051 "A01 Revision Request"
{
    ApplicationArea = All;
    Caption = 'Revision Request';
    PageType = Card;
    SourceTable = "A01 Revision Request";
    UsageCategory = Documents;

    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General';

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
                field("Sales Mode"; Rec."Sales Mode")
                {
                }
                field("Prepayment Required"; Rec."Prepayment Required")
                {
                }
            }
            part(Lines; "A01 Revision Request Subform")
            {
                ApplicationArea = Basic, Suite;
                SubPageLink = "Document No." = field("No.");
                UpdatePropagation = Both;
            }
        }
    }
}
