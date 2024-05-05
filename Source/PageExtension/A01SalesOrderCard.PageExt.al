/// <summary>
/// PageExtension A01 SalesOrderCard (ID 50026) extends Sales Order
/// </summary>
pageextension 50026 "A01 SalesOrderCard" extends "Sales Order"
{
    layout
    {

    }

    actions
    {
        // addafter("&Print")
        // {
        //     action("A01 Preparation Order")
        //     {
        //         ApplicationArea = All;
        //         Image = PrintForm;
        //         Caption = 'Print Preparation Order';
        //         trigger OnAction()
        //         var
        //             SalesOrderRec: Record "Sales Header";
        //         begin
        //             SalesOrderRec.SetRange("No.", Rec."No.");
        //             SalesOrderRec.SetRange("Sell-to Customer No.", Rec."Sell-to Customer No.");
        //             Report.Run(50016, true, false, SalesOrderRec);
        //         end;
        //     }
        // }
    }
}