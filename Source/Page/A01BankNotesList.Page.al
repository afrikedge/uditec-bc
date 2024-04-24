/// <summary>
/// Page A01 Bank Notes List (ID 50076).
/// </summary>
page 50076 "A01 Bank Notes List"
{
    ApplicationArea = All;
    Caption = 'Bank Notes List';
    PageType = List;
    SourceTable = "A01 Parameter Record";
    SourceTableView = where(Type = const(BankNote));
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
