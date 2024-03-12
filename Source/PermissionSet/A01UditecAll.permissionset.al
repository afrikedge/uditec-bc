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
        page "A01 ShipToAdressMediaFactbox" = X;
}