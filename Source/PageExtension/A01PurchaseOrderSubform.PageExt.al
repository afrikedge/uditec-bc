pageextension 50039 "A01 Purchase Order Subform" extends "Purchase Order Subform"
{
    layout
    {
        addafter("Promised Receipt Date")
        {
            field("A01Quantity (Base)"; Rec."Quantity (Base)")
            {
                ApplicationArea = all;
            }
        }
    }
}
