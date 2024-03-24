/// <summary>
/// PageExtension A01 Sales Order Subform (ID 50015) extends Record Sales Order Subform.
/// </summary>
pageextension 50015 "A01 Sales Order Subform" extends "Sales Order Subform"
{
    layout
    {
        addafter("Line Amount")
        {
            field("A01 Shipment Method Code"; Rec."A01 Shipment Method Code")
            {
                ApplicationArea = Basic, Suite;
            }
        }
    }
}
