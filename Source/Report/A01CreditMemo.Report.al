/// <summary>
/// Report A01 Credit Memo (ID 50037).
/// </summary>
report 50037 "A01 CreditMemo"
{
    Caption = 'A01 Credit Memo';
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;
    DefaultLayout = RDLC;
    PreviewMode = PrintLayout;
    EnableHyperlinks = true;
    WordMergeDataItem = Header;
    RDLCLayout = './Source/Report/Layout/CreditMemoPrint.rdl';

    dataset
    {
        dataitem(Header; "Sales Cr.Memo Header")
        {
            DataItemTableView = sorting("No.");
            RequestFilterFields = "No.", "Sell-to Customer No.";
            RequestFilterHeading = 'Posted Sales Credit Memo';
            column(CompanyAddress1; CompanyAddr[1])
            {
            }
            column(CompanyAddress2; CompanyAddr[2])
            {
            }
            column(CompanyAddress3; CompanyAddr[3])
            {
            }
            column(CompanyAddress4; CompanyAddr[4])
            {
            }
            column(CompanyAddress5; CompanyAddr[5])
            {
            }
            column(CompanyAddress6; CompanyAddr[6])
            {
            }
            column(CompanyAddress7; CompanyAddr[7])
            {
            }
            column(CompanyAddress8; CompanyAddr[8])
            {
            }
            column(CompanyHomePage; CompanyInfo."Home Page")
            {
            }
            column(CompanyEMail; CompanyInfo."E-Mail")
            {
            }
            column(CompanyPicture; DummyCompanyInfo.Picture)
            {
            }
            column(CompanyPhoneNo; CompanyInfo."Phone No.")
            {
            }
            column(CompanyPhone; CompInfo."Phone No.")
            {
            }
            column(CompanyPhoneNo_Lbl; CompanyInfoPhoneNoLbl)
            {
            }
            column(CompanyGiroNo; CompanyInfo."Giro No.")
            {
            }
            column(CompanyGiroNo_Lbl; CompanyInfoGiroNoLbl)
            {
            }
            column(CompanyBankName; CompanyBankAccount.Name)
            {
            }
            column(CompanyBankName_Lbl; CompanyInfoBankNameLbl)
            {
            }
            column(CompanyBankBranchNo; CompanyBankAccount."Bank Branch No.")
            {
            }
            column(CompanyBankBranchNo_Lbl; CompanyBankAccount.FieldCaption("Bank Branch No."))
            {
            }
            column(CompanyBankAccountNo; CompanyBankAccount."Bank Account No.")
            {
            }
            column(CompanyBankAccountNo_Lbl; CompanyInfoBankAccNoLbl)
            {
            }
            column(CompanyIBAN; CompanyBankAccount.IBAN)
            {
            }
            column(CompanyIBAN_Lbl; CompanyBankAccount.FieldCaption(IBAN))
            {
            }
            column(CompanySWIFT; CompanyBankAccount."SWIFT Code")
            {
            }
            column(CompanySWIFT_Lbl; CompanyBankAccount.FieldCaption("SWIFT Code"))
            {
            }
            column(CompanyLogoPosition; CompanyLogoPosition)
            {
            }
            column(CompanyRegistrationNumber; CompanyInfo.GetRegistrationNumber())
            {
            }
            column(CompanyRegistrationNumber_Lbl; CompanyInfo.GetRegistrationNumberLbl())
            {
            }
            column(CompanyVATRegNo; CompanyInfo.GetVATRegistrationNumber())
            {
            }
            column(CompanyVATRegNo_Lbl; CompanyInfo.GetVATRegistrationNumberLbl())
            {
            }
            column(CompanyVATRegistrationNo; CompanyInfo.GetVATRegistrationNumber())
            {
            }
            column(CompanyVATRegistrationNo_Lbl; CompanyInfo.GetVATRegistrationNumberLbl())
            {
            }
            column(CompanyLegalOffice; LegalOfficeTxt)
            {
            }
            column(CompanyLegalOffice_Lbl; LegalOfficeLbl)
            {
            }
            column(CompanyCustomGiro; CustomGiroTxt)
            {
            }
            column(CompanyCustomGiro_Lbl; CustomGiroLbl)
            {
            }
            column(CompanyLegalStatement; LegalStatementLbl)
            {
            }
            column(CustomerAddress1; CustAddr[1])
            {
            }
            column(CustomerAddress2; CustAddr[2])
            {
            }
            column(CustomerAddress3; CustAddr[3])
            {
            }
            column(CustomerAddress4; CustAddr[4])
            {
            }
            column(CustomerAddress5; CustAddr[5])
            {
            }
            column(CustomerAddress6; CustAddr[6])
            {
            }
            column(CustomerAddress7; CustAddr[7])
            {
            }
            column(CustomerAddress8; CustAddr[8])
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
            column(CustomerPostalBarCode; FormatAddr.PostalBarCode(1))
            {
            }
            column(YourReference; "Your Reference")
            {
            }
            column(YourReference_Lbl; FieldCaption("Your Reference"))
            {
            }
            column(ExternalDocumentNo; "External Document No.")
            {
            }
            column(ExternalDocumentNoLbl; FieldCaption("External Document No."))
            {
            }
            column(ShipmentMethodDescription; ShipmentMethod.Description)
            {
            }
            column(ShipmentMethodDescription_Lbl; ShptMethodDescLbl)
            {
            }
            column(ShipmentDate; Format("Shipment Date", 0, 4))
            {
            }
            column(ShipmentDate_Lbl; FieldCaption("Shipment Date"))
            {
            }
            column(Shipment_Lbl; ShipmentLbl)
            {
            }
            column(ShowShippingAddress; ShowShippingAddr)
            {
            }
            column(ShipToAddress_Lbl; ShiptoAddrLbl)
            {
            }
            column(ShipToAddress1; ShipToAddr[1])
            {
            }
            column(ShipToAddress2; ShipToAddr[2])
            {
            }
            column(ShipToAddress3; ShipToAddr[3])
            {
            }
            column(ShipToAddress4; ShipToAddr[4])
            {
            }
            column(ShipToAddress5; ShipToAddr[5])
            {
            }
            column(ShipToAddress6; ShipToAddr[6])
            {
            }
            column(ShipToAddress7; ShipToAddr[7])
            {
            }
            column(ShipToAddress8; ShipToAddr[8])
            {
            }
            column(CustomerSirenNo; Cust.GetSIRENNoWithCaption())
            {
            }
            column(GoodsAndServices_Lbl; GetGoodsAndServicesText())
            {
            }
            column(VATPaidOnDebits_Lbl; GetVATPaidOnDebitsText())
            {
            }
            column(PaymentTermsDescription; PaymentTerms.Description)
            {
            }
            column(PaymentTermsDescription_Lbl; PaymentTermsDescLbl)
            {
            }
            column(PaymentMethodDescription; PaymentMethod.Description)
            {
            }
            column(PaymentMethodDescription_Lbl; PaymentMethodDescLbl)
            {
            }
            column(DocumentCopyText; StrSubstNo(DocumentCaption(), CopyText))
            {
            }
            column(BilltoCustumerNo; "Bill-to Customer No.")
            {
            }
            column(BilltoCustumerNo_Lbl; FieldCaption("Bill-to Customer No."))
            {
            }
            column(DocumentDate; Format("Document Date", 0, 4))
            {
            }
            column(DocumentDate_Lbl; FieldCaption("Document Date"))
            {
            }
            column(DueDate; Format("Due Date", 0, 4))
            {
            }
            column(DueDate_Lbl; FieldCaption("Due Date"))
            {
            }
            column(DocumentNo; "No.")
            {
            }
            // column(DocumentNo_Lbl; InvNoLbl)
            // {
            // }
            column(AppliesToDocument; AppliesToText)
            {
            }
            column(AppliesToDocument_Lbl; AppliesToTextLbl)
            {
            }
            column(PricesIncludingVAT; "Prices Including VAT")
            {
            }
            column(PricesIncludingVAT_Lbl; FieldCaption("Prices Including VAT"))
            {
            }
            column(PricesIncludingVATYesNo; Format("Prices Including VAT"))
            {
            }
            column(SalesPerson_Lbl; SalespersonLbl)
            {
            }
            column(SalesPersonBlank_Lbl; SalesPersonText)
            {
            }
            column(SalesPersonName; SalespersonPurchaser.Name)
            {
            }
            column(SelltoCustomerNo; "Sell-to Customer No.")
            {
            }
            column(Sell_to_Customer_Name; "Sell-to Customer Name")
            {
            }
            column(SelltoCustomerNo_Lbl; FieldCaption("Sell-to Customer No."))
            {
            }
            column(VATRegistrationNo; GetCustomerVATRegistrationNumber())
            {
            }
            column(VATRegistrationNo_Lbl; GetCustomerVATRegistrationNumberLbl())
            {
            }
            column(GlobalLocationNumber; GetCustomerGlobalLocationNumber())
            {
            }
            column(GlobalLocationNumber_Lbl; GetCustomerGlobalLocationNumberLbl())
            {
            }
            column(LegalEntityType; Cust.GetLegalEntityType())
            {
            }
            column(LegalEntityType_Lbl; Cust.GetLegalEntityTypeLbl())
            {
            }
            column(Copy_Lbl; CopyLbl)
            {
            }
            column(EMail_Header_Lbl; EMailLbl)
            {
            }
            column(HomePage_Header_Lbl; HomePageLbl)
            {
            }
            column(InvoiceDiscountBaseAmount_Lbl; InvDiscBaseAmtLbl)
            {
            }
            column(InvoiceDiscountAmount_Lbl; InvDiscountAmtLbl)
            {
            }
            column(LineAmountAfterInvoiceDiscount_Lbl; LineAmtAfterInvDiscLbl)
            {
            }
            column(LocalCurrency_Lbl; LocalCurrencyLbl)
            {
            }
            column(ExchangeRateASText; ExchangeRateText)
            {
            }
            column(Page_Lbl; PageLbl)
            {
            }
            column(SalesInvoiceLineDiscount_Lbl; SalesInvLineDiscLbl)
            {
            }
            column(DocumentTitle_Lbl; SalesCreditMemoLbl)
            {
            }
            column(ShowWorkDescription; ShowWorkDescription)
            {
            }
            column(Subtotal_Lbl; SubtotalLbl)
            {
            }
            column(Total_Lbl; TotalLbl)
            {
            }
            column(VATAmount_Lbl; VATAmtLbl)
            {
            }
            column(VATBase_Lbl; VATBaseLbl)
            {
            }
            column(VATAmountSpecification_Lbl; VATAmtSpecificationLbl)
            {
            }
            column(VATClauses_Lbl; VATClausesLbl)
            {
            }
            column(VATIdentifier_Lbl; VATIdentifierLbl)
            {
            }
            column(VATPercentage_Lbl; VATPercentageLbl)
            {
            }
            column(VATClause_Lbl; VATClause.TableCaption())
            {
            }
            column(LogInteractionEnable; LogInteractionEnable)
            {
            }
            column(SalesPrepCreditMemoNoLbl; SalesPrepCreditMemoNoLbl)
            {
            }
            column(SalesCreditMemoNoLbl; SalesCreditMemoNoLbl)
            {
            }


            column(DocumentNo_; "No.")
            {
            }
            column(SalesPersonCode; "Salesperson Code")
            {
            }
            column(A01RespCenterName; UnitName)
            {
            }
            column(A01RespCenterAddress; UnitAddress)
            {
            }
            column(A01respCenterCity; City)
            {
            }
            column(A01RespCenterPostCode; PostCode)
            {
            }
            column(A01Customer_Name; Header."Sell-to Customer Name")
            {
            }
            column(CustAddress; CustAddress)
            {
            }
            column(CustomerPhone; CustomerPhone)
            {
            }
            column(A01PostingDate; Format("Posting Date"))
            {
            }
            column(A01DateOfPrint; Format(Today))
            {
            }
            column(A01Vendor_Name; SalesPersonCode.Name)
            {
            }
            column(Salesperson_Code; "Salesperson Code")
            {
            }
            column(SalesInvoiceLbl; SalesInvoiceLbl)
            {
            }
            column(DocumentNo_Lbl; InvNoLbl)
            {
            }
            column(InvoiceDateLbl; InvoiceDateLbl)
            {
            }
            column(DateofprintLbl; DateofprintLbl)
            {
            }
            column(VendorNameLbl; VendorNameLbl)
            {
            }
            column(VendorMatriculeLbl; VendorMatriculeLbl)
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
            column(CustomerNameLbl; CustomerNameLbl)
            {
            }
            column(CustomerAddressLbl; CustomerAddressLbl)
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
            column(rcs; rcs)
            {
            }
            column(nif; nif)
            {
            }
            column(stat; stat)
            {
            }
            column(CustomerPhoneLbl; CustomerPhoneLbl)
            {
            }
            column(ProductCodeLbl; ProductCodeLbl)
            {
            }
            column(DesignationLbl; DesignationLbl)
            {
            }
            column(QuantityLbl; QuantityLbl)
            {
            }
            column(UnitPriceLbl; UnitPriceLbl)
            {
            }
            column(DiscountPercentLbl; DiscountPercentLbl)
            {
            }
            column(DiscountAmountLbl; DiscountAmountLbl)
            {
            }
            column(HTPriceLbl; HTPriceLbl)
            {
            }
            column(VAT20Lbl; VAT20Lbl)
            {
            }
            column(TTCPriceLbl; TTCPriceLbl)
            {
            }
            column(ArrestedOfSumLbl; ArrestedOfSumLbl)
            {
            }
            column(ClientSignLbl; ClientSignLbl)
            {
            }
            column(CompanySignLbl; CompanySignLbl)
            {
            }
            column(Afk_mountInWords; Afk_AmountInWords)
            {
            }
            column(VATText; VATText)
            {
            }
            column(AfkLinesNumber; AfkLinesNumber)
            {
            }
            column(AfkCurrCod; AfkCurrCod)
            {
            }
            column(LocationLbl; LocationLbl)
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
            dataitem(Line; "Sales Cr.Memo Line")
            {
                DataItemLink = "Document No." = field("No.");
                DataItemLinkReference = Header;
                DataItemTableView = sorting("Document No.", "Line No.");
                column(LineNo_Line; "Line No.")
                {
                }
                column(AmountExcludingVAT_Line; Amount)
                {
                    AutoFormatExpression = GetCurrencyCode();
                    AutoFormatType = 1;
                }
                column(AmountExcludingVAT_Line_Lbl; FieldCaption(Amount))
                {
                }
                column(AmountIncludingVAT_Line; "Amount Including VAT")
                {
                    AutoFormatExpression = GetCurrencyCode();
                    AutoFormatType = 1;
                }
                column(AmountIncludingVAT_Line_Lbl; FieldCaption("Amount Including VAT"))
                {
                    AutoFormatExpression = GetCurrencyCode();
                    AutoFormatType = 1;
                }
                column(Description_Line; Description)
                {
                }
                column(Location_Code; "Location Code")
                {
                }
                column(Description_Line_Lbl; FieldCaption(Description))
                {
                }
                column(LineDiscountPercent_Line; "Line Discount %")
                {
                }
                column(LineDiscountPercentText_Line; LineDiscountPctText)
                {
                }
                column(LineAmount_Line; FormattedLineAmount)
                {
                    AutoFormatExpression = GetCurrencyCode();
                    AutoFormatType = 1;
                }
                column(LineAmount_Line_Lbl; FieldCaption("Line Amount"))
                {
                }
                column(ItemNo_Line; "No.")
                {
                }
                column(ItemNo_Line_Lbl; FieldCaption("No."))
                {
                }
                column(ItemReferenceNo_Line; "Item Reference No.")
                {
                }
                column(ItemReferenceNo_Line_Lbl; FieldCaption("Item Reference No."))
                {
                }
                column(ShipmentDate_Line; Format("Shipment Date"))
                {
                }
                column(ShipmentDate_Line_Lbl; PostedShipmentDateLbl)
                {
                }
                column(Quantity_Line; FormattedQuantity)
                {
                }
                column(Quantity_Line_Lbl; FieldCaption(Quantity))
                {
                }
                column(Type_Line; Format(Type))
                {
                }
                column(UnitPrice; FormattedUnitPrice)
                {
                    AutoFormatExpression = GetCurrencyCode();
                    AutoFormatType = 2;
                }
                column(UnitPrice_Lbl; FieldCaption("Unit Price"))
                {
                }
                column(UnitOfMeasure; "Unit of Measure")
                {
                }
                column(UnitOfMeasure_Lbl; FieldCaption("Unit of Measure"))
                {
                }
                column(VATIdentifier_Line; "VAT Identifier")
                {
                }
                column(VATIdentifier_Line_Lbl; FieldCaption("VAT Identifier"))
                {
                }
                column(VATPct_Line; FormattedVATPct)
                {
                }
                column(VATPct_Line_Lbl; FieldCaption("VAT %"))
                {
                }
                column(TransHeaderAmount; TransHeaderAmount)
                {
                    AutoFormatExpression = Header."Currency Code";
                    AutoFormatType = 1;
                }
                column(AfkIsLine; AfkIsLine)
                {
                }
                column(AfkNumLigne; NumLigneText)
                {
                }
                column(A01Description_Line; Line.Description)
                {
                }
                column(A01LineDiscountPercent_Line; "Line Discount %")
                {
                }
                column(A01Line_Discount_Amount; A01FormattedLineDiscountAmount)
                {
                    AutoFormatExpression = Header."Currency Code";
                    AutoFormatType = 1;
                }
                column(A01LineAmount_Line; A01FormattedAmtHT)
                {
                    AutoFormatExpression = Header."Currency Code";
                    AutoFormatType = 1;
                }
                column(A01LineAmountTTC_Line; FormattedLineAmountTTC)
                {
                    AutoFormatExpression = Header."Currency Code";
                    AutoFormatType = 1;
                }
                column(A01LineQty; A01LineQtyFormatted)
                {
                }
                column(A01LinePU; A01LinePUFormatted)
                {
                    AutoFormatExpression = Header."Currency Code";
                    AutoFormatType = 2;
                }
                column(A01AmountVAT_Line; A01FormattedVAT)
                {
                    AutoFormatExpression = Header."Currency Code";
                    AutoFormatType = 1;
                }
                column(A01FormattedVAT; A01FormattedVAT)
                {
                }
                column(A01DiscountedPrice; A01DiscountedPriceText)
                {
                    AutoFormatExpression = Header."Currency Code";
                    AutoFormatType = 2;
                }
                dataitem(ShipmentLine; "Sales Shipment Buffer")
                {
                    DataItemTableView = sorting("Document No.", "Line No.", "Entry No.");
                    UseTemporary = true;
                    column(DocumentNo_ShipmentLine; "Document No.")
                    {
                    }
                    column(PostingDate_ShipmentLine; "Posting Date")
                    {
                    }
                    column(PostingDate_ShipmentLine_Lbl; FieldCaption("Posting Date"))
                    {
                    }
                    column(Quantity_ShipmentLine; Quantity)
                    {
                        DecimalPlaces = 0 : 5;
                    }
                    column(Quantity_ShipmentLine_Lbl; FieldCaption(Quantity))
                    {
                    }

                    trigger OnPreDataItem()
                    begin
                        SetRange("Line No.", Line."Line No.");
                    end;
                }
                dataitem(AssemblyLine; "Posted Assembly Line")
                {
                    DataItemTableView = sorting("Document No.", "Line No.");
                    UseTemporary = true;
                    column(LineNo_AssemblyLine; "No.")
                    {
                    }
                    column(Description_AssemblyLine; Description)
                    {
                    }
                    column(Quantity_AssemblyLine; Quantity)
                    {
                        DecimalPlaces = 0 : 5;
                    }
                    column(UnitOfMeasure_AssemblyLine; GetUOMText("Unit of Measure Code"))
                    {
                    }
                    column(VariantCode_AssemblyLine; "Variant Code")
                    {
                    }

                    trigger OnPreDataItem()
                    var
                        ValueEntry: Record "Value Entry";
                    begin
                        Clear(AssemblyLine);
                        if not DisplayAssemblyInformation then
                            CurrReport.Break();
                        GetAssemblyLinesForDocument(
                          AssemblyLine, ValueEntry."Document Type"::"Sales Credit Memo", Line."Document No.", Line."Line No.");
                    end;
                }
                // Line
                trigger OnAfterGetRecord()
                var
                    tempHT: Decimal;
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

                    SalesLineRec.Reset();
                    SalesLineRec.SetRange("Document No.", Header."No.");
                    if SalesLineRec.FindFirst() then
                        VATText := VAT20Lbl + ' (' + Format(SalesLineRec."VAT %") + ')';

                    InitializeSalesShipmentLine();
                    if Type = Type::"G/L Account" then
                        // "No." := '';
                        CurrReport.Skip();

                    OnLineOnAfterGetRecordOnBeforeCheckLineDiscount(Line, Header);
                    // if "Line Discount %" = 0 then
                    //     LineDiscountPctText := ''
                    // else
                    LineDiscountPctText := StrSubstNo('%1%', -Round("Line Discount %", 0.1));

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

                    TransHeaderAmount += PrevLineAmount;
                    PrevLineAmount := "Line Amount";
                    TotalSubTotal += "Line Amount";
                    TotalInvDiscAmount -= "Inv. Discount Amount";
                    TotalAmount += Amount;
                    TotalAmountVAT += "Amount Including VAT" - Amount;
                    TotalAmountInclVAT += "Amount Including VAT";
                    TotalPaymentDiscOnVAT += -("Line Amount" - "Inv. Discount Amount" - "Amount Including VAT");

                    FormatLineValues(Line);

                    if FirstLineHasBeenOutput then
                        Clear(DummyCompanyInfo.Picture);
                    FirstLineHasBeenOutput := true;
                end;

                trigger OnPreDataItem()
                begin
                    VATAmountLine.DeleteAll();
                    VATClauseLine.DeleteAll();
                    ShipmentLine.Reset();
                    ShipmentLine.DeleteAll();
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
                    DummyCompanyInfo.Picture := CompanyInfo.Picture;
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
                    SetRange(Number, 1, 10);
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
                    AutoFormatExpression = Line.GetCurrencyCode();
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

                    if "VAT Clause Code" <> '' then begin
                        VATClauseLine := VATAmountLine;
                        if VATClauseLine.Insert() then;
                    end;
                end;

                trigger OnPreDataItem()
                begin
                    Clear(VATBaseLCY);
                    Clear(VATAmountLCY);

                    TotalVATBaseLCY := 0;
                    TotalVATAmountLCY := 0;
                end;
            }
            dataitem(VATClauseLine; "VAT Amount Line")
            {
                DataItemTableView = sorting("VAT Identifier", "VAT Calculation Type", "Tax Group Code", "Use Tax", Positive);
                UseTemporary = true;
                column(VATIdentifier_VATClauseLine; "VAT Identifier")
                {
                }
                column(Code_VATClauseLine; VATClause.Code)
                {
                }
                column(Code_VATClauseLine_Lbl; VATClause.FieldCaption(Code))
                {
                }
                column(Description_VATClauseLine; VATClauseText)
                {
                }
                column(Description2_VATClauseLine; VATClause."Description 2")
                {
                }
                column(VATAmount_VATClauseLine; "VAT Amount")
                {
                    AutoFormatExpression = Header."Currency Code";
                    AutoFormatType = 1;
                }
                column(NoOfVATClauses; Count)
                {
                }

                trigger OnAfterGetRecord()
                begin
                    if "VAT Clause Code" = '' then
                        CurrReport.Skip();
                    if not VATClause.Get("VAT Clause Code") then
                        CurrReport.Skip();
                    VATClauseText := VATClause.GetDescriptionText(Header);
                end;
            }
            dataitem(ReportTotalsLine; "Report Totals Buffer")
            {
                DataItemTableView = sorting("Line No.");
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
            }
            dataitem(Totals; "Integer")
            {
                DataItemTableView = sorting(Number) where(Number = const(1));
                column(TotalNetAmount; Format(TotalAmount, 0, AutoFormat.ResolveAutoFormat("Auto Format"::AmountFormat, Header."Currency Code")))
                {
                }
                column(TotalVATBaseLCY; TotalVATBaseLCY)
                {
                }
                column(TotalAmountIncludingVAT; Format(TotalAmountInclVAT, 0, AutoFormat.ResolveAutoFormat("Auto Format"::AmountFormat, Header."Currency Code")))
                {
                }
                column(TotalVATAmount; Format(TotalAmountVAT, 0, AutoFormat.ResolveAutoFormat("Auto Format"::AmountFormat, Header."Currency Code")))
                {
                }
                column(TotalVATAmountLCY; TotalVATAmountLCY)
                {
                }
                column(TotalInvoiceDiscountAmount; Format(TotalInvDiscAmount, 0, AutoFormat.ResolveAutoFormat("Auto Format"::AmountFormat, Header."Currency Code")))
                {
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
                column(TotalSubTotal; Format(TotalSubTotal, 0, AutoFormat.ResolveAutoFormat("Auto Format"::AmountFormat, Header."Currency Code")))
                {
                }
                column(TotalSubTotalMinusInvoiceDiscount; Format(TotalSubTotal + TotalInvDiscAmount, 0, AutoFormat.ResolveAutoFormat("Auto Format"::AmountFormat, Header."Currency Code")))
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
                column(AfkTotalAmount_LCY; AfkTotalAmount_LCY)
                {
                }
                column(AfkTotalAmount_LCYText; AfkTotalAmount_LCYText)
                {
                }
                column(Afk_AmountInWords; Afk_AmountInWords)
                {
                }
                column(AfkTotalAmountInclVAT_LCY; AfkTotalAmountInclVAT_LCY)
                {
                }
                column(AfkTotalAmountInclVAT_LCYText; AfkTotalAmountInclVAT_LCYText)
                {
                }
                column(AfkTotalVAT_LCY; AfkTotalVAT_LCY)
                {
                }
                column(AfkTotalVAT_LCYText; AfkTotalVAT_LCYText)
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
                    AfkLocalCurrencyCaption := AfkDeviseLbl;

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
                Currency: Record Currency;
                GeneralLedgerSetup: Record "General Ledger Setup";
                Language: Codeunit Language;
            begin
                if not IsReportInPreviewMode() then
                    CODEUNIT.Run(CODEUNIT::"Sales Cr. Memo-Printed", Header);

                OnHeaderOnAfterGetRecordOnAfterUpdateNoPrinted(IsReportInPreviewMode(), Header);

                CalcFields("Work Description");
                ShowWorkDescription := "Work Description".HasValue;
                CurrReport.Language := Language.GetLanguageIdOrDefault("Language Code");
                CurrReport.FormatRegion := Language.GetFormatRegionOrDefault("Format Region");
                FormatAddr.SetLanguageCode("Language Code");

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

                if SalesPersonCode.Get(Header."Salesperson Code") then
                    VendorName := SalesPersonCode.Name;

                if RespCenter.Get(Header."Responsibility Center") then begin
                    UnitName := RespCenter.Name;
                    UnitAddress := RespCenter.Address;
                    City := RespCenter.City;
                    PostCode := RespCenter."Post Code";
                    UnitPhone := RespCenter."Phone No.";
                end;

                if Cust.Get(Header."Sell-to Customer No.") then begin
                    rcs := Cust."A01 RCS";
                    stat := Cust."A01 STAT";
                    nif := Cust."A01 NIF";
                    CustAddress := Cust.Address;
                    CustomerPhone := Cust."Phone No.";
                end;

                if OptionValue = OptionValue::LogoCosmos then
                    OptionType := 1
                else
                    OptionType := 0;

                // if Cust.Get(Header."Sell-to Customer No.") then
                //     if Cust."A01 Customer Type" = Cust."A01 Customer Type"::Miscellaneous then begin
                //         if ContactInfo.Get(Header."A01 Miscellaneous Contact") then begin
                //             CustomerPhone := ContactInfo."Phone No.";
                //             rcs := ContactInfo."A01 RCS";
                //             stat := ContactInfo."A01 STAT";
                //             nif := ContactInfo."A01 NIF";
                //             CustAddress := ContactInfo.Address;
                //         end;
                //     end else begin
                //         if Cust.Get(Header."Sell-to Customer No.") then begin
                //             CustomerPhone := Cust."Phone No.";
                //             rcs := Cust."A01 RCS";
                //             stat := Cust."A01 STAT";
                //             nif := Cust."A01 NIF";
                //             CustAddress := Cust.Address;
                //         end;
                //     end;

                FormatAddressFields(Header);
                FormatDocumentFields(Header);
                if SellToContact.Get("Sell-to Contact No.") then;
                if BillToContact.Get("Bill-to Contact No.") then;

                if not Cust.Get("Bill-to Customer No.") then
                    Clear(Cust);

                if not CompanyBankAccount.Get(Header."Company Bank Account Code") then
                    CompanyBankAccount.CopyBankFieldsFromCompanyInfo(CompanyInfo);

                if "Currency Code" <> '' then begin
                    CurrencyExchangeRate.FindCurrency("Posting Date", "Currency Code", 1);
                    CalculatedExchRate :=
                      Round(1 / "Currency Factor" * CurrencyExchangeRate."Exchange Rate Amount", 0.000001);
                    ExchangeRateText := StrSubstNo(ExchangeRateTxt, CalculatedExchRate, CurrencyExchangeRate."Exchange Rate Amount");
                    CurrCode := "Currency Code";
                    if Currency.Get("Currency Code") then
                        CurrSymbol := Currency.GetCurrencySymbol();
                end else
                    if GeneralLedgerSetup.Get() then begin
                        CurrCode := GeneralLedgerSetup."LCY Code";
                        CurrSymbol := GeneralLedgerSetup.GetCurrencySymbol();
                    end;

                TotalSubTotal := 0;
                TotalInvDiscAmount := 0;
                TotalAmount := 0;
                TotalAmountVAT := 0;
                TotalAmountInclVAT := 0;
                TotalPaymentDiscOnVAT := 0;
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
            area(Content)
            {
                group(GroupName)
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
            // area(processing)
            // {
            //     action(LayoutName)
            //     {
            //         ApplicationArea = All;

            //     }
            // }
        }
        trigger OnInit()
        begin
            LogInteractionEnable := true;
        end;

        trigger OnOpenPage()
        begin
            InitLogInteraction();
            LogInteractionEnable := LogInteraction;
        end;
    }

    // rendering
    // {
    //     layout(LayoutName)
    //     {
    //         Type = Excel;
    //         LayoutFile = 'mySpreadsheet.xlsx';
    //     }
    // }

    trigger OnInitReport()
    var
        SalesCrMemoHeader: Record "Sales Cr.Memo Header";
        IsHandled: Boolean;
    begin
        GLSetup.Get();
        CompanyInfo.SetAutoCalcFields(Picture);
        CompanyInfo.Get();
        SalesSetup.Get();
        CompanyInfo.VerifyAndSetPaymentInfo();

        if SalesCrMemoHeader.GetLegalStatement() <> '' then
            LegalStatementLbl := SalesCrMemoHeader.GetLegalStatement();

        IsHandled := false;
        OnInitReportForGlobalVariable(IsHandled, LegalOfficeTxt, LegalOfficeLbl, CustomGiroTxt, CustomGiroLbl, LegalStatementLbl);
#if not CLEAN23
        if not IsHandled then begin
            // LegalOfficeTxt := CompanyInfo.GetLegalOffice();
            // LegalOfficeLbl := CompanyInfo.GetLegalOfficeLbl();
            // CustomGiroTxt := CompanyInfo.GetCustomGiro();
            // CustomGiroLbl := CompanyInfo.GetCustomGiroLbl();
        end;
#endif
    end;

    trigger OnPostReport()
    begin
        if LogInteraction and not IsReportInPreviewMode() then
            if Header.FindSet() then
                repeat
                    if Header."Bill-to Contact No." <> '' then
                        SegManagement.LogDocument(
                          6, Header."No.", 0, 0, DATABASE::Contact, Header."Bill-to Contact No.", Header."Salesperson Code",
                          Header."Campaign No.", Header."Posting Description", '')
                    else
                        SegManagement.LogDocument(
                          6, Header."No.", 0, 0, DATABASE::Customer, Header."Bill-to Customer No.", Header."Salesperson Code",
                          Header."Campaign No.", Header."Posting Description", '');
                until Header.Next() = 0;
    end;

    trigger OnPreReport()
    begin
        if Header.GetFilters = '' then
            Error(NoFilterSetErr);

        if not CurrReport.UseRequestPage then
            InitLogInteraction();

        RespCenterUditec.Get('UDT');
        CompInfo.Get();

        CompanyLogoPosition := SalesSetup."Logo Position on Documents";
    end;

    var
        GLSetup: Record "General Ledger Setup";
        PaymentMethod: Record "Payment Method";
        CompanyBankAccount: Record "Bank Account";
        DummyCompanyInfo: Record "Company Information";
        SalesSetup: Record "Sales & Receivables Setup";
        Cust: Record Customer;
        CompInfo: Record "Company Information";
        RespCenterUditec: Record "Responsibility Center";
        SalesLineRec: Record "Sales Cr.Memo Line";
        SalesPersonCode: Record "Salesperson/Purchaser";
        RespCenter: Record "Responsibility Center";
        CurrencyExchangeRate: Record "Currency Exchange Rate";
        AfkLocalCurrency: Record Currency;
        AfkCurrency: Record Currency;
        // ContactInfo: Record Contact;
        RepCheck: Report Check;
        // Language: Codeunit Language;
        FormatAddr: Codeunit "Format Address";
        FormatDocument: Codeunit "Format Document";
        SegManagement: Codeunit SegManagement;
        AutoFormat: Codeunit "Auto Format";
        OptionValue: Option LogoCosmos,LogoUditec;
        WorkDescriptionInstream: InStream;
        OptionType: Integer;
        WorkDescriptionLine: Text;
        MoreLines: Boolean;
        CopyText: Text[30];
        ShowWorkDescription: Boolean;
        LogInteraction: Boolean;
        TransHeaderAmount: Decimal;
        LogInteractionEnable: Boolean;
        CompanyLogoPosition: Integer;
        CalculatedExchRate: Decimal;
        ExchangeRateText: Text;
        PrevLineAmount: Decimal;
        AppliesToText: Text;
        CurrCode: Text[10];
        CurrSymbol: Text[10];
        UnitName: Text[100];
        UnitAddress: Text[100];
        City: Code[30];
        PostCode: Code[20];
        rcs: Code[30];
        nif: Code[30];
        stat: Code[30];
        VATText: Text[50];
        CustomerPhone: Text[30];
        CustAddress: Text[100];
        Afk_AmountInWords: Text;
        AfkIsLine: Integer;
        NumLigneText: Code[2];
        A01FormattedLineDiscountAmount: Text[50];
        A01LineQtyFormatted: Text[50];
        A01LinePUFormatted: Text[50];
        A01FormattedVAT: Text[50];
        A01DiscountedPriceText: Text[50];
        A01FormattedAmtHT: Text[50];
        FormattedLineAmountTTC: Text;
        NumLigne: Integer;
        A01LineQty: Decimal;
        A01LinePU: Decimal;
        A01DiscountedPrice: Decimal;
        AfkLinesNumber: Integer;
        AfkFormattedTotalVAT: Text[50];
        AfkFormattedTotalHT: Text[50];
        AfkFormattedTotalTTC: Text[50];
        AfkTotalAmount_LCY: Decimal;
        AfkTotalAmount_LCYText: Text[50];
        AfkTotalAmountInclVAT_LCY: Decimal;
        AfkTotalAmountInclVAT_LCYText: Text[50];
        AfkTotalVAT_LCY: Decimal;
        AfkTotalVAT_LCYText: Text[50];
        AfkLocalCurrencyText: Text[100];
        AfkLocalCurrencyCaption: Text[50];
        AfkTotalVAT_LCYCaption: Text[50];
        AfkTotalAmount_LCYCaption: Text[50];
        AfkTotalAmountInclVAT_LCYCaption: Text[50];
        TotalAmountExclInclVATTextValue: Text;
        TotalAmountExclInclVATValue: Decimal;
        NoText: array[2] of Text;
        AfkCurrCod: Code[20];
        AfkCurrCode: Code[20];
        AfkCurrencyName: Text;
        AfkLocalCurrencyName: Text;
        VendorName: Text[50];
        UnitPhone: Text[30];
        AfkDeviseLbl: Label 'Currency :';
        SalesInvoiceLbl: Label 'CREDIT MEMO';
        InvoiceDateLbl: Label 'Invoice Date :';
        DateofprintLbl: Label 'Date of print :';
        VendorNameLbl: Label 'Vendor name :';
        VendorMatriculeLbl: Label 'Vendor matricule :';
        UnitNameLbl: Label 'Unit name :';
        UnitAddressLbl: Label 'Unit address :';
        UnitCityLbl: Label 'City';
        UnitPostalCodeLbl: Label 'Postal code :';
        CustomerNameLbl: Label 'Customer Name :';
        CustomerAddressLbl: Label 'Customer address :';
        NIFLbl: Label 'NIF :';
        STATLbl: Label 'STAT :';
        RCSLbl: Label 'RCS :';
        CustomerPhoneLbl: Label 'Phone :';
        ProductCodeLbl: Label 'Code';
        DesignationLbl: Label 'Designation';
        QuantityLbl: Label 'Qty';
        UnitPriceLbl: Label 'U.P (HT)';
        DiscountPercentLbl: Label 'Discount';
        DiscountAmountLbl: Label 'Amount (HT)';
        HTPriceLbl: Label 'Total HT';
        VAT20Lbl: Label 'VAT';
        TTCPriceLbl: Label 'Total TTC';
        ArrestedOfSumLbl: Label 'TTC AMOUNT :';
        ClientSignLbl: Label 'Client Signature';
        CompanySignLbl: Label 'Company signature';
        LocationLbl: Label 'Location';
        SalesCreditMemoNoLbl: Label 'Sales - Credit Memo %1', Comment = '%1 Credit Memo.';
        SalespersonLbl: Label 'Sales person';
        CompanyInfoBankAccNoLbl: Label 'Account No.';
        CompanyInfoBankNameLbl: Label 'Bank';
        CompanyInfoGiroNoLbl: Label 'Giro No.';
        CompanyInfoPhoneNoLbl: Label 'Phone No.';
        CopyLbl: Label 'Copy';
        EMailLbl: Label 'Email';
        HomePageLbl: Label 'Home Page';
        InvDiscBaseAmtLbl: Label 'Invoice Discount Base Amount';
        InvDiscountAmtLbl: Label 'Invoice Discount';
        InvNoLbl: Label 'Credit Memo No.';
        LineAmtAfterInvDiscLbl: Label 'Payment Discount on VAT';
        LocalCurrencyLbl: Label 'Local Currency';
        PageLbl: Label 'Page';
        PaymentTermsDescLbl: Label 'Payment Terms';
        PaymentMethodDescLbl: Label 'Payment Method';
        PostedShipmentDateLbl: Label 'Shipment Date';
        SalesInvLineDiscLbl: Label 'Discount %';
        SalesCreditMemoLbl: Label 'Credit Memo';
        ShipmentLbl: Label 'Shipment';
        ShiptoAddrLbl: Label 'Ship-to Address';
        ShptMethodDescLbl: Label 'Shipment Method';
        SubtotalLbl: Label 'Subtotal';
        TotalLbl: Label 'Total';
        VATAmtSpecificationLbl: Label 'VAT Amount Specification';
        VATAmountLCYLbl: Label 'VAT Amount (LCY)';
        VATBaseLbl: Label 'VAT Base';
        VATBaseLCYLbl: Label 'VAT Base (LCY)';
        VATClausesLbl: Label 'VAT Clause';
        VATIdentifierLbl: Label 'VAT Identifier';
        VATPercentageLbl: Label 'VAT %';
        SellToContactPhoneNoLbl: Label 'Sell-to Contact Phone No.';
        SellToContactMobilePhoneNoLbl: Label 'Sell-to Contact Mobile Phone No.';
        SellToContactEmailLbl: Label 'Sell-to Contact E-Mail';
        BillToContactPhoneNoLbl: Label 'Bill-to Contact Phone No.';
        BillToContactMobilePhoneNoLbl: Label 'Bill-to Contact Mobile Phone No.';
        BillToContactEmailLbl: Label 'Bill-to Contact E-Mail';
        SalesPrepCreditMemoNoLbl: Label 'Sales - Prepmt. Credit Memo %1', Comment = '%1 Credit Memo.';
        ExchangeRateTxt: Label 'Exchange rate: %1/%2', Comment = '%1 and %2 are both amounts.';
        AppliesToTextLbl: Label 'Applies to Document';
        NoFilterSetErr: Label 'You must specify one or more filters to avoid accidently printing all documents.';
        GreetingLbl: Label 'Hello';
        ClosingLbl: Label 'Sincerely';
        BodyLbl: Label 'Thank you for your business. Your credit memo is attached to this message.';
        LCYTxt: label ' (LCY)';
        IncludesGoodsLbl: Label 'Sales credit memo includes only goods.';
        IncludesServicesLbl: Label 'Sales credit memo includes only services.';
        IncludesGoodsAndServicesLbl: Label 'Sales credit memo includes goods and services.';
        VATClauseText: Text;
        LegalOfficeTxt, LegalOfficeLbl, CustomGiroTxt, CustomGiroLbl, LegalStatementLbl : Text;

    protected var
        CompanyInfo: Record "Company Information";
        PaymentTerms: Record "Payment Terms";
        SalespersonPurchaser: Record "Salesperson/Purchaser";
        ShipmentMethod: Record "Shipment Method";
        SellToContact: Record Contact;
        BillToContact: Record Contact;
        VATClause: Record "VAT Clause";
        CustAddr: array[8] of Text[100];
        ShipToAddr: array[8] of Text[100];
        CompanyAddr: array[8] of Text[100];
        FormattedLineAmount: Text;
        FormattedQuantity: Text;
        FormattedUnitPrice: Text;
        FormattedVATPct: Text;
        LineDiscountPctText: Text;
        SalesPersonText: Text[50];
        TotalText: Text[50];
        TotalExclVATText: Text[50];
        TotalInclVATText: Text[50];
        TotalAmount: Decimal;
        TotalAmountInclVAT: Decimal;
        TotalAmountVAT: Decimal;
        TotalSubTotal: Decimal;
        TotalInvDiscAmount: Decimal;
        TotalPaymentDiscOnVAT: Decimal;
        DisplayAssemblyInformation: Boolean;
        DisplayShipmentInformation: Boolean;
        FirstLineHasBeenOutput: Boolean;
        ShowShippingAddr: Boolean;
        VATBaseLCY: Decimal;
        VATAmountLCY: Decimal;
        TotalVATBaseLCY: Decimal;
        TotalVATAmountLCY: Decimal;
        VATAmtLbl: Label 'VAT Amount';

    local procedure InitLogInteraction()
    begin
        LogInteraction := SegManagement.FindInteractionTemplateCode(Enum::"Interaction Log Entry Document Type"::"Sales Cr. Memo") <> '';
    end;

    local procedure InitializeSalesShipmentLine(): Date
    var
        ReturnReceiptHeader: Record "Return Receipt Header";
        SalesShipmentBuffer2: Record "Sales Shipment Buffer";
    begin
        if Line."Return Receipt No." <> '' then
            if ReturnReceiptHeader.Get(Line."Return Receipt No.") then
                exit(ReturnReceiptHeader."Posting Date");
        if Header."Return Order No." = '' then
            exit(Header."Posting Date");
        if Line.Type = Line.Type::" " then
            exit(0D);

        ShipmentLine.GetLinesForSalesCreditMemoLine(Line, Header);

        ShipmentLine.Reset();
        ShipmentLine.SetRange("Line No.", Line."Line No.");
        if ShipmentLine.Find('-') then begin
            SalesShipmentBuffer2 := ShipmentLine;
            if not DisplayShipmentInformation then
                if ShipmentLine.Next() = 0 then begin
                    ShipmentLine.Get(
                      SalesShipmentBuffer2."Document No.", SalesShipmentBuffer2."Line No.", SalesShipmentBuffer2."Entry No.");
                    ShipmentLine.Delete();
                    exit(SalesShipmentBuffer2."Posting Date");
                end;
            ShipmentLine.CalcSums(Quantity);
            if ShipmentLine.Quantity <> Line.Quantity then begin
                ShipmentLine.DeleteAll();
                exit(Header."Posting Date");
            end;
        end;
        exit(Header."Posting Date");
    end;

    protected procedure IsReportInPreviewMode(): Boolean
    var
        MailManagement: Codeunit "Mail Management";
    begin
        exit(CurrReport.Preview() or MailManagement.IsHandlingGetEmailBody());
    end;

    local procedure DocumentCaption(): Text[250]
    var
        DocCaption: Text[250];
    begin
        OnBeforeDocumentCaption(Header, DocCaption);
        if DocCaption <> '' then
            exit(DocCaption);

        if Header."Prepayment Credit Memo" then
            exit(SalesPrepCreditMemoNoLbl);
        exit(SalesCreditMemoNoLbl);
    end;

    procedure InitializeRequest(NewLogInteraction: Boolean; DisplayAsmInfo: Boolean)
    begin
        LogInteraction := NewLogInteraction;
        DisplayAssemblyInformation := DisplayAsmInfo;
    end;

    local procedure GetGoodsAndServicesText(): Text
    var
        SalesCrMemoLine: Record "Sales Cr.Memo Line";
        GotGoods: Boolean;
        GotServices: Boolean;
    begin
        SalesCrMemoLine.SetRange("Document No.", Header."No.");
        SalesCrMemoLine.SetFilter(Type, '<> %1', SalesCrMemoLine.Type::Item);
        if not SalesCrMemoLine.IsEmpty() then
            GotServices := true;
        SalesCrMemoLine.SetRange(Type, SalesCrMemoLine.Type::Item);
        SalesCrMemoLine.SetLoadFields("No.");
        if SalesCrMemoLine.FindSet() then
            repeat
                if IsItemInventory(SalesCrMemoLine."No.") then
                    GotGoods := true
                else
                    GotServices := true;
            until SalesCrMemoLine.Next() = 0;
        if GotServices then
            if GotGoods then
                exit(IncludesGoodsAndServicesLbl)
            else
                exit(IncludesServicesLbl)
        else
            exit(IncludesGoodsLbl);
    end;

    local procedure IsItemInventory(ItemNo: Code[20]): Boolean
    var
        Item: Record Item;
    begin
        Item.SetLoadFields(Type);
        if Item.Get(ItemNo) then
            exit(Item.Type = Item.Type::Inventory);
    end;

    local procedure GetVATPaidonDebitsText(): Text
    begin
        if Header."VAT Paid on Debits" then
            exit(Header.FieldCaption("VAT Paid on Debits"));
    end;

    local procedure GetUOMText(UOMCode: Code[10]): Text[50]
    var
        UnitOfMeasure: Record "Unit of Measure";
    begin
        if not UnitOfMeasure.Get(UOMCode) then
            exit(UOMCode);
        exit(UnitOfMeasure.Description);
    end;

    local procedure CreateReportTotalLines()
    begin
        ReportTotalsLine.DeleteAll();
        if (TotalInvDiscAmount <> 0) or (TotalAmountVAT <> 0) then
            ReportTotalsLine.Add(SubtotalLbl, TotalSubTotal, true, false, false);
        if TotalInvDiscAmount <> 0 then begin
            ReportTotalsLine.Add(InvDiscountAmtLbl, TotalInvDiscAmount, false, false, false);
            if TotalAmountVAT <> 0 then
                ReportTotalsLine.Add(TotalExclVATText, TotalAmount, true, false, false);
        end;
        if TotalAmountVAT <> 0 then begin
            ReportTotalsLine.Add(VATAmountLine.VATAmountText(), TotalAmountVAT, false, true, false);
            if TotalVATAmountLCY <> TotalAmountVAT then
                ReportTotalsLine.Add(VATAmountLine.VATAmountText() + LCYTxt, TotalVATAmountLCY, false, true, false);
        end;
    end;

    local procedure FormatAddressFields(var SalesCrMemoHeader: Record "Sales Cr.Memo Header")
    begin
        FormatAddr.GetCompanyAddr(SalesCrMemoHeader."Responsibility Center", RespCenter, CompanyInfo, CompanyAddr);
        FormatAddr.SalesCrMemoBillTo(CustAddr, SalesCrMemoHeader);
        ShowShippingAddr := FormatAddr.SalesCrMemoShipTo(ShipToAddr, CustAddr, SalesCrMemoHeader);
    end;

    local procedure FormatDocumentFields(SalesCrMemoHeader: Record "Sales Cr.Memo Header")
    begin
        // with SalesCrMemoHeader do begin
        FormatDocument.SetTotalLabels(SalesCrMemoHeader."Currency Code", TotalText, TotalInclVATText, TotalExclVATText);
        FormatDocument.SetSalesPerson(SalespersonPurchaser, SalesCrMemoHeader."Salesperson Code", SalesPersonText);
        FormatDocument.SetPaymentTerms(PaymentTerms, SalesCrMemoHeader."Payment Terms Code", SalesCrMemoHeader."Language Code");
        FormatDocument.SetPaymentMethod(PaymentMethod, SalesCrMemoHeader."Payment Method Code", SalesCrMemoHeader."Language Code");
        FormatDocument.SetShipmentMethod(ShipmentMethod, SalesCrMemoHeader."Shipment Method Code", SalesCrMemoHeader."Language Code");

        AppliesToText :=
          FormatDocument.SetText(SalesCrMemoHeader."Applies-to Doc. No." <> '', StrSubstNo('%1 %2', Format(SalesCrMemoHeader."Applies-to Doc. Type"), SalesCrMemoHeader."Applies-to Doc. No."));

        OnAfterFormatDocumentFields(SalesCrMemoHeader);
        // end;
    end;

    local procedure FormatLineValues(CurrLine: Record "Sales Cr.Memo Line")
    var
        IsHandled: Boolean;
    begin
        IsHandled := false;
        OnBeforeFormatLineValues(CurrLine, FormattedQuantity, FormattedUnitPrice, FormattedVATPct, FormattedLineAmount, IsHandled);
        if not IsHandled then
            FormatDocument.SetSalesCrMemoLine(CurrLine, FormattedQuantity, FormattedUnitPrice, FormattedVATPct, FormattedLineAmount);
    end;

    [IntegrationEvent(false, false)]
    local procedure OnBeforeDocumentCaption(SalesCrMemoHeader: Record "Sales Cr.Memo Header"; var DocCaption: Text[250])
    begin
    end;

    [IntegrationEvent(false, false)]
    local procedure OnBeforeFormatLineValues(SalesCrMemoLine: Record "Sales Cr.Memo Line"; var FormattedQuantity: Text; var FormattedUnitPrice: Text; var FormattedVATPercentage: Text; var FormattedLineAmount: Text; var IsHandled: Boolean)
    begin
    end;

    [IntegrationEvent(false, false)]
    local procedure OnAfterFormatDocumentFields(SalesCrMemoHeader: Record "Sales Cr.Memo Header")
    begin
    end;

    [IntegrationEvent(false, false)]
    local procedure OnLineOnAfterGetRecordOnBeforeCheckLineDiscount(var SalesCrMemoLine: Record "Sales Cr.Memo Line"; var SalesCrMemoHeader: Record "Sales Cr.Memo Header")
    begin
    end;

    [IntegrationEvent(false, false)]
    local procedure OnInitReportForGlobalVariable(var IsHandled: Boolean; var LegalOfficeTxt: Text; var LegalOfficeLbl: Text; var CustomGiroTxt: Text; var CustomGiroLbl: Text; var LegalStatementLbl: Text)
    begin
    end;

    [IntegrationEvent(true, false)]
    local procedure OnHeaderOnAfterGetRecordOnAfterUpdateNoPrinted(ReportInPreviewMode: Boolean; var SalesCrMemoHeader: Record "Sales Cr.Memo Header")
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