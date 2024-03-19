/// <summary>
/// Report A01 Delivery note Print (ID 50003).
/// </summary>
report 50003 "A01 DeliveryNotePrint"
{
    Caption = 'A01 Delivery note print';
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;
    DefaultLayout = RDLC;
    PreviewMode = PrintLayout;
    EnableHyperlinks = true;
    WordMergeDataItem = Header;
    RDLCLayout = './Source/Report/Layout/DeliveryNotePrint.rdl';

    dataset
    {
        dataitem(Header; "Sales Shipment Header")
        {
            DataItemTableView = sorting("No.");
            RequestFilterFields = "No.";
            column(DocumentNo_; "No.")
            {
            }
            column(Posting_Date; Format("Posting Date"))
            {
            }
            column(Order_No_; "Order No.")
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
            column(CustName; "Bill-to Name")
            {
            }
            column(UnitPostalCode; UnitPostalCode)
            {
            }
            column(CustAddress; CustAddress)
            {
            }
            column(CustPhone; CustPhone)
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
            column(OrderNumberLbl; OrderNumberLbl)
            {
            }
            column(DeleveryNoteDateLbl; DeleveryNoteDateLbl)
            {
            }
            column(InvoiceNumberLbl; InvoiceNumberLbl)
            {
            }
            column(VehicleNumberLbl; VehicleNumberLbl)
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
            dataitem(Line; "Sales Shipment Line")
            {
                DataItemTableView = sorting("Document No.", "Line No.");
                DataItemLinkReference = Header;
                DataItemLink = "Document No." = field("No.");
                column(LineNo_Line; "Line No.")
                {
                }
                column(Document_No_; "Document No.")
                {
                }
                column(ItemNo_Line; "No.")
                {
                }
                column(Description_Line; Description)
                {
                }
                column(Location_Code; "Location Code")
                {
                }
                column(Quantity; Quantity)
                {
                }
                column(Quantity_Line_Lbl; FieldCaption(Quantity))
                {
                }
                column(Type_Line; Format(Type))
                {
                }
                dataitem("Item Ledger Entry"; "Item Ledger Entry")
                {
                    DataItemTableView = sorting("Document No.") where("Document Type" = filter(1));
                    DataItemLinkReference = Line;
                    DataItemLink = "Document No." = field("Document No."), "Document Line No." = field("Line No.");
                    column(Serial_No_; "Serial No.")
                    {
                    }
                    column(Quantity_; Quantity)
                    {
                    }
                }
            }

            trigger OnAfterGetRecord()
            begin
                if RespCenter.Get(Header."Responsibility Center") then begin
                    UnitName := RespCenter.Name;
                    UnitAddress := RespCenter.Address;
                    UnitCity := RespCenter.City;
                    UnitPostalCode := RespCenter."Phone No.";
                end;

                if Cust.Get(Header."Sell-to Customer No.") then begin
                    CustAddress := Cust.Address;
                    CustPhone := Cust."Phone No.";
                end;

            end;
        }

    }

    requestpage
    {
        layout
        {
            area(Content)
            {
                // group(GroupName)
                // {
                //     field(Name; SourceExpression)
                //     {
                //         ApplicationArea = All;

                //     }
                // }
            }
        }

        actions
        {
        }
    }

    trigger OnPreReport()
    begin
        CompanyInfo.Get();
        CompanyInfo.CalcFields(Picture);

        // if not CompanyInfo.Get() then
    end;

    var
        CompanyInfo: Record "Company Information";
        RespCenter: Record "Responsibility Center";
        Cust: Record Customer;
        UnitName: Text[100];
        // UnitCenterLogo: Media
        UnitAddress: Text[100];
        UnitCity: Text[50];
        UnitPostalCode: Text[50];
        CustAddress: Text[100];
        CustPhone: Text[30];
        ReportTitleLbl: Label 'DELIVERY NOTE';
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
        OrderNumberLbl: Label 'Delivery note number :';
        DeleveryNoteDateLbl: Label 'Delivery note date :';
        InvoiceNumberLbl: Label 'Invoice number :';
        VehicleNumberLbl: Label 'Vehicle number :';

        ProductCodeLbl: Label 'Product code';
        ProductSerialNumberLbl: Label 'product serial number';
        DesignationLbl: Label 'Designation';
        ProductLocationLbl: Label 'Product Location';
        CustSignLbl: Label 'Customer signature';
        CompanySignLbl: Label 'Company signature';


    // local procedure GetImage()
    // var
    //     RespCenter: Record "Responsibility Center";
    //     Img: Codeunit Image;
    // begin
    //     RespCenter.Get();
    //     // ImgStream := RespCenter.gets
    // end;


}