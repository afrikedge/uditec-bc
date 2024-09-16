page 50103 "A01 Route Card"
{
    ApplicationArea = All;
    Caption = 'Route Card';
    PageType = Card;
    SourceTable = "A01 Route";
    UsageCategory = None;

    layout
    {
        area(Content)
        {
            group(General)
            {
                Caption = 'General';

                field("Code"; Rec."Code")
                {
                }
                field(Description; Rec.Description)
                {
                }
                field("Route Type"; Rec."Route Type")
                {
                }
                field("Route Status"; Rec."Route Status")
                {
                }
                field("Departure Zone"; Rec."Departure Zone")
                {
                }
                field("Arrival Zone"; Rec."Arrival Zone")
                {
                }
                field("Total Distance(Km)"; Rec."Total Distance(Km)")
                {
                }
                field("Average Duration"; Rec."Average Duration")
                {
                }
            }
            part(Itinaries; "A01 Route Subform")
            {
                Caption = 'Lines';
                ApplicationArea = Basic, Suite;
                // Editable = IsSalesLinesEditable;
                // Enabled = IsSalesLinesEditable;
                SubPageLink = "Route Code" = field("Code");
                UpdatePropagation = Both;
            }
        }
    }
}
