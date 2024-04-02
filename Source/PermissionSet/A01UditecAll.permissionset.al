permissionset 50000 "A01 Uditec_All"
{
    Assignable = true;
    Permissions = tabledata "A01 Document Step History" = RIMD,
        table "A01 Document Step History" = X,
        codeunit "A01 Sales Order Processing" = X,
        codeunit "A01 EventsSubscribers_Code" = X,
        codeunit "A01 EventsSubscribers_Page" = X,
        codeunit "A01 EventsSubscribers_Table" = X,
        codeunit "A01 Security Mgt" = X,
        tabledata "A01 External User" = RIMD,
        table "A01 External User" = X,
        page "A01 Document Step Lines" = X,
        page "A01 Sales Order - Draft" = X,
        page "A01 Sales Order - FollowUp" = X,
        page "A01 Sales Order - Workflow" = X,
        page "A01 Sales Order List Blocked" = X,
        page "A01 Sales Order List Prepay" = X,
        page "A01 Sales Orders - Cancelled" = X,
        page "A01 Sales Orders - Closed" = X,
        page "A01 Sales Orders - Invoiced" = X,
        page "A01 SalesOrderList-Consigned" = X,
        page "A01 SalesOrderList-Delivery" = X,
        page "A01 SalesOrderList-Discount" = X,
        page "A01 SalesOrderList-Draft" = X,
        page "A01 SalesOrderList-PConsigned" = X,
        page "A01 SalesOrderList-PInvoiced" = X,
        page "A01 SalesOrderList-PShipped" = X,
        page "A01 SalesOrderList-PStockOut" = X,
        page "A01 SalesOrderList-Shipped" = X,
        page "A01 SalesOrderList-StockOut" = X,
        tabledata "A01 External Profile" = RIMD,
        tabledata "A01 External User Company" = RIMD,
        table "A01 External Profile" = X,
        table "A01 External User Company" = X,
        tabledata "A01 Resp Center Item Category" = RIMD,
        table "A01 Resp Center Item Category" = X,
        report "A01 CreateResetPassword" = X,
        codeunit "A01 Api Mgt" = X,
        page "A01 External Profiles" = X,
        page "A01 External User" = X,
        page "A01 External User Companies" = X,
        page "A01 External Users" = X,
        tabledata "A01 Warranty Plan" = RIMD,
        table "A01 Warranty Plan" = X,
        page "A01 Resp Center Categories" = X,
        page "A01Resp Center Media Factbox" = X,
        tabledata "A01 Item Warranty" = RIMD,
        table "A01 Item Warranty" = X,
        page "A01 Warranty Plans" = X,
        tabledata "A01 Payment Type Configuration" = RIMD,
        table "A01 Payment Type Configuration" = X,
        codeunit "A01 WS QuotesMgt" = X,
        page "A01 Item Warranty Plans" = X,
        page "A01 ShipToAdressMediaFactbox" = X,
        tabledata "A01 Parameter Record" = RIMD,
        table "A01 Parameter Record" = X,
        tabledata "A01 Customer Debt Status" = RIMD,
        table "A01 Customer Debt Status" = X,
        page "A01 Customer Debt Status List" = X,
        page "A01 Customer Risk Levels" = X,
        page "A01 Item Ticket Format List" = X,
        page "A01 Parameter Value List" = X,
        tabledata "A01 Scoring Criteria" = RIMD,
        table "A01 Scoring Criteria" = X,
        codeunit "A01 Treso Mgt" = X,
        page "A01 Cash Receipt Doc Journal" = X,
        page "A01 Payment Type Configuration" = X,
        tabledata "A01 Scoring Criteria Value" = RIMD,
        table "A01 Scoring Criteria Value" = X,
        tabledata "A01 Cust Scoring Requirement" = RIMD,
        table "A01 Cust Scoring Requirement" = X,
        tabledata "A01 Cust Scoring Criteria" = RIMD,
        table "A01 Cust Scoring Criteria" = X,
        tabledata "A01 Scoring Matrix" = RIMD,
        table "A01 Scoring Matrix" = X,
        tabledata "A01 Customer Scoring" = RIMD,
        table "A01 Customer Scoring" = X,
        tabledata "A01 Credit Depreciation Table" = RIMD,
        table "A01 Credit Depreciation Table" = X,
        codeunit "A01 Api Interface Mgt" = X,
        page "A01 Cust Scoring Criteria" = X,
        page "A01 Cust Scoring Requirement" = X,
        page "A01 Customer Scoring List" = X,
        page "A01 Scoring Criteria List" = X,
        page "A01 Scoring Criteria Value" = X,
        page "A01 Scoring Matrix" = X,
        tabledata "A01 Afk Setup" = RIMD,
        table "A01 Afk Setup" = X,
        tabledata "A01 RC Payment Method" = RIMD,
        table "A01 RC Payment Method" = X,
        codeunit "A01 WS OrdersMgt" = X,
        page "A01 Afk Setup" = X,
        tabledata "A01 Responsibility Matrix" = RIMD,
        table "A01 Responsibility Matrix" = X,
        page "A01 Objects" = X,
        page "A01 RC Payment Methods" = X,
        tabledata "A01 Sales Payment Method" = RIMD,
        table "A01 Sales Payment Method" = X,
        page "A01 Responsibility Matrix" = X,
        tabledata "A01 Purchase Import Step" = RIMD,
        table "A01 Purchase Import Step" = X,
        page "A01 Import Steps" = X,
        tabledata "A01 Approval Flow" = RIMD,
        table "A01 Approval Flow" = X,
        report "A01 CashReceiptPrint" = X,
        report "A01 DeliveryNotePrint" = X,
        report "A01 PurchaseOrderPrint" = X,
        report "A01 PurchaseQuotePrint" = X,
        report "A01 SalesInvoicePrint" = X,
        report "A01 SalesOrderPrint" = X,
        report "A01 SalesQuotePrint" = X,
        report "A01 TransferOrderPrint" = X,
        codeunit "A01 EventsSubscribers_Report" = X,
        page "A01 Item Brands" = X,
        page "A01 Purchase Import Steps" = X,
        page "A01 Sales Payment Methods" = X,
        tabledata "A01 Revision Request" = RIMD,
        table "A01 Revision Request" = X,
        page "A01 Approval flows" = X,
        tabledata "A01 Revision Request Line" = RIMD,
        table "A01 Revision Request Line" = X,
        tabledata "A01 Deadline Assignment" = RIMD,
        table "A01 Deadline Assignment" = X,
        page "A01 Revision Request" = X,
        page "A01 Revision Request List" = X,
        page "A01 Revision Request Subform" = X,
        tabledata "A01 Reminder" = RIMD,
        table "A01 Reminder" = X,
        tabledata "A01 Warranty contract" = RIMD,
        table "A01 Warranty contract" = X,
        tabledata "A01 Purchase Voucher" = RIMD,
        table "A01 Purchase Voucher" = X,
        tabledata "A01 Purchase Voucher Entry" = RIMD,
        table "A01 Purchase Voucher Entry" = X,
        tabledata "A01 Payment Promise" = RIMD,
        table "A01 Payment Promise" = X,
        tabledata "A01 Request On Sales Document" = RIMD,
        table "A01 Request On Sales Document" = X,
        tabledata "A01 Payment Document" = RIMD,
        table "A01 Payment Document" = X,
        tabledata "A01 Payment Document Line" = RIMD,
        table "A01 Payment Document Line" = X;
}