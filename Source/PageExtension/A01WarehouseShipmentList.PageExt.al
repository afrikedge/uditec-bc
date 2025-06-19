pageextension 50057 "A01 Warehouse Shipment List" extends "Warehouse Shipment List"
{
    layout
    {
        addafter("Shipping Agent Code")
        {
            field("A01External Document No."; Rec."External Document No.")
            {
                ApplicationArea = All;
            }
        }
    }
}
