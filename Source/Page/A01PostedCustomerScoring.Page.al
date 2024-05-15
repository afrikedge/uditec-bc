page 50092 "A01 Posted Customer Scoring"
{
    ApplicationArea = All;
    Caption = 'Posted Customer Scoring';
    PageType = List;
    SourceTable = "A01 Posted Customer Scoring";
    UsageCategory = Lists;
    
    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("Customer No."; Rec."Customer No.")
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
                field("Document Required"; Rec."Document Required")
                {
                }
                field(DocumentLink; Rec.DocumentLink)
                {
                }
                field("Modified By"; Rec."Modified By")
                {
                }
                field(Precision; Rec.Precision)
                {
                }
                field("Sales Mode"; Rec."Sales Mode")
                {
                }
                field(Score; Rec.Score)
                {
                }
                field("Type"; Rec."Type")
                {
                }
                field(Valid; Rec.Valid)
                {
                }
                field(Validity; Rec.Validity)
                {
                }
                field("Validity Date"; Rec."Validity Date")
                {
                }
                field("Weighted Score"; Rec."Weighted Score")
                {
                }
            }
        }
    }
}
