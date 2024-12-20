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
            // field("A01 MIR Max credit duration"; Rec."A01 MIR Max credit duration")
            // {
            //     ApplicationArea = Basic, Suite;
            // }
            // field("A01 MIR Monthly interest %"; Rec."A01 MIR Monthly interest %")
            // {
            //     ApplicationArea = Basic, Suite;
            // }
            // field("A01 MIR Required Prepayment %"; Rec."A01 MIR Required Prepayment %")
            // {
            //     ApplicationArea = Basic, Suite;
            // }
            // field("A01 MIR Eligible Product"; Rec."A01 MIR Eligible Product")
            // {
            //     ApplicationArea = Basic, Suite;
            // }
            field("A01 Prep required for credit"; Rec."A01 Prep required for credit")
            {
                ApplicationArea = Basic, Suite;
            }
            field("A01 Non Eligible credit sales"; Rec."A01 Non Eligible credit sales")
            {
                ApplicationArea = Basic, Suite;
            }
            field("A01 Assembly service"; Rec."A01 Assembly service")
            {
                ApplicationArea = Basic, Suite;
            }
            field("A01 Brand"; Rec."A01 Brand")
            {
                ApplicationArea = Basic, Suite;
            }
            field("A01 Cancel Prepayment"; Rec."A01 Cancel Prepayment")
            {
                ApplicationArea = Basic, Suite;
            }
            field("A01 Number of package"; Rec."A01 Number of package")
            {
                ApplicationArea = Basic, Suite;
            }
        }
        // addafter(Warehouse)
        // {
        //     group(A01Promotion)
        //     {
        //         Caption = 'Promotion';
        //         field("A01 Promotion Activated"; Rec."A01 Promotion Activated")
        //         {
        //             ApplicationArea = Basic, Suite;
        //         }
        //         field("A01 Promotion Starting Date"; Rec."A01 Promotion Starting Date")
        //         {
        //             ApplicationArea = Basic, Suite;
        //         }
        //         field("A01 Promotion Ending Date"; Rec."A01 Promotion Ending Date")
        //         {
        //             ApplicationArea = Basic, Suite;
        //         }
        //         field("A01 Promotion Add Items Nomber"; Rec."A01 Promotion Add Items Nomber")
        //         {
        //             ApplicationArea = Basic, Suite;
        //         }
        //         field("A01 Promo Resp Center Filter"; Rec."A01 Promo Resp Center Filter")
        //         {
        //             ApplicationArea = Basic, Suite;
        //             MultiLine = true;
        //         }
        //     }
        // }

        modify("Last Direct Cost")
        {
            Editable = false;
        }
        modify("Unit Price")
        {
            Editable = false;
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
