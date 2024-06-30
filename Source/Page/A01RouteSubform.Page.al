page 50102 "A01 Route Subform"
{
    ApplicationArea = All;
    Caption = 'Route Subform';
    PageType = ListPart;
    SourceTable = "A01 Route Itinery";

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field("Departure Zone"; Rec."Departure Zone")
                {
                }
                field("Arrival Code"; Rec."Arrival Zone")
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
                field("Time preference"; Rec."Time preference")
                {
                }
            }
        }
    }
}
