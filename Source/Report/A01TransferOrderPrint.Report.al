/// <summary>
/// Report A01 Transfer Order Print (ID 50005).
/// </summary>
report 50005 "A01 TransferOrderPrint"
{
    Caption = 'A01 Transfer order print';
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;
    DefaultLayout = RDLC;
    PreviewMode = PrintLayout;
    EnableHyperlinks = true;
    WordMergeDataItem = Header;
    RDLCLayout = './Source/Report/Layout/TransferOrderPrint.rdl';

    dataset
    {
        dataitem(Header; "Transfer Shipment Header")
        {
            DataItemTableView = sorting("No.");
            RequestFilterFields = "No.", "Transfer-from Code", "Transfer-to Code";
            RequestFilterHeading = 'Transfer Order';
            column(DocumentNo_; "No.")
            {
            }
            column(Transfer_Order_No_; "Transfer Order No.")
            {
            }
            column(Transfer_Order_Date; Format("Transfer Order Date"))
            {
            }
            column(Shipment_Date; Format("Shipment Date"))
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
            column(UnitPostalCode; UnitPostalCode)
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
            column(DeleveryNoteDateLbl; DeleveryNoteDateLbl)
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
            column(IssuerSignLbl; IssuerSignLbl)
            {
            }
            column(ReceiverSignLbl; ReceiverSignLbl)
            {
            }
            column(TransferNumberLbl; TransferNumberLbl)
            {
            }
            column(OriginLocationLbl; OriginLocationLbl)
            {
            }
            column(DestinationLocationLbl; DestinationLocationLbl)
            {
            }
            column(Transfer_from_Code; "Transfer-from Code")
            {
            }
            column(Transfer_to_Code; "Transfer-to Code")
            {
            }
            column(Transfer_from_Name; "Transfer-from Name")
            {
            }
            column(Transfer_from_City; "Transfer-from City")
            {
            }
            column(Transfer_from_Address; "Transfer-from Address")
            {
            }
            column(Transfer_from_Post_Code; "Transfer-from Post Code")
            {
            }
            column(Transfer_to_Name; "Transfer-to Name")
            {
            }
            column(LogistiqueSignLbl; LogistiqueSignLbl)
            {
            }
            column(SecuritySignLbl; SecuritySignLbl)
            {
            }
            column(NameSignLbl; NameSignLbl)
            {
            }
            column(SignLbl; SignLbl)
            {
            }
            column(DateSignLbl; DateSignLbl)
            {
            }
            column(HourSignLbl; HourSignLbl)
            {
            }
            column(OrigineLbl; OrigineLbl)
            {
            }
            column(DestinationLbl; DestinationLbl)
            {
            }
            column(ShippedQtyLbl; ShippedQtyLbl)
            {
            }
            column(LogoOption; OptionValue)
            {
            }
            column(RespCenterUditec; RespCenterUditec."A01 Logo")
            {
            }
            column(OptionType; OptionType)
            {
            }
            column(LocationCodeLbl; LocationCodeLbl)
            {
            }
            column(CustomerCodeLbl; CustomerCodeLbl)
            {
            }
            column(CustomerAddressLbl; CustomerAddressLbl)
            {
            }
            dataitem(Line; "Transfer Shipment Line")
            {
                DataItemLinkReference = Header;
                DataItemLink = "Document No." = field("No.");
                DataItemTableView = sorting("Document No.", "Line No.");
                column(LineNo_Line; "Line No.")
                {
                }
                column(Document_No_; "Document No.")
                {
                }
                column(ItemNo_Line; "Item No.")
                {
                }
                column(Description_Line; Description)
                {
                }
                column(Quantity; Quantity)
                {
                }
                // dataitem("Item Ledger Entry"; "Item Ledger Entry")
                // {
                //     DataItemTableView = sorting("Document Type", "Entry Type") where("Document Type" = filter(9), "Entry Type" = const(Transfer));
                //     DataItemLinkReference = Line;
                //     DataItemLink = "Item No." = field("Item No."), "Order No." = field("Document No.");
                //     column(Serial_No_; "Serial No.")
                //     {
                //     }
                //     column(Quantity_; Quantity)
                //     {
                //     }
                // }
                dataitem(Bin; Bin)
                {
                    DataItemLinkReference = Line;
                    DataItemLink = "Location Code" = field("Transfer-to Code");
                    DataItemTableView = sorting(Code) where(Description = const('S2M ANKORONDRANO'));
                    column(Code; Code)
                    {
                    }
                    column(Location_Code; "Location Code")
                    {
                    }
                    dataitem(Customer; Customer)
                    {
                        DataItemLinkReference = Bin;
                        DataItemLink = "No." = field(Code);
                        DataItemTableView = sorting("No.");
                        column(No_; "No.")
                        {
                        }
                        column(Address; Address)
                        {
                        }
                    }
                }
                trigger OnAfterGetRecord()
                begin
                    if Quantity = 0 then
                        CurrReport.Skip();

                    if "Transfer-from Code" = '' then
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
        RespCenterUditec: Record "Responsibility Center";
        OptionValue: Option LogoCosmos,LogoUditec;
        OptionType: Integer;
        UnitName: Text[100];
        UnitAddress: Text[100];
        UnitCity: Text[50];
        UnitPostalCode: Text[50];
        ReportTitleLbl: Label 'TRANSFER ORDER';
        UnitNameLbl: Label 'Warehouse name :';
        UnitAddressLbl: Label 'Warehouse address :';
        UnitCityLbl: Label 'City';
        UnitPostalCodeLbl: Label 'Postal code :';
        TransferNumberLbl: Label 'Transfer order N° :';
        DeleveryNoteDateLbl: Label 'Transfer date :';
        ProductCodeLbl: Label 'Product code';
        ProductSerialNumberLbl: Label 'product serial number';
        DesignationLbl: Label 'Designation';
        ProductLocationLbl: Label 'Product Location';
        OriginLocationLbl: Label 'Transfer origin location';
        DestinationLocationLbl: Label 'Transfer destination location';
        ShippedQtyLbl: Label 'Shipped quantity';
        IssuerSignLbl: Label 'Issuer signature';
        ReceiverSignLbl: Label 'Receiver signature';
        LogistiqueSignLbl: Label 'Logistique signature';
        SecuritySignLbl: Label 'Security signature';
        NameSignLbl: Label 'Name';
        OrigineLbl: Label 'Origine';
        DestinationLbl: Label 'Destination';
        SignLbl: Label 'Signature';
        DateSignLbl: Label 'Date';
        HourSignLbl: Label 'Hour';
        LocationCodeLbl: Label 'Location code :';
        CustomerCodeLbl: Label 'Customer code :';
        CustomerAddressLbl: Label 'Customer address:';

}