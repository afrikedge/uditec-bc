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
            }
        }
    }
}
