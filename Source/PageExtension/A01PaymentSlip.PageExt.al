/// <summary>
/// PageExtension A01 Payment Slip (ID 50009) extends Record Payment Slip.
/// </summary>
pageextension 50009 "A01 Payment Slip" extends "Payment Slip"
{
    layout
    {
        addafter("Partner Type")
        {
            field("A01 Description"; Rec."A01 Description")
            {
                ApplicationArea = Basic, Suite;
            }
            field("A01 Customer No."; Rec."A01 Customer No.")
            {
                ApplicationArea = Basic, Suite;
            }
            field("A01 Origin Document No."; Rec."A01 Origin Document No.")
            {
                ApplicationArea = Basic, Suite;
            }
        }
    }
}
