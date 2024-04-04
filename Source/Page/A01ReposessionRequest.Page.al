/// <summary>
/// Page A01 Reposession Request (ID 50053).
/// </summary>
page 50053 "A01 Reposession Request"
{
    ApplicationArea = All;
    Caption = 'Reposession Request';
    PageType = Card;
    SourceTable = "A01 Reposession Request";
    UsageCategory = Documents;

    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General';

                field("No."; Rec."No.")
                {
                }
                field(Object; Rec.Object)
                {
                }
                field("Document Type"; Rec."Document Type")
                {
                }
                field("Document No."; Rec."Document No.")
                {
                }
                field("Item No."; Rec."Item No.")
                {
                }
                field("Reposession Item Status"; Rec."Reposession Item Status")
                {
                }
                field("Reposession Type"; Rec."Reposession Type")
                {
                }
                field("Serial Number"; Rec."Serial Number")
                {
                }
                // field(Status; Rec.Status)
                // {
                // }
                field(Origin; Rec.Origin)
                {
                }
                field("Acceptance Status"; Rec."Acceptance Status")
                {
                }
                field(Reason; Rec.Reason)
                {
                }
                field("Modified By"; Rec."Modified By")
                {
                }
            }
        }
    }
}
