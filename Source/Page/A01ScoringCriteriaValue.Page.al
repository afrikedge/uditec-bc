/// <summary>
/// Page A01 Scoring Criteria Value (ID 50035).
/// </summary>
page 50035 "A01 Scoring Criteria Value"
{
    ApplicationArea = All;
    Caption = 'Scoring Criteria Value';
    PageType = List;
    SourceTable = "A01 Scoring Criteria Value";
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
                field("Type"; Rec."Type")
                {

                }
                field(Citeria; Rec.Criteria)
                {

                }
            }
        }
    }
}
