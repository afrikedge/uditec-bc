
/// <summary>
/// Page A01 Customer Settlements (ID 50056).
/// </summary>
page 50058 "A01 Customer Settlements"
{
    ApplicationArea = All;
    Caption = 'Customer Scoring List';
    PageType = List;
    SourceTable = "A01 Payment Document";
    UsageCategory = Lists;
    CardPageId = "A01 Customer Settlement";



    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("No."; Rec."No.")
                {
                }
                field("Partner No."; Rec."Partner No.")
                {
                }
                field(Object; Rec.Object)
                {
                }
                field("Posting Date"; Rec."Posting Date")
                {
                }
                field("Responsibility Center"; Rec."Responsibility Center")
                {
                }
                field(Status; Rec.Status)
                {
                }
                field("Modified By"; Rec."Modified By")
                {
                }
            }
        }
    }
}
