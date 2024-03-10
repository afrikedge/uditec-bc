/// <summary>
/// Page A01 Warranty Plans (ID 50025).
/// </summary>
page 50025 "A01 Warranty Plans"
{
    ApplicationArea = All;
    Caption = 'Warranty Plans';
    PageType = List;
    SourceTable = "A01 Warranty Plan";
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("Code"; Rec."Code")
                {
                }

                field("Type"; Rec."Type")
                {
                }
                field(Name; Rec.Name)
                {
                }
                field(Status; Rec.Status)
                {
                }
                field("Duration (months)"; Rec."Duration (months)")
                {
                }
                field(Coverage; Rec.Coverage)
                {
                }
                field(Exclusions; Rec.Exclusions)
                {
                }
                field(Limitations; Rec.Limitations)
                {
                }
                field(Transferable; Rec.Transferable)
                {
                }

                field("Item Code"; Rec."Item Code")
                {
                }
                field("Pricing Mode"; Rec."Pricing Mode")
                {
                }
                field(Percentage; Rec.Percentage)
                {
                }
                field("Amount (LCY)"; Rec."Amount (LCY)")
                {
                }

            }
        }
    }
}
