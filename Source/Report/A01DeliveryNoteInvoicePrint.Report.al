/// <summary>
/// Report A01 Delivery Note Invoice Print (ID 50009).
/// </summary>
report 50009 "A01 DeliveryNoteInvoicePrint"
{
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;
    Caption = 'Delivery Note Invoice Print';
    PreviewMode = PrintLayout;
    DefaultLayout = RDLC;
    RDLCLayout = './Source/Report/Layout/DeliveryNoteInvoicePrint.rdl';

    dataset
    {
        dataitem("Sales Shipment Header"; "Sales Shipment Header")
        {
            DataItemTableView = sorting("No.");
            RequestFilterFields = "No.", "Location Code";
            PrintOnlyIfDetail = true;
            column(DocumentNo_; "No.")
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
            column(Order_No_; "Order No.")
            {
            }
            column(CustName; "Bill-to Name")
            {
            }
            column(Posting_Date; Format("Posting Date"))
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
            column(CustAddress; "Ship-to Name")
            {
            }
            column(CustPhone; CustPhone)
            {
            }
            column(CustIdentity; CustIdentity)
            {
            }
            column(A01TotalHT__Caption; A01TotalHT__Caption)
            {
            }
            column(A01TVA__Caption; A01TVA__Caption)
            {
            }
            column(A01TotalTTC__Caption; A01TotalTTC__Caption)
            {
            }
            column(TotalHT; TotalHT)
            {
            }
            column(TVA; TVA)
            {
            }
            column(TotalTTC; TotalTTC)
            {
            }
            column(Afk_AmountInWords; Afk_AmountInWords)
            {
            }
            column(ArrestedOfSum__Caption; ArrestedOfSum__Caption)
            {
            }
            column(DiscountPercent__Caption; DiscountPercent__Caption)
            {
            }
            column(A01UnitPrice__Caption; A01UnitPrice__Caption)
            {
            }
            column(A01LineDiscountedPrice__Caption; A01LineDiscountedPrice__Caption)
            {
            }
            column(AfkCurrCode; AfkCurrCode)
            {
            }
            column(A01Qty__Caption; A01Qty__Caption)
            {
            }
            dataitem("Sales Shipment Line"; "Sales Shipment Line")
            {
                DataItemTableView = sorting("Document No.", "Line No.") where(Type = filter(2));
                DataItemLinkReference = "Sales Shipment Header";
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
                column(PUnit_Price_Text; Format(Round("Unit Price", 0.01, '<')))
                {
                }
                column(LineDiscount; LineDiscountText)
                {
                    AutoFormatExpression = "Sales Shipment Header"."Currency Code";
                    AutoFormatType = 2;
                }
                column(A01DiscountedPrice; A01DiscountedPriceText)
                {
                    AutoFormatExpression = "Sales Shipment Header"."Currency Code";
                    AutoFormatType = 2;
                }
                column(Quantity_Line_Lbl; FieldCaption(Quantity))
                {
                }
                column(Type_Line; Format(Type))
                {
                }
                column(Total_LCYText; Total_LCYText)
                {
                }
                column(TotalTTC_LCYText; TotalTTC_LCYText)
                {
                }
                column(TVA_LCYText; TVA_LCYText)
                {
                }
                column(Bin_Code; "Bin Code")
                {
                }
                dataitem("Item Ledger Entry"; "Item Ledger Entry")
                {
                    DataItemTableView = sorting("Document No.") where("Document Type" = filter(1));
                    DataItemLinkReference = "Sales Shipment Line";
                    DataItemLink = "Document No." = field("Document No."), "Document Line No." = field("Line No.");
                    column(Serial_No_; "Serial No.")
                    {
                    }
                    column(Quantity_; Quantity)
                    {
                    }
                }
                trigger OnAfterGetRecord()
                begin
                    LineDiscount := Round((Quantity * "Unit Price") * ("Line Discount %" / 100), 0.01, '<');
                    LineDiscountText := Format(LineDiscount);

                    A01DiscountedPrice := Round("Sales Shipment Line"."Unit Price" - LineDiscount, 0.01, '<');
                    A01DiscountedPriceText := Format(A01DiscountedPrice);

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

                GLSetup.Get();
                GLSetup.TestField("LCY Code");

                AfkCurrCode := GLSetup."Local Currency Symbol";

                CurrCode := "Sales Shipment Header"."Currency Code";
                if (CurrCode = '') then
                    CurrCode := GLSetup."LCY Code";

                AfkCurrencyName := CurrCode;
                if AfkCurrency.Get(CurrCode) then
                    AfkCurrencyName := AfkCurrency.Description;

                if (AfkLocalCurrency.Get(GLSetup."LCY Code") and (CurrCode <> GLSetup."LCY Code")) then
                    AfkLocalCurrencyName := AfkLocalCurrency.Description;

                if "Currency Code" <> '' then begin
                    CurrencyExchangeRate.FindCurrency("Posting Date", "Currency Code", 1);
                    CalculatedExchRate :=
                      Round(1 / "Currency Factor" * CurrencyExchangeRate."Exchange Rate Amount", 0.000001);
                    ExchangeRateText := StrSubstNo(ExchangeRateTxt, CalculatedExchRate, CurrencyExchangeRate."Exchange Rate Amount");
                end;

                Clear(TotalHT);
                Clear(TVA);
                Clear(TotalTTC);
                SaleLineRec.Reset();
                SaleLineRec.SetRange("Document No.", "Sales Shipment Header"."No.");
                if SaleLineRec.FindFirst() then begin
                    repeat
                        Montant := Round(SaleLineRec.Quantity * SaleLineRec."Unit Price", 0.01, '<');
                        TotalHT := Round(TotalHT + (Montant - (Montant * SaleLineRec."Line Discount %" / 100)), 0.01, '<');
                        TVA2 := Round((TotalHT * SaleLineRec."VAT %" / 100), 0.01, '<');
                        TVA := Round((TotalHT + TVA2) - TotalHT, 0.01, '<');

                        TotalHT := CurrencyExchangeRate.ExchangeAmtFCYToLCY("Sales Shipment Header"."Posting Date",
                            "Sales Shipment Header"."Currency Code", TotalHT, "Sales Shipment Header"."Currency Factor");
                        TVA := CurrencyExchangeRate.ExchangeAmtFCYToLCY("Sales Shipment Header"."Posting Date",
                            "Sales Shipment Header"."Currency Code", TVA, "Sales Shipment Header"."Currency Factor");

                        TotalHT := ROUND(TotalHT, AfkLocalCurrency."Amount Rounding Precision");
                        TVA := ROUND(TVA, AfkLocalCurrency."Amount Rounding Precision");

                        Total_LCYText :=
                         Format(TotalHT, 0,
                         AutoFormat.ResolveAutoFormat("Auto Format"::AmountFormat, AfkLocalCurrency.Code));
                        Total_LCYText := Format(TotalHT);
                        TVA_LCYText :=
                         Format(TVA, 0,
                         AutoFormat.ResolveAutoFormat("Auto Format"::AmountFormat, AfkLocalCurrency.Code));
                        TVA_LCYText := Format(TVA);
                    until SaleLineRec.Next() = 0;

                    TotalTTC := CurrencyExchangeRate.ExchangeAmtFCYToLCY("Sales Shipment Header"."Posting Date",
                                "Sales Shipment Header"."Currency Code", TotalTTC, "Sales Shipment Header"."Currency Factor");
                    TotalTTC := TotalHT + TVA;
                    TotalTTC := ROUND(TotalTTC, AfkLocalCurrency."Amount Rounding Precision");
                    TotalTTC_LCYText :=
                     Format(TotalTTC, 0,
                     AutoFormat.ResolveAutoFormat("Auto Format"::AmountFormat, AfkLocalCurrency.Code));
                    TotalTTC_LCYText := Format(TotalTTC);
                end;

                RepCheck.InitTextVariable();
                RepCheck.FormatNoText(NoText, TotalTTC, AfkLocalCurrency.Code);

                NoText[1] := ReplaceString(NoText[1], '****');
                NoText[1] := ReplaceString(NoText[1], 'AND 0/100');
                NoText[2] := ReplaceString(NoText[2], '****');
                NoText[2] := ReplaceString(NoText[2], 'AND 0/100');
                Afk_AmountInWords := NoText[1] + ' ' + NoText[2];

                // if RespCenter.Get("Sales Shipment Header"."Responsibility Center") then begin
                //     UnitName := RespCenter.Name;
                //     UnitAddress := RespCenter.Address;
                //     UnitCity := RespCenter.City;
                //     UnitPostalCode := RespCenter."Post Code";
                // end;

                if LocRec.Get("Sales Shipment Header"."Location Code") then begin
                    UnitName := LocRec.Name;
                    UnitAddress := LocRec.Address;
                    UnitCity := LocRec.City;
                    UnitPostalCode := LocRec."Post Code";
                end;

                if Contact.Get("Sales Shipment Header"."Bill-to Contact No.") then begin
                    CustIdentity := Contact.Name;
                    CustPhone := Contact."Phone No.";
                end;

                if Ship.Get("Sales Shipment Header"."Ship-to Code") then
                    CustAddress := Ship.Name;

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
        LocRec: Record Location;
        Contact: Record Contact;
        GLSetup: Record "General Ledger Setup";
        CurrencyExchangeRate: Record "Currency Exchange Rate";
        Ship: Record "Ship-to Address";
        SaleLineRec: Record "Sales Shipment Line";
        AfkLocalCurrency: Record Currency;
        AfkCurrency: Record Currency;
        RepCheck: Report Check;
        AutoFormat: Codeunit "Auto Format";
        Montant: Decimal;
        CalculatedExchRate: Decimal;
        ExchangeRateTxt: Label 'Exchange rate: %1/%2', Comment = '%1 and %2 are both amounts.';
        // "Currency Factor": Decimal;
        ExchangeRateText: Text;
        AfkLocalCurrencyName: Text;
        CurrCode: Code[20];
        AfkCurrencyName: Text;
        A01DiscountedPrice: Decimal;
        LineDiscount: Decimal;
        AfkCurrCode: Code[20];
        LineDiscountText: Text[50];
        A01DiscountedPriceText: Text[50];
        NoText: array[2] of Text;
        TVA2: Decimal;
        Total_LCYText: Text[50];
        TVA_LCYText: Text[50];
        TotalTTC_LCYText: Text[50];
        Afk_AmountInWords: Text;
        TotalHT: Decimal;
        TVA: Decimal;
        TotalTTC: Decimal;
        UnitName: Text[100];
        UnitAddress: Text[100];
        UnitCity: Text[50];
        UnitPostalCode: Text[50];
        CustAddress: Text[100];
        CustIdentity: Text[100];
        CustPhone: Text[30];
        ReportTitleLbl: Label 'DELIVERYNOTEINVOICE';
        UnitNameLbl: Label 'Unitname:';
        UnitAddressLbl: Label 'Unitaddress:';
        UnitCityLbl: Label 'City';
        UnitPostalCodeLbl: Label 'Postal code :';
        CustNameLbl: Label 'Customer name :';
        CustIdentityLbl: Label 'Customer identity :';
        CustAddressLbl: Label 'Customer address :';
        NIFLbl: Label 'NIF :';
        STATLbl: Label 'STAT :';
        RCSLbl: Label 'RCS :';
        CustPhoneLbl: Label 'Phone :';
        OrderNumberLbl: Label 'Deliverynotenumber:';
        DeleveryNoteDateLbl: Label 'Deliverynotedate :';
        InvoiceNumberLbl: Label 'Invoicenumber:';
        VehicleNumberLbl: Label 'Vehicle number :';

        ProductCodeLbl: Label 'Product code';
        ProductSerialNumberLbl: Label 'product_serialnumber';
        DesignationLbl: Label 'Designation';
        A01TotalHT__Caption: Label 'TotalHT:';
        DiscountPercent__Caption: Label 'Discount';
        A01UnitPrice__Caption: Label 'UnitpriceHT';
        A01TVA__Caption: Label 'VAT(20%):';
        A01LineDiscountedPrice__Caption: Label 'Discounted price';
        A01TotalTTC__Caption: Label 'TotalTTC:';
        A01Qty__Caption: Label 'Qty';
        ArrestedOfSum__Caption: Label 'Arrested at the sum of :';
        ProductLocationLbl: Label 'Product Location';
        CustSignLbl: Label 'Customer signature';
        CompanySignLbl: Label 'Company signature';


    local procedure ReplaceString(OriginString: Text; ReplaceStr: Text): Text
    var
        Rep: Text;
        pos: Integer;
    begin
        Rep := OriginString;
        pos := StrPos(OriginString, ReplaceStr);
        if (pos >= 1) then begin
            Rep := DelStr(OriginString, pos, StrLen(ReplaceStr));
        end;
        exit(Rep);
    end;

}