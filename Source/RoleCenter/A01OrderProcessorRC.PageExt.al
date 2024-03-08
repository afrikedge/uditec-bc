/// <summary>
/// PageExtension AFK01 Order Processor RC (ID 50002) extends Record Order Processor Role Center.
/// </summary>
pageextension 50002 "A01 Order Processor RC" extends "Order Processor Role Center"
{
    actions
    {
        addafter("Posted Documents")
        {
            group(A01_SalesProcess)
            {
                Caption = 'Afk Sales Order process';
                Image = Sales;
                action(A01Orders_FollowUp)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Orders - FollowUp';
                    RunObject = Page "A01 Sales Order - FollowUp";
                }

                action(A01Orders_Draft)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Orders - Draft';
                    RunObject = Page "A01 SalesOrderList-Draft";
                }
                action(A01Orders_POutOfStock)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Orders - Partially out of stock';
                    RunObject = Page "A01 SalesOrderList-PStockOut";
                }
                action(A01Orders_OutOfStock)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Orders - Out of stock';
                    RunObject = Page "A01 SalesOrderList-StockOut";
                }
                action(A01Orders_Blocked)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Orders - Blocked';
                    RunObject = Page "A01 Sales Order List Blocked";
                }
                action(A01Orders_Consigned)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Orders - Consigned';
                    RunObject = Page "A01 SalesOrderList-Consigned";
                }
                action(A01Orders_PConsigned)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Orders - Partially Consigned';
                    RunObject = Page "A01 SalesOrderList-PConsigned";
                }
                action(A01Orders_Discount)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Orders - Awaiting for discount';
                    RunObject = Page "A01 SalesOrderList-Discount";
                }
                action(A01Orders_Payment)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Orders - Awaiting for prepayment';
                    RunObject = Page "A01 Sales Order List Prepay";
                }
                action(A01Orders_Delivery)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Orders - Delivery';
                    RunObject = Page "A01 SalesOrderList-Delivery";
                }
                action(A01Orders_PShipped)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Orders - Partially shipped';
                    RunObject = Page "A01 SalesOrderList-PShipped";
                }
                action(A01Orders_Shipped)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Orders - Shipped';
                    RunObject = Page "A01 SalesOrderList-Shipped";
                }
                action(A01Orders_Closed)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Orders - Closed';
                    RunObject = Page "A01 Sales Orders - Closed";
                }
                action(A01Orders_Cancelled)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Orders - Cancelled';
                    RunObject = Page "A01 Sales Orders - Cancelled";
                }
                action(A01Orders_Invoiced)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Orders - Invoiced';
                    RunObject = Page "A01 Sales Orders - Invoiced";
                }
            }
        }
    }
}
