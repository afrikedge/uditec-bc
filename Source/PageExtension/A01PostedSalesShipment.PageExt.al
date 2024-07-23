/// <summary>
/// PageExtension A01 Posted Sales Shipment (ID 50024) extends Posted Sales Shipment.
/// </summary>
pageextension 50024 "A01 Posted Sales Shipment" extends "Posted Sales Shipment"
{
    layout
    {

    }

    actions
    {
        addafter("&Print")
        {
            action("A01 BL/Invoice")
            {
                ApplicationArea = All;
                Image = PrintForm;
                Caption = 'Print BL/Invoice';
                trigger OnAction()
                var
                    SalesShipmentRec: Record "Sales Shipment Header";
                begin
                    SalesShipmentRec.SetRange("No.", Rec."No.");
                    SalesShipmentRec.SetRange("Sell-to Customer No.", Rec."Sell-to Customer No.");
                    Report.Run(50009, true, false, SalesShipmentRec);
                end;
            }
            action("A01 Undeclared BL/Invoice")
            {
                ApplicationArea = All;
                Image = PrintForm;
                Caption = 'Print the undeclared BL/Invoice';
                trigger OnAction()
                var
                    SalesShipmentRec: Record "Sales Shipment Header";
                begin
                    SalesShipmentRec.SetRange("No.", Rec."No.");
                    SalesShipmentRec.SetRange("Sell-to Customer No.", Rec."Sell-to Customer No.");
                    Report.Run(50034, true, false, SalesShipmentRec);
                end;
            }
            action("A01 BL")
            {
                ApplicationArea = All;
                Image = PrintForm;
                Caption = 'Print BL';
                trigger OnAction()
                var
                    SalesShipmentRec: Record "Sales Shipment Header";
                begin
                    SalesShipmentRec.SetRange("No.", Rec."No.");
                    SalesShipmentRec.SetRange("Sell-to Customer No.", Rec."Sell-to Customer No.");
                    Report.Run(50036, true, false, SalesShipmentRec);
                end;
            }
        }
    }
}