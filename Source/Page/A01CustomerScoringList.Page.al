/// <summary>
/// Page A01 Customer Scoring List (ID 50039).
/// </summary>
page 50039 "A01 Customer Scoring List"
{
    ApplicationArea = All;
    Caption = 'Customer Scoring List';
    PageType = List;
    SourceTable = "A01 Customer Scoring";
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field(Criteria; Rec.Criteria)
                {
                }
                field("Type"; Rec."Type")
                {
                }
                field("Criteria Value"; Rec."Criteria Value")
                {
                }
                field(Validity; Rec.Validity)
                {
                }
                field("Document Required"; Rec."Document Required")
                {
                }
                field("Validity Date"; Rec."Validity Date")
                {
                }
                field(Valid; Rec.Valid)
                {
                }
                field(Point; Rec.Score)
                {
                }
            }
        }
    }
}
