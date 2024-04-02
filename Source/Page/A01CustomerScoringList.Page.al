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
                field("Sales Mode"; Rec."Sales Mode")
                {
                }
                field(Criteria; Rec.Criteria)
                {
                }
                field("Type"; Rec."Type")
                {
                }
                field("Criteria Value"; Rec."Criteria Value")
                {
                }
                field(Precision; Rec.Precision)
                {
                }
                field(Validity; Rec.Validity)
                {
                }
                field("Validity Date"; Rec."Validity Date")
                {
                }
                field("Document Required"; Rec."Document Required")
                {
                }
                field(DocumentLink; Rec.DocumentLink)
                {
                }
                field(Valid; Rec.Valid)
                {
                }
                field(Point; Rec.Score)
                {
                }
                field("A01 Account Type"; Rec."Account Type")
                {
                }
                field("Customer No."; Rec."Customer No.")
                {
                }
                field("Modified By"; Rec."Modified By")
                {
                }
                field(SystemModifiedAt; Rec.SystemModifiedAt)
                {
                }
            }
        }
    }
}
