page 50101 "A01 Gap Reason List"
{
    ApplicationArea = All;
    Caption = 'Gap Reason List';
    PageType = List;
    SourceTable = "A01 Parameter Record";
    SourceTableView = where(Type = const(GapReason));
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
            }
        }
    }
}
