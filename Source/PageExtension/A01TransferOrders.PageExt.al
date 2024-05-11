pageextension 50041 "A01 Transfer Orders" extends "Transfer Orders"
{
    layout
    {
        addafter("Receipt Date")
        {
            field("A01 Approval Status"; Rec."A01 Approval Status")
            {
                ApplicationArea = all;
            }
        }
    }
}
