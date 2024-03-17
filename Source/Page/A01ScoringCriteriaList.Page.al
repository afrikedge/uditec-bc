/// <summary>
/// Page A01 Scoring Criteria List (ID 50034).
/// </summary>
page 50034 "A01 Scoring Criteria List"
{
    ApplicationArea = All;
    Caption = 'Scoring Criteria List';
    PageType = List;
    SourceTable = "A01 Scoring Criteria";
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
                field(Requirement; Rec.Requirement)
                {
                }
                field(Validity; Rec.Validity)
                {
                }
                field(Coefficient; Rec.Coefficient)
                {
                }
                field("Point Maximal"; Rec."Point Maximal")
                {
                }
                field("Document required"; Rec."Document required")
                {
                }
                field("Type"; Rec."Type")
                {
                }
                field(Size; Rec.Size)
                {
                }
            }
        }
    }
}
