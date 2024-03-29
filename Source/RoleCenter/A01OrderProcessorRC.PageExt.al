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
            group(A01_Config)
            {
                Caption = 'Afk Config';
                Image = Administration;
                action(A01Config_Setup)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Afk Setup';
                    RunObject = Page "A01 Afk Setup";
                }
                action(A01Config_RiskLevels)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Risk levels';
                    RunObject = Page "A01 Customer Risk Levels";
                }
                action(A01Config_TicketFormat)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Item Ticket formats';
                    RunObject = Page "A01 Item Ticket Format List";
                }
                action(A01Config_DebtStatus)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Customer Debt Status';
                    RunObject = Page "A01 Customer Debt Status List";
                }
                action(A01Config_WarrantyPlans)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Warranty plans';
                    RunObject = Page "A01 Warranty Plans";
                }
                action(A01Config_PaymentTypeConfig)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Payment configuration types';
                    RunObject = Page "A01 Payment Type Configuration";
                }
                action(A01Config_UserSetup)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'User Setup';
                    RunObject = Page "User Setup";
                }
                action(A01Config_ScoringCriteria)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Scoring criteria';
                    RunObject = Page "A01 Scoring Criteria List";
                }
                action(A01Config_ScoringCriteriaValue)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Scoring Criteria Values';
                    RunObject = Page "A01 Scoring Criteria Value";
                }
                action(A01Config_CustScoringRequirement)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Cust Scoring Requirement';
                    RunObject = Page "A01 Cust Scoring Requirement";
                }
                action(A01Config_ScoringMatrix)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Scoring Matrix';
                    RunObject = Page "A01 Scoring Matrix";
                }
                action(A01External_profiles)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'External profiles';
                    RunObject = Page "A01 External Profiles";
                }
                action(A01ExternalUsers)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'External users';
                    RunObject = Page "A01 External Users";
                }
                action(A01RCPaymentMethod)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Payment method configuration';
                    RunObject = Page "A01 RC Payment Methods";
                }
                action(A01Objets)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Objects';
                    RunObject = Page "A01 Objects";
                }
                action(A01ResponsibilityMatrix)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Responsibility Matrix';
                    RunObject = Page "A01 Responsibility Matrix";
                }
                action(A01Compta_PayClassList02)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Payment Class List';
                    RunObject = Page "Payment Class";
                }
                action(A01Compta_PayMethods)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Payment methods';
                    RunObject = Page "Payment Methods";
                }
                action(A01ImportSteps)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Import Steps';
                    RunObject = Page "A01 Import Steps";
                }
            }
            group(A01_Compta)
            {
                //Visible = false;
                // Caption = 'Afk Compta';
                // Image = Administration;
                // action(A01Compta_JournalPayment)
                // {
                //     ApplicationArea = Basic, Suite;
                //     Caption = 'Afk Cash receipt journal';
                //     RunObject = Page "A01 Cash Receipt Doc Journal";
                // }
                // action(A01Compta_PayClassList)
                // {
                //     ApplicationArea = Basic, Suite;
                //     Caption = 'Payment Class List';
                //     RunObject = Page "Payment Class";
                // }
                action(A01Compta_PayList)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Payment Slip List';
                    RunObject = Page "Payment Slip List";
                }
                action(A01Compta_PayListArchive)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Payment Slip List Archive';
                    RunObject = Page "Payment Slip List Archive";
                }
            }
        }
    }
}
