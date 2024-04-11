/// <summary>
/// Report A01 Purchase Receipt Print (ID 50011).
/// </summary>
report 50011 "A01 PurchaseReceiptPrint"
{
    DefaultLayout = RDLC;
    Caption = 'A01 Purchase Receipt print';
    PreviewMode = PrintLayout;
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;
    WordMergeDataItem = "Purch. Rcpt. Header";
    RDLCLayout = './Source/Report/Layout/PurchaseReceiptPrint.rdl';

    dataset
    {
        dataitem("Purch. Rcpt. Header"; "Purch. Rcpt. Header")
        {
            DataItemTableView = sorting("No.");
            RequestFilterFields = "No.", "Buy-from Vendor No.", "Location Code";
            RequestFilterHeading = 'Purchase Receipt';
            column(No_PurchRcptHeader; "No.")
            {
            }
            column(Posting_Date; Format("Posting Date"))
            {
            }
            column(Order_Date; Format("Order Date"))
            {
            }
            column(CompanyName; COMPANYPROPERTY.DisplayName())
            {
            }
            column(CompanyPicture; CompanyInfo.Picture)
            {
            }
            column(CompanyAddress; CompanyInfo.Address)
            {
            }
            column(CompanyHomePage; CompanyInfo."Home Page")
            {
            }
            column(CompanyPhone; CompanyInfo."Phone No.")
            {
            }
            column(Order_No_; "Order No.")
            {
            }
            column(UnitName; UnitName)
            {
            }
            column(UnitAddress; UnitAddress)
            {
            }
            column(UnitCity; UnitCity)
            {
            }
            column(UnitPostalCode; UnitPostalCode)
            {
            }
            column(VendorName; "Buy-from Vendor Name")
            {
            }
            column(VendorAddress; "Ship-to Name")
            {
            }
            column(VendorIdentity; VendorIdentity)
            {
            }
            column(VendorPhone; VendorPhone)
            {
            }
            column(ReportTitleLbl; ReportTitleLbl)
            {
            }
            column(UnitNameLbl; UnitNameLbl)
            {
            }
            column(UnitAddressLbl; UnitAddressLbl)
            {
            }
            column(UnitCityLbl; UnitCityLbl)
            {
            }
            column(UnitPostalCodeLbl; UnitPostalCodeLbl)
            {
            }
            column(VendorNameLbl; VendorNameLbl)
            {
            }
            column(VendorIdentityLbl; VendorIdentityLbl)
            {
            }
            column(VendorAddressLbl; VendorAddressLbl)
            {
            }
            column(NIFLbl; NIFLbl)
            {
            }
            column(STATLbl; STATLbl)
            {
            }
            column(RCSLbl; RCSLbl)
            {
            }
            column(VendorPhoneLbl; VendorPhoneLbl)
            {
            }
            column(PurchaseReceiptNumberLbl; PurchaseReceiptNumberLbl)
            {
            }
            column(OrderNumberLbl; OrderNumberLbl)
            {
            }
            column(DateOfReceiptLbl; DateOfReceiptLbl)
            {
            }
            column(ProductCodeLbl; ProductCodeLbl)
            {
            }
            column(DesignationLbl; DesignationLbl)
            {
            }
            column(OrderedQuantityLbl; OrderedQuantityLbl)
            {
            }
            column(QuantityReceivedLbl; QuantityReceivedLbl)
            {
            }
            column(OrderDateLbl; OrderDateLbl)
            {
            }
            column(CustomerSignLbl; CustomerSignLbl)
            {
            }
            column(CompanySignLbl; CompanySignLbl)
            {
            }
            column(PurchaseSignLbl; PurchaseSignLbl)
            {
            }
            column(OrderDate; Format(OrderDate))
            {
            }
            dataitem("Purch. Rcpt. Line"; "Purch. Rcpt. Line")
            {
                DataItemLink = "Document No." = field("No.");
                DataItemLinkReference = "Purch. Rcpt. Header";
                DataItemTableView = sorting("Document No.", "Line No.");
                column(ItemNo_; "No.")
                {
                }
                column(Type_PurchRcptLine; Format(Type, 0, 2))
                {
                }
                column(Description; Description)
                {
                }
                column(Quantity; Quantity)
                {
                }
                column(Quantity_Invoiced; "Quantity Invoiced")
                {
                }
                column(Location_Code; "Location Code")
                {
                }
                column(LocationLbl; LocationLbl)
                {
                }
            }
            trigger OnAfterGetRecord()
            begin
                // if RespCenter.Get("Purch. Rcpt. Header"."Responsibility Center") then begin
                //     UnitName := RespCenter.Name;
                //     UnitAddress := RespCenter.Address;
                //     UnitCity := RespCenter.City;
                //     UnitPostalCode := RespCenter."Post Code";
                // end;

                if LocRec.Get("Purch. Rcpt. Header"."Location Code") then begin
                    UnitName := LocRec.Name;
                    UnitAddress := LocRec.Address;
                    UnitCity := LocRec.City;
                    UnitPostalCode := LocRec."Post Code";
                end;

                if Contact.Get("Purch. Rcpt. Header"."Buy-from Contact No.") then begin
                    VendorIdentity := Contact.Name;
                    VendorPhone := Contact."Phone No.";
                end;

                if Ship.Get("Purch. Rcpt. Header"."Ship-to Code") then
                    VendorAddress := Ship.Name;

                // if PurHeader.Get("Purch. Rcpt. Header"."Order No.") then
                //     OrderDate := PurHeader."Order Date";

            end;
        }
    }


    requestpage
    {
        SaveValues = true;
        layout
        {

        }

        actions
        {
        }
    }

    trigger OnPreReport()
    begin
        CompanyInfo.Get();
        CompanyInfo.CalcFields(Picture);
    end;


    var
        CompanyInfo: Record "Company Information";
        // RespCenter: Record "Responsibility Center";
        Contact: Record Contact;
        // PurHeader: Record "Purchase Header";
        Ship: Record "Ship-to Address";
        LocRec: Record Location;
        UnitName: Text[100];
        OrderDate: Date;
        UnitAddress: Text[100];
        UnitCity: Text[50];
        UnitPostalCode: Text[50];
        VendorIdentity: Text[100];
        VendorAddress: Text[100];
        VendorPhone: Text[30];

        ReportTitleLbl: Label 'PURCHASE RECEIPT';
        PurchaseReceiptNumberLbl: Label 'Purchase receipt number :';
        OrderNumberLbl: Label 'Order number :';
        DateOfReceiptLbl: Label 'Date receipt :';
        OrderDateLbl: Label 'Order date :';
        UnitNameLbl: Label 'Warehouse name :';
        UnitAddressLbl: Label 'Warehouse address :';
        UnitCityLbl: Label 'Warehouse City';
        UnitPostalCodeLbl: Label 'Warehouse Postalcode :';
        VendorNameLbl: Label 'Vendor name :';
        VendorIdentityLbl: Label 'Vendor identity :';
        VendorAddressLbl: Label 'Vendor address :';
        NIFLbl: Label 'NIF :';
        STATLbl: Label 'STAT :';
        RCSLbl: Label 'RCS :';
        VendorPhoneLbl: Label 'Phone :';
        ProductCodeLbl: Label 'Product code';
        DesignationLbl: Label 'Designation';
        OrderedQuantityLbl: Label 'Ordered quantity';
        QuantityReceivedLbl: Label 'Quantity received';
        LocationLbl: Label 'Location';
        CustomerSignLbl: Label 'Vendor signature';
        CompanySignLbl: Label 'Warehouse signature';
        PurchaseSignLbl: Label 'Purchase';
}