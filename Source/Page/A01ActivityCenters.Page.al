page 50117 "A01 Activity Centers"
{
    ApplicationArea = All;
    Caption = 'Activity Centers';
    PageType = List;
    SourceTable = "A01 Parameter Record";
    SourceTableView = where(Type = const(ActivityCenter));
    UsageCategory = Lists;

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field("Code"; Rec."Code")
                {
                }
                field(Description; Rec.Description)
                {
                }
                field(Manager; Rec.Manager)
                {
                }
            }
        }
    }
}
