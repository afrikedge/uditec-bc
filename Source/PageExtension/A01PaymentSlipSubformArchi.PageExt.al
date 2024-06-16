pageextension 50050 "A01 Payment Slip Subform Archi" extends "Payment Slip Subform Archive"
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
