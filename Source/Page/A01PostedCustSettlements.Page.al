/// <summary>
/// Page A01 Posted Cust Settlements (ID 50058).
/// </summary>
page 50062 "A01 Posted Cust Settlements"
{
    ApplicationArea = All;
    Caption = 'Posted Cust Settlements';
    PageType = List;
    SourceTable = "A01 Posted Payment Document";
    CardPageId = "A01 Posted Cust Settlement";
    UsageCategory = Lists;

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
