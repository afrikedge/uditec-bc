/// <summary>
/// Page A01 Purchase Import Steps (ID 50045).
/// </summary>
page 50045 "A01 Purchase Import Steps"
{
    ApplicationArea = All;
    Caption = 'Purchase Import Steps';
    PageType = ListPart;
    SourceTable = "A01 Purchase Import Step";
    UsageCategory = Lists;
    AutoSplitKey = true;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("Step Type"; Rec."Step Type")
                {
                }
                field("Step Code"; Rec."Step Code")
                {
                }
                field(Notes; Rec.Notes)
                {
                }
                field("Step Description"; Rec."Step Description")
                {
                }
                field("Step Status"; Rec."Step Status")
                {
                }
                field("Starting Date"; Rec."Starting Date")
                {
                }
                field("Due Date"; Rec."Due Date")
                {
                }
                field(Notify; Rec.Notify)
                {
                }
                field("Notify Date"; Rec."Notify Date")
                {
                }
            }
        }
    }
}
