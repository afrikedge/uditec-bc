/// <summary>
/// PageExtension A01 Payment Methods (ID 50019) extends Record Payment Methods.
/// </summary>
pageextension 50019 "A01 Payment Methods" extends "Payment Methods"
{
    layout
    {
        addafter(Description)
        {
            field("A01 Approval required"; Rec."A01 Approval required")
            {
                ApplicationArea = All;
            }
            field("A01 Reference required"; Rec."A01 Reference required")
            {
                ApplicationArea = All;
            }
        }
    }
}
