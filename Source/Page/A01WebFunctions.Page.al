/// <summary>
/// Page A01 Web Functions (ID 50088).
/// </summary>
page 50088 "A01 Web Functions"
{
    ApplicationArea = All;
    Caption = 'Web Functions';
    PageType = List;
    SourceTable = "A01 Parameter Record";
    SourceTableView = where(Type = const(WebFunction));
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
