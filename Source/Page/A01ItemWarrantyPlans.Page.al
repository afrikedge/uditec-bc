/// <summary>
/// Page A01 Item Warranty Plans (ID 50026).
/// </summary>
page 50026 "A01 Item Warranty Plans"
{
    ApplicationArea = All;
    Caption = 'Item Warranty Plans';
    PageType = List;
    SourceTable = "A01 Item Warranty";
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("Warranty Plan Code"; Rec."Warranty Plan Code")
                {
                }
                field(Default; Rec.Default)
                {
                }
                field("Warranty Plan Name"; Rec."Warranty Plan Name")
                {
                }
                field("Warranty Plan Type"; Rec."Warranty Plan Type")
                {
                }
            }
        }
    }
}
