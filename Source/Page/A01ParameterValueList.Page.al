/// <summary>
/// Page A01 Parameter Value List (ID 50030).
/// </summary>
page 50030 "A01 Parameter Value List"
{
    ApplicationArea = All;
    Caption = 'Parameter Value List';
    PageType = List;
    SourceTable = "A01 Parameter Record";
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
