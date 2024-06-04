page 50097 "A01 Discount Limits"
{
    ApplicationArea = All;
    Caption = 'Discount Limits';
    PageType = List;
    SourceTable = "A01 Parameter Record";
    SourceTableView = where(Type = const(DiscountLimit));
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
                field("Discount Limit (%)"; Rec."Discount Limit (%)")
                {
                }
            }
        }
    }
}
