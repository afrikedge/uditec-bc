/// <summary>
/// Page A01 Reposession Request List (ID 50052).
/// </summary>
page 50052 "A01 Reposession Request List"
{
    ApplicationArea = All;
    Caption = 'Reposession Request List';
    PageType = List;
    CardPageId = "A01 Reposession Request";
    SourceTable = "A01 Reposession Request";
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
                field(Reason; Rec.Reason)
                {
                }
                field(Origin; Rec.Origin)
                {
                }
                field("Modified By"; Rec."Modified By")
                {
                }
                field("Acceptance Status"; Rec."Acceptance Status")
                {
                }
            }
        }
    }
}
