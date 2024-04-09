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
        dataitem(Header; "Transfer Header")
        {
            DataItemTableView = sorting("No.");
            RequestFilterFields = "No.", "Transfer-from Code", "Transfer-to Code";
            RequestFilterHeading = 'Transfer Order';
            column(DocumentNo_; "No.")
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
            column(RequesterLbl; RequesterLbl)
            {
            }
            column(RequesterUnitLbl; RequesterUnitLbl)
            {
            }
            column(RequestUnitLbl; RequestUnitLbl)
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
            column(OrderedQtyLbl; OrderedQtyLbl)
            {
            }
            column(ShippedQtyLbl; ShippedQtyLbl)
            {
            }
            column(ReceveidQtyLbl; ReceveidQtyLbl)
            {
            }
            dataitem(Line; "Transfer Line")
            {
                DataItemLinkReference = Header;
                DataItemLink = "Document No." = field("No.");
                DataItemTableView = sorting("Document No.", "Line No.") where("Derived From Line No." = const(0));
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
                column(Quantity_Shipped; "Quantity Shipped")
                {
                }
                column(Quantity_Line_Lbl; FieldCaption(Quantity))
                {
                }
                // dataitem("Tracking Specification"; "Tracking Specification")
                // {
                //     DataItemTableView = sorting("Serial No.");
                //     DataItemLinkReference = Line;
                //     DataItemLink = "Item No." = field("Item No."), "Source Ref. No." = field("Line No.");
                //     column(Serial_No_; "Serial No.")
                //     {
                //     }
                //     column(Quantity__Base_; "Quantity (Base)")
                //     {
                //     }
                // }
                dataitem("Item Ledger Entry"; "Item Ledger Entry")
                {
                    DataItemTableView = sorting("Document Type", "Entry Type") where("Document Type" = filter(9), "Entry Type" = const(Transfer));
                    DataItemLinkReference = Line;
                    DataItemLink = "Item No." = field("Item No."), "Order No." = field("Document No.");
                    column(Serial_No_; "Serial No.")
                    {
                    }
                    column(Quantity_; Quantity)
                    {
                    }
                }
                trigger OnAfterGetRecord()
                begin
                    if "Item No." = 'MIR_FEES' then
                        CurrReport.Skip();
                    if "Item No." = 'mir_fees' then
                        CurrReport.Skip();
                    if "Item No." = 'MIR_INTEREST' then
                        CurrReport.Skip();
                    if "Item No." = 'mir_interest' then
                        CurrReport.Skip();
                end;
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
        ReportTitleLbl: Label 'TRANSFER ORDER';
        UnitNameLbl: Label 'Unit name :';
        UnitAddressLbl: Label 'Unit address :';
        UnitCityLbl: Label 'City';
        UnitPostalCodeLbl: Label 'Postal code :';
        TransferNumberLbl: Label 'Transfer order N° :';
        DeleveryNoteDateLbl: Label 'Date :';
        ProductCodeLbl: Label 'Product code';
        ProductSerialNumberLbl: Label 'product serial number';
        DesignationLbl: Label 'Designation';
        ProductLocationLbl: Label 'Product Location';
        OriginLocationLbl: Label 'Transfer origin location';
        DestinationLocationLbl: Label 'Transfer destination location';
        OrderedQtyLbl: Label 'Ordered quantity';
        ShippedQtyLbl: Label 'Shipped quantity';
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
        RequestUnitLbl: Label 'Nameofrequesting unit :';
        RequesterLbl: Label 'Name of requester :';
        RequesterUnitLbl: Label 'Name of receiving unit :';

}