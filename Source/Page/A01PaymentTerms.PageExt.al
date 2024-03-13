/// <summary>
/// PageExtension A01 Payment Terms (ID 50008) extends Record Payment Terms.
/// </summary>
pageextension 50008 "A01 Payment Terms" extends "Payment Terms"
{
    layout
    {
        addafter(Description)
        {
            field("A01 Sales Mode"; Rec."A01 Sales Mode")
            {
                ApplicationArea = Basic, Suite;
            }
            field("A01 Multi-deadlines"; Rec."A01 Multi-deadlines")
            {
                ApplicationArea = Basic, Suite;
            }
            field("A01 Prepayment (%)"; Rec."A01 Prepayment (%)")
            {
                ApplicationArea = Basic, Suite;
            }
        }
    }
}
