page 50098 "A01 Activity Feedback List"
{
    ApplicationArea = All;
    Caption = 'Activity Feedback List';
    PageType = List;
    SourceTable = "A01 Parameter Record";
    SourceTableView = where(Type = const(ActivityFeedback));
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
