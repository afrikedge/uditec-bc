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
            RequestFilterFields = "No.", "Location Code";
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
            column(CustAddress; "Ship-to Name")
            {
            }
            column(CustPhone; CustPhone)
            {
            }
            column(CustIdentity; "Sell-to Customer No.")
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
            column(Sell_to_Customer_No_; "Sell-to Customer No.")
            {
            }
            column(Sell_to_Customer_Name; "Sell-to Customer Name")
            {
            }
            column(LogoOption; OptionValue)
            {
            }
            column(RespCenterImg; RespCenter."A01 Logo")
            {
            }
            column(RespCenterUditec; RespCenterUditec."A01 Logo")
            {
            }
            column(OptionType; OptionType)
            {
            }
            column(NumberOfPackagesLbl; NumberOfPackagesLbl)
            {
            }
            // column(CustomerAddress; CustomerAddress)
            // {
            // }
            // column(CustomerPhone; CustomerPhone)
            // {
            // }
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
                column(Bin_Code; "Bin Code")
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
                    column(Item_No_; "Item No.")
                    {
                    }
                    column(Quantity_; Format(-Quantity))
                    {
                    }
                    dataitem(Item; Item)
                    {
                        DataItemTableView = sorting("No.");
                        DataItemLinkReference = "Item Ledger Entry";
                        DataItemLink = "No." = field("Item No.");

                        column(A01NumberOfPackage; "A01 Number of package")
                        {
                        }
                        trigger OnAfterGetRecord()
                        begin
                            if "A01 Number of package" = 0 then
                                "A01 Number of package" := 1;
                        end;
                    }

                }
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

                    if Type = Type::"G/L Account" then
                        CurrReport.Skip();

                    if Type = Type::Item then
                        if Quantity = 0 then
                            CurrReport.Skip();
                end;
            }

            trigger OnAfterGetRecord()
            begin
                if OptionValue = OptionValue::LogoCosmos then
                    OptionType := 1
                else
                    OptionType := 0;

                if RespCenter.Get(Header."Responsibility Center") then begin
                end;

                if LocRec.Get(Header."Location Code") then begin
                    UnitName := LocRec.Name;
                    UnitAddress := LocRec.Address;
                    UnitCity := LocRec.City;
                    UnitPostalCode := LocRec."Post Code";
                end;

                if Cust.Get(Header."Sell-to Customer No.") then begin
                    rcs := Cust."A01 RCS";
                    stat := Cust."A01 STAT";
                    nif := Cust."A01 NIF";
                    CustAddress := Cust.Address;
                    CustPhone := Cust."Phone No.";
                end;

                // if Contact.Get(Header."Bill-to Contact No.") then begin
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
            area(Content)
            {
                group(groupName)
                {
                    Caption = 'Option';
                    field(OptionVal; OptionValue)
                    {
                        Caption = 'Logo';
                        OptionCaption = 'Cosmos, Uditec';
                        ApplicationArea = Basic, Suite;
                    }
                }
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

        RespCenterUditec.Get('UDT');
    end;

    var
        CompanyInfo: Record "Company Information";
        RespCenter: Record "Responsibility Center";
        RespCenterUditec: Record "Responsibility Center";
        Cust: Record Customer;
        // Contact: Record Contact;
        LocRec: Record Location;
        // Ship: Record "Ship-to Address";
        // Img: Media;
        OptionValue: Option LogoCosmos,LogoUditec;
        OptionType: Integer;
        UnitName: Text[100];
        rcs: Code[30];
        stat: Code[30];
        nif: Code[30];
        UnitAddress: Text[100];
        UnitCity: Text[50];
        UnitPostalCode: Text[50];
        CustAddress: Text[100];
        // CustIdentity: Text[100];
        CustPhone: Text[30];
        ReportTitleLbl: Label 'DELIVERY NOTE';
        UnitNameLbl: Label 'Unit name:';
        UnitAddressLbl: Label 'Unit address:';
        UnitCityLbl: Label 'City';
        UnitPostalCodeLbl: Label 'Postal code :';
        CustNameLbl: Label 'Customer name :';
        CustIdentityLbl: Label 'Customer identity :';
        CustAddressLbl: Label 'Customer address :';
        NIFLbl: Label 'NIF :';
        STATLbl: Label 'STAT :';
        RCSLbl: Label 'RCS :';
        CustPhoneLbl: Label 'Phone :';
        OrderNumberLbl: Label 'Delivery note N°:';
        DeleveryNoteDateLbl: Label 'Date:';
        InvoiceNumberLbl: Label 'Invoice N° :';
        VehicleNumberLbl: Label 'Vehicle N° :';

        ProductCodeLbl: Label 'Product code';
        ProductSerialNumberLbl: Label 'product serial number';
        DesignationLbl: Label 'Designation';
        ProductLocationLbl: Label 'Product Location';
        CustSignLbl: Label 'Customer signature';
        CompanySignLbl: Label 'Company signature';
        NumberOfPackagesLbl: Label 'Number of packages';


}