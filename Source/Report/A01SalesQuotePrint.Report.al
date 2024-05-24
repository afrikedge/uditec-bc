/// <summary>
/// Report A01 SalesQuotePrint (ID 50001).
/// </summary>
report 50001 "A01 SalesQuotePrint"
{
    Caption = 'A01 Sales Quote Print';
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;
    DefaultLayout = RDLC;
    PreviewMode = PrintLayout;
    WordMergeDataItem = Header;
    RDLCLayout = './Source/Report/Layout/SalesQuotePrint.rdl';

    dataset
    {
        dataitem(Header; "Sales Header")
        {
            RequestFilterFields = "No.", "Sell-to Customer No.";
            DataItemTableView = sorting("Document Type", "No.") where("Document Type" = const(Quote));
            RequestFilterHeading = 'Pro Forma Invoice';
            column(CompanyInfo__Picture; CompanyInfo.Picture)
            {
            }
            column(CompanyName; COMPANYPROPERTY.DisplayName())
            {
            }
            column(CompanyAddress; CompanyInfo.Address)
            {
            }
            column(CompanyAddress2; CompanyInfo."Address 2")
            {
            }
            column(CompanyHomePage; CompanyInfo."Home Page")
            {
            }
            column(CompanyPhone; CompanyInfo."Phone No.")
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

            column(UnitName; UnitName)
            {
            }
            column(unitAddress; unitAddress)
            {
            }
            column(City; City)
            {
            }
            column(PostCode; PostCode)
            {
            }
            column(SellerName; SellerName)
            {
            }
            column(CustIdentity; CustIdentity)
            {
            }
            column(Sell_to_Address; "Sell-to Address")
            {
            }
            column(DocumentNo; "No.")
            {
            }
            column(PostingDate; "Posting Date")
            {
            }
            column(UnitName__Caption; UnitName__Caption)
            {
            }
            column(UnitAddress__Caption; UnitAddress__Caption)
            {
            }
            column(City__Caption; City__Caption)
            {
            }
            column(CustomerName; CustomerName)
            {
            }
            // column(CustomerAddress; "Ship-to Name")
            // {
            // }
            column(PostalCode__Caption; PostalCode__Caption)
            {
            }
            column(SellerName__Caption; SellerName__Caption)
            {
            }
            column(Report__Caption; Report__Caption)
            {
            }
            column(DevisNo__Caption; DevisNo__Caption)
            {
            }
            column(DateOfPrint; DateOfPrint)
            {
            }
            column(Quote_Valid_Until_Date; Format("Quote Valid Until Date"))
            {
            }
            column(AfkCurrCod; AfkCurrCod)
            {
            }
            column(CustomerName__Caption; CustomerName__Caption)
            {
            }
            column(CustomerIdentity__Caption; CustomerIdentity__Caption)
            {
            }
            column(CustomerAddress__Caption; CustomerAddress__Caption)
            {
            }
            column(CustomerPhone__Caption; CustomerPhone__Caption)
            {
            }
            column(NIF__Caption; NIF__Caption)
            {
            }
            column(STAT__Caption; STAT__Caption)
            {
            }
            column(RCS__Caption; RCS__Caption)
            {
            }
            column(Date; FORMAT(Today()))
            {
            }
            column(CustSignLbl; CustSignLbl)
            {
            }
            column(CompanySignLbl; CompanySignLbl)
            {
            }
            column(OffreLbl; OffreLbl)
            {
            }
            column(ArrestedSumLbl; ArrestedSumLbl)
            {
            }
            column(ProformaLbl; ProformaLbl)
            {
            }
            column(Document_No__Caption; Document_No__Caption)
            {
            }
            column(Description__Caption; Description__Caption)
            {
            }
            column(Quantity__Caption; Quantity__Caption)
            {
            }
            column(UnitPrice__Caption; UnitPrice__Caption)
            {
            }
            column(DiscountPercent__Caption; DiscountPercent__Caption)
            {
            }
            column(DiscountAmount__Caption; DiscountAmount__Caption)
            {
            }
            column(Sell_to_Customer_No_; "Sell-to Customer No.")
            {
            }
            column(Sell_to_Customer_Name; "Sell-to Customer Name")
            {
            }
            column(CustomerAddress; CustomerAddress)
            {
            }
            column(CustomerPhone; CustomerPhone)
            {
            }
            dataitem(Line; "Sales Line")
            {
                DataItemTableView = sorting("Document No.", "Line No.");
                DataItemLinkReference = Header;
                DataItemLink = "Document No." = field("No.");
                UseTemporary = true;
                column(LineNo_Line; "Line No.")
                {
                }
                column(ItemNo_Line; "No.")
                {
                }
                column(Document_No_; "Document No.")
                {
                }
                column(AfkIsLine; AfkIsLine)
                {
                }
                column(AfkNumLigne; NumLigneText)
                {
                }
                column(ShipmentDate_Line; Format("Shipment Date"))
                {
                }
                column(A01Description_Line; Description)
                {
                }
                column(AmountExcludingVAT_Line; Amount)
                {
                    AutoFormatExpression = "Currency Code";
                    AutoFormatType = 1;
                }
                column(AmountIncludingVAT_Line; "Amount Including VAT")
                {
                    AutoFormatExpression = "Currency Code";
                    AutoFormatType = 1;
                }
                column(AmountIncludingVAT_Line_Lbl; FieldCaption("Amount Including VAT"))
                {
                    AutoFormatExpression = "Currency Code";
                    AutoFormatType = 1;
                }
                column(A01LineDiscountPercent_Line; "Line Discount %")
                {
                }
                column(LineDiscountPercentText_Line; LineDiscountPctText)
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
                    AutoFormatExpression = "Currency Code";
                    AutoFormatType = 1;
                }
                column(A01LineQty; A01LineQtyFormatted)
                {
                }
                column(Type_Line; Format(Type))
                {
                }
                column(A01LinePU; A01LinePUFormatted)
                {
                    AutoFormatExpression = "Currency Code";
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
                column(UnitOfMeasure; "Unit of Measure")
                {
                }
                column(VATIdentifier_Line; "VAT Identifier")
                {
                }
                column(VATPct_Line; FormattedVATPct)
                {
                }
                column(AfkTotalAmountInclVAT_LCY; AfkTotalAmountInclVAT_LCY)
                {
                }
                column(AfkTotalAmount_LCY; AfkTotalAmount_LCY)
                {
                }
                column(AfkTotalVAT_LCY; AfkTotalVAT_LCY)
                {
                }
                column(TransHeaderAmount; TransHeaderAmount)
                {
                    AutoFormatExpression = "Currency Code";
                    AutoFormatType = 1;
                }
                column(Unit_Lbl; UnitLbl)
                {
                }
                column(Qty_Lbl; QtyLbl)
                {
                }
                column(Price_Lbl; PriceLbl)
                {
                }
                column(PricePer_Lbl; PricePerLbl)
                {
                }
                column(TotalHT__Caption; TotalHT__Caption)
                {
                }
                column(TVA__Caption; TVA__Caption)
                {
                }
                column(TotalTTC__Caption; TotalTTC__Caption)
                {
                }
                column(A01DiscountedPrice; A01DiscountedPriceText)
                {
                    AutoFormatExpression = Header."Currency Code";
                    AutoFormatType = 2;
                }

                // Line
                trigger OnAfterGetRecord()
                var
                    tempHT: Decimal;
                    // tempHTD: Decimal;
                    tempPU: Decimal;
                    tempTTC: Decimal;
                    tempVAT: Decimal;
                begin
                    AfkIsLine := 1;
                    NumLigne := NumLigne + 1;
                    if (NumLigne < 10) then
                        NumLigneText := '0' + Format(NumLigne)
                    else
                        NumLigneText := Format(NumLigne);
                    if Line.Type = Line.Type::" " then begin
                        A01FormattedVAT := '';
                        A01FormattedAmtHT := '';
                        A01FormattedLineDiscountAmount := '';

                        A01LineQtyFormatted := '';
                        A01LinePUFormatted := '';
                    end else begin
                        if (Header."Prices Including VAT") then begin
                            tempHT := Line."Line Amount" * (1 / (1 + Line."VAT %" / 100));
                            // tempHTD := Line."Line Amount" * (1 / (1 + Line."Line Discount %" / 100));
                            tempPU := Line."Unit Price" * (1 / (1 + Line."VAT %" / 100));
                            tempVAT := line."Amount Including VAT" - tempHT;
                            tempTTC := line."Amount Including VAT";

                        end else begin
                            tempHT := Line."Line Amount";
                            // tempHTD := Line."Line Discount Amount";
                            tempPU := Line."Unit Price";
                            tempVAT := tempHT * Line."VAT %" / 100;
                            tempTTC := tempVAT + Line."Line Amount";
                        end;
                        A01FormattedVAT := Format(Round(tempVAT, 0.001, '<'));
                        A01FormattedAmtHT := Format(Round(Line.Quantity * tempPU, 0.001, '<'));
                        A01FormattedLineDiscountAmount := Format(Round((Line.Quantity * tempPU) * (Line."Line Discount %" / 100), 0.001, '<'));
                        FormattedLineAmountTTC := Format(Round(tempTTC, 0.001, '<'));
                    end;
                    A01LineQty := Line.Quantity;
                    A01LinePU := Round(tempPU, 0.000001, '<');
                    A01DiscountedPrice := Round((Line.Quantity * tempPU) - Line."Line Discount Amount", 0.001, '<');

                    A01LineQtyFormatted := Format(A01LineQty);
                    A01LinePUFormatted := Format(A01LinePU);
                    A01DiscountedPriceText := Format(A01DiscountedPrice);

                    // InitializeShipmentLine();
                    // if Type = Type::"G/L Account" then
                    // "No." := '';
                    // CurrReport.Skip();

                    if "No." = 'MIR_FEES' then
                        CurrReport.Skip();
                    if "No." = 'mir_fees' then
                        CurrReport.Skip();
                    if "No." = 'MIR_INTEREST' then
                        CurrReport.Skip();
                    if "No." = 'mir_interest' then
                        CurrReport.Skip();
                    if "No." = 'AGP_FEES' then
                        CurrReport.Skip();
                    if "No." = 'agp_fees' then
                        CurrReport.Skip();

                    OnBeforeLineOnAfterGetRecord(Header, Line);

                    // if "Line Discount %" = 0 then
                    //     LineDiscountPctText := ''
                    // else
                    LineDiscountPctText := StrSubstNo('%1%', Round("Line Discount %", 0.1));

                    VATAmountLine.Init();
                    VATAmountLine."VAT Identifier" := "VAT Identifier";
                    VATAmountLine."VAT Calculation Type" := "VAT Calculation Type";
                    VATAmountLine."Tax Group Code" := "Tax Group Code";
                    VATAmountLine."VAT %" := "VAT %";
                    VATAmountLine."VAT Base" := Amount;
                    VATAmountLine."Amount Including VAT" := "Amount Including VAT";
                    VATAmountLine."Line Amount" := "Line Amount";
                    if "Allow Invoice Disc." then
                        VATAmountLine."Inv. Disc. Base Amount" := "Line Amount";
                    VATAmountLine."Invoice Discount Amount" := "Inv. Discount Amount";
                    VATAmountLine."VAT Clause Code" := "VAT Clause Code";
                    VATAmountLine.InsertLine();

                    if (Header."Prices Including VAT") then begin
                        TransHeaderAmount += PrevLineAmount;
                        PrevLineAmount := tempHT;
                        TotalSubTotal += tempHT;
                        TotalInvDiscAmount -= "Inv. Discount Amount";
                        TotalAmount += tempHT;
                        TotalAmountVAT += "Amount Including VAT" - tempHT;
                        TotalAmountInclVAT += "Amount Including VAT";
                        TotalPaymentDiscOnVAT += -(tempHT - "Inv. Discount Amount" - "Amount Including VAT");

                    end else begin
                        TransHeaderAmount += PrevLineAmount;
                        PrevLineAmount := "Line Amount";
                        TotalSubTotal += "Line Amount";
                        TotalInvDiscAmount -= "Inv. Discount Amount";
                        TotalAmount += Amount;
                        TotalAmountVAT += "Amount Including VAT" - Amount;
                        TotalAmountInclVAT += "Amount Including VAT";
                        TotalPaymentDiscOnVAT += -("Line Amount" - "Inv. Discount Amount" - "Amount Including VAT");
                    end;

                    if FirstLineHasBeenOutput then
                        Clear(DummyCompanyInfo.Picture);
                    FirstLineHasBeenOutput := true;

                    FormatDocument.SetSalesLine(Line, FormattedQuantity, FormattedUnitPrice, FormattedVATPct, FormattedLineAmount);
                    // FormatLineValues(Line);
                end;

                trigger OnPreDataItem()
                begin
                    VATAmountLine.DeleteAll();
                    SetRange(Type, Type::Item);
                    MoreLines := Find('+');
                    while MoreLines and (Description = '') and ("No." = '') and (Quantity = 0) and (Amount = 0) do
                        MoreLines := Next(-1) <> 0;
                    if not MoreLines then
                        CurrReport.Break();
                    SetRange("Line No.", 0, "Line No.");
                    TransHeaderAmount := 0;
                    PrevLineAmount := 0;
                    // AfkLinesNumber := Count();
                    FirstLineHasBeenOutput := false;
                    DummyCompanyInfo.Picture := CompanyInfo.Picture;

                    OnAfterLineOnPreDataItem(Header, Line);
                end;
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
            dataitem(WorkDescriptionLines; "Integer")
            {
                DataItemTableView = sorting(Number) where(Number = filter(1 .. 99999));
                column(WorkDescriptionLineNumber; Number)
                {
                }
                column(WorkDescriptionLine; WorkDescriptionLine)
                {
                }

                trigger OnAfterGetRecord()
                begin
                    if WorkDescriptionInstream.EOS then
                        CurrReport.Break();
                    WorkDescriptionInstream.ReadText(WorkDescriptionLine);
                end;

                trigger OnPostDataItem()
                begin
                    Clear(WorkDescriptionInstream)
                end;

                trigger OnPreDataItem()
                begin
                    if not ShowWorkDescription then
                        CurrReport.Break();

                    Header."Work Description".CreateInStream(WorkDescriptionInstream, TEXTENCODING::UTF8);
                end;
            }
            dataitem(VATAmountLine; "VAT Amount Line")
            {
                DataItemTableView = sorting("VAT Identifier", "VAT Calculation Type", "Tax Group Code", "Use Tax", Positive);
                UseTemporary = true;
                column(InvoiceDiscountAmount_VATAmountLine; "Invoice Discount Amount")
                {
                    AutoFormatExpression = Header."Currency Code";
                    AutoFormatType = 1;
                }
                column(InvoiceDiscountAmount_VATAmountLine_Lbl; FieldCaption("Invoice Discount Amount"))
                {
                }
                column(InvoiceDiscountBaseAmount_VATAmountLine; "Inv. Disc. Base Amount")
                {
                    AutoFormatExpression = Header."Currency Code";
                    AutoFormatType = 1;
                }
                column(InvoiceDiscountBaseAmount_VATAmountLine_Lbl; FieldCaption("Inv. Disc. Base Amount"))
                {
                }
                column(LineAmount_VatAmountLine; "Line Amount")
                {
                    AutoFormatExpression = Header."Currency Code";
                    AutoFormatType = 1;
                }
                column(LineAmount_VatAmountLine_Lbl; FieldCaption("Line Amount"))
                {
                }
                column(VATAmount_VatAmountLine; "VAT Amount")
                {
                    AutoFormatExpression = Header."Currency Code";
                    AutoFormatType = 1;
                }
                column(VATAmount_VatAmountLine_Lbl; FieldCaption("VAT Amount"))
                {
                }
                column(VATAmountLCY_VATAmountLine; VATAmountLCY)
                {
                }
                column(VATAmountLCY_VATAmountLine_Lbl; VATAmountLCYLbl)
                {
                }
                column(VATBase_VatAmountLine; "VAT Base")
                {
                    AutoFormatExpression = Header."Currency Code";
                    AutoFormatType = 1;
                }
                column(VATBase_VatAmountLine_Lbl; FieldCaption("VAT Base"))
                {
                }
                column(VATBaseLCY_VATAmountLine; VATBaseLCY)
                {
                }
                column(VATBaseLCY_VATAmountLine_Lbl; VATBaseLCYLbl)
                {
                }
                column(VATIdentifier_VatAmountLine; "VAT Identifier")
                {
                }
                column(VATIdentifier_VatAmountLine_Lbl; FieldCaption("VAT Identifier"))
                {
                }
                column(VATPct_VatAmountLine; "VAT %")
                {
                    DecimalPlaces = 0 : 5;
                }
                column(VATPct_VatAmountLine_Lbl; FieldCaption("VAT %"))
                {
                }
                column(NoOfVATIdentifiers; Count)
                {
                }

                trigger OnAfterGetRecord()
                begin
                    VATBaseLCY :=
                      GetBaseLCY(
                        Header."Posting Date", Header."Currency Code",
                        Header."Currency Factor");
                    VATAmountLCY :=
                      GetAmountLCY(
                        Header."Posting Date", Header."Currency Code",
                        Header."Currency Factor");
                    TotalVATBaseLCY += VATBaseLCY;
                    TotalVATAmountLCY += VATAmountLCY;
                end;

                trigger OnPreDataItem()
                begin
                    Clear(VATBaseLCY);
                    Clear(VATAmountLCY);

                    TotalVATBaseLCY := 0;
                    TotalVATAmountLCY := 0;
                end;
            }
            dataitem(ReportTotalsLine; "Report Totals Buffer")
            {
                DataItemTableView = SORTING("Line No.");
                UseTemporary = true;
                column(Description_ReportTotalsLine; Description)
                {
                }
                column(Amount_ReportTotalsLine; Amount)
                {
                    AutoFormatExpression = Header."Currency Code";
                    AutoFormatType = 1;
                }
                column(AmountFormatted_ReportTotalsLine; "Amount Formatted")
                {
                    AutoFormatExpression = Header."Currency Code";
                    AutoFormatType = 1;
                }
                column(FontBold_ReportTotalsLine; "Font Bold")
                {
                }
                column(FontUnderline_ReportTotalsLine; "Font Underline")
                {
                }
                trigger OnPreDataItem()
                begin
                    CreateReportTotalLines();
                end;
            }
            dataitem(LetterText; "Integer")
            {
                DataItemTableView = sorting(Number) where(Number = const(1));
                column(GreetingText; GreetingLbl)
                {
                }
                column(BodyText; BodyLbl)
                {
                }
                column(ClosingText; ClosingLbl)
                {
                }
                column(PmtDiscText; PmtDiscText)
                {
                }

                trigger OnPreDataItem()
                begin
                    PmtDiscText := '';
                    if Header."Payment Discount %" <> 0 then
                        PmtDiscText := StrSubstNo(PmtDiscTxt, Header."Pmt. Discount Date", Header."Payment Discount %");
                end;
            }
            dataitem(Totals; "Integer")
            {
                DataItemTableView = sorting(Number) where(Number = const(1));
                column(TotalNetAmount; TotalAmount)
                {
                    AutoFormatExpression = Header."Currency Code";
                    AutoFormatType = 1;
                }
                column(TotalVATBaseLCY; TotalVATBaseLCY)
                {
                }
                column(TotalAmountIncludingVAT; Format(TotalAmountInclVAT, 0, AutoFormat.ResolveAutoFormat(Enum::"Auto Format"::AmountFormat, Header."Currency Code")))
                {
                    AutoFormatExpression = Header."Currency Code";
                    AutoFormatType = 1;
                }
                column(TotalVATAmount; TotalAmountVAT)
                {
                    AutoFormatExpression = Header."Currency Code";
                    AutoFormatType = 1;
                }
                column(TotalVATAmountLCY; TotalVATAmountLCY)
                {
                }
                column(TotalInvoiceDiscountAmount; TotalInvDiscAmount)
                {
                    AutoFormatExpression = Header."Currency Code";
                    AutoFormatType = 1;
                }
                column(TotalPaymentDiscountOnVAT; TotalPaymentDiscOnVAT)
                {
                }
                column(TotalVATAmountText; VATAmountLine.VATAmountText())
                {
                }
                column(TotalExcludingVATText; TotalExclVATText)
                {
                }
                column(TotalIncludingVATText; TotalInclVATText)
                {
                }
                column(TotalSubTotal; TotalSubTotal)
                {
                    AutoFormatExpression = Header."Currency Code";
                    AutoFormatType = 1;
                }
                column(TotalSubTotalMinusInvoiceDiscount; TotalSubTotal + TotalInvDiscAmount)
                {
                }
                column(TotalText; TotalText)
                {
                }
                column(CurrencyCode; CurrCode)
                {
                }
                column(CurrencySymbol; CurrSymbol)
                {
                }
                column(AfkFormattedTotalVAT; AfkFormattedTotalVAT)
                {
                }
                column(AfkFormattedTotalHT; AfkFormattedTotalHT)
                {
                }
                column(AfkFormattedTotalTTC; AfkFormattedTotalTTC)
                {
                }
                column(AfkTotalAmount_LCYText; AfkTotalAmount_LCYText)
                {
                }
                column(Afk_AmountInWords; Afk_AmountInWords)
                {
                }
                column(AfkTotalAmountInclVAT_LCYText; AfkTotalAmountInclVAT_LCYText)
                {
                }
                column(AfkTotalVAT_LCYText; AfkTotalVAT_LCYText)
                {
                }
                column(AfkLocalCurrencyText; AfkLocalCurrencyText)
                {
                }
                trigger OnPreDataItem()
                begin
                    TotalAmountExclInclVATTextValue := TotalInclVATText;
                    TotalAmountExclInclVATValue := TotalAmountInclVAT;

                    AfkFormattedTotalVAT :=
                        Format(TotalAmountVAT, 0,
                        AutoFormat.ResolveAutoFormat("Auto Format"::AmountFormat, Header."Currency Code"));
                    AfkFormattedTotalHT :=
                        Format(TotalAmount, 0,
                        AutoFormat.ResolveAutoFormat("Auto Format"::AmountFormat, Header."Currency Code"));
                    AfkFormattedTotalTTC :=
                        Format(TotalAmountExclInclVATValue, 0,
                        AutoFormat.ResolveAutoFormat("Auto Format"::AmountFormat, Header."Currency Code"));

                    AfkTotalAmountInclVAT_LCY := CurrencyExchangeRate.ExchangeAmtFCYToLCY(Header."Posting Date",
                        Header."Currency Code", TotalAmountExclInclVATValue, Header."Currency Factor");
                    AfkTotalAmount_LCY := CurrencyExchangeRate.ExchangeAmtFCYToLCY(Header."Posting Date",
                        Header."Currency Code", TotalAmount, Header."Currency Factor");
                    AfkTotalVAT_LCY := CurrencyExchangeRate.ExchangeAmtFCYToLCY(Header."Posting Date",
                        Header."Currency Code", TotalAmountVAT, Header."Currency Factor");

                    AfkTotalAmountInclVAT_LCY := ROUND(AfkTotalAmountInclVAT_LCY, AfkLocalCurrency."Amount Rounding Precision");
                    AfkTotalAmount_LCY := ROUND(AfkTotalAmount_LCY, AfkLocalCurrency."Amount Rounding Precision");
                    AfkTotalVAT_LCY := ROUND(AfkTotalVAT_LCY, AfkLocalCurrency."Amount Rounding Precision");

                    AfkTotalAmountInclVAT_LCYText :=
                           Format(AfkTotalAmountInclVAT_LCY, 0,
                           AutoFormat.ResolveAutoFormat("Auto Format"::AmountFormat, AfkLocalCurrency.Code));
                    AfkTotalAmountInclVAT_LCYText := Format(AfkTotalAmountInclVAT_LCY);

                    AfkTotalAmount_LCYText :=
                        Format(AfkTotalAmount_LCY, 0,
                        AutoFormat.ResolveAutoFormat("Auto Format"::AmountFormat, AfkLocalCurrency.Code));
                    AfkTotalAmount_LCYText := Format(AfkTotalAmount_LCY);

                    AfkTotalVAT_LCYText :=
                        Format(AfkTotalVAT_LCY, 0,
                        AutoFormat.ResolveAutoFormat("Auto Format"::AmountFormat, AfkLocalCurrency.Code));
                    AfkTotalVAT_LCYText := Format(AfkTotalVAT_LCY);

                    RepCheck.InitTextVariable();
                    RepCheck.FormatNoText(NoText, AfkTotalAmountInclVAT_LCY, AfkLocalCurrency.Code);

                    NoText[1] := ReplaceString(NoText[1], '****');
                    NoText[1] := ReplaceString(NoText[1], 'AND 0/100');
                    NoText[2] := ReplaceString(NoText[2], '****');
                    NoText[2] := ReplaceString(NoText[2], 'AND 0/100');
                    Afk_AmountInWords := NoText[1] + ' ' + NoText[2];

                end;

            }
            trigger OnAfterGetRecord()
            var
                CurrencyExchangeRate: Record "Currency Exchange Rate";
                SalesPost: Codeunit "Sales-Post";
            begin
                GLSetup.Get();
                GLSetup.TestField("LCY Code");

                FirstLineHasBeenOutput := false;
                Clear(Line);
                Clear(SalesPost);
                VATAmountLine.DeleteAll();
                Line.DeleteAll();
                SalesPost.GetSalesLines(Header, Line, 0);
                OnBeforeCalcVATAmountLines(Header, Line);
                Line.CalcVATAmountLines(0, Header, Line, VATAmountLine);
                Line.UpdateVATOnLines(0, Header, Line, VATAmountLine);
                OnLineOnAfterGetRecordOnAfterUpdateVATOnLines(Header, Line);

                if not Cust.Get("Sell-to Customer No.") then
                    Clear(Cust);

                AfkCurrCod := GLSetup."Local Currency Symbol";
                AfkCurrCode := Header."Currency Code";
                if (AfkCurrCode = '') then
                    AfkCurrCode := GLSetup."LCY Code";

                AfkCurrencyName := AfkCurrCode;
                if AfkCurrency.Get(AfkCurrCode) then
                    AfkCurrencyName := AfkCurrency.Description;

                if (AfkLocalCurrency.Get(GLSetup."LCY Code") and (AfkCurrCode <> GLSetup."LCY Code")) then
                    AfkLocalCurrencyName := AfkLocalCurrency.Description;

                NumLigne := 0;

                if ResponsibilityInfo.Get(Header."Responsibility Center") then begin
                    UnitName := ResponsibilityInfo.Name;
                    City := ResponsibilityInfo.City;
                    unitAddress := ResponsibilityInfo.Address;
                    PostCode := ResponsibilityInfo."Post Code";
                end;

                if SalesPersonInfo.Get(Header."Salesperson Code") then
                    SellerName := SalesPersonInfo.Name;

                if Cust.Get(Header."Sell-to Customer No.") then
                    if Cust."A01 Customer Type" = Cust."A01 Customer Type"::Miscellaneous then begin
                        if ContactInfo.Get(Header."A01 Miscellaneous Contact") then begin
                            CustomerPhone := ContactInfo."Phone No.";
                            rcs := ContactInfo."A01 RCS";
                            stat := ContactInfo."A01 STAT";
                            nif := ContactInfo."A01 NIF";
                            CustomerAddress := ContactInfo.Address;
                        end;
                    end else begin
                        if Cust.Get(Header."Sell-to Customer No.") then begin
                            CustomerPhone := Cust."Phone No.";
                            rcs := Cust."A01 RCS";
                            stat := Cust."A01 STAT";
                            nif := Cust."A01 NIF";
                            CustomerAddress := Cust.Address;
                        end;
                    end;

                if not IsReportInPreviewMode() then
                    CODEUNIT.Run(CODEUNIT::"Sales-Printed", Header);

                OnHeaderOnAfterGetRecordOnAfterUpdateNoPrinted(IsReportInPreviewMode(), Header);

                SetFormatRegion("Format Region");
                SetLanguage("Language Code");
                FormatAddr.SetLanguageCode("Language Code");

                // CalcFields("Work Description");
                // ShowWorkDescription := "Work Description".HasValue;

                FormatAddr.GetCompanyAddr("Responsibility Center", RespCenter, CompanyInfo, CompanyAddr);
                FormatAddr.SalesHeaderBillTo(CustAddr, Header);
                // ShowShippingAddr := FormatAddr.SalesHeaderShipTo(ShipToAddr, CustAddr, Header);

                FormatDocumentFields(Header);
                if SellToContact.Get("Sell-to Contact No.") then;
                if BillToContact.Get("Bill-to Contact No.") then;

                if not CompanyBankAccount.Get(Header."Company Bank Account Code") then
                    CompanyBankAccount.CopyBankFieldsFromCompanyInfo(CompanyInfo);

                if not Cust.Get("Bill-to Customer No.") then
                    Clear(Cust);

                if "Currency Code" <> '' then begin
                    CurrencyExchangeRate.FindCurrency("Posting Date", "Currency Code", 1);
                    CalculatedExchRate :=
                      Round(1 / "Currency Factor" * CurrencyExchangeRate."Exchange Rate Amount", 0.000001);
                    ExchangeRateText := StrSubstNo(ExchangeRateTxt, CalculatedExchRate, CurrencyExchangeRate."Exchange Rate Amount");
                end;

                // if Rec.Status = Rec.Status::Open then
                //     if ApprovalsMgmt.PrePostApprovalCheckSales(Rec) then begin
                //         Message(Msg);
                //         // Codeunit.Run(Codeunit::"Sales-Quote to Order (Yes/No)", Rec);
                //         CurrReport.Quit();
                //     end;

                TotalSubTotal := 0;
                TotalInvDiscAmount := 0;
                TotalAmount := 0;
                TotalAmountVAT := 0;
                TotalAmountInclVAT := 0;
                AfkTotalAmountInclVAT_LCY := 0;
                AfkTotalAmount_LCY := 0;
                AfkTotalVAT_LCY := 0;
            end;

            trigger OnPreDataItem()
            begin
                FirstLineHasBeenOutput := false;
            end;
        }
    }

    requestpage
    {
        SaveValues = true;

        layout
        {
            area(content)
            {
                group(Options)
                {
                    //         Caption = 'Options';
                    //         field(LogInteraction; LogInteraction)
                    //         {
                    //             ApplicationArea = Basic, Suite;
                    //             Caption = 'Log Interaction';
                    //             Enabled = LogInteractionEnable;
                    //             ToolTip = 'Specifies that interactions with the contact are logged.';
                    //         }
                    //         field(ArchiveDocument; ArchiveDocument)
                    //         {
                    //             ApplicationArea = Basic, Suite;
                    //             Caption = 'Archive Document';
                    //             ToolTip = 'Specifies if the document is archived after you preview or print it.';

                    //             trigger OnValidate()
                    //             begin
                    //                 if not ArchiveDocument then
                    //                     LogInteraction := false;
                    //             end;
                    //         }
                }
            }
        }

        actions
        {
        }

        trigger OnInit()
        begin
            // LogInteractionEnable := true;
            // ArchiveDocument := SalesSetup."Archive Quotes" <> SalesSetup."Archive Quotes"::Never;
        end;

        trigger OnOpenPage()
        begin
            InitLogInteraction();
            // LogInteractionEnable := LogInteraction;
        end;
    }

    trigger OnInitReport()
    begin
        GLSetup.Get();
        CompanyInfo.SetAutoCalcFields(Picture);
        CompanyInfo.Get();
        SalesSetup.Get();
        CompanyInfo.VerifyAndSetPaymentInfo();
    end;

    trigger OnPostReport()
    begin
        if LogInteraction and not IsReportInPreviewMode() then
            if Header.FindSet() then
                repeat
                    Header.CalcFields("No. of Archived Versions");
                    if Header."Bill-to Contact No." <> '' then
                        SegManagement.LogDocument(
                          1, Header."No.", Header."Doc. No. Occurrence",
                          Header."No. of Archived Versions", Database::Contact, Header."Bill-to Contact No.",
                          Header."Salesperson Code", Header."Campaign No.", Header."Posting Description", Header."Opportunity No.")
                    else
                        SegManagement.LogDocument(
                          1, Header."No.", Header."Doc. No. Occurrence",
                          Header."No. of Archived Versions", Database::Customer, Header."Bill-to Customer No.",
                          Header."Salesperson Code", Header."Campaign No.", Header."Posting Description", Header."Opportunity No.");
                until Header.Next() = 0;
    end;

    trigger OnPreReport()
    begin
        CompanyInfo.Get();
        CompanyInfo.CalcFields(Picture);

        if Header.GetFilters = '' then
            Error(NoFilterSetErr);

        if not CurrReport.UseRequestPage then
            InitLogInteraction();

        // CompanyLogoPosition := SalesSetup."Logo Position on Documents";
    end;


    var
        CompanyInfo: Record "Company Information";
        SalesPersonInfo: Record "Salesperson/Purchaser";
        ContactInfo: Record Contact;
        AfkLocalCurrency: Record Currency;
        CurrencyExchangeRate: Record "Currency Exchange Rate";
        ResponsibilityInfo: Record "Responsibility Center";
        AfkCurrency: Record Currency;
        Cust: Record Customer;
        GLSetup: Record "General Ledger Setup";
        SalesSetup: Record "Sales & Receivables Setup";
        RespCenter: Record "Responsibility Center";
        SellToContact: Record Contact;
        // ShipToAddr: Record "Ship-to Address";
        BillToContact: Record Contact;
        CompanyBankAccount: Record "Bank Account";
        DummyCompanyInfo: Record "Company Information";
        ShipmentMethod: Record "Shipment Method";
        PaymentTerms: Record "Payment Terms";
        PaymentMethod: Record "Payment Method";
        SalespersonPurchaser: Record "Salesperson/Purchaser";
        // TempLineFeeNoteOnReportHist: Record "Line Fee Note on Report Hist.";
        // SalesLineRec: Record "Sales Line";
        // Currency: Record Currency;
        // VATClause: Record "VAT Clause";
        // Langauge: Codeunit Language;
        RepCheck: Report Check;
        LanguageMgt: Codeunit Language;
        FormatAddr: Codeunit "Format Address";
        FormatDocument: Codeunit "Format Document";
        SegManagement: Codeunit SegManagement;
        AutoFormat: Codeunit "Auto Format";
        WorkDescriptionInstream: InStream;
        AfkCurrCode: Code[20];
        NumLigneText: Code[2];
        PostCode: Code[20];
        City: Code[30];
        AfkLocalCurrencyName: Text;
        AfkCurrencyName: Text;
        NoText: array[2] of Text;
        A01FormattedAmtHT: Text[50];
        TotalAmountExclInclVATTextValue: Text;
        AfkFormattedTotalVAT: Text[50];
        AfkFormattedTotalHT: Text[50];
        AfkFormattedTotalTTC: Text[50];
        AfkTotalAmount_LCYText: Text[50];
        Afk_AmountInWords: Text;
        AfkTotalAmountInclVAT_LCYText: Text[50];
        AfkTotalVAT_LCYText: Text[50];
        AfkLocalCurrencyText: Text[100];
        FormattedLineAmountTTC: Text;
        A01LineQtyFormatted: Text[50];
        A01LinePUFormatted: Text[50];
        A01FormattedVAT: Text[50];
        UnitName: Text[100];
        rcs: Code[30];
        nif: Code[30];
        stat: Code[30];
        A01FormattedLineDiscountAmount: Text[50];
        CustomerPhone: Text[30];
        CustomerName: Text[100];
        CustomerAddress: Text[100];
        SellerName: Text[50];
        WorkDescriptionLine: Text;
        ExchangeRateText: Text;
        PmtDiscText: Text;
        LCYTxt: label ' (LCY)';
        LegalOfficeTxt, LegalOfficeLbl, CustomGiroTxt, CustomGiroLbl, LegalStatementLbl : Text;
        CustAddr: array[8] of Text[100];
        // ShipToAddr: array[8] of Text[100];
        CompanyAddr: array[8] of Text[100];
        CurrCode: Text[10];
        CurrSymbol: Text[10];
        CustIdentity: Text[100];
        unitAddress: Text[100];
        TotalText: Text[50];
        TotalExclVATText: Text[50];
        TotalInclVATText: Text[50];
        SalesPersonText: Text[50];
        LineDiscountPctText: Text;
        FormattedVATPct: Text;
        FormattedUnitPrice: Text;
        FormattedQuantity: Text;
        FormattedLineAmount: Text;
        // CopyText: Text[30];
        // VATClausesText: Text;
        // AfkTotalAmount_LCYCaption: Text[50];
        TotalAmountExclInclVATValue: Decimal;
        AfkTotalAmountInclVAT_LCY: Decimal;
        AfkTotalAmount_LCY: Decimal;
        A01DiscountedPrice: Decimal;
        A01DiscountedPriceText: Text[50];
        AfkTotalVAT_LCY: Decimal;
        CalculatedExchRate: Decimal;
        PrevLineAmount: Decimal;
        TotalSubTotal: Decimal;
        A01LineQty: Decimal;
        A01LinePU: Decimal;
        TotalAmount: Decimal;
        TotalAmountInclVAT: Decimal;
        TotalAmountVAT: Decimal;
        TotalInvDiscAmount: Decimal;
        TotalPaymentDiscOnVAT: Decimal;
        TransHeaderAmount: Decimal;
        VATBaseLCY: Decimal;
        VATAmountLCY: Decimal;
        TotalVATAmountLCY: Decimal;
        TotalVATBaseLCY: Decimal;
        NumLigne: Integer;
        AfkCurrCod: Code[20];
        AfkIsLine: Integer;
        // AfkLinesNumber: Integer;
        // CompanyLogoPosition: Integer;
        MoreLines: Boolean;
        ShowWorkDescription: Boolean;
        // ShowShippingAddr: Boolean;
        // LogInteractionEnable: Boolean;
        // ArchiveDocument: Boolean;
        LogInteraction: Boolean;
        FirstLineHasBeenOutput: Boolean;
        // DisplayAdditionalFeeNote: Boolean;
        // DisplayShipmentInformation: Boolean;
        // DisplayAssemblyInformation: Boolean;
        Report__Caption: Label 'PROFORMA INVOICE';
        UnitName__Caption: Label 'Unit name :';
        UnitAddress__Caption: Label 'Unit address :';
        City__Caption: Label 'City';
        PostalCode__Caption: Label 'Postal code :';
        SellerName__Caption: Label 'Seller name :';
        Document_No__Caption: Label 'Product code';
        Description__Caption: Label 'Designation';
        Quantity__Caption: Label 'Quantity';
        UnitPrice__Caption: Label 'Unit price HT';
        DiscountPercent__Caption: Label 'Discount';
        DiscountAmount__Caption: Label 'Discounted price HT';
        DevisNo__Caption: Label 'Reference :';
        DateOfPrint: Label 'Date of print :';
        CustomerName__Caption: Label 'Customer name :';
        CustomerIdentity__Caption: Label 'Customer identity :';
        CustomerAddress__Caption: Label 'Customer address :';
        NIF__Caption: Label 'NIF:';
        STAT__Caption: Label 'STAT:';
        RCS__Caption: Label 'RCS:';
        CustomerPhone__Caption: Label 'Phone:';
        TotalHT__Caption: Label 'Total HT';
        TVA__Caption: Label 'VAT(20%)';
        TotalTTC__Caption: Label 'Total TTC';
        CustSignLbl: Label 'Customer signature';
        CompanySignLbl: Label 'Company signature';
        ArrestedSumLbl: Label 'Arrested at the sum of :';
        OffreLbl: Label 'Offer subject to conditions. See in store';
        ProformaLbl: Label 'This proforma invoice is valid until';
        // SalesConfirmationLbl: Label 'Sales Quote';
        InvDiscountAmtLbl: Label 'Invoice Discount';
        SubtotalLbl: Label 'Subtotal';
        UnitLbl: Label 'Unit';
        ExchangeRateTxt: Label 'Exchange rate: %1/%2', Comment = '%1 and %2 are both amounts.';
        VATAmountLCYLbl: Label 'VAT Amount (LCY)';
        VATBaseLCYLbl: Label 'VAT Base (LCY)';
        NoFilterSetErr: Label 'You must specify one or more filters to avoid accidently printing all documents.';
        GreetingLbl: Label 'Hello';
        ClosingLbl: Label 'Sincerely';
        PmtDiscTxt: Label 'If we receive the payment before %1, you are eligible for a %2% payment discount.', Comment = '%1 = Discount Due Date %2 = value of Payment Discount % ';
        BodyLbl: Label 'Thank you for your business. Your quote is attached to this message.';
        QtyLbl: Label 'Qty', Comment = 'Short form of Quantity';
        PriceLbl: Label 'Price';
        PricePerLbl: Label 'Price per';
    // YourEstimateLbl: Label 'Your Estimate';
    // EstimateLbl: Label 'Estimate';
    // SalespersonLbl: Label 'Sales person';
    // CompanyInfoBankAccNoLbl: Label 'Account No.';
    // CompanyInfoBankNameLbl: Label 'Bank';
    // CompanyInfoGiroNoLbl: Label 'Giro No.';
    // CompanyInfoPhoneNoLbl: Label 'Phone No.';
    // CopyLbl: Label 'Copy';
    // EMailLbl: Label 'Email';
    // HomePageLbl: Label 'Home Page';
    // InvDiscBaseAmtLbl: Label 'Invoice Discount Base Amount';
    // InvNoLbl: Label 'No.';
    // LineAmtAfterInvDiscLbl: Label 'Payment Discount on VAT';
    // LocalCurrencyLbl: Label 'Local Currency';
    // PageLbl: Label 'Page';
    // PaymentMethodDescLbl: Label 'Payment Method';
    // PostedShipmentDateLbl: Label 'Shipment Date';
    // SalesInvLineDiscLbl: Label 'Discount %';
    // ShipmentLbl: Label 'Shipment';
    // ShiptoAddrLbl: Label 'Ship-to Address';
    // TotalLbl: Label 'Total';
    // VATAmtSpecificationLbl: Label 'VAT Amount Specification';
    // VATAmtLbl: Label 'VAT Amount';
    // VATBaseLbl: Label 'VAT Base';
    // VATClausesLbl: Label 'VAT Clause';
    // VATIdentifierLbl: Label 'VAT Identifier';
    // VATPercentageLbl: Label 'VAT %';
    // FromLbl: Label 'From';
    // EstimateForLbl: Label 'Estimate for';
    // QuestionsLbl: Label 'Questions?';
    // ThanksLbl: Label 'Thank You!';
    // EstimateBodyLbl: Label 'As promised, here''s our estimate. Please see the attached estimate for details.';
    // QuoteValidToDateLbl: Label 'Valid to';
    // SellToContactPhoneNoLbl: Label 'Sell-to Contact Phone No.';
    // SellToContactMobilePhoneNoLbl: Label 'Sell-to Contact Mobile Phone No.';
    // SellToContactEmailLbl: Label 'Sell-to Contact E-Mail';
    // BillToContactPhoneNoLbl: Label 'Bill-to Contact Phone No.';
    // BillToContactMobilePhoneNoLbl: Label 'Bill-to Contact Mobile Phone No.';
    // BillToContactEmailLbl: Label 'Bill-to Contact E-Mail';
    // PaymentTermsDescLbl: Label 'Payment Terms';
    // ShptMethodDescLbl: Label 'Shipment Method';

    local procedure InitLogInteraction()
    begin
        LogInteraction := SegManagement.FindInteractionTemplateCode(Enum::"Interaction Log Entry Document Type"::"Sales Qte.") <> '';
    end;

    // local procedure DocumentCaption(): Text[250]
    // begin
    //     exit(SalesConfirmationLbl);
    // end;

    /// <summary>
    /// IsReportInPreviewMode.
    /// </summary>
    /// <returns>Return value of type Boolean.</returns>
    procedure InitializeRequest(NewLogInteraction: Boolean)
    begin
        LogInteraction := NewLogInteraction;
    end;

    protected procedure IsReportInPreviewMode(): Boolean
    var
        MailManagement: Codeunit "Mail Management";
    begin
        exit(CurrReport.Preview() or MailManagement.IsHandlingGetEmailBody());
    end;

    local procedure FormatDocumentFields(SalesHeader: Record "Sales Header")
    begin
        // with SalesHeader do begin
        FormatDocument.SetTotalLabels(SalesHeader.GetCurrencySymbol(), TotalText, TotalInclVATText, TotalExclVATText);
        FormatDocument.SetSalesPerson(SalespersonPurchaser, SalesHeader."Salesperson Code", SalesPersonText);
        FormatDocument.SetPaymentTerms(PaymentTerms, SalesHeader."Payment Terms Code", SalesHeader."Language Code");
        FormatDocument.SetPaymentMethod(PaymentMethod, SalesHeader."Payment Method Code", SalesHeader."Language Code");
        FormatDocument.SetShipmentMethod(ShipmentMethod, SalesHeader."Shipment Method Code", SalesHeader."Language Code");
        //     OnAfterFormatDocumentFields(SalesHeader);
        // end;
    end;

    local procedure CreateReportTotalLines()
    begin
        ReportTotalsLine.DeleteAll();
        if (TotalInvDiscAmount <> 0) or (TotalAmountVAT <> 0) then
            ReportTotalsLine.Add(SubtotalLbl, TotalSubTotal, true, false, false, Header."Currency Code");
        if TotalInvDiscAmount <> 0 then begin
            ReportTotalsLine.Add(InvDiscountAmtLbl, TotalInvDiscAmount, false, false, false, Header."Currency Code");
            if TotalAmountVAT <> 0 then
                ReportTotalsLine.Add(TotalExclVATText, TotalAmount, true, false, false, Header."Currency Code");
        end;
        if TotalAmountVAT <> 0 then begin
            ReportTotalsLine.Add(VATAmountLine.VATAmountText(), TotalAmountVAT, false, true, false, Header."Currency Code");
            if TotalVATAmountLCY <> TotalAmountVAT then
                ReportTotalsLine.Add(VATAmountLine.VATAmountText() + LCYTxt, TotalVATAmountLCY, false, true, false);
        end;
    end;

    local procedure SetFormatRegion(FormatRegion: Text[80])
    begin
        CurrReport.FormatRegion := LanguageMgt.GetFormatRegionOrDefault(FormatRegion);
        OnAfterSetFormatRegion();
    end;

    local procedure SetLanguage(LanguageCode: Code[10])
    begin
        CurrReport.Language := LanguageMgt.GetLanguageIdOrDefault(LanguageCode);

        OnAfterSetLanguage();
    end;

    // [IntegrationEvent(false, false)]
    // local procedure OnAfterFormatDocumentFields(var SalesHeader: Record "Sales Header")
    // begin
    // end;

    [IntegrationEvent(false, false)]
    local procedure OnAfterSetLanguage()
    begin
    end;

    // [IntegrationEvent(TRUE, FALSE)]
    // local procedure OnAfterGetSalesHeader(SalesHeader: Record "Sales Header")
    // begin
    // end;

    [IntegrationEvent(false, false)]
    local procedure OnAfterSetFormatRegion()
    begin
    end;

    [IntegrationEvent(false, false)]
    local procedure OnBeforeCalcVATAmountLines(var Header: Record "Sales Header"; var Line: Record "Sales Line")
    begin
    end;

    [IntegrationEvent(false, false)]
    local procedure OnLineOnAfterGetRecordOnAfterUpdateVATOnLines(var SalesHeader: Record "Sales Header"; var SalesLine: Record "Sales Line")
    begin
    end;

    // [IntegrationEvent(false, false)]
    // local procedure OnInitReportForGlobalVariable(var IsHandled: Boolean; var LegalOfficeTxt: Text; var LegalOfficeLbl: Text; var CustomGiroTxt: Text; var CustomGiroLbl: Text; var LegalStatementLbl: Text)
    // begin
    // end;

    [IntegrationEvent(true, false)]
    local procedure OnHeaderOnAfterGetRecordOnAfterUpdateNoPrinted(ReportInPreviewMode: Boolean; var SalesHeader: Record "Sales Header")
    begin
    end;

    [IntegrationEvent(false, false)]
    local procedure OnAfterLineOnPreDataItem(var SalesHeader: Record "Sales Header"; var SalesLine: Record "Sales Line")
    begin
    end;

    [IntegrationEvent(false, false)]
    local procedure OnBeforeLineOnAfterGetRecord(var SalesHeader: Record "Sales Header"; var SalesLine: Record "Sales Line")
    begin
    end;

    // [IntegrationEvent(false, false)]
    // local procedure OnBeforeFormatLineValues(SalesInvoiceLine: Record "Sales Line"; var FormattedQuantity: Text; var FormattedUnitPrice: Text; var FormattedVATPercentage: Text; var FormattedLineAmount: Text; var IsHandled: Boolean)
    // begin
    // end;

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