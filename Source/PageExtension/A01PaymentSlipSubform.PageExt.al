pageextension 50049 "A01 Payment Slip Subform" extends "Payment Slip Subform"
{
    layout
    {
        addafter(Amount)
        {
            field("A01 Payment Reference"; Rec."A01 Payment Reference")
            {
                ApplicationArea = Basic, Suite;
            }
        }
    }
}
