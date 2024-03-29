/// <summary>
/// Page A01 Approval flows (ID 50048).
/// </summary>
page 50048 "A01 Approval flows"
{
    ApplicationArea = All;
    Caption = 'Approval flows';
    PageType = List;
    SourceTable = "A01 Approval Flow";
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field(Object; Rec.Object)
                {
                }
                field("Document No."; Rec."Document No.")
                {
                }
                field("Sequence No."; Rec."Sequence No.")
                {
                }
                field(Method; Rec.Method)
                {
                }
                field("Approved On"; Rec."Approved On")
                {
                }
                field("Approved By"; Rec."Approved By")
                {
                }
                field("Approved As"; Rec."Approved As")
                {
                }
                field(Comments; Rec.Comments)
                {
                }
                field("Actual Status"; Rec."Actual Status")
                {
                }
                field("Next Status"; Rec."Next Status")
                {
                }
            }
        }
    }
}
