/// <summary>
/// Report A01 Warehouse Reception Print (ID 50028).
/// </summary>
report 50028 "A01 WarehouseReceptionPrint"
{
    DefaultLayout = RDLC;
    Caption = 'A01 Warehouse Reception print';
    PreviewMode = PrintLayout;
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;
    RDLCLayout = './Source/Report/Layout/WarehouseReceptionPrint.rdl';
    dataset
    {
        dataitem(Header; "Posted Whse. Receipt Header")
        {
            DataItemTableView = sorting("No.");
            RequestFilterFields = "No.", "Location Code";
            RequestFilterHeading = 'Warehouse shipping order';
            column(DocumentNo_; "No.")
            {
            }
            column(Whse__Receipt_No_; "Whse. Receipt No.")
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
            column(UnitName; UnitName)
            {
            }
            column(UnitAddress; UnitAddress)
            {
            }
            column(UnitCity; UnitCity)
            {
            }
            // column(CustName; "Sell-to Customer Name")
            // {
            // }
            column(UnitPostalCode; UnitPostalCode)
            {
            }
            // column(CustAddress; "Ship-to Name")
            // {
            // }
            column(CustPhone; CustPhone)
            {
            }
            column(CustIdentity; CustIdentity)
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
            column(PreparationOrderDateLbl; PreparationOrderDateLbl)
            {
            }
            column(CustNameLbl; CustNameLbl)
            {
            }
            column(CustIdentityLbl; CustIdentityLbl)
            {
            }
            column(CustAddressLbl; CustAddressLbl)
            {
            }
            column(rcs; rcs)
            {
            }
            column(nif; nif)
            {
            }
            column(stat; stat)
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
            column(CustPhoneLbl; CustPhoneLbl)
            {
            }
            column(ProductCodeLbl; ProductCodeLbl)
            {
            }
            column(PreparationOrderNumberLbl; PreparationOrderNumberLbl)
            {
            }
            column(ProductSerialNumberLbl; ProductSerialNumberLbl)
            {
            }
            column(DesignationLbl; DesignationLbl)
            {
            }
            column(ProductLocationLbl; ProductLocationLbl)
            {
            }
            column(VendSignLbl; VendSignLbl)
            {
            }
            column(WarehousSignLbl; WarehousSignLbl)
            {
            }
            column(PurchSignLbl; PurchSignLbl)
            {
            }
            column(QtyLbl; QtyLbl)
            {
            }
            column(OrderNumberLbl; OrderNumberLbl)
            {
            }
            dataitem(Line; "Posted Whse. Receipt Line")
            {
                DataItemLink = "No." = field("No.");
                DataItemLinkReference = Header;
                DataItemTableView = sorting("No.", "Line No.");
                // RequestFilterFields = "Location Code", "Qty. to Ship";
                column(Source_No_; "Source No.")
                {
                }
                column(Item_No_; "Item No.")
                {
                }
                column(Description; Description)
                {
                }
                column(Location_Code; "Location Code")
                {
                }
                column(Shelf_No_; "Shelf No.")
                {
                }
                column(Quantity; Quantity)
                {
                }
                // dataitem("Tracking Specification"; "Tracking Specification")
                // {
                //     DataItemLink = "Item No." = field("No."), "Source ID" = field("Document No."), "Source Ref. No." = field("Line No.");
                //     DataItemLinkReference = Line;
                //     DataItemTableView = sorting("Entry No.");
                //     column(Serial_No_; "Serial No.")
                //     {
                //     }
                // }

                trigger OnAfterGetRecord()
                begin
                    if "No." = 'MIR_FEES' then
                        CurrReport.Skip();
                    if "No." = 'mir_fees' then
                        CurrReport.Skip();
                    if "No." = 'MIR_INTEREST' then
                        CurrReport.Skip();
                    if "No." = 'mir_interest' then
                        CurrReport.Skip();
                    if "No." = 'AGP_FEES' then
                        CurrReport.Skip();
                    if "No." = 'agp_fees' then
                        CurrReport.Skip();
                end;
            }
            trigger OnAfterGetRecord()
            begin
                // if RespCenter.Get(Header."Responsibility Center") then begin
                //     UnitName := RespCenter.Name;
                //     UnitAddress := RespCenter.Address;
                //     UnitCity := RespCenter.City;
                //     UnitPostalCode := RespCenter."Post Code";
                // end;

                if LocRec.Get(Header."Location Code") then begin
                    UnitName := LocRec.Name;
                    UnitAddress := LocRec.Address;
                    UnitCity := LocRec.City;
                    UnitPostalCode := LocRec."Post Code";
                end;

                // if Cust.Get(Header."Sell-to Customer No.") then begin
                //     rcs := Cust."A01 RCS";
                //     stat := Cust."A01 STAT";
                //     nif := Cust."A01 NIF";
                // end;

                // if Contact.Get(Header."Sell-to Contact No.") then begin
                //     CustIdentity := Contact.Name;
                //     CustPhone := Contact."Phone No.";
                // end;

                // if Ship.Get(Header."Ship-to Code") then
                //     CustAddress := Ship.Name;

            end;
        }
    }

    requestpage
    {
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
        // Cust: Record Customer;
        // Contact: Record Contact;
        LocRec: Record Location;
        // Order: Record "Sales Line";
        // Ship: Record "Ship-to Address";
        UnitName: Text[100];
        rcs: Code[30];
        stat: Code[30];
        nif: Code[30];
        UnitAddress: Text[100];
        UnitCity: Text[50];
        UnitPostalCode: Text[50];
        // CustAddress: Text[100];
        CustIdentity: Text[100];
        CustPhone: Text[30];

        ReportTitleLbl: Label 'WAREHOUSE RECEPTION';
        UnitNameLbl: Label 'Unit name :';
        UnitAddressLbl: Label 'Unit address :';
        UnitCityLbl: Label 'City';
        UnitPostalCodeLbl: Label 'Postal code :';
        CustNameLbl: Label 'Customer name :';
        CustIdentityLbl: Label 'Customer identity :';
        CustAddressLbl: Label 'Customer address :';
        NIFLbl: Label 'NIF :';
        STATLbl: Label 'STAT :';
        RCSLbl: Label 'RCS :';
        CustPhoneLbl: Label 'Phone :';
        PreparationOrderNumberLbl: Label 'Reception order N° :';
        PreparationOrderDateLbl: Label 'Date :';
        OrderNumberLbl: Label 'Order N°';
        ProductCodeLbl: Label 'Product code';
        // PlannedDeliveryDateLbl: Label 'Planned delivery date';
        ProductSerialNumberLbl: Label 'product serial number';
        DesignationLbl: Label 'Designation';
        QtyLbl: Label 'Quantity';
        ProductLocationLbl: Label 'Product Location';
        VendSignLbl: Label 'Vendor signature';
        WarehousSignLbl: Label 'Warehouse signature';
        PurchSignLbl: Label 'Purchase signature';
}