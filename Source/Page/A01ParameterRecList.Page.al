page 50028 "A01 Customer Risk Levels"
{
    ApplicationArea = All;
    Caption = 'Customer Risk Levels';
    PageType = List;
    SourceTable = "A01 Parameter Record";
    SourceTableView = Type
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
