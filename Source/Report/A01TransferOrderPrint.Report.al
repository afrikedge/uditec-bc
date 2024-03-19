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
            RequestFilterFields = "No.";
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
                    DataItemTableView = sorting("Document Type", "Entry Type") where("Document Type" = filter(9), "Entry Type" = filter(4));
                    DataItemLinkReference = Line;
                    DataItemLink = "Item No." = field("Item No."), "Order No." = field("Document No.");
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
                // if RespCenter.Get(Header."Responsibility Center") then begin
                //     UnitName := RespCenter.Name;
                //     UnitAddress := RespCenter.Address;
                //     UnitCity := RespCenter.City;
                //     UnitPostalCode := RespCenter."Phone No.";
                // end;

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
        // RespCenter: Record "Responsibility Center";
        // Cust: Record Customer;
        UnitName: Text[100];
        // UnitCenterLogo: Media
        UnitAddress: Text[100];
        UnitCity: Text[50];
        UnitPostalCode: Text[50];
        // CustAddress: Text[100];
        // CustPhone: Text[30];
        ReportTitleLbl: Label 'TRANSFER ORDER';
        UnitNameLbl: Label 'Unit name :';
        UnitAddressLbl: Label 'Unit address :';
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
        IssuerSignLbl: Label 'Issuer signature';
        ReceiverSignLbl: Label 'Receiver signature';
        RequestUnitLbl: Label 'Name of requesting unit';
        RequesterLbl: Label 'Name of requester';
        RequesterUnitLbl: Label 'Name of receiving unit';

}