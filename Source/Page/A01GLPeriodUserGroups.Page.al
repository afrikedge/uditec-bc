/// <summary>
/// Page A01 GL Period User Groups (ID 50072).
/// </summary>
page 50072 "A01 GL Period User Groups"
{
    ApplicationArea = All;
    Caption = 'GL Period User Groups';
    PageType = List;
    SourceTable = "A01 GL Period User Group";
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
                field(Name; Rec.Name)
                {
                }
                field("Allow Posting From"; Rec."Allow Posting From")
                {
                }
                field("Allow Posting To"; Rec."Allow Posting To")
                {
                }
            }
        }
    }
}
