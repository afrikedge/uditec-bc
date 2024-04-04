/// <summary>
/// Report A01 Sales Return Receipt Print (ID 50012).
/// </summary>
report 50012 "A01 SalesReturnReceiptPrint"
{
    DefaultLayout = RDLC;
    Caption = 'A01 SalesReturnReceipt print';
    PreviewMode = PrintLayout;
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;
    WordMergeDataItem = "Return Receipt Header";
    RDLCLayout = './Source/Report/Layout/SalesReturnReceiptPrint.rdl';

    dataset
    {
        dataitem("Return Receipt Header"; "Return Receipt Header")
        {
            DataItemTableView = sorting("No.");
            RequestFilterFields = "No.", "Sell-to Customer No.";
            RequestFilterHeading = 'Sales Return Receipt';
            column(No_ReturnRcptHeader; "No.")
            {
            }
            column(Posting_Date; Format("Posting Date"))
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
            column(ReturnOrder_No_; "Return Order No.")
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
            column(CustomerName; "Sell-to Customer Name")
            {
            }
            column(CustomerAddress; "Ship-to Name")
            {
            }
            column(CustomerIdentity; CustomerIdentity)
            {
            }
            column(CustomerPhone; CustomerPhone)
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
            column(CustomerNameLbl; CustomerNameLbl)
            {
            }
            column(CustomerIdentityLbl; CustomerIdentityLbl)
            {
            }
            column(CustomerAddressLbl; CustomerAddressLbl)
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
            column(CustomerPhoneLbl; CustomerPhoneLbl)
            {
            }
            column(SalesReceiptNumberLbl; SalesReceiptNumberLbl)
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
            column(CustomerSignLbl; CustomerSignLbl)
            {
            }
            column(LocationLbl; LocationLbl)
            {
            }
            column(CompanySignLbl; CompanySignLbl)
            {
            }
            dataitem("Return Receipt Line"; "Return Receipt Line")
            {
                DataItemLink = "Document No." = field("No.");
                DataItemLinkReference = "Return Receipt Header";
                DataItemTableView = sorting("Document No.", "Line No.");
                column(ItemNo_; "No.")
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
            }
            trigger OnAfterGetRecord()
            begin
                if RespCenter.Get("Return Receipt Header"."Responsibility Center") then begin
                    UnitName := RespCenter.Name;
                    UnitAddress := RespCenter.Address;
                    UnitCity := RespCenter.City;
                    UnitPostalCode := RespCenter."Post Code";
                end;

                if Contact.Get("Return Receipt Header"."Sell-to Contact No.") then begin
                    CustomerIdentity := Contact.Name;
                    CustomerPhone := Contact."Phone No.";
                end;

                if Ship.Get("Return Receipt Header"."Ship-to Code") then
                    CustomerAddress := Ship.Name;

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
        RespCenter: Record "Responsibility Center";
        Contact: Record Contact;
        Ship: Record "Ship-to Address";
        UnitName: Text[100];
        UnitAddress: Text[100];
        UnitCity: Text[50];
        UnitPostalCode: Text[50];
        CustomerIdentity: Text[100];
        CustomerAddress: Text[100];
        CustomerPhone: Text[30];

        ReportTitleLbl: Label 'SALES RETURN RECEIPT';
        SalesReceiptNumberLbl: Label 'Sales Return receipt number :';
        OrderNumberLbl: Label 'Sales return number :';
        DateOfReceiptLbl: Label 'Date of return :';
        UnitNameLbl: Label 'Unit name :';
        UnitAddressLbl: Label 'Unit address :';
        UnitCityLbl: Label 'City';
        UnitPostalCodeLbl: Label 'Postal code :';
        CustomerNameLbl: Label 'Customer name :';
        CustomerIdentityLbl: Label 'Customer identity :';
        CustomerAddressLbl: Label 'Customer address :';
        NIFLbl: Label 'NIF :';
        STATLbl: Label 'STAT :';
        RCSLbl: Label 'RCS :';
        CustomerPhoneLbl: Label 'Phone :';
        ProductCodeLbl: Label 'Product code';
        DesignationLbl: Label 'Designation';
        OrderedQuantityLbl: Label 'Ordered quantity';
        QuantityReceivedLbl: Label 'Quantity returned';
        LocationLbl: Label 'Location';
        CustomerSignLbl: Label 'Customer signature';
        CompanySignLbl: Label 'Company signature';
}