pageextension 50043 "A01 User Groups" extends "User Groups"
{
    layout
    {
        addafter(Name)
        {
            field("A01 Max Discount Allowed %"; Rec."A01 Max Discount Allowed %")
            {
                ApplicationArea = Basic, Suite;
            }
        }
    }
}
