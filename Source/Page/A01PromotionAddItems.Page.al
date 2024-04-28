/// <summary>
/// Page A01 Promotion Add Items (ID 50084).
/// </summary>
page 50084 "A01 Promotion Add Items"
{
    ApplicationArea = All;
    Caption = 'Promotion Add Items';
    PageType = List;
    SourceTable = "A01 Promo Additionnal Item";
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("Additionnal Item No."; Rec."Additionnal Item No.")
                {
                }
                field(Quantity; Rec.Quantity)
                {
                }
                field("Discount (%)"; Rec."Discount (%)")
                {
                }
                field(Exclude; Rec.Exclude)
                {
                }
            }
        }
    }
}
