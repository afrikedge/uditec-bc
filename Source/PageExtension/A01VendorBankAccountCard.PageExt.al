pageextension 50047 "A01 Vendor Bank Account Card" extends "Vendor Bank Account Card"
{
    layout
    {
        addafter("Name")
        {
            field("A01 Beneficiairy Name"; Rec."A01 Beneficiairy Name")
            {
                ApplicationArea = Basic, Suite;
            }
        }
    }
}
