/// <summary>
/// Report A01 PreparationOrderPrint (ID 50016).
/// </summary>
report 50016 "A01 PreparationOrderPrint"
{
    DefaultLayout = RDLC;
    Caption = 'A01 Preparation Order print';
    PreviewMode = PrintLayout;
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;
    RDLCLayout = './Source/Report/Layout/PreparationOrderPrint.rdl';
    dataset
    {
        dataitem(Header; "Sales Header")
        {
            DataItemTableView = sorting("Document Type", "No.") where("Document Type" = const(Order));
            RequestFilterFields = "No.", "Sell-to Customer No.", "Location Code";
            RequestFilterHeading = 'Preparation order';
            column(DocumentNo_; "No.")
            {
            }
            column(Posting_Date; Format("Posting Date"))
            {
            }
            column(Order_Date; Format("Order Date"))
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
            column(CustName; "Sell-to Customer Name")
            {
            }
            column(UnitPostalCode; UnitPostalCode)
            {
            }
            column(CustAddress; "Ship-to Name")
            {
            }
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
            dataitem(Line; "Sales Line")
            {
                DataItemLink = "Document Type" = field("Document Type"), "Document No." = field("No.");
                DataItemLinkReference = Header;
                DataItemTableView = sorting("Document No.", "Line No.");
                RequestFilterFields = "Location Code", "Qty. to Ship";
                column(LineNo_Line; "Line No.")
                {
                }
                column(ItemNo_Line; "No.")
                {
                }
                column(Document_No_; "Document No.")
                {
                }
                column(Description; Description)
                {
                }
                column(Location_Code; "Location Code")
                {
                }
                column(Qty__to_Ship; "Qty. to Ship")
                {
                }
                column(Planned_Delivery_Date; Format("Planned Delivery Date"))
                {
                }
                column(Bin_Code; "Bin Code")
                {
                }
                dataitem("Tracking Specification"; "Tracking Specification")
                {
                    DataItemLink = "Item No." = field("No."), "Source ID" = field("Document No."), "Source Ref. No." = field("Line No.");
                    DataItemLinkReference = Line;
                    DataItemTableView = sorting("Entry No.");
                    column(Serial_No_; "Serial No.")
                    {
                    }
                }
                trigger OnPreDataItem()
                begin
                    SetRange(Type, Type::Item);
                end;

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

                if Contact.Get(Header."Sell-to Contact No.") then begin
                    CustIdentity := Contact.Name;
                    CustPhone := Contact."Phone No.";
                end;

                // if Ship.Get(Header."Ship-to Code") then
                //     CustAddress := Ship.Name;

            end;
        }
    }

    requestpage
    {
        layout
        {
            // area(Content)
            // {
            //     group(GroupName)
            //     {
            //         field(Name; SourceExpression)
            //         {
            //             ApplicationArea = All;
            //         }
            //     }
            // }
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
        LocRec: Record Location;
        // Ship: Record "Ship-to Address";
        UnitName: Text[100];
        UnitAddress: Text[100];
        UnitCity: Text[50];
        UnitPostalCode: Text[50];
        // CustAddress: Text[100];
        CustIdentity: Text[100];
        CustPhone: Text[30];

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
        PreparationOrderNumberLbl: Label 'Preparation order number :';
        PreparationOrderDateLbl: Label 'preparationorderdate :';
        // OrderNumberLbl: Label 'Order number :';
        ProductCodeLbl: Label 'Product code';
        PlannedDeliveryDateLbl: Label 'Planned delivery date';
        ProductSerialNumberLbl: Label 'product serial number';
        DesignationLbl: Label 'Designation';
        QtyToShipLbl: Label 'Quantity to ship';
        ProductLocationLbl: Label 'Product Location';
        CustSignLbl: Label 'Logistique signature';
        CompanySignLbl: Label 'Preparator signature';
}