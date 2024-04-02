/// <summary>
/// Page A01 Item Brands (ID 50047).
/// </summary>
page 50047 "A01 Item Brands"
{
    ApplicationArea = All;
    Caption = 'Item Brands';
    PageType = List;
    SourceTable = "A01 Parameter Record";
    SourceTableView = where(Type = const(Brand));
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("Code"; Rec."Code")
                {
                }
                field(Description; Rec.Description)
                {
                }
            }
        }
    }
}
