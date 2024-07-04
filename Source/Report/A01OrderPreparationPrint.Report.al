/// <summary>
/// Report A01 Order Preparation Print (ID 50025).
/// </summary>
report 50025 "A01 OrderPreparationPrint"
{
    DefaultLayout = RDLC;
    Caption = 'A01 Order Preparation print';
    PreviewMode = PrintLayout;
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;
    RDLCLayout = './Source/Report/Layout/OrderPreparationPrint.rdl';
    dataset
    {
        dataitem(Header; "Warehouse Shipment Header")
        {
            DataItemTableView = sorting("No.");
            RequestFilterFields = "No.", "Location Code";
            RequestFilterHeading = 'Preparation order';
            column(DocumentNo_; "No.")
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
            column(UnitPostalCode; UnitPostalCode)
            {
            }
            // column(CustPhone; CustPhone)
            // {
            // }
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
            // column(rcs; rcs)
            // {
            // }
            // column(nif; nif)
            // {
            // }
            // column(stat; stat)
            // {
            // }
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
            column(PlannedDeliveryDateLbl; PlannedDeliveryDateLbl)
            {
            }
            column(OrderNumberLbl; OrderNumberLbl)
            {
            }
            dataitem(Line; "Warehouse Shipment Line")
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
                column(Bin_Code; "Bin Code")
                {
                }
                column(Qty__to_Ship; "Qty. to Ship")
                {
                }
                column(Destination_No_; "Destination No.")
                {
                }
                column(CustName; CustName)
                {
                }
                column(CustIdentity; CustIdentity)
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
                dataitem(Customer; Customer)
                {
                    DataItemLink = "No." = field("Destination No.");
                    DataItemLinkReference = Line;
                    DataItemTableView = sorting("No.");

                    column(Sell_to_Customer_No_; "No.")
                    {
                    }
                    column(Sell_to_Customer_Name; Name)
                    {
                    }
                    column(Sell_to_Address; Address)
                    {
                    }
                    column(CustPhone; "Phone No.")
                    {
                    }
                    column(rcs; "A01 RCS")
                    {
                    }
                    column(nif; "A01 NIF")
                    {
                    }
                    column(stat; "A01 STAT")
                    {
                    }
                }
                // dataitem("Sales Header"; "Sales Header")
                // {
                //     DataItemLink = "Document Type" = field("Source Document"), "No." = field("Source No.");
                //     DataItemLinkReference = Line;
                //     DataItemTableView = sorting("No.", "Document Type");

                //     column(Sell_to_Customer_No_; "Sell-to Customer No.")
                //     {
                //     }
                //     column(Sell_to_Customer_Name; "Sell-to Customer Name")
                //     {
                //     }
                //     column(Sell_to_Address; "Sell-to Address")
                //     {
                //     }
                //     trigger OnAfterGetRecord()
                //     begin
                //         if CustRec.Get("Sales Header"."Sell-to Customer No.") then begin
                //             nif := CustRec."A01 NIF";
                //             stat := CustRec."A01 STAT";
                //             rcs := CustRec."A01 RCS";
                //             CustPhone := CustRec."Phone No.";
                //         end;
                //     end;
                // }
            }
            trigger OnAfterGetRecord()
            begin
                if LocRec.Get(Header."Location Code") then begin
                    UnitName := LocRec.Name;
                    UnitAddress := LocRec.Address;
                    UnitCity := LocRec.City;
                    UnitPostalCode := LocRec."Post Code";
                end;
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
        // CustRec: Record Customer;
        LocRec: Record Location;
        UnitName: Text[100];
        // rcs: Code[30];
        // stat: Code[30];
        // nif: Code[30];
        UnitAddress: Text[100];
        UnitCity: Text[50];
        UnitPostalCode: Text[50];
        // CustAddress: Text[100];
        CustIdentity: Text[100];
        CustName: Text[100];
        // CustPhone: Text[30];

        ReportTitleLbl: Label 'PREPARATION ORDER';
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
        PreparationOrderNumberLbl: Label 'Preparation order N° :';
        PreparationOrderDateLbl: Label 'Date :';
        // OrderNumberLbl: Label 'Order number :';
        OrderNumberLbl: Label 'Order N°';
        ProductCodeLbl: Label 'Product code';
        PlannedDeliveryDateLbl: Label 'Planned delivery date';
        ProductSerialNumberLbl: Label 'product serial number';
        DesignationLbl: Label 'Designation';
        QtyToShipLbl: Label 'Quantity to ship';
        ProductLocationLbl: Label 'Product Location';
        CustSignLbl: Label 'Logistique signature';
        CompanySignLbl: Label 'Preparator signature';
}