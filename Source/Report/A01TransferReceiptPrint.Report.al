/// <summary>
/// Report A01 Transfer Receipt Print (ID 50026).
/// </summary>
report 50026 "A01 TransferReceiptPrint"
{
    Caption = 'A01 Transfer receipt print';
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;
    DefaultLayout = RDLC;
    PreviewMode = PrintLayout;
    EnableHyperlinks = true;
    WordMergeDataItem = Header;
    RDLCLayout = './Source/Report/Layout/TransferReceiptPrint.rdl';

    dataset
    {
        dataitem(Header; "Transfer Receipt Header")
        {
            DataItemTableView = sorting("No.");
            RequestFilterFields = "No.", "Transfer-from Code", "Transfer-to Code";
            RequestFilterHeading = 'Transfer Receipt';
            column(DocumentNo_; "No.")
            {
            }
            column(Transfer_Order_No_; "Transfer Order No.")
            {
            }
            column(Receipt_Date; Format("Receipt Date"))
            {
            }
            column(Transfer_Order_Date; Format("Transfer Order Date"))
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
            column(ReceveidQtyLbl; ReceveidQtyLbl)
            {
            }
            dataitem(Line; "Transfer Receipt Line")
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
            }
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
        UnitName: Text[100];
        UnitAddress: Text[100];
        UnitCity: Text[50];
        UnitPostalCode: Text[50];
        ReportTitleLbl: Label 'TRANSFER RECEIPT';
        UnitNameLbl: Label 'Warehouse name :';
        UnitAddressLbl: Label 'Warehouse address :';
        UnitCityLbl: Label 'City';
        UnitPostalCodeLbl: Label 'Postal code :';
        TransferNumberLbl: Label 'Transfer order N° :';
        DeleveryNoteDateLbl: Label 'Receipt date :';
        ProductCodeLbl: Label 'Product code';
        ProductSerialNumberLbl: Label 'product serial number';
        DesignationLbl: Label 'Designation';
        ProductLocationLbl: Label 'Product Location';
        OriginLocationLbl: Label 'Transfer origin location';
        DestinationLocationLbl: Label 'Transfer destination location';
        ReceveidQtyLbl: Label 'Received quantity';
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

}