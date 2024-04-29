/// <summary>
/// PageExtension A01 Bin List (ID 50034) extends Record Bin List.
/// </summary>
pageextension 50034 "A01 Bin List" extends "Bin List"
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
