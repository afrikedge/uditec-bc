pageextension 50035 "A01 Bins" extends Bins
{
    layout
    {
        addafter(Description)
        {
            field("A01 Capacity"; Rec."A01 Capacity")
            {
                ApplicationArea = Basic, Suite;
            }
            field("A01 Unit of Measure Code"; Rec."A01 Unit of Measure Code")
            {
                ApplicationArea = Basic, Suite;
            }
        }
    }
}
