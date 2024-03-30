/// <summary>
/// Report A01 PurchaseQuotePrint (ID 50008).
/// </summary>
report 50008 "A01 PurchaseQuotePrint"
{
    Caption = 'Purchase Quote Print';
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;
    DefaultLayout = RDLC;
    PreviewMode = PrintLayout;
    WordMergeDataItem = "Purchase Header";
    RDLCLayout = './Source/Report/Layout/PurchaseQuotePrint.rdl';

    dataset
    {
        dataitem("Purchase Header"; "Purchase Header")
        {
            DataItemTableView = sorting("Document Type", "No.") where("Document Type" = const(Quote));
            RequestFilterFields = "No.", "Buy-from Vendor No.";
            RequestFilterHeading = 'Proforma';
            column(PurchHeadNo; "No.")
            {
            }
            column(CompanyInfo_Name; COMPANYPROPERTY.DisplayName())
            {
            }
            column(CompanyInfo_Picture; CompanyInfo.Picture)
            {

            }
            column(CompanyInfo_Address; CompanyInfo.Address)
            {
            }
            column(CompanyInfo_HomePage; CompanyInfo."Home Page")
            {
            }
            column(CompanyInfo_Phone; CompanyInfo."Phone No.")
            {
            }
            column(A01Vendor_Name; "Buy-from Vendor Name")
            {
            }
            column(A01VendorAddress; A01VendorAddress)
            {
            }
            column(A01VendorPhone; A01VendorPhone)
            {
            }
            column(A01VendorIdentity; A01VendorIdentity)
            {
            }
            column(A01Document_Date; Format("Document Date"))
            {
            }
            column(ReportTitle__Caption; ReportTitle__Caption)
            {
            }
            column(A01VendorName__Caption; A01VendorName__Caption)
            {
            }
            column(A01VendorIdentity__Caption; A01VendorIdentity__Caption)
            {
            }
            column(A01VendorAddress__Caption; A01VendorAddress__Caption)
            {
            }
            column(A01NIF__Caption; A01NIF__Caption)
            {
            }
            column(A01STAT__Caption; A01STAT__Caption)
            {
            }
            column(A01RCS__Caption; A01RCS__Caption)
            {
            }
            column(A01VendorPhone__Caption; A01VendorPhone__Caption)
            {
            }
            column(A01DevisNo__Caption; A01DevisNo__Caption)
            {
            }
            column(A01DateOfPrint_Caption; A01DateOfPrint)
            {
            }
            column(A01ProductCode__Caption; A01ProductCode__Caption)
            {
            }
            column(A01Description__Caption; A01Description__Caption)
            {
            }
            column(A01Quantity__Caption; A01Quantity__Caption)
            {
            }
            column(A01UnitPrice__Caption; A01UnitPrice__Caption)
            {
            }
            column(A01DiscountPercent__Caption; A01DiscountPercent__Caption)
            {
            }
            column(A01DiscountAmount__Caption; A01DiscountAmount__Caption)
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


            column(DocType_PurchHead; Format("Document Type"))
            {
            }
            column(CompanyInfoPhoneNoCap; CompanyInfoPhoneNoCapLbl)
            {
            }
            column(CompanyInfoVATRegNoCap; CompanyInfoVATRegNoCapLbl)
            {
            }
            column(CompanyInfoGiroNoCap; CompanyInfoGiroNoCapLbl)
            {
            }
            column(CompanyInfoBankNameCap; CompanyInfoBankNameCapLbl)
            {
            }
            column(CompInfoBankAccNoCap; CompInfoBankAccNoCapLbl)
            {
            }
            column(DocumentDateCap; DocumentDateCapLbl)
            {
            }
            column(PageNoCaption; PageNoCaptionLbl)
            {
            }
            column(ShipmentMethodDescCap; ShipmentMethodDescCapLbl)
            {
            }
            column(PurchLineVendItemNoCap; PurchLineVendItemNoCapLbl)
            {
            }
            column(PurchaseLineDescCap; PurchaseLineDescCapLbl)
            {
            }
            column(PurchaseLineQuantityCap; PurchaseLineQuantityCapLbl)
            {
            }
            column(PurchaseLineUOMCaption; PurchaseLineUOMCaptionLbl)
            {
            }
            column(PurchaseLineNoCaption; PurchaseLineNoCaptionLbl)
            {
            }
            column(PurchaserTextCaption; PurchaserTextCaptionLbl)
            {
            }
            column(ReferenceTextCaption; ReferenceTextCaptionLbl)
            {
            }
            column(HomePageCaption; HomePageCaptionLbl)
            {
            }
            column(EMailCaption; EMailCaptionLbl)
            {
            }
            column(VatRegistrationNoCaption; VatRegistrationNoCaptionLbl)
            {
            }
            column(BuyFromContactPhoneNoLbl; BuyFromContactPhoneNoLbl)
            {
            }
            column(BuyFromContactMobilePhoneNoLbl; BuyFromContactMobilePhoneNoLbl)
            {
            }
            column(BuyFromContactEmailLbl; BuyFromContactEmailLbl)
            {
            }
            column(PayToContactPhoneNoLbl; PayToContactPhoneNoLbl)
            {
            }
            column(PayToContactMobilePhoneNoLbl; PayToContactMobilePhoneNoLbl)
            {
            }
            column(PayToContactEmailLbl; PayToContactEmailLbl)
            {
            }
            column(BuyFromContactPhoneNo; BuyFromContact."Phone No.")
            {
            }
            column(BuyFromContactMobilePhoneNo; BuyFromContact."Mobile Phone No.")
            {
            }
            column(BuyFromContactEmail; BuyFromContact."E-Mail")
            {
            }
            column(PayToContactPhoneNo; PayToContact."Phone No.")
            {
            }
            column(PayToContactMobilePhoneNo; PayToContact."Mobile Phone No.")
            {
            }
            column(PayToContactEmail; PayToContact."E-Mail")
            {
            }
            dataitem("Purchase Line"; "Purchase Line")
            {
                DataItemLink = "Document Type" = field("Document Type"), "Document No." = field("No.");
                DataItemLinkReference = "Purchase Header";
                DataItemTableView = sorting("Document Type", "Document No.", "Line No.");
                column(LineNo_PurchLine; "Line No.")
                {
                }
                column(AfkIsLine; AfkIsLine)
                {
                }
                column(AfkNumLigne; NumLigneText)
                {
                }
                column(A01ItemNo_; "No.")
                {
                }
                column(A01Description_Line; Description)
                {
                }
                column(A01LineDiscountPercent_Line; "Line Discount %")
                {
                }
                column(Type_Line; Format(Type))
                {
                }
                column(LineDiscountPercentText_Line; LineDiscountPctText)
                {
                }
                column(A01LineQty; A01LineQtyFormatted)
                {
                }
                column(A01Line_Discount_Amount; A01FormattedLineDiscountAmount)
                {
                    AutoFormatExpression = "Currency Code";
                    AutoFormatType = 1;
                }
                column(A01LineAmount_Line; A01FormattedAmtHT)
                {
                    AutoFormatExpression = "Currency Code";
                    AutoFormatType = 1;
                }
                column(A01LineAmountTTC_Line; FormattedLineAmountTTC)
                {
                    AutoFormatExpression = "Purchase Header"."Currency Code";
                    AutoFormatType = 1;
                }
                column(A01LinePU; A01LinePUFormatted)
                {
                    AutoFormatExpression = "Purchase Header"."Currency Code";
                    AutoFormatType = 2;
                }
                column(A01AmountVAT_Line; A01FormattedVAT)
                {
                    AutoFormatExpression = "Currency Code";
                    AutoFormatType = 1;
                }
                column(A01FormattedVAT; A01FormattedVAT)
                {
                }
                column(A01TotalAmountInclVAT_LCY; A01TotalAmountInclVAT_LCY)
                {
                }
                column(A01TotalAmount_LCY; A01TotalAmount_LCY)
                {
                }
                column(A01TotalVAT_LCY; A01TotalVAT_LCY)
                {
                }
                column(TransHeaderAmount; TransHeaderAmount)
                {
                    AutoFormatExpression = "Currency Code";
                    AutoFormatType = 1;
                }

                trigger OnAfterGetRecord()
                var
                    tempHT: Decimal;
                    // tempHTD: Decimal;
                    tempPU: Decimal;
                    tempTTC: Decimal;
                    tempVAT: Decimal;
                begin
                    // AllowInvDisctxt := Format("Allow Invoice Disc.");
                    // TotalSubTotal += "Line Amount";
                    // TotalInvoiceDiscountAmount -= "Inv. Discount Amount";
                    // TotalAmount += Amount;

                    ItemNo := "No.";

                    if "Vendor Item No." <> '' then
                        ItemNo := "Vendor Item No.";

                    if "Item Reference No." <> '' then
                        ItemNo := "Item Reference No.";

                    AfkIsLine := 1;
                    NumLigne := NumLigne + 1;
                    if (NumLigne < 10) then
                        NumLigneText := '0' + Format(NumLigne)
                    else
                        NumLigneText := Format(NumLigne);

                    if "Purchase Line".Type = "Purchase Line".Type::" " then begin
                        A01FormattedVAT := '';
                        A01FormattedAmtHT := '';
                        A01FormattedLineDiscountAmount := '';

                        A01LineQtyFormatted := '';
                        A01LinePUFormatted := '';
                    end else begin
                        if ("Purchase Header"."Prices Including VAT") then begin
                            tempHT := "Purchase Line"."Line Amount" * (1 / (1 + "Purchase Line"."VAT %" / 100));
                            // tempHTD := "Purchase Line"."Line Amount" * (1 / (1 + "Purchase Line"."Line Discount %" / 100));
                            tempPU := "Purchase Line"."Direct Unit Cost" * (1 / (1 + "Purchase Line"."VAT %" / 100));
                            tempVAT := "Purchase Line"."Amount Including VAT" - tempHT;
                            tempTTC := "Purchase Line"."Amount Including VAT";

                        end else begin
                            tempHT := "Purchase Line"."Line Amount";
                            // tempHTD := "Purchase Line"."Line Discount Amount";
                            tempPU := "Purchase Line"."Direct Unit Cost";
                            tempVAT := tempHT * "Purchase Line"."VAT %" / 100;
                            tempTTC := tempVAT + "Purchase Line"."Line Amount";
                        end;
                        A01FormattedVAT := Format(Round(tempVAT, 0.001, '<'));
                        A01FormattedAmtHT := Format(Round("Purchase Line".Quantity * tempPU, 0.001, '<'));
                        A01FormattedLineDiscountAmount := Format(Round(("Purchase Line".Quantity * tempPU) * ("Purchase Line"."Line Discount %" / 100), 0.001, '<'));
                        FormattedLineAmountTTC := Format(Round(tempTTC, 0.001, '<'));
                    end;
                    A01LineQty := "Purchase Line".Quantity;
                    A01LinePU := Round(tempPU, 0.000001, '<');

                    A01LineQtyFormatted := Format(A01LineQty);
                    A01LinePUFormatted := Format(A01LinePU);

                    LineDiscountPctText := StrSubstNo('%1%', Round("Line Discount %", 0.1));

                    if ("Purchase Header"."Prices Including VAT") then begin
                        TransHeaderAmount += PrevLineAmount;
                        PrevLineAmount := tempHT;
                        TotalSubTotal += tempHT;
                        // TotalInvDiscAmount -= "Inv. Discount Amount";
                        TotalAmount += tempHT;
                        TotalAmountVAT += "Amount Including VAT" - tempHT;
                        TotalAmountInclVAT += "Amount Including VAT";
                        // TotalPaymentDiscOnVAT += -(tempHT - "Inv. Discount Amount" - "Amount Including VAT");

                    end else begin
                        TransHeaderAmount += PrevLineAmount;
                        PrevLineAmount := "Line Amount";
                        TotalSubTotal += "Line Amount";
                        // TotalInvDiscAmount -= "Inv. Discount Amount";
                        TotalAmount += Amount;
                        TotalAmountVAT += "Amount Including VAT" - Amount;
                        TotalAmountInclVAT += "Amount Including VAT";
                        // TotalPaymentDiscOnVAT += -("Line Amount" - "Inv. Discount Amount" - "Amount Including VAT");
                    end;

                    FormatDocument.SetPurchaseLine("Purchase Line", FormattedQuanitity, FormattedDirectUnitCost, FormattedVATPct, FormattedLineAmount);
                end;

                trigger OnPreDataItem()
                begin
                    MoreLines := Find('+');
                    while MoreLines and (Description = '') and ("No." = '') and (Quantity = 0) and (Amount = 0) do
                        MoreLines := Next(-1) <> 0;
                    if not MoreLines then
                        CurrReport.Break();
                    SetRange("Line No.", 0, "Line No.");
                    TransHeaderAmount := 0;
                    PrevLineAmount := 0;
                    // AfkLinesNumber := Count();
                end;

                // trigger OnPostDataItem()
                // begin
                //     TempPurchaseLine.DeleteAll();
                // end;
            }
            dataitem(AfkFooterline; "Integer")
            {
                DataItemTableView = SORTING(Number);
                column(AfkNumLigne2; NumLigneText)
                {
                }
                column(AfkIsLine2; AfkIsLine)
                {
                }
                trigger OnAfterGetRecord()
                begin
                    AfkIsLine := 1;
                    NumLigne := NumLigne + 1;
                    if (NumLigne < 10) then
                        NumLigneText := '0' + Format(NumLigne)
                    else
                        NumLigneText := Format(NumLigne);
                end;

                trigger OnPreDataItem()
                begin
                    SetRange(Number, 1, 0);
                end;
            }
            dataitem(Totals; Integer)
            {
                DataItemTableView = sorting(Number) where(Number = const(1));
                column(SelltoCustNo_PurchHdr; "Purchase Header"."Sell-to Customer No.")
                {
                }
                column(ShipToAddr1; ShipToAddr[1])
                {
                }
                column(ShipToAddr2; ShipToAddr[2])
                {
                }
                column(ShipToAddr3; ShipToAddr[3])
                {
                }
                column(ShipToAddr4; ShipToAddr[4])
                {
                }
                column(ShipToAddr5; ShipToAddr[5])
                {
                }
                column(ShipToAddr6; ShipToAddr[6])
                {
                }
                column(ShipToAddr7; ShipToAddr[7])
                {
                }
                column(ShipToAddr8; ShipToAddr[8])
                {
                }
                column(ShiptoAddressCaption; ShiptoAddressCaptionLbl)
                {
                }

                column(VATAmountText; TempVATAmountLine.VATAmountText())
                {
                }
                column(TotalVATAmount; VATAmount)
                {
                    AutoFormatExpression = "Purchase Header"."Currency Code";
                    AutoFormatType = 1;
                }
                column(TotalVATDiscountAmount; -VATDiscountAmount)
                {
                    AutoFormatExpression = "Purchase Header"."Currency Code";
                    AutoFormatType = 1;
                }
                column(TotalVATBaseAmount; VATBaseAmount)
                {
                    AutoFormatExpression = "Purchase Header"."Currency Code";
                    AutoFormatType = 1;
                }
                column(TotalAmountInclVAT; TotalAmountInclVAT)
                {
                    AutoFormatExpression = "Purchase Header"."Currency Code";
                    AutoFormatType = 1;
                }
                column(TotalInclVATText; TotalInclVATText)
                {
                }
                column(TotalExclVATText; TotalExclVATText)
                {
                }
                column(TotalSubTotal; TotalSubTotal)
                {
                    AutoFormatExpression = "Purchase Header"."Currency Code";
                    AutoFormatType = 1;
                }
                column(TotalInvoiceDiscountAmount; TotalInvoiceDiscountAmount)
                {
                    AutoFormatExpression = "Purchase Header"."Currency Code";
                    AutoFormatType = 1;
                }
                column(TotalAmount; TotalAmount)
                {
                    AutoFormatExpression = "Purchase Header"."Currency Code";
                    AutoFormatType = 1;
                }
                column(TotalText; TotalText)
                {
                }
                column(A01FormattedTotalVAT; A01FormattedTotalVAT)
                {
                }
                column(A01FormattedTotalHT; A01FormattedTotalHT)
                {
                }
                column(A01FormattedTotalTTC; A01FormattedTotalTTC)
                {
                }
                column(A01TotalAmount_LCYText; A01TotalAmount_LCYText)
                {
                }
                column(A01_AmountInWords; A01_AmountInWords)
                {
                }
                column(A01TotalAmountInclVAT_LCYText; A01TotalAmountInclVAT_LCYText)
                {
                }
                column(A01TotalVAT_LCYText; A01TotalVAT_LCYText)
                {
                }
                column(AfkLocalCurrencyText; AfkLocalCurrencyText)
                {
                }
                column(AfkLocalCurrencyCaption; AfkLocalCurrencyCaption)
                {
                }
                column(AfkTotalVAT_LCYCaption; AfkTotalVAT_LCYCaption)
                {
                }
                column(AfkTotalAmount_LCYCaption; AfkTotalAmount_LCYCaption)
                {
                }
                column(AfkTotalAmountInclVAT_LCYCaption; AfkTotalAmountInclVAT_LCYCaption)
                {
                }

                trigger OnPreDataItem()
                begin
                    TotalAmountExclInclVATTextValue := TotalInclVATText;
                    TotalAmountExclInclVATValue := TotalAmountInclVAT;

                    A01FormattedTotalVAT :=
                        Format(TotalAmountVAT, 0,
                        AutoFormat.ResolveAutoFormat("Auto Format"::AmountFormat, "Purchase Header"."Currency Code"));
                    A01FormattedTotalHT :=
                        Format(TotalAmount, 0,
                        AutoFormat.ResolveAutoFormat("Auto Format"::AmountFormat, "Purchase Header"."Currency Code"));
                    A01FormattedTotalTTC :=
                        Format(TotalAmountExclInclVATValue, 0,
                        AutoFormat.ResolveAutoFormat("Auto Format"::AmountFormat, "Purchase Header"."Currency Code"));

                    A01TotalAmountInclVAT_LCY := CurrencyExchangeRate.ExchangeAmtFCYToLCY("Purchase Header"."Posting Date",
                        "Purchase Header"."Currency Code", TotalAmountExclInclVATValue, "Purchase Header"."Currency Factor");
                    A01TotalAmount_LCY := CurrencyExchangeRate.ExchangeAmtFCYToLCY("Purchase Header"."Posting Date",
                        "Purchase Header"."Currency Code", TotalAmount, "Purchase Header"."Currency Factor");
                    A01TotalVAT_LCY := CurrencyExchangeRate.ExchangeAmtFCYToLCY("Purchase Header"."Posting Date",
                        "Purchase Header"."Currency Code", TotalAmountVAT, "Purchase Header"."Currency Factor");

                    A01TotalAmountInclVAT_LCY := ROUND(A01TotalAmountInclVAT_LCY, AfkLocalCurrency."Amount Rounding Precision");
                    A01TotalAmount_LCY := ROUND(A01TotalAmount_LCY, AfkLocalCurrency."Amount Rounding Precision");
                    A01TotalVAT_LCY := ROUND(A01TotalVAT_LCY, AfkLocalCurrency."Amount Rounding Precision");

                    A01TotalAmountInclVAT_LCYText :=
                         Format(A01TotalAmountInclVAT_LCY, 0,
                         AutoFormat.ResolveAutoFormat("Auto Format"::AmountFormat, AfkLocalCurrency.Code));
                    A01TotalAmount_LCYText :=
                        Format(A01TotalAmount_LCY, 0,
                        AutoFormat.ResolveAutoFormat("Auto Format"::AmountFormat, AfkLocalCurrency.Code));
                    AfkLocalCurrencyText := 'XAF';
                    A01TotalVAT_LCYText :=
                        Format(A01TotalVAT_LCY, 0,
                        AutoFormat.ResolveAutoFormat("Auto Format"::AmountFormat, AfkLocalCurrency.Code));
                end;

                trigger OnAfterGetRecord()
                var
                    TempPrepmtPurchLine: Record "Purchase Line" temporary;
                begin
                    Clear(TempPurchLine);
                    Clear(PurchPost);
                    TempPurchLine.DeleteAll();
                    TempVATAmountLine.DeleteAll();
                    PurchPost.GetPurchLines("Purchase Header", TempPurchLine, 0);
                    TempPurchLine.CalcVATAmountLines(0, "Purchase Header", TempPurchLine, TempVATAmountLine);
                    TempPurchLine.UpdateVATOnLines(0, "Purchase Header", TempPurchLine, TempVATAmountLine);
                    VATAmount := TempVATAmountLine.GetTotalVATAmount();
                    VATBaseAmount := TempVATAmountLine.GetTotalVATBase();
                    VATDiscountAmount :=
                      TempVATAmountLine.GetTotalVATDiscount("Purchase Header"."Currency Code", "Purchase Header"."Prices Including VAT");
                    TotalAmountInclVAT := TempVATAmountLine.GetTotalAmountInclVAT();

                    // TempPrepaymentInvLineBuffer.DeleteAll();
                    PurchasePostPrepayments.GetPurchLines("Purchase Header", 0, TempPrepmtPurchLine);
                    if not TempPrepmtPurchLine.IsEmpty() then begin
                        PurchasePostPrepayments.GetPurchLinesToDeduct("Purchase Header", TempPurchLine);
                        if not TempPurchLine.IsEmpty() then
                            PurchasePostPrepayments.CalcVATAmountLines("Purchase Header", TempPurchLine, TempPrePmtVATAmountLineDeduct, 1);
                    end;
                    PurchasePostPrepayments.CalcVATAmountLines("Purchase Header", TempPrepmtPurchLine, TempPrepmtVATAmountLine, 0);
                    TempPrepmtVATAmountLine.DeductVATAmountLine(TempPrePmtVATAmountLineDeduct);
                    PurchasePostPrepayments.UpdateVATOnLines("Purchase Header", TempPrepmtPurchLine, TempPrepmtVATAmountLine, 0);
                    // PurchasePostPrepayments.BuildInvLineBuffer("Purchase Header", TempPrepmtPurchLine, 0, TempPrepaymentInvLineBuffer);
                    // PrepmtVATAmount := TempPrepmtVATAmountLine.GetTotalVATAmount();
                    // PrepmtVATBaseAmount := TempPrepmtVATAmountLine.GetTotalVATBase();
                    // PrepmtTotalAmountInclVAT := TempPrepmtVATAmountLine.GetTotalAmountInclVAT();
                end;
            }

            trigger OnAfterGetRecord()
            var
                GLSetup: Record "General Ledger Setup";
            begin
                CurrReport.Language := LanguageMgt.GetLanguageIdOrDefault("Language Code");
                CurrReport.FormatRegion := LanguageMgt.GetFormatRegionOrDefault("Format Region");
                FormatAddr.SetLanguageCode("Language Code");

                AfkCurrCode := "Purchase Header"."Currency Code";
                if (AfkCurrCode = '') then
                    AfkCurrCode := GLSetup."LCY Code";

                AfkCurrencyName := AfkCurrCode;
                if AfkCurrency.Get(AfkCurrCode) then
                    AfkCurrencyName := AfkCurrency.Description;

                if (AfkLocalCurrency.Get(GLSetup."LCY Code") and (AfkCurrCode <> GLSetup."LCY Code")) then
                    AfkLocalCurrencyName := AfkLocalCurrency.Description;

                if BuyFromContact.Get("Purchase Header"."Buy-from Contact No.") then begin
                    A01VendorPhone := BuyFromContact."Phone No.";
                    A01VendorIdentity := BuyFromContact.Name;
                end;

                if ShipToAddrr.Get("Purchase Header"."Ship-to Code") then
                    A01VendorAddress := ShipToAddrr.Name;

                NumLigne := 0;

                FormatAddressFields("Purchase Header");
                FormatDocumentFields("Purchase Header");
                if BuyFromContact.Get("Buy-from Contact No.") then;
                if PayToContact.Get("Pay-to Contact No.") then;

                DimSetEntry1.SetRange("Dimension Set ID", "Dimension Set ID");

                if not IsReportInPreviewMode() then
                    if ArchiveDocument then
                        ArchiveManagement.StorePurchDocument("Purchase Header", LogInteraction);

                TotalSubTotal := 0;
                // TotalInvDiscAmount := 0;
                TotalAmount := 0;
                TotalAmountVAT := 0;
                TotalAmountInclVAT := 0;
                // TotalPaymentDiscOnVAT := 0;
                A01TotalAmountInclVAT_LCY := 0;
                A01TotalAmount_LCY := 0;
                A01TotalVAT_LCY := 0;

                TotalAmount := 0;
                TotalSubTotal := 0;
                TotalInvoiceDiscountAmount := 0;
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

        trigger OnInit()
        begin
            // LogInteractionEnable := true;

            case PurchSetup."Archive Quotes" of
                PurchSetup."Archive Quotes"::Never:
                    ArchiveDocument := false;
                PurchSetup."Archive Quotes"::Always:
                    ArchiveDocument := true;
            end;
        end;

        trigger OnOpenPage()
        begin
            InitLogInteraction();
            // LogInteractionEnable := LogInteraction;
        end;
    }

    trigger OnInitReport()
    begin
        CompanyInfo.Get();
        CompanyInfo.CalcFields(Picture);
        PurchSetup.Get();

        OnAfterInitReport();
    end;

    trigger OnPostReport()
    begin
        if LogInteraction and not IsReportInPreviewMode() then
            if "Purchase Header".FindSet() then
                repeat
                    "Purchase Header".CalcFields("No. of Archived Versions");
                    SegManagement.LogDocument(
                      11, "Purchase Header"."No.", "Purchase Header"."Doc. No. Occurrence", "Purchase Header"."No. of Archived Versions",
                      DATABASE::Vendor, "Purchase Header"."Pay-to Vendor No.", "Purchase Header"."Purchaser Code", '',
                      "Purchase Header"."Posting Description", '');
                until "Purchase Header".Next() = 0;
    end;

    trigger OnPreReport()
    begin
        if not CurrReport.UseRequestPage then
            InitLogInteraction();
    end;


    var

        ShipmentMethod: Record "Shipment Method";
        SalesPurchPerson: Record "Salesperson/Purchaser";
        CompanyInfo: Record "Company Information";
        // TempPurchaseLine: Record "Purchase Line" temporary;
        DimSetEntry1: Record "Dimension Set Entry";
        // DimSetEntry2: Record "Dimension Set Entry";
        RespCenter: Record "Responsibility Center";
        PurchSetup: Record "Purchases & Payables Setup";
        BuyFromContact: Record Contact;
        ShipToAddrr: Record "Ship-to Address";
        PayToContact: Record Contact;
        CurrencyExchangeRate: Record "Currency Exchange Rate";
        AfkLocalCurrency: Record Currency;
        // Vendor: Record Vendor;
        TempPurchLine: Record "Purchase Line" temporary;
        TempVATAmountLine: Record "VAT Amount Line" temporary;
        // TempPrepaymentInvLineBuffer: Record "Prepayment Inv. Line Buffer";
        TempPrepmtVATAmountLine: Record "VAT Amount Line" temporary;
        TempPrePmtVATAmountLineDeduct: Record "VAT Amount Line" temporary;
        // CurrExchRate: Record "Currency Exchange Rate";
        AfkCurrency: Record Currency;
        PurchasePostPrepayments: Codeunit "Purchase-Post Prepayments";
        AutoFormat: Codeunit "Auto Format";
        LanguageMgt: Codeunit Language;
        PurchPost: Codeunit "Purch.-Post";
        FormatAddr: Codeunit "Format Address";
        FormatDocument: Codeunit "Format Document";
        SegManagement: Codeunit SegManagement;
        ArchiveManagement: Codeunit ArchiveManagement;
        VendAddr: array[8] of Text[100];
        ShipToAddr: array[8] of Text[100];
        CompanyAddr: array[8] of Text[100];
        PurchaserText: Text[50];
        A01VendorIdentity: Text[100];
        VATNoText: Text[80];
        FormattedVATPct: Text;
        FormattedLineAmount: Text;
        FormattedQuanitity: Text;
        FormattedDirectUnitCost: Text;
        TransHeaderAmount: Decimal;
        ReferenceText: Text[80];
        A01LinePU: Decimal;
        A01LineQty: Decimal;
        MoreLines: Boolean;
        VATAmount: Decimal;
        VATBaseAmount: Decimal;
        AfkIsLine: Integer;
        NumLigneText: Code[2];
        // TotalInvDiscAmount: Decimal;
        // TotalPaymentDiscOnVAT: Decimal;
        TotalAmountVAT: Decimal;
        VATDiscountAmount: Decimal;
        PrevLineAmount: Decimal;
        TotalAmountInclVAT: Decimal;
        // Number: Integer;
        TotalInclVATText: Text[50];
        TotalExclVATText: Text[50];
        TotalSubTotal: Decimal;
        TotalAmount: Decimal;
        TotalText: Text[50];
        TotalInvoiceDiscountAmount: Decimal;
        // VALVATBaseLCY: Decimal;
        // AfkLinesNumber: Integer;
        // VALVATAmountLCY: Decimal;
        // VALSpecLCYHeader: Text[80];
        // VALExchRate: Text[50];
        // PrepmtVATAmount: Decimal;
        // PrepmtVATBaseAmount: Decimal;
        // PrepmtTotalAmountInclVAT: Decimal;
        // PrepmtLineAmount: Decimal;
        LineDiscountPctText: Text;
        A01FormattedLineDiscountAmount: Text[50];
        A01FormattedAmtHT: Text[50];
        FormattedLineAmountTTC: Text;
        A01LineQtyFormatted: Text[50];
        A01TotalAmountInclVAT_LCY: Decimal;
        A01TotalAmount_LCY: Decimal;
        AfkCurrCode: Code[20];
        AfkCurrencyName: Text;
        AfkLocalCurrencyName: Text;
        TotalAmountExclInclVATTextValue: Text;
        TotalAmountExclInclVATValue: Decimal;
        NumLigne: Integer;
        A01TotalVAT_LCY: Decimal;
        A01LinePUFormatted: Text[50];
        A01FormattedVAT: Text[50];
        // AllowInvDisctxt: Text[30];
        // CompanyLogoPosition: Integer;
        ItemNo: Text;
        A01FormattedTotalVAT: Text[50];
        A01FormattedTotalHT: Text[50];
        A01FormattedTotalTTC: Text[50];
        A01TotalAmount_LCYText: Text[50];
        AfkLocalCurrencyText: Text[100];
        AfkLocalCurrencyCaption: Text[50];
        AfkTotalVAT_LCYCaption: Text[50];
        AfkTotalAmount_LCYCaption: Text[50];
        AfkTotalAmountInclVAT_LCYCaption: Text[50];
        A01TotalAmountInclVAT_LCYText: Text[50];
        A01TotalVAT_LCYText: Text[50];
        A01_AmountInWords: Text;
        // NoOfLoops: Integer;
        // CopyText: Text[30];
        // DimText: Text[120];
        // OldDimText: Text[75];
        // Continue: Boolean;
        // OutputNo: Integer;
        A01VendorPhone: Text[30];
        // A01VendorName: Text[100];
        A01VendorAddress: Text[100];
        // LogInteractionEnable: Boolean;
        // Text002: Label 'Purchase - Quote %1', Comment = '%1 = Document No.';
        ReportTitle__Caption: Label 'PROFORMA INVOICE';
        A01ProductCode__Caption: Label 'Product code';
        A01Description__Caption: Label 'Designation';
        A01Quantity__Caption: Label 'Quantity';
        A01UnitPrice__Caption: Label 'Unit price HT(AR)';
        A01DiscountPercent__Caption: Label 'Discount(AR)';
        A01DiscountAmount__Caption: Label 'Discounted price HT(AR)';
        A01DevisNo__Caption: Label 'Quote No :';
        A01DateOfPrint: Label 'Date of print :';
        A01VendorName__Caption: Label 'Vendor name :';
        A01VendorIdentity__Caption: Label 'Vendor identity :';
        A01VendorAddress__Caption: Label 'Vendor address :';
        A01NIF__Caption: Label 'NIF :';
        A01STAT__Caption: Label 'STAT :';
        A01RCS__Caption: Label 'RCS :';
        A01VendorPhone__Caption: Label 'Phone :';
        A01TotalHT__Caption: Label 'Total HT (AR) :';
        A01TVA__Caption: Label 'VAT(20%)(AR) :';
        A01TotalTTC__Caption: Label 'Total TTC(AR) :';
        // A01ArrestedSumLbl: Label 'Arrested at the sum of :';
        // ExpectedDateCaptionLbl: Label 'Expected Date';
        // QuoteNoCaptionLbl: Label 'Quote No.';
        // HeaderDimensionsCaptionLbl: Label 'Header Dimensions';
        // PurchaseLineNoOurNoCapLbl: Label 'Our No.';
        // LineDimensionsCaptionLbl: Label 'Line Dimensions';
        ShiptoAddressCaptionLbl: Label 'Ship-to Address';
        CompanyInfoPhoneNoCapLbl: Label 'Phone No.';
        CompanyInfoVATRegNoCapLbl: Label 'VAT Reg. No.';
        CompanyInfoGiroNoCapLbl: Label 'Giro No.';
        CompanyInfoBankNameCapLbl: Label 'Bank';
        CompInfoBankAccNoCapLbl: Label 'Account No.';
        DocumentDateCapLbl: Label 'Document Date';
        PageNoCaptionLbl: Label 'Page';
        ShipmentMethodDescCapLbl: Label 'Shipment Method';
        PurchLineVendItemNoCapLbl: Label 'Vendor Item No.';
        PurchaseLineDescCapLbl: Label 'Description';
        PurchaseLineQuantityCapLbl: Label 'Quantity';
        PurchaseLineUOMCaptionLbl: Label 'Unit of Measure';
        PurchaseLineNoCaptionLbl: Label 'Item No.';
        PurchaserTextCaptionLbl: Label 'Purchaser';
        ReferenceTextCaptionLbl: Label 'Your Reference';
        HomePageCaptionLbl: Label 'Home Page';
        EMailCaptionLbl: Label 'Email';
        VatRegistrationNoCaptionLbl: Label 'VAT Registration No.';
        BuyFromContactPhoneNoLbl: Label 'Buy-from Contact Phone No.';
        BuyFromContactMobilePhoneNoLbl: Label 'Buy-from Contact Mobile Phone No.';
        BuyFromContactEmailLbl: Label 'Buy-from Contact E-Mail';
        PayToContactPhoneNoLbl: Label 'Pay-to Contact Phone No.';
        PayToContactMobilePhoneNoLbl: Label 'Pay-to Contact Mobile Phone No.';
        PayToContactEmailLbl: Label 'Pay-to Contact E-Mail';

    protected var
        ArchiveDocument: Boolean;
        // ArchiveDocumentEnable: Boolean;
        LogInteraction: Boolean;
        NoOfCopies: Integer;
        ShowInternalInfo: Boolean;

    /// <summary>
    /// IsReportInPreviewMode.
    /// </summary>
    /// <returns>Return value of type Boolean.</returns>
    procedure IntializeRequest(NewNoOfCopies: Integer; NewShowInternalInfo: Boolean; NewArchiveDocument: Boolean; NewLogInteraction: Boolean)
    begin
        NoOfCopies := NewNoOfCopies;
        ShowInternalInfo := NewShowInternalInfo;
        ArchiveDocument := NewArchiveDocument;
        LogInteraction := NewLogInteraction;
    end;

    local procedure IsReportInPreviewMode(): Boolean
    var
        MailManagement: Codeunit "Mail Management";
    begin
        exit(CurrReport.Preview or MailManagement.IsHandlingGetEmailBody());
    end;

    local procedure InitLogInteraction()
    begin
        LogInteraction := SegManagement.FindInteractionTemplateCode(Enum::"Interaction Log Entry Document Type"::"Purch.Qte.") <> '';
    end;

    local procedure FormatAddressFields(PurchaseHeader: Record "Purchase Header")
    begin
        FormatAddr.GetCompanyAddr(PurchaseHeader."Responsibility Center", RespCenter, CompanyInfo, CompanyAddr);
        FormatAddr.PurchHeaderPayTo(VendAddr, PurchaseHeader);
        FormatAddr.PurchHeaderShipTo(ShipToAddr, PurchaseHeader);
    end;

    local procedure FormatDocumentFields(PurchaseHeader: Record "Purchase Header")
    begin
        // with PurchaseHeader do begin
        FormatDocument.SetPurchaser(SalesPurchPerson, PurchaseHeader."Purchaser Code", PurchaserText);
        FormatDocument.SetShipmentMethod(ShipmentMethod, PurchaseHeader."Shipment Method Code", PurchaseHeader."Language Code");
        ReferenceText := FormatDocument.SetText(PurchaseHeader."Your Reference" <> '', PurchaseHeader."Your Reference");
        VATNoText := FormatDocument.SetText(PurchaseHeader."VAT Registration No." <> '', PurchaseHeader."VAT Registration No.");
        // end;
    end;

    [IntegrationEvent(TRUE, false)]
    local procedure OnAfterInitReport()
    begin
    end;

    // [IntegrationEvent(TRUE, false)]
    // local procedure OnAfterPostDataItem(var PurchaseHeader: Record "Purchase Header")
    // begin
    // end;
}