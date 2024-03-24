/// <summary>
/// Page A01 Cust Scoring Criteria (ID 50037).
/// </summary>
page 50037 "A01 Cust Scoring Criteria"
{
    ApplicationArea = All;
    Caption = 'Customer Scoring Criteria List';
    PageType = List;
    SourceTable = "A01 Cust Scoring Criteria";
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
                field(Requirement; Rec.Requirement)
                {
                }
                field("Type"; Rec."Type")
                {
                }
                field("Numeric Value"; Rec."Numeric Value")
                {
                }
                field("Aplhanumeric Value"; Rec."Aplhanumeric Value")
                {
                }
                field("List Value"; Rec."List Value")
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
            }
        }
    }
}
