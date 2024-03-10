/// <summary>
/// Page A01 Resp Center Categories (ID 50023).
/// </summary>
page 50023 "A01 Resp Center Categories"
{
    ApplicationArea = All;
    Caption = 'Responsability Center Categories';
    PageType = List;
    SourceTable = "A01 Resp Center Item Category";
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("Item Category Code"; Rec."Item Category Code")
                {
                    //ToolTip = 'Specifies the value of the Item Category Code field.';
                }
                field(Blocked; Rec.Blocked)
                {
                    //ToolTip = 'Specifies the value of the Active field.';
                }
            }
        }
    }
}
