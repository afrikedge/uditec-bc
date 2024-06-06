/// <summary>
/// Page A01 Scoring Matrix (ID 50038).
/// </summary>
page 50038 "A01 Scoring Matrix"
{
    ApplicationArea = All;
    Caption = 'Scoring Matrix';
    PageType = List;
    SourceTable = "A01 Scoring Matrix";
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("Sales Mode"; Rec."Sales Mode")
                {
                }
                field(Criteria; Rec.Criteria)
                {
                }
                field(Coefficient; Rec.Coefficient)
                {
                }
                field("Criteria Value"; Rec."Criteria Value")
                {
                }
                field(Point; Rec.Point)
                {
                }
                field("Weighted Point"; Rec."Weighted Point")
                {
                }
                field("Max credit Duration"; Rec."Max credit Duration")
                {
                }
                field("Required Prepayment (%)"; Rec."Required Prepayment (%)")
                {
                }
            }
        }
    }
}
