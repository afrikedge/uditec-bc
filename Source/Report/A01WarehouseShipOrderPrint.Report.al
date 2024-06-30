/// <summary>
/// Report A01 Warehouse Shipping Order Print (ID 50027).
/// </summary>
report 50027 "A01 WarehouseShipOrderPrint"
{
    DefaultLayout = RDLC;
    Caption = 'A01 Warehouse shipping order print';
    PreviewMode = PrintLayout;
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;
    RDLCLayout = './Source/Report/Layout/ShippingOrderPrint.rdl';
    dataset
    {
        dataitem(Header; "Posted Whse. Shipment Header")
        {
            DataItemTableView = sorting("No.");
            RequestFilterFields = "No.", "Location Code";
            RequestFilterHeading = 'Warehouse shipping order';
            column(DocumentNo_; "No.")
            {
            }
            column(Whse__Shipment_No_; "Whse. Shipment No.")
            {
            }
            column(Posting_Date; Format("Posting Date"))
            {
            }
            column(Shipment_Date; Format("Shipment Date"))
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
            column(PreparationOrderNumberLbl; PreparationOrderNumberLbl)
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
            column(ProductSerialNumberLbl; ProductSerialNumberLbl)
            {
            }
            column(DesignationLbl; DesignationLbl)
            {
            }
            column(ProductLocationLbl; ProductLocationLbl)
            {
            }
            column(CustomerSignLbl; CustSignLbl)
            {
            }
            column(CompanySignLbl; CompanySignLbl)
            {
            }
            column(QtyToShipLbl; QtyToShipLbl)
            {
            }
            column(OrderNumberLbl; OrderNumberLbl)
            {
            }
            dataitem(Line; "Posted Whse. Shipment Line")
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
                column(Bin_Code; "Bin Code")
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
                dataitem("Sales Header"; "Sales Header")
                {
                    DataItemLink = "No." = field("Source No.");
                    DataItemLinkReference = Line;
                    DataItemTableView = sorting("No.", "Document Type");

                    column(Sell_to_Customer_No_; "Sell-to Customer No.")
                    {
                    }
                    column(Sell_to_Customer_Name; "Sell-to Customer Name")
                    {
                    }
                    column(Sell_to_Address; "Sell-to Address")
                    {
                    }
                    trigger OnAfterGetRecord()
                    begin
                        if CustRec.Get("Sales Header"."Sell-to Customer No.") then begin
                            nif := CustRec."A01 NIF";
                            stat := CustRec."A01 STAT";
                            rcs := CustRec."A01 RCS";
                            CustPhone := CustRec."Phone No.";
                        end;
                    end;
                }
            }
            trigger OnAfterGetRecord()
            var
                userSetup: Record "User Setup";
                LabErrorNosPrinted: label 'The document has already been printed. You do not have permission to reprint it';
            begin

                if ("A01 No. Printed" > 0) then begin
                    userSetup.Get(UserId);
                    if (not userSetup."A01 Print Whse Delivery") then
                        error(LabErrorNosPrinted);
                end;

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

            end;

            trigger OnPostDataItem()
            var
                GLMgt: Codeunit "A01 Inventory Mgt";
            begin
                if (not CurrReport.Preview) then
                    GLMgt.ConfirmPrintReport50027(Header);
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
        CustRec: Record Customer;
        // RespCenter: Record "Responsibility Center";
        LocRec: Record Location;
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

        ReportTitleLbl: Label 'WAREHOUSE SHIPPING ORDER';
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
        PreparationOrderNumberLbl: Label 'Shipping order N° :';
        PreparationOrderDateLbl: Label 'Date :';
        OrderNumberLbl: Label 'Order N°';
        ProductCodeLbl: Label 'Product code';
        // PlannedDeliveryDateLbl: Label 'Planned delivery date';
        ProductSerialNumberLbl: Label 'product serial number';
        DesignationLbl: Label 'Designation';
        QtyToShipLbl: Label 'Shipped quantity';
        ProductLocationLbl: Label 'Product Location';
        CustSignLbl: Label 'Logistique signature';
        CompanySignLbl: Label 'Warehouse signature';
}