/// <summary>
/// Page A01 SalesOrderList-PShipped (ID 50011).
/// </summary>
page 50011 "A01 SalesOrderList-PShipped"
{
    ApplicationArea = All;
    Caption = 'Sales Order List - Partially shipped';
    PageType = List;
    SourceTable = "Sales Header";
    CardPageId = "A01 Sales Order - workflow";
    Editable = false;
    SourceTableView = where("Document Type" = const(Order), "A01 Processing Status" = const("A01 SO Processing Status"::"Partially shipped"));
    UsageCategory = Lists;


    layout
    {
        area(content)
        {
            repeater(General)
            {

                field("No."; Rec."No.")
                {
                }
                field("Sell-to Customer No."; Rec."Sell-to Customer No.")
                {
                }

                field("Sell-to Customer Name"; Rec."Sell-to Customer Name")
                {
                }

                field("Shortcut Dimension 1 Code"; Rec."Shortcut Dimension 1 Code")
                {
                }
                field("Shortcut Dimension 2 Code"; Rec."Shortcut Dimension 2 Code")
                {
                }
                field("Salesperson Code"; Rec."Salesperson Code")
                {
                }
                field("Responsibility Center"; Rec."Responsibility Center")
                {
                }
                field("Order Date"; Rec."Order Date")
                {
                }
                field("Location Code"; Rec."Location Code")
                {
                }
                field("AFK01 Observations"; Rec."A01 Observations")
                {
                }
                field("AFK01 Processing Status"; Rec."A01 Processing Status")
                {
                }
                field("AFK01 Return Reason"; Rec."A01 Return Reason")
                {
                }
                field("AFK01 User Id"; Rec."A01 User Id")
                {
                }
            }
        }
    }
    actions
    {
        area(navigation)
        {
            group("O&rder")
            {
                Caption = 'O&rder';
                Image = "Order";
                action("A01 Validation History")
                {
                    ApplicationArea = All;
                    Caption = 'Validation History';
                    Image = PickLines;
                    RunObject = page "A01 Document Step Lines";
                    RunPageLink = "Document Type" = const("Sales Order"), "Document No." = field("No.");
                }
                action(Dimensions)
                {
                    AccessByPermission = TableData Dimension = R;
                    ApplicationArea = Dimensions;
                    Caption = 'Dimensions';
                    Image = Dimensions;
                    ShortCutKey = 'Alt+D';
                    //ToolTip = 'View or edit dimensions, such as area, project, or department, that you can assign to sales and purchase documents to distribute costs and analyze transaction history.';

                    trigger OnAction()
                    begin
                        Rec.ShowDocDim();
                    end;
                }
                action(Statistics)
                {
                    ApplicationArea = Suite;
                    Caption = 'Statistics';
                    Image = Statistics;
                    ShortCutKey = 'F7';
                    //ToolTip = 'View statistical information, such as the value of posted entries, for the record.';

                    trigger OnAction()
                    begin
                        Rec.OpenSalesOrderStatistics();
                    end;
                }
                action(Approvals)
                {
                    ApplicationArea = Suite;
                    Caption = 'Approvals';
                    Image = Approvals;
                    //ToolTip = 'View a list of the records that are waiting to be approved. For example, you can see who requested the record to be approved, when it was sent, and when it is due to be approved.';

                    trigger OnAction()
                    var
                        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
                    begin
                        ApprovalsMgmt.OpenApprovalsSales(Rec);
                    end;
                }
                action("Co&mments")
                {
                    ApplicationArea = Comments;
                    Caption = 'Co&mments';
                    Image = ViewComments;
                    RunObject = Page "Sales Comment Sheet";
                    RunPageLink = "Document Type" = field("Document Type"),
                                  "No." = field("No."),
                                  "Document Line No." = const(0);
                    //ToolTip = 'View or add comments for the record.';
                }
            }
            group(Documents)
            {
                Caption = 'Documents';
                Image = Documents;
                action("S&hipments")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'S&hipments';
                    Image = Shipment;
                    RunObject = Page "Posted Sales Shipments";
                    RunPageLink = "Order No." = field("No.");
                    RunPageView = sorting("Order No.");
                    //ToolTip = 'View related posted sales shipments.';
                }
                action(PostedSalesInvoices)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Invoices';
                    Image = Invoice;
                    // ToolTip = 'View a list of ongoing sales invoices for the order.';

                    // AboutTitle = 'What has been invoiced?';
                    // AboutText = 'Here you can look up what has already been invoiced on an order.';

                    trigger OnAction()
                    var
                        TempSalesInvoiceHeader: Record "Sales Invoice Header" temporary;
                        SalesGetShipment: Codeunit "Sales-Get Shipment";
                    begin
                        SalesGetShipment.GetSalesOrderInvoices(TempSalesInvoiceHeader, Rec."No.");
                        Page.Run(Page::"Posted Sales Invoices", TempSalesInvoiceHeader);
                    end;
                }
                action(PostedSalesPrepmtInvoices)
                {
                    ApplicationArea = Prepayments;
                    Caption = 'Prepa&yment Invoices';
                    Image = PrepaymentInvoice;
                    RunObject = Page "Posted Sales Invoices";
                    RunPageLink = "Prepayment Order No." = field("No.");
                    RunPageView = sorting("Prepayment Order No.");
                    //ToolTip = 'View related posted sales invoices that involve a prepayment. ';
                }
                action("Prepayment Credi&t Memos")
                {
                    ApplicationArea = Prepayments;
                    Caption = 'Prepayment Credi&t Memos';
                    Image = PrepaymentCreditMemo;
                    RunObject = Page "Posted Sales Credit Memos";
                    RunPageLink = "Prepayment Order No." = field("No.");
                    RunPageView = sorting("Prepayment Order No.");
                    //ToolTip = 'View related posted sales credit memos that involve a prepayment. ';
                }
            }
        }
    }
    trigger OnOpenPage()
    begin
        SetFiltreCentreGestion();
        //Rec.SetRange("A01 User Id", UserId);
        Rec.SetRange("Date Filter", 0D, WorkDate());
    end;

    local procedure SetFiltreCentreGestion()
    var
        UserMgt: codeunit "User Setup Management";
        SecMgt: codeunit "A01 Security Mgt";
        FiltreCG: Text[1024];
    begin

        if UserMgt.GetSalesFilter() <> '' then begin

            FiltreCG := SecMgt.GetSalesRespCenterFilter();
            if FiltreCG <> '' then begin
                Rec.FILTERGROUP(2);
                Rec.SETFILTER("Responsibility Center", FiltreCG);
                Rec.FILTERGROUP(0);
            end;
        end;
    end;
}


