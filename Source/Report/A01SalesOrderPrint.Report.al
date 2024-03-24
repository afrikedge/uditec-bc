/// <summary>
/// Report A01 SalesOrderPrint (ID 50007).
/// </summary>
report 50007 "A01 SalesOrderPrint"
{
    Caption = 'A01 Sales Order Print';
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;
    DefaultLayout = RDLC;
    PreviewMode = PrintLayout;
    WordMergeDataItem = Header;
    RDLCLayout = './Source/Report/Layout/SalesOrderPrint.rdl';

    dataset
    {
        dataitem(Header; "Sales Header")
        {
            DataItemTableView = sorting("Document Type", "No.");
            RequestFilterFields = "No.", "Sell-to Customer No.";
            RequestFilterHeading = 'Pro Forma Invoice';
            column(DocumentNo_; "No.")
            {
            }
            column(CompanyInfo__Picture; CompanyInformation.Picture)
            {
            }
            column(CompanyName; COMPANYPROPERTY.DisplayName())
            {
            }
            column(CompanyAddress; CompanyInformation.Address)
            {
            }
            column(CompanyAddress2; CompanyInformation."Address 2")
            {
            }
            column(CompanyHomePage; CompanyInformation."Home Page")
            {
            }
            column(CompanyPhone; CompanyInformation."Phone No.")
            {
            }
            column(A01UnitName; UnitName)
            {
            }
            column(A01City; City)
            {
            }
            column(A01PostCode; PostalCode)
            {
            }
            column(A01SellerName; SellerName)
            {
            }
            column(A01CustomerPhone; CustomerPhone)
            {
            }
            column(A01CustomerName; "Sell-to Customer Name")
            {
            }
            column(A01CustomerAddress; CustAddress)
            {
            }
            column(A01Order_Date; Format("Order Date"))
            {
            }
            column(A01UnitName__Caption; A01UnitName__Caption)
            {
            }
            column(A01UnitAddress__Caption; A01UnitAddress__Caption)
            {
            }
            column(A01City__Caption; A01City__Caption)
            {
            }
            column(A01PostalCode__Caption; A01PostalCode__Caption)
            {
            }
            column(A01Report__Caption; A01Report__Caption)
            {
            }
            column(A01OrderNo__Caption; A01OrderNo__Caption)
            {
            }
            column(SellerName__Caption; SellerName__Caption)
            {
            }
            column(A01DateOfPrint__Caption; A01DateOfPrint__Caption)
            {
            }
            column(A01CustomerName__Caption; A01CustomerName__Caption)
            {
            }
            column(A01CustomerIdentity__Caption; A01CustomerIdentity__Caption)
            {
            }
            column(A01CustomerAddress__Caption; A01CustomerAddress__Caption)
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
            column(A01CustomerPhone__Caption; A01CustomerPhone__Caption)
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
            column(A01ArrestedSumLbl; A01ArrestedSumLbl)
            {
            }
            column(A01OffreLbl; A01OffreLbl)
            {
            }
            column(A01ProformaLbl; A01ProformaLbl)
            {
            }
            column(A01CustSignLbl; A01CustSignLbl)
            {
            }
            column(A01CompanySignLbl; A01CompanySignLbl)
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

            column(CompanyVATRegNo; CompanyInformation.GetVATRegistrationNumber())
            {
            }
            column(SellToContactPhoneNoLbl; SellToContactPhoneNoLbl)
            {
            }
            column(SellToContactMobilePhoneNoLbl; SellToContactMobilePhoneNoLbl)
            {
            }
            column(SellToContactEmailLbl; SellToContactEmailLbl)
            {
            }
            column(BillToContactPhoneNoLbl; BillToContactPhoneNoLbl)
            {
            }
            column(BillToContactMobilePhoneNoLbl; BillToContactMobilePhoneNoLbl)
            {
            }
            column(BillToContactEmailLbl; BillToContactEmailLbl)
            {
            }
            column(SellToContactPhoneNo; SellToContact."Phone No.")
            {
            }
            column(SellToContactMobilePhoneNo; SellToContact."Mobile Phone No.")
            {
            }
            column(SellToContactEmail; SellToContact."E-Mail")
            {
            }
            column(BillToContactPhoneNo; BillToContact."Phone No.")
            {
            }
            column(BillToContactMobilePhoneNo; BillToContact."Mobile Phone No.")
            {
            }
            column(BillToContactEmail; BillToContact."E-Mail")
            {
            }
            column(YourReference; "Your Reference")
            {
            }
            column(ExternalDocumentNo; "External Document No.")
            {
            }
            column(DocumentNo; "No.")
            {
            }
            column(CompanyLegalOffice; LegalOfficeTxt)
            {
            }
            column(SalesPersonName; SalespersonPurchaserName)
            {
            }
            column(ShipmentMethodDescription; ShipmentMethodDescription)
            {
            }
            column(Currency; CurrencyCode)
            {
            }
            column(CustomerVATRegNo; GetCustomerVATRegistrationNumber())
            {
            }
            column(CustomerVATRegistrationNoLbl; GetCustomerVATRegistrationNumberLbl())
            {
            }
            column(PageLbl; PageLbl)
            {
            }
            column(DocumentTitleLbl; DocumentCaption())
            {
            }
            column(YourReferenceLbl; FieldCaption("Your Reference"))
            {
            }
            column(ExternalDocumentNoLbl; FieldCaption("External Document No."))
            {
            }
            column(CompanyLegalOfficeLbl; LegalOfficeLbl)
            {
            }
            column(SalesPersonLbl; SalesPersonLblText)
            {
            }
            column(EMailLbl; CompanyInformation.FieldCaption("E-Mail"))
            {
            }
            column(HomePageLbl; CompanyInformation.FieldCaption("Home Page"))
            {
            }
            column(CompanyPhoneNoLbl; CompanyInformation.FieldCaption("Phone No."))
            {
            }
            column(ShipmentMethodDescriptionLbl; DummyShipmentMethod.TableCaption())
            {
            }
            column(CurrencyLbl; DummyCurrency.TableCaption())
            {
            }
            column(ItemLbl; Item.TableCaption())
            {
            }
            column(TariffLbl; Item.FieldCaption("Tariff No."))
            {
            }
            column(UnitPriceLbl; Item.FieldCaption("Unit Price"))
            {
            }
            column(CountryOfManufactuctureLbl; CountryOfManufactuctureLbl)
            {
            }
            column(AmountLbl; Line.FieldCaption(Amount))
            {
            }
            column(VATPctLbl; Line.FieldCaption("VAT %"))
            {
            }
            column(VATAmountLbl; DummyVATAmountLine.VATAmountText())
            {
            }
            column(TotalWeightLbl; TotalWeightLbl)
            {
            }
            column(TotalAmountLbl; TotalAmountLbl)
            {
            }
            column(TotalAmountInclVATLbl; TotalAmountInclVATLbl)
            {
            }
            column(QuantityLbl; Line.FieldCaption(Quantity))
            {
            }
            column(NetWeightLbl; Line.FieldCaption("Net Weight"))
            {
            }
            column(DeclartionLbl; DeclartionLbl)
            {
            }
            column(SignatureLbl; SignatureLbl)
            {
            }
            column(SignatureNameLbl; SignatureNameLbl)
            {
            }
            column(SignaturePositionLbl; SignaturePositionLbl)
            {
            }
            column(VATRegNoLbl; CompanyInformation.GetVATRegistrationNumberLbl())
            {
            }
            column(ShowWorkDescription; ShowWorkDescription) { }
            dataitem(Line; "Sales Line")
            {
                DataItemLink = "Document Type" = field("Document Type"), "Document No." = field("No.");
                DataItemLinkReference = Header;
                DataItemTableView = sorting("Document No.", "Line No.");
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
                column(A01Description_Line; Description)
                {
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
                column(A01LineQty; A01LineQtyFormatted)
                {
                }
                column(A01LinePU; A01LinePUFormatted)
                {
                    AutoFormatExpression = "Currency Code";
                    AutoFormatType = 2;
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
                column(A01AmountVAT_Line; A01FormattedVAT)
                {
                    AutoFormatExpression = "Currency Code";
                    AutoFormatType = 1;
                }
                column(A01FormattedVAT; A01FormattedVAT)
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

                column(ItemDescription; Description)
                {
                }
                column(CountryOfManufacturing; Item."Country/Region of Origin Code")
                {
                }
                column(Tariff; Item."Tariff No.")
                {
                }
                column(Quantity; "Qty. to Invoice")
                {
                }
                column(Price; FormattedLinePrice)
                {
                    AutoFormatExpression = "Currency Code";
                    AutoFormatType = 2;
                }
                column(NetWeight; "Net Weight")
                {
                }
                column(LineAmount; FormattedLineAmount)
                {
                    AutoFormatExpression = "Currency Code";
                    AutoFormatType = 1;
                }
                column(VATPct; "VAT %")
                {
                }
                column(VATAmount; FormattedVATAmount)
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
                column(Type_Line; Format(Type))
                {
                }
                column(TransHeaderAmount; TransHeaderAmount)
                {
                    AutoFormatExpression = "Currency Code";
                    AutoFormatType = 1;
                }

                trigger OnAfterGetRecord()
                var
                    // Location: Record Location;
                    // AutoFormatType: Enum "Auto Format";
                    tempHT: Decimal;
                    tempHTD: Decimal;
                    tempPU: Decimal;
                    tempTTC: Decimal;
                    tempVAT: Decimal;
                begin
                    GetItemForRec("No.");
                    OnBeforeLineOnAfterGetRecord(Header, Line);

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
                            tempHTD := Line."Line Amount" * (1 / (1 + Line."Line Discount %" / 100));
                            tempPU := Line."Unit Price" * (1 / (1 + Line."VAT %" / 100));
                            tempVAT := line."Amount Including VAT" - tempHT;
                            tempTTC := line."Amount Including VAT";

                        end else begin
                            tempHT := Line."Line Amount";
                            tempHTD := Line."Line Discount Amount";
                            tempPU := Line."Unit Price";
                            tempVAT := tempHT * Line."VAT %" / 100;
                            tempTTC := tempVAT + Line."Line Amount";
                        end;
                        A01FormattedVAT := Format(Round(tempVAT, 0.001, '<'));
                        A01FormattedAmtHT := Format(Round(Line.Quantity * tempPU, 0.001, '<'));
                        A01FormattedLineDiscountAmount := Format(Round(tempHT * Line."Line Discount %", 0.001, '<'));
                        FormattedLineAmountTTC := Format(Round(tempTTC, 0.001, '<'));
                    end;
                    A01LineQty := Line.Quantity;
                    A01LinePU := Round(tempPU, 0.000001, '<');

                    A01LineQtyFormatted := Format(A01LineQty);
                    A01LinePUFormatted := Format(A01LinePU);

                    if Type = Type::"G/L Account" then
                        "No." := '';

                    // if "Line Discount %" = 0 then
                    //     LineDiscountPctText := ''
                    // else
                    LineDiscountPctText := StrSubstNo('%1%', Round("Line Discount %", 0.1));

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
                end;

                trigger OnPreDataItem()
                begin
                    TotalWeight := 0;
                    TotalAmount := 0;
                    TotalVATAmount := 0;
                    TotalAmountInclVAT := 0;
                    SetRange(Type, Type::Item);

                    MoreLines := Find('+');
                    while MoreLines and (Description = '') and ("No." = '') and (Quantity = 0) and (Amount = 0) do
                        MoreLines := Next(-1) <> 0;
                    if not MoreLines then
                        CurrReport.Break();
                    SetRange("Line No.", 0, "Line No.");
                    TransHeaderAmount := 0;
                    PrevLineAmount := 0;
                    AfkLinesNumber := Count();
                    FirstLineHasBeenOutput := false;

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
                column(WorkDescriptionLineNumber; Number) { }
                column(WorkDescriptionLine; WorkDescriptionLine) { }

                trigger OnAfterGetRecord()
                var
                    TypeHelper: Codeunit "Type Helper";
                begin
                    if WorkDescriptionInStream.EOS() then
                        CurrReport.Break();
                    WorkDescriptionLine := TypeHelper.ReadAsTextWithSeparator(WorkDescriptionInStream, TypeHelper.LFSeparator());
                end;

                trigger OnPostDataItem()
                begin
                    Clear(WorkDescriptionInStream)
                end;

                trigger OnPreDataItem()
                begin
                    if not ShowWorkDescription then
                        CurrReport.Break();
                    Header."Work Description".CreateInStream(WorkDescriptionInStream, TextEncoding::UTF8);
                end;

            }
            dataitem(Totals; "Integer")
            {
                // MaxIteration = 1;
                DataItemTableView = sorting(Number) where(Number = const(1));
                column(TotalWeight; TotalWeight)
                {
                }
                column(TotalValue; FormattedTotalAmount)
                {
                }
                // column(TotalVATAmount; FormattedTotalVATAmount)
                // {
                // }
                column(TotalAmountInclVAT; FormattedTotalAmountInclVAT)
                {
                }
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
                var
                    AutoFormatType: Enum "Auto Format";
                begin
                    // FormattedTotalAmount := Format(TotalAmount, 0, AutoFormat.ResolveAutoFormat(AutoFormatType::AmountFormat, CurrencyCode));
                    // FormattedTotalVATAmount := Format(TotalVATAmount, 0, AutoFormat.ResolveAutoFormat(AutoFormatType::AmountFormat, CurrencyCode));
                    // FormattedTotalAmountInclVAT := Format(TotalAmountInclVAT, 0, AutoFormat.ResolveAutoFormat(AutoFormatType::AmountFormat, CurrencyCode));

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
                           AutoFormat.ResolveAutoFormat(AutoFormatType::AmountFormat, CurrencyCode));
                    AfkTotalAmount_LCYText :=
                        Format(AfkTotalAmount_LCY, 0,
                        AutoFormat.ResolveAutoFormat("Auto Format"::AmountFormat, AfkLocalCurrency.Code));
                    // AfkLocalCurrencyText := 'XAF';
                    AfkTotalVAT_LCYText :=
                        Format(AfkTotalVAT_LCY, 0,
                        AutoFormat.ResolveAutoFormat("Auto Format"::AmountFormat, AfkLocalCurrency.Code));

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
                Language: Codeunit Language;
            begin
                GLSetup.Get();
                GLSetup.TestField("LCY Code");

                CurrReport.Language := Language.GetLanguageIdOrDefault("Language Code");
                CurrReport.FormatRegion := Language.GetFormatRegionOrDefault("Format Region");

                FormatDocumentFields(Header);
                if SellToContact.Get("Sell-to Contact No.") then;
                if BillToContact.Get("Bill-to Contact No.") then;

                // CalcFields("Work Description");
                // ShowWorkDescription := "Work Description".HasValue();

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
                    PostalCode := ResponsibilityInfo."Post Code";
                end;

                if SalesPersonInfo.Get(Header."Salesperson Code") then
                    SellerName := SalesPersonInfo.Name;

                if "Currency Code" <> '' then begin
                    CurrencyExchangeRate.FindCurrency("Posting Date", "Currency Code", 1);
                    CalculatedExchRate :=
                      Round(1 / "Currency Factor" * CurrencyExchangeRate."Exchange Rate Amount", 0.000001);
                    ExchangeRateText := StrSubstNo(ExchangeRateTxt, CalculatedExchRate, CurrencyExchangeRate."Exchange Rate Amount");
                end;

                TotalAmount := 0;
                TotalAmountVAT := 0;
                TotalAmountInclVAT := 0;
                AfkTotalAmountInclVAT_LCY := 0;
                AfkTotalAmount_LCY := 0;
                AfkTotalVAT_LCY := 0;
            end;

            // trigger OnPreDataItem()
            // begin
            //     FirstLineHasBeenOutput := false;
            // end;
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

    trigger OnInitReport()
    var
        IsHandled: Boolean;
    begin
        CompanyInformation.Get();
        CompanyInformation.CalcFields(Picture);

        IsHandled := false;
        OnInitReportForGlobalVariable(IsHandled, LegalOfficeTxt, LegalOfficeLbl);
#if not CLEAN23
        if not IsHandled then begin
            LegalOfficeTxt := CompanyInformation.GetLegalOffice();
            LegalOfficeLbl := CompanyInformation.GetLegalOfficeLbl();
        end;
#endif
    end;



    var
        DummyVATAmountLine: Record "VAT Amount Line";
        CompanyInformation: Record "Company Information";
        DummyShipmentMethod: Record "Shipment Method";
        DummyCurrency: Record Currency;
        CurrencyExchangeRate: Record "Currency Exchange Rate";
        AfkLocalCurrency: Record Currency;
        GLSetup: Record "General Ledger Setup";
        AfkCurrency: Record Currency;
        ResponsibilityInfo: Record "Responsibility Center";
        SalesPersonInfo: Record "Salesperson/Purchaser";
        Item: Record Item;
        Currency: Record Currency;
        SellToContact: Record Contact;
        BillToContact: Record Contact;
        RepCheck: Report Check;
        AutoFormat: Codeunit "Auto Format";
        // Language: Codeunit Language;
        CalculatedExchRate: Decimal;
        PrevLineAmount: Decimal;
        ExchangeRateText: Text;
        NoText: array[2] of Text;
        AfkCurrencyName: Text;
        AfkLocalCurrencyName: Text;
        UnitName: Text[100];
        AfkTotalAmountInclVAT_LCY: Decimal;
        AfkTotalAmount_LCY: Decimal;
        AfkCurrCode: Code[20];
        AfkTotalVAT_LCY: Decimal;
        AfkLinesNumber: Integer;
        A01FormattedVAT: Text[50];
        A01LinePUFormatted: Text[50];
        TotalInclVATText: Text[50];
        A01LineQtyFormatted: Text[50];
        TotalAmountExclInclVATValue: Decimal;
        TotalAmountVAT: Decimal;
        FormattedLineAmountTTC: Text;
        TotalAmountExclInclVATTextValue: Text;
        A01FormattedAmtHT: Text[50];
        FirstLineHasBeenOutput: Boolean;
        MoreLines: Boolean;
        A01FormattedLineDiscountAmount: Text[50];
        LineDiscountPctText: Text;
        TotalVATBaseLCY: Decimal;
        City: Code[30];
        SellerName: Text[50];
        TotalVATAmountLCY: Decimal;
        TotalInvDiscAmount: Decimal;
        CurrCode: Text[10];
        TotalExclVATText: Text[50];
        CurrSymbol: Text[10];
        TotalPaymentDiscOnVAT: Decimal;
        TransHeaderAmount: Decimal;
        TotalText: Text[50];
        TotalSubTotal: Decimal;
        AfkFormattedTotalVAT: Text[50];
        AfkFormattedTotalHT: Text[50];
        AfkFormattedTotalTTC: Text[50];
        AfkTotalAmount_LCYText: Text[50];
        Afk_AmountInWords: Text;
        AfkTotalAmountInclVAT_LCYText: Text[50];
        AfkTotalVAT_LCYText: Text[50];
        AfkLocalCurrencyText: Text[100];
        CustomerPhone: Text[30];
        CustAddress: Text[100];
        PostalCode: Code[20];
        AfkIsLine: Integer;
        NumLigne: Integer;
        A01LineQty: Decimal;
        A01LinePU: Decimal;
        NumLigneText: Code[2];
        ExchangeRateTxt: Label 'Exchange rate: %1/%2', Comment = '%1 and %2 are both amounts.';
        A01Report__Caption: Label 'PROFORMA INVOICE';
        A01UnitName__Caption: Label 'Unit name :';
        A01UnitAddress__Caption: Label 'Unit address :';
        A01City__Caption: Label 'City';
        A01PostalCode__Caption: Label 'Postal code :';
        A01OrderNo__Caption: Label 'Order No :';
        SellerName__Caption: Label 'Seller name :';
        A01DateOfPrint__Caption: Label 'Date of print :';
        A01CustomerName__Caption: Label 'Customer name :';
        A01CustomerIdentity__Caption: Label 'Customer identity :';
        A01CustomerAddress__Caption: Label 'Customer address :';
        A01NIF__Caption: Label 'NIF :';
        A01STAT__Caption: Label 'STAT :';
        A01RCS__Caption: Label 'RCS :';
        A01CustomerPhone__Caption: Label 'Phone :';
        A01ProductCode__Caption: Label 'Product code';
        A01Description__Caption: Label 'Designation';
        A01Quantity__Caption: Label 'Quantity';
        A01UnitPrice__Caption: Label 'Unit price HT(AR)';
        A01DiscountPercent__Caption: Label 'Discount(AR)';
        A01DiscountAmount__Caption: Label 'Discounted price HT(AR)';
        A01TotalHT__Caption: Label 'Total HT (AR) :';
        A01TVA__Caption: Label 'VAT(20%)(AR) :';
        A01TotalTTC__Caption: Label 'Total TTC(AR) :';
        A01CustSignLbl: Label 'Customer signature';
        A01CompanySignLbl: Label 'Company signature';
        A01ArrestedSumLbl: Label 'Arrested at the sum of :';
        A01OffreLbl: Label 'Offer subject to conditions. See in store';
        A01ProformaLbl: Label 'This proforma invoice is valid for one week';
        CountryOfManufactuctureLbl: Label 'Country';
        TotalWeightLbl: Label 'Total Weight';
        SalespersonPurchaserName: Text;
        ShipmentMethodDescription: Text;
        DocumentTitleLbl: Label 'Pro Forma Invoice';
        PageLbl: Label 'Page';
        DeclartionLbl: Label 'For customs purposes only.';
        SignatureLbl: Label 'For and on behalf of the above named company:';
        SignatureNameLbl: Label 'Name (in print) Signature';
        SignaturePositionLbl: Label 'Position in company';
        SellToContactPhoneNoLbl: Label 'Sell-to Contact Phone No.';
        SellToContactMobilePhoneNoLbl: Label 'Sell-to Contact Mobile Phone No.';
        SellToContactEmailLbl: Label 'Sell-to Contact E-Mail';
        BillToContactPhoneNoLbl: Label 'Bill-to Contact Phone No.';
        BillToContactMobilePhoneNoLbl: Label 'Bill-to Contact Mobile Phone No.';
        BillToContactEmailLbl: Label 'Bill-to Contact E-Mail';
        LegalOfficeTxt, LegalOfficeLbl : Text;

        // protected var
        CompanyAddress: array[8] of Text[100];
        CustomerAddress: array[8] of Text[100];
        WorkDescriptionInStream: InStream;
        SalesPersonLblText: Text[50];
        TotalAmountLbl: Text[50];
        TotalAmountInclVATLbl: Text[50];
        FormattedLinePrice: Text;
        FormattedLineAmount: Text;
        FormattedVATAmount: Text;
        FormattedTotalAmount: Text;
        FormattedTotalVATAmount: Text;
        FormattedTotalAmountInclVAT: Text;
        WorkDescriptionLine: Text;
        CurrencyCode: Code[10];
        TotalWeight: Decimal;
        TotalAmount: Decimal;
        TotalVATAmount: Decimal;
        TotalAmountInclVAT: Decimal;
        LinePrice: Decimal;
        LineAmount: Decimal;
        VATAmount: Decimal;
        ShowWorkDescription: Boolean;

    local procedure FormatDocumentFields(SalesHeader: Record "Sales Header")
    var
        GeneralLedgerSetup: Record "General Ledger Setup";
        SalespersonPurchaser: Record "Salesperson/Purchaser";
        ShipmentMethod: Record "Shipment Method";
        ResponsibilityCenter: Record "Responsibility Center";
        Customer: Record Customer;
        FormatDocument: Codeunit "Format Document";
        FormatAddress: Codeunit "Format Address";
        TotalAmounExclVATLbl: Text[50];
    begin
        FormatAddress.SetLanguageCode(SalesHeader."Language Code");
        // with SalesHeader do begin
        Customer.Get(SalesHeader."Sell-to Customer No.");
        FormatDocument.SetSalesPerson(SalespersonPurchaser, SalesHeader."Salesperson Code", SalesPersonLblText);
        SalespersonPurchaserName := SalespersonPurchaser.Name;

        FormatDocument.SetShipmentMethod(ShipmentMethod, SalesHeader."Shipment Method Code", SalesHeader."Language Code");
        ShipmentMethodDescription := ShipmentMethod.Description;

        FormatAddress.GetCompanyAddr(SalesHeader."Responsibility Center", ResponsibilityCenter, CompanyInformation, CompanyAddress);
        FormatAddress.SalesHeaderBillTo(CustomerAddress, SalesHeader);

        if SalesHeader."Currency Code" = '' then begin
            GeneralLedgerSetup.Get();
            GeneralLedgerSetup.TestField("LCY Code");
            CurrencyCode := GeneralLedgerSetup."LCY Code";
            Currency.InitRoundingPrecision();
        end else begin
            CurrencyCode := SalesHeader."Currency Code";
            Currency.Get(SalesHeader."Currency Code");
        end;

        FormatDocument.SetTotalLabels(SalesHeader."Currency Code", TotalAmountLbl, TotalAmountInclVATLbl, TotalAmounExclVATLbl);
        // end;
    end;

    local procedure DocumentCaption(): Text
    var
        DocCaption: Text;
    begin
        OnBeforeGetDocumentCaption(Header, DocCaption);
        if DocCaption <> '' then
            exit(DocCaption);
        exit(DocumentTitleLbl);
    end;

    local procedure GetItemForRec(ItemNo: Code[20])
    var
        IsHandled: Boolean;
    begin
        IsHandled := false;
        OnBeforeGetItemForRec(ItemNo, IsHandled);
        if IsHandled then
            exit;

        Item.Get(ItemNo);
    end;

    [IntegrationEvent(false, false)]
    local procedure OnAfterLineOnPreDataItem(var SalesHeader: Record "Sales Header"; var SalesLine: Record "Sales Line")
    begin
    end;

    [IntegrationEvent(false, false)]
    local procedure OnBeforeGetDocumentCaption(SalesHeader: Record "Sales Header"; var DocCaption: Text)
    begin
    end;

    [IntegrationEvent(true, false)]
    local procedure OnBeforeGetItemForRec(ItemNo: Code[20]; var IsHandled: Boolean)
    begin
    end;

    [IntegrationEvent(false, false)]
    local procedure OnBeforeLineOnAfterGetRecord(SalesHeader: Record "Sales Header"; var SalesLine: Record "Sales Line")
    begin
    end;

    [IntegrationEvent(false, false)]
    local procedure OnInitReportForGlobalVariable(var IsHandled: Boolean; var LegalOfficeTxt: Text; var LegalOfficeLbl: Text)
    begin
    end;

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