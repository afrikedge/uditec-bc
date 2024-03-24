/// <summary>
/// Page A01 Import Steps (ID 50044).
/// </summary>
page 50044 "A01 Import Steps"
{
    ApplicationArea = All;
    Caption = 'Import Steps';
    PageType = List;
    SourceTable = "A01 Parameter Record";
    SourceTableView = where(Type = const(ImportStep));
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
