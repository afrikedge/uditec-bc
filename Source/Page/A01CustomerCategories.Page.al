page 50116 "A01 Customer Categories"
{
    ApplicationArea = All;
    Caption = 'Customer Categories';
    PageType = List;
    SourceTable = "A01 Parameter Record";
    SourceTableView = where(Type = const(CustomerCategory));
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
