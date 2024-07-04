page 50104 "A01 Routes"
{
    ApplicationArea = All;
    Caption = 'Routes';
    PageType = List;
    SourceTable = "A01 Route";
    CardPageId = "A01 Route Card";
    UsageCategory = Lists;
    Editable = false;

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field("Code"; Rec."Code")
                {
                }
                field(Description; Rec.Description)
                {
                }
                field("Departure Zone"; Rec."Departure Zone")
                {
                }
                field("Arrival Zone"; Rec."Arrival Zone")
                {
                }
                field("Average Duration"; Rec."Average Duration")
                {
                }
                field("Total Distance(Km)"; Rec."Total Distance(Km)")
                {
                }
                field("Route Type"; Rec."Route Type")
                {
                }
                field("Route Status"; Rec."Route Status")
                {
                }
            }
        }
    }
}
