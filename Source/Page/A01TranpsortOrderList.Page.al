page 50107 "A01 Tranpsort Order List"
{
    ApplicationArea = All;
    Caption = 'Trapsort Order List';
    PageType = List;
    SourceTable = "A01 Transport Order";
    CardPageId = "A01 Transport Order";
    UsageCategory = Lists;
    Editable = false;

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field("No."; Rec."No.")
                {
                }
                field(" Driver No."; Rec." Driver No.")
                {
                }
                field("Carrier No."; Rec."Carrier No.")
                {
                }
                field("Vehicle No."; Rec."Vehicle No.")
                {
                }
                field("TransportOrder Status"; Rec."TransportOrder Status")
                {
                }
                field("Useful volume (cbm)"; Rec."Useful volume (cbm)")
                {
                }
                field("Route No."; Rec."Route No.")
                {
                }
                field("Departure Date (Actual)"; Rec."Departure Date (Actual)")
                {
                }
                field("Departure Date (Planned)"; Rec."Departure Date (Planned)")
                {
                }
                field("Departure Time (Actual)"; Rec."Departure Time (Actual)")
                {
                }
                field("Departure Time (Planned)"; Rec."Departure Time (Planned)")
                {
                }
                field("Duration (Actual)"; Rec."Duration (Actual)")
                {
                }
                field("Duration (Planned)"; Rec."Duration (Planned)")
                {
                }
                field("Payload (kg)"; Rec."Payload (kg)")
                {
                }
                field("Return Date (Actual)"; Rec."Return Date (Actual)")
                {
                }
                field("Return Date (Planned)"; Rec."Return Date (Planned)")
                {
                }
                field("Return Time (Actual)"; Rec."Return Time (Actual)")
                {
                }
                field("Return Time (Planned)"; Rec."Return Time (Planned)")
                {
                }
            }
        }
    }
}
