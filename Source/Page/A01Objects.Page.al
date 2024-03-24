/// <summary>
/// Page A01 Objects (ID 50042).
/// </summary>
page 50042 "A01 Objects"
{
    ApplicationArea = All;
    Caption = 'Objects';
    PageType = List;
    SourceTable = "A01 Parameter Record";
    SourceTableView = where(Type = const(Object));
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
