page 50106 "A01 Transport Order"
{
    ApplicationArea = All;
    Caption = 'Transport Order';
    PageType = Document;
    SourceTable = "A01 Transport Order";

    layout
    {
        area(Content)
        {
            group(General)
            {
                Caption = 'General';

                field("No."; Rec."No.")
                {
                }
                field("TransportOrder Status"; Rec."TransportOrder Status")
                {
                }
                field("Carrier No."; Rec."Carrier No.")
                {
                }
                field("Vehicle No."; Rec."Vehicle No.")
                {
                }
                field(" Driver No."; Rec." Driver No.")
                {
                }
                field("Route No."; Rec."Route No.")
                {
                }
                field("Departure Date (Planned)"; Rec."Departure Date (Planned)")
                {
                }
                field("Departure Time (Planned)"; Rec."Departure Time (Planned)")
                {
                }
                field("Departure Date (Actual)"; Rec."Departure Date (Actual)")
                {
                }
                field("Departure Time (Actual)"; Rec."Departure Time (Actual)")
                {
                }
                field("Duration (Actual)"; Rec."Duration (Actual)")
                {
                }
                field("Duration (Planned)"; Rec."Duration (Planned)")
                {
                }
                field("Return Date (Planned)"; Rec."Return Date (Planned)")
                {
                }
                field("Return Time (Planned)"; Rec."Return Time (Planned)")
                {
                }
                field("Return Date (Actual)"; Rec."Return Date (Actual)")
                {
                }
                field("Return Time (Actual)"; Rec."Return Time (Actual)")
                {
                }
                field("Useful volume (cbm)"; Rec."Useful volume (cbm)")
                {
                }
                field("Payload (kg)"; Rec."Payload (kg)")
                {
                }
            }
            part(TransportOrderDetails; "A01 Transport Order Subform")
            {
                Caption = 'Lines';
                ApplicationArea = Basic, Suite;
                SubPageLink = "Transport Order No." = field("No.");
                UpdatePropagation = Both;
            }
            group("Outgoing totals")
            {
                Caption = 'Outgoing totals';

                field("Outbound Package Count"; Rec."Outbound Package Count")
                {
                }
                field("Outbound Unloading Dura (Plan)"; Rec."Outbound Unloading Dura (Plan)")
                {
                }
                field("Outbound Volume Loaded (cbm)"; Rec."Outbound Volume Loaded (cbm)")
                {
                }
                field("Outbound Weight Load (Kg)"; Rec."Outbound Weight Load (Kg)")
                {
                }
            }
            group("Incoming totals")
            {
                Caption = 'Incoming totals';

                field("Inbound Package Count"; Rec."Inbound Package Count")
                {
                }
                field("Inbound Unloading Dura (Plan)"; Rec."Inbound Unloading Dura (Plan)")
                {
                }
                field("Inbound Volume Loaded (cbm)"; Rec."Inbound Volume Loaded (cbm)")
                {
                }
                field("Inbound Weight Load (Kg)"; Rec."Inbound Weight Load (Kg)")
                {
                }
            }
        }
    }
}
