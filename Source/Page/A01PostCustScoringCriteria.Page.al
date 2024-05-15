page 50091 "A01 Post Cust Scoring Criteria"
{
    ApplicationArea = All;
    Caption = 'Post Cust Scoring Criteria';
    PageType = List;
    SourceTable = "A01 Post Cust Scoring Criteria";
    UsageCategory = Lists;
    Editable = false;

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
                field("Aplhanumeric Value"; Rec."Aplhanumeric Value")
                {
                }
                field("Document Required"; Rec."Document Required")
                {
                }
                field(DocumentLink; Rec.DocumentLink)
                {
                }
                field("List Value"; Rec."List Value")
                {
                }
                field("Numeric Value"; Rec."Numeric Value")
                {
                }
                field(Requirement; Rec.Requirement)
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
                field("Modified By"; Rec."Modified By")
                {
                }
                field("Created By"; Rec."Created By")
                {
                }
            }
        }
    }
}
