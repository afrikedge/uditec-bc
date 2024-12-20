page 50105 "A01 Transport Order Subform"
{
    ApplicationArea = All;
    Caption = 'Transport Order Subform';
    PageType = ListPart;
    SourceTable = "A01 Transport Order Detail";

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field("Order No."; Rec."Order No.")
                {
                }
                field("Customer No."; Rec."Customer No.")
                {
                }
                field("Address Code"; Rec."Address Code")
                {
                }
                field("Time preference"; Rec."Time preference")
                {
                }
                field("Transport Direction"; Rec."Transport Direction")
                {
                }
                field("Line No."; Rec."Line No.")
                {
                }
                field("Unit of Mesure Code"; Rec."Unit of Mesure Code")
                {
                }
                field("Quantity (Planned)"; Rec."Quantity (Planned)")
                {
                }
                field("Quantity (Actual)"; Rec."Quantity (Actual)")
                {
                }
                field("Quantity (Gap)"; Rec."Quantity (Gap)")
                {
                }
                field("Item No."; Rec."Item No.")
                {
                }
                field("Total Volume (cbm)"; Rec."Total Volume (cbm)")
                {
                }
                field("Total Weight (Kg)"; Rec."Total Weight (Kg)")
                {
                }
                field("Unloading Duration"; Rec."Unloading Duration")
                {
                }
                field("Gap Reason Code"; Rec."Gap Reason Code")
                {
                }
                field("Anomaly Type"; Rec."Anomaly Type")
                {
                }
                field("Anomaly Description"; Rec."Anomaly Description")
                {
                }
                field("Location Code"; Rec."Location Code")
                {
                }
                field("Return Status"; Rec."Return Status")
                {
                }
                field("Service Zone"; Rec."Service Zone")
                {
                }
                field("Order Type"; Rec."Order Type")
                {
                }
                field("Execution Rank"; Rec."Execution Rank")
                {
                }
                field(Name; Rec.Name)
                {
                }
                field("Returned Qty"; Rec."Returned Qty")
                {
                }
                field("Return Reason Code"; Rec."Return Reason Code")
                {
                }
                field("Postponed-to Date"; Rec."Postponed-to Date")
                {
                }
                field("Line Type"; Rec."Line Type")
                {
                }
            }
        }
    }
}
