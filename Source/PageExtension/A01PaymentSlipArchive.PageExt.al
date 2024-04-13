pageextension 50030 "A01 Payment Slip Archive" extends "Payment Slip Archive"
{
    layout
    {
        addafter("Amount (LCY)")
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
            field("A01 Payment Method"; Rec."A01 Payment Method")
            {
                ApplicationArea = Basic, Suite;
            }
        }
    }
}
