/// <summary>
/// PageExtension A01 Item Card (ID 50003) extends Record Item Card.
/// </summary>
pageextension 50003 "A01 Item Card" extends "Item Card"
{
    layout
    {
        addafter("Item Category Code")
        {
            field("A01 Item Status"; Rec."A01 Item Status")
            {
                ApplicationArea = Basic, Suite;
            }
            field("A01 Shipment Method Code"; Rec."A01 Shipment Method Code")
            {
                ApplicationArea = Basic, Suite;
            }
            field("A01 Ticket Format"; Rec."A01 Ticket Format")
            {
                ApplicationArea = Basic, Suite;
            }
        }
    }
    actions
    {
        addafter(Attributes)
        {
            action(A01Attributes)
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Warranty plans';
                Image = ViewDetails;
                RunObject = Page "A01 Item Warranty Plans";
                RunPageLink = "Item No." = field("No.");
            }
        }
    }
}
