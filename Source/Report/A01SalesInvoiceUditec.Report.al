/// <summary>
/// Report A01 SalesInvoicePrint (ID 50030).
/// </summary>
report 50030 "A01 SalesInvoiceUditec"
{
    Caption = 'Sales Invoice Uditec';
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;
    DefaultLayout = RDLC;
    PreviewMode = PrintLayout;
    EnableHyperlinks = true;
    Permissions = tabledata "Sales Shipment Buffer" = rimd;
    WordMergeDataItem = Header;
    RDLCLayout = './Source/Report/Layout/SalesInvoiceUditec.rdl';

    dataset
    {
        dataitem(Header; "Sales Invoice Header")
        {
            DataItemTableView = sorting("No.");
            RequestFilterFields = "No.", "Sell-to Customer No.";
            RequestFilterHeading = 'Sales invoice';
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
            column(CompanyInfoName; CompanyInfo.Name)
            {
            }
            column(CompanyInfoAddress; CompanyInfo.Address)
            {
            }
            column(SalesPersonCode; "Salesperson Code")
            {
            }
            column(CompanyPic; CompanyInfo.Picture)
            {
            }
            column(CompanyPhoneNo; CompanyInfo."Phone No.")
            {
            }
            column(CompanyGiroNo; CompanyInfo."Giro No.")
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
            column(A01RespCenterUnitPhone; UnitPhone)
            {
            }
            column(A01Customer_Name; Header."Sell-to Customer Name")
            {
            }
            column(CustomerAddress; "Ship-to Name")
            {
            }
            column(CustomerIdentity; CustomerIdentity)
            {
            }
            // column(CustomerPhone; CustomerPhone)
            // {
            // }
            column(DocumentNo; "No.")
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
            column(UnitPhoneLbl; UnitPhoneLbl)
            {
            }
            column(CustomerNameLbl; CustomerNameLbl)
            {
            }
            column(CustomerIdentityLbl; CustomerIdentityLbl)
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
            column(DeliverySiteLbl; DeliverySiteLbl)
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
            column(TotalDeposit; TotalDeposit)
            {
                AutoFormatExpression = Header."Currency Code";
                AutoFormatType = 1;
            }
            column(AfkTotalDeposit_LCYText; AfkTotalDeposit_LCYText)
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
            column(CompanyVATRegNumber; CompanyInfo.GetVATRegistrationNumber())
            {
            }
            column(CompanyVATRegNumber_Lbl; CompanyInfo.GetVATRegistrationNumberLbl())
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
            column(DisplayAdditionalFeeNote; DisplayAdditionalFeeNote)
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
            column(CustomerPostalBarCode; FormatAddr.PostalBarCode(1))
            {
            }
            column(YourReference; "Your Reference")
            {
            }
            column(YourReference_Lbl; FieldCaption("Your Reference"))
            {
            }
            column(ShipmentMethodDescription; ShipmentMethod.Description)
            {
            }
            column(ShipmentDate; Format("Shipment Date", 0, 4))
            {
            }
            column(ShipmentDate_Lbl; FieldCaption("Shipment Date"))
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
            column(PaymentTermsDescription; PaymentTerms.Description)
            {
            }
            // column(PaymentTermsDescription_Lbl; PaymentTermsDescLbl)
            // {
            // }
            column(PaymentMethodDescription; PaymentMethod.Description)
            {
            }
            // column(PaymentMethodDescription_Lbl; PaymentMethodDescLbl)
            // {
            // }
            column(BilltoCustumerNo; "Bill-to Customer No.")
            {
            }
            column(BilltoCustomerNo_Lbl; FieldCaption("Bill-to Customer No."))
            {
            }
            // column(DocumentDate; Format("Document Date", 0, 4))
            // {
            // }
            // column(DocumentDate_Lbl; FieldCaption("Document Date"))
            // {
            // }
            // column(DueDate; Format("Due Date", 0, 4))
            // {
            // }
            // column(DueDate_Lbl; FieldCaption("Due Date"))
            // {
            // }
            column(PricesIncludingVAT; "Prices Including VAT")
            {
            }
            column(PricesIncludingVAT_Lbl; FieldCaption("Prices Including VAT"))
            {
            }
            column(PricesIncludingVATYesNo; Format("Prices Including VAT"))
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
            column(SellToFaxNo; GetSellToCustomerFaxNo())
            {
            }
            column(SellToPhoneNo; "Sell-to Phone No.")
            {
            }
            column(ChecksPayable_Lbl; ChecksPayableText)
            {
            }
            column(LegalEntityType; Cust.GetLegalEntityType())
            {
            }
            column(LegalEntityType_Lbl; Cust.GetLegalEntityTypeLbl())
            {
            }
            // column(EMail_Header_Lbl; EMailLbl)
            // {
            // }
            column(ExchangeRateAsText; ExchangeRateText)
            {
            }
            column(Contact_Lbl; CompanyInfo.GetContactUsText())
            {
            }
            column(DocumentTitle_Lbl; DocumentCaption())
            {
            }
            column(ShowWorkDescription; ShowWorkDescription)
            {
            }
            column(RemainingAmount; RemainingAmount)
            {
            }
            column(VATClause_Lbl; VATClause.TableCaption)
            {
            }
            column(PackageTrackingNo; "Package Tracking No.")
            {
            }
            column(PackageTrackingNo_Lbl; FieldCaption("Package Tracking No."))
            {
            }
            column(ShippingAgentCode; "Shipping Agent Code")
            {
            }
            column(PaymentInstructions_Txt; PaymentInstructionsTxt)
            {
            }
            column(ExternalDocumentNo; "External Document No.")
            {
            }
            column(ExternalDocumentNo_Lbl; FieldCaption("External Document No."))
            {
            }
            column(Afk_mountInWords; Afk_AmountInWords)
            {
            }
            column(AfkCurrCod; AfkCurrCod)
            {
            }
            column(Sell_to_Customer_No_; "Sell-to Customer No.")
            {
            }
            column(Sell_to_Customer_Name; "Sell-to Customer Name")
            {
            }
            column(CustAddress; CustAddress)
            {
            }
            column(CustomerPhone; CustomerPhone)
            {
            }
            dataitem(Line; "Sales Invoice Line")
            {
                DataItemLink = "Document No." = field("No.");
                DataItemLinkReference = Header;
                DataItemTableView = sorting("Document No.", "Line No.");
                column(LineNo_Line; "Line No.")
                {
                }
                column(ItemNo_Line; "No.")
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
                column(A01Description_Line; Line.Description)
                {
                }
                column(AmountExcludingVAT_Line; Amount)
                {
                    AutoFormatExpression = Header."Currency Code";
                    AutoFormatType = 1;
                }
                column(AmountIncludingVAT_Line; "Amount Including VAT")
                {
                    AutoFormatExpression = Header."Currency Code";
                    AutoFormatType = 1;
                }
                column(AmountIncludingVAT_Line_Lbl; FieldCaption("Amount Including VAT"))
                {
                    AutoFormatExpression = GetCurrencyCode();
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
                column(Type_Line; Format(Type))
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
                    AutoFormatExpression = Header."Currency Code";
                    AutoFormatType = 1;
                }
                column(JobTaskNo_Lbl; JobTaskNoLbl)
                {
                }
                column(JobTaskNo; JobTaskNo)
                {
                }
                column(JobTaskDescription; JobTaskDescription)
                {
                }
                column(JobTaskDesc_Lbl; JobTaskDescLbl)
                {
                }
                column(JobNo_Lbl; JobNoLbl)
                {
                }
                column(JobNo; JobNo)
                {
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
                    DataItemTableView = SORTING("Document No.", "Line No.");
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
                          AssemblyLine, ValueEntry."Document Type"::"Sales Invoice", Line."Document No.", Line."Line No.");
                    end;
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

                    InitializeShipmentLine();
                    // if Type = Type::"G/L Account" then
                    //     "No." := '';
                    // CurrReport.Skip();
                    // if "No." = 'MIR_INTEREST' then
                    //     CurrReport.Skip();
                    // if "No." = 'mir_interest' then
                    //     CurrReport.Skip();

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

                    JobNo := "Job No.";
                    JobTaskNo := "Job Task No.";

                    if JobTaskNo <> '' then begin
                        JobTaskNoLbl := JobTaskNoLbl2;
                        JobTaskDescription := GetJobTaskDescription(JobNo, JobTaskNo);
                    end else begin
                        JobTaskDescription := '';
                        JobTaskNoLbl := '';
                    end;

                    if JobNo <> '' then
                        JobNoLbl := JobNoLbl2
                    else
                        JobNoLbl := '';

                    // FormatDocument.SetSalesLine(Line, FormattedQuantity, FormattedUnitPrice, FormattedVATPct, FormattedLineAmount);
                    FormatLineValues(Line);
                end;

                trigger OnPreDataItem()
                begin
                    VATAmountLine.DeleteAll();
                    VATClauseLine.DeleteAll();
                    ShipmentLine.Reset();
                    ShipmentLine.DeleteAll();
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
            dataitem(WorkDescriptionLines; Integer)
            {
                DataItemTableView = SORTING(Number) WHERE(Number = FILTER(1 .. 99999));
                column(WorkDescriptionLineNumber; Number)
                {
                }
                column(WorkDescriptionLine; WorkDescriptionLine)
                {
                }
                trigger OnAfterGetRecord()
                var
                    TypeHelper: Codeunit "Type Helper";
                begin
                    if WorkDescriptionInstream.EOS then
                        CurrReport.Break();
                    WorkDescriptionLine := TypeHelper.ReadAsTextWithSeparator(WorkDescriptionInstream, TypeHelper.LFSeparator());
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
                // column(VATAmountLCY_VATAmountLine_Lbl; VATAmountLCYLbl)
                // {
                // }
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
                // column(VATBaseLCY_VATAmountLine_Lbl; VATBaseLCYLbl)
                // {
                // }
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

                    if ShowVATClause("VAT Clause Code") then begin
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
                DataItemTableView = SORTING("VAT Identifier", "VAT Calculation Type", "Tax Group Code", "Use Tax", Positive);
                UseTemporary = true;
                column(VATClausesHeader; VATClausesText)
                {
                }
                column(VATIdentifier_VATClauseLine; "VAT Identifier")
                {
                }
                column(Code_VATClauseLine; VATClause.Code)
                {
                }
                column(Code_VATClauseLine_Lbl; VATClause.FieldCaption(Code))
                {
                }
                column(Description_VATClauseLine; VATClause.Description)
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
                    VATClause.GetDescriptionText(Header);
                end;

                trigger OnPreDataItem()
                begin
                    if Count = 0 then
                        VATClausesText := ''
                    else
                        VATClausesText := VATClausesLbl;
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
            dataitem(LineFee; Integer)
            {
                DataItemTableView = sorting(Number) ORDER(Ascending) where(Number = filter(1 ..));
                column(LineFeeCaptionText; TempLineFeeNoteOnReportHist.ReportText)
                {
                }
                trigger OnAfterGetRecord()
                begin
                    if not DisplayAdditionalFeeNote then
                        CurrReport.Break();

                    if Number = 1 then begin
                        if not TempLineFeeNoteOnReportHist.FindSet() then
                            CurrReport.Break()
                    end else
                        if TempLineFeeNoteOnReportHist.Next() = 0 then
                            CurrReport.Break();
                end;
            }
            // dataitem(PaymentReportingArgument; "Payment Reporting Argument")
            // {
            //     DataItemTableView = SORTING(Key);
            //     UseTemporary = true;
            //     column(PaymentServiceLogo; Logo)
            //     {
            //     }
            //     column(PaymentServiceLogo_UrlText; "URL Caption")
            //     {
            //     }
            //     column(PaymentServiceLogo_Url; GetTargetURL())
            //     {
            //     }
            //     column(PaymentServiceText_UrlText; "URL Caption")
            //     {
            //     }
            //     column(PaymentServiceText_Url; GetTargetURL())
            //     {
            //     }
            // }
            dataitem(LeftHeader; "Name/Value Buffer")
            {
                DataItemTableView = SORTING(ID);
                UseTemporary = true;
                column(LeftHeaderName; Name)
                {
                }
                column(LeftHeaderValue; Value)
                {
                }
            }
            dataitem(RightHeader; "Name/Value Buffer")
            {
                DataItemTableView = sorting(ID);
                UseTemporary = true;
                column(RightHeaderName; Name)
                {
                }
                column(RightHeaderValue; Value)
                {
                }
            }
            dataitem(LetterText; "Integer")
            {
                DataItemTableView = sorting(Number) where(Number = const(1));
                // column(GreetingText; GreetingLbl)
                // {
                // }
                // column(BodyText; BodyLbl)
                // {
                // }
                // column(ClosingText; ClosingLbl)
                // {
                // }
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
            dataitem(Totals; Integer)
            {
                DataItemTableView = SORTING(Number) WHERE(Number = CONST(1));
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
                column(TotalAmountExclInclVAT; Format(TotalAmountExclInclVATValue, 0, AutoFormat.ResolveAutoFormat("Auto Format"::AmountFormat, Header."Currency Code")))
                {
                }
                column(TotalAmountExclInclVATText; TotalAmountExclInclVATTextValue)
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
                // PaymentServiceSetup: Record "Payment Service Setup";
                Language: Codeunit Language;
            begin
                CurrReport.Language := Language.GetLanguageIdOrDefault("Language Code");

                GLSetup.Get();
                GLSetup.TestField("LCY Code");
                // AfkSetup.TestField("XAF Currency Code");

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

                if SalesPersonCode.Get(Header."Salesperson Code") then
                    VendorName := SalesPersonCode.Name;

                if RespCenter.Get(Header."Responsibility Center") then begin
                    UnitName := RespCenter.Name;
                    UnitAddress := RespCenter.Address;
                    City := RespCenter.City;
                    PostCode := RespCenter."Post Code";
                    UnitPhone := RespCenter."Phone No.";
                end;

                if Cust.Get(Header."Sell-to Customer No.") then
                    if Cust."A01 Customer Type" = Cust."A01 Customer Type"::Miscellaneous then begin
                        if ContactInfo.Get(Header."A01 Miscellaneous Contact") then begin
                            CustomerPhone := ContactInfo."Phone No.";
                            rcs := ContactInfo."A01 RCS";
                            stat := ContactInfo."A01 STAT";
                            nif := ContactInfo."A01 NIF";
                            CustAddress := ContactInfo.Address;
                        end;
                    end else begin
                        if Cust.Get(Header."Sell-to Customer No.") then begin
                            CustomerPhone := Cust."Phone No.";
                            rcs := Cust."A01 RCS";
                            stat := Cust."A01 STAT";
                            nif := Cust."A01 NIF";
                            CustAddress := Cust.Address;
                        end;
                    end;


                ChecksPayableText := StrSubstNo(ChecksPayableLbl, CompanyInfo.Name);

                FormatAddressFields(Header);
                FormatDocumentFields(Header);
                if SellToContact.Get("Sell-to Contact No.") then;
                if BillToContact.Get("Bill-to Contact No.") then;

                if not CompanyBankAccount.Get(Header."Company Bank Account Code") then
                    CompanyBankAccount.CopyBankFieldsFromCompanyInfo(CompanyInfo);

                FillLeftHeader();
                FillRightHeader();

                if not Cust.Get("Bill-to Customer No.") then
                    Clear(Cust);

                if "Currency Code" <> '' then begin
                    CurrencyExchangeRate.FindCurrency("Posting Date", "Currency Code", 1);
                    CalculatedExchRate :=
                      Round(1 / "Currency Factor" * CurrencyExchangeRate."Exchange Rate Amount", 0.000001);
                    ExchangeRateText := StrSubstNo(ExchangeRateTxt, CalculatedExchRate, CurrencyExchangeRate."Exchange Rate Amount");
                end;

                GetLineFeeNoteOnReportHist("No.");

                //PaymentServiceSetup.CreateReportingArgs(PaymentReportingArgument, Header);

                CalcFields("Amount Including VAT");
                //RemainingAmount := GetRemainingAmount;
                if RemainingAmount = 0 then
                    RemainingAmountTxt := AlreadyPaidLbl
                else
                    if RemainingAmount <> "Amount Including VAT" then
                        RemainingAmountTxt := StrSubstNo(PartiallyPaidLbl, Format(RemainingAmount, 0, '<Precision,2><Standard Format,0>'))
                    else
                        RemainingAmountTxt := '';

                OnAfterGetSalesHeader(Header);


                TotalSubTotal := 0;
                TotalInvDiscAmount := 0;
                TotalAmount := 0;
                TotalAmountVAT := 0;
                TotalAmountInclVAT := 0;
                TotalPaymentDiscOnVAT := 0;
                AfkTotalAmountInclVAT_LCY := 0;
                AfkTotalAmount_LCY := 0;
                AfkTotalVAT_LCY := 0;

                if ("Order No." = '') and "Prepayment Invoice" then
                    "Order No." := "Prepayment Order No.";

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
                    // field(Name; SourceExpression)
                    // {
                    //     ApplicationArea = All;

                    // }
                }
            }
        }
        trigger OnInit()
        begin
            // LogInteractionEnable := true;
        end;

        trigger OnOpenPage()
        begin
            InitLogInteraction();
            // LogInteractionEnable := LogInteraction;
        end;
    }

    labels
    {
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
                    if Header."Bill-to Contact No." <> '' then
                        SegManagement.LogDocument(
                          4, Header."No.", 0, 0, DATABASE::Contact, Header."Bill-to Contact No.", Header."Salesperson Code",
                          Header."Campaign No.", Header."Posting Description", '')
                    else
                        SegManagement.LogDocument(
                          4, Header."No.", 0, 0, DATABASE::Customer, Header."Bill-to Customer No.", Header."Salesperson Code",
                          Header."Campaign No.", Header."Posting Description", '');
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

        CompanyLogoPosition := SalesSetup."Logo Position on Documents";
    end;


    var
        GLSetup: Record "General Ledger Setup";
        CompanyInfo: Record "Company Information";
        DummyCompanyInfo: Record "Company Information";
        RespCenter: Record "Responsibility Center";
        SalesPersonCode: Record "Salesperson/Purchaser";
        SellToContact: Record Contact;
        ContactInfo: Record Contact;
        // ShipToAddrr: Record "Ship-to Address";
        // Country: Record "Country/Region";
        VATClause: Record "VAT Clause";
        BillToContact: Record Contact;
        AfkCurrency: Record Currency;
        CurrencyExchangeRate: Record "Currency Exchange Rate";
        CompanyBankAccount: Record "Bank Account";
        PaymentMethod: Record "Payment Method";
        SalespersonPurchaser: Record "Salesperson/Purchaser";
        SalesSetup: Record "Sales & Receivables Setup";
        ShipmentMethod: Record "Shipment Method";
        PaymentTerms: Record "Payment Terms";
        AfkLocalCurrency: Record Currency;
        Cust: Record Customer;
        // TempLineFeeNoteOnReportHist: Record "Line Fee Note on Report Hist.";
        TempLineFeeNoteOnReportHist: Record "Line Fee Note on Report Hist." temporary;
        // LineRec: Record "Sales Invoice Line";
        RepCheck: Report Check;

        // Language: Codeunit Language;
        FormatAddr: Codeunit "Format Address";
        SegManagement: Codeunit SegManagement;
        AutoFormat: Codeunit "Auto Format";
        FormatDocument: Codeunit "Format Document";
        MoreLines: Boolean;
        CustomerIdentity: Text[100];
        rcs: Code[30];
        stat: Code[30];
        nif: Code[30];
        TotalDeposit: Decimal;
        A01DiscountedPrice: Decimal;
        A01DiscountedPriceText: Text[50];
        // Deposit: Decimal;
        AfkTotalDeposit_LCYText: Text[50];
        AfkIsLine: Integer;
        NumLigne: Integer;
        NumLigneText: Code[2];
        // LogInteractionEnable: Boolean;
        WorkDescriptionInstream: InStream;
        TransHeaderAmount: Decimal;
        FirstLineHasBeenOutput: Boolean;
        // A01FormattedUnitPrice: Text[50];
        PartiallyPaidLbl: Label 'The invoice has been partially paid. The remaining amount is %1', Comment = '%1=an amount';
        RemainingAmountTxt: Text;
        ChecksPayableLbl: Label 'Please make checks payable to %1', Comment = '%1 = company name';
        CalculatedExchRate: Decimal;
        JobTaskNoLbl: Text;
        JobTaskNo: Code[20];
        JobTaskDescription: Text[100];
        JobTaskDescLbl: Label 'Job Task Description';
        JobNoLbl: Text;
        JobNo: Code[20];
        UnitLbl: Label 'Unit';
        QtyLbl: Label 'Qty';
        PriceLbl: Label 'Price';
        PricePerLbl: Label 'Price per';
        JobTaskNoLbl2: Label 'Job Task No.';
        JobNoLbl2: Label 'Job No.';
        AfkLocalCurrencyName: Text;
        NoText: array[2] of Text;
        TotalExclVATText: Text[50];
        TotalInclVATText: Text[50];
        TotalText: text[50];
        VendorName: Text[50];
        UnitName: Text[100];
        UnitAddress: Text[100];
        PostCode: Code[20];
        City: Code[30];
        UnitPhone: Text[30];
        CustomerPhone: Text[30];
        CustAddress: Text[100];
        TotalInvDiscAmount: Decimal;
        PrevLineAmount: Decimal;
        TotalAmountExclInclVATValue: Decimal;
        TotalAmountExclInclVATTextValue: Text;
        AfkFormattedTotalVAT: Text[50];
        AfkFormattedTotalHT: Text[50];
        AfkFormattedTotalTTC: Text[50];
        AfkLocalCurrencyCaption: Text[50];
        AfkTotalVAT_LCYCaption: Text[50];
        AfkTotalAmount_LCYCaption: Text[50];
        AfkTotalAmountInclVAT_LCYCaption: Text[50];
        AfkTotalAmount_LCYText: Text[50];
        Afk_AmountInWords: Text;
        AfkTotalAmountInclVAT_LCYText: Text[50];
        AfkTotalVAT_LCYText: Text[50];
        AfkLocalCurrencyText: Text[100];
        TotalSubTotal: Decimal;
        FormattedLineAmount: Text;
        TotalPaymentDiscOnVAT: Decimal;
        TotalVATAmountLCY: Decimal;
        TotalAmountInclVAT: Decimal;
        TotalAmountVAT: Decimal;
        TotalAmount: Decimal;
        VATAmountLCY: Decimal;
        VATBaseLCY: Decimal;
        VATClausesText: Text;
        PmtDiscText: Text;
        TotalVATBaseLCY: Decimal;
        A01LineQty: Decimal;
        A01LinePU: Decimal;
        A01LineQtyFormatted: Text[50];
        A01FormattedVAT: Text[50];
        A01LinePUFormatted: Text[50];
        FormattedLineAmountTTC: Text;
        FormattedQuantity: Text;
        FormattedUnitPrice: Text;
        FormattedVATPct: Text;
        LineDiscountPctText: Text;
        // AfkLinesNumber: Integer;
        A01FormattedAmtHT: Text[50];
        A01FormattedLineDiscountAmount: Text[50];
        CompanyAddr: array[8] of Text[100];
        CustAddr: array[8] of Text[100];
        ShipToAddr: array[8] of Text[100];
        PaymentInstructionsTxt: Text;
        CompanyLogoPosition: Integer;
        DisplayAssemblyInformation: Boolean;
        ShowWorkDescription: Boolean;
        RemainingAmount: Decimal;
        AfkCurrCode: Code[20];
        AfkCurrCod: Code[20];
        AfkCurrencyName: Text;
        DisplayShipmentInformation: Boolean;
        DisplayAdditionalFeeNote: Boolean;
        ChecksPayableText: Text;
        ExchangeRateText: Text;
        WorkDescriptionLine: Text;
        AfkTotalVAT_LCY: Decimal;
        AfkTotalAmount_LCY: Decimal;
        AfkTotalAmountInclVAT_LCY: Decimal;
        LegalOfficeTxt, LegalOfficeLbl, CustomGiroTxt, CustomGiroLbl, LegalStatementLbl : Text;
        LogInteraction: Boolean;
        // ShowShippingAddr: Boolean;
        // AfkTotalHTCFALbl: Label 'Total Excl. VAT CFAF :';
        // AfkVAT1925Lbl: Label 'VAT 19.25% :';
        // AfkTotalTTCCFALbl: Label 'Total Incl. VAT CFAF :';
        AfkDeviseLbl: Label 'Currency :';
        AlreadyPaidLbl: Label 'The invoice has been paid.';
        NoFilterSetErr: Label 'You must specify one or more filters to avoid accidently printing all documents.';
        ExchangeRateTxt: Label 'Exchange rate: %1/%2', Comment = '%1 and %2 are both amounts.';
        PmtDiscTxt: Label 'If we receive the payment before %1, you are eligible for a %2% payment discount.', Comment = '%1 Discount Due Date %2 = value of Payment Discount % ';
        SalesInvoiceLbl: Label 'SALES INVOICE';
        InvNoLbl: Label 'Invoice N° :';
        SalesPersonText: Text[50];
        UnitNameLbl: Label 'Unit name :';
        UnitAddressLbl: Label 'Unit address :';
        UnitCityLbl: Label 'City';
        UnitPostalCodeLbl: Label 'Postal code :';
        UnitPhoneLbl: Label 'Phone :';
        CustomerNameLbl: Label 'Customer Name :';
        CustomerIdentityLbl: Label 'Customer identity :';
        CustomerAddressLbl: Label 'Customer address :';
        NIFLbl: Label 'NIF :';
        STATLbl: Label 'STAT :';
        RCSLbl: Label 'RCS :';
        CustomerPhoneLbl: Label 'Phone :';
        InvoiceDateLbl: Label 'Invoice Date :';
        DateofprintLbl: Label 'Date of print :';
        VendorNameLbl: Label 'Vendor name :';
        VendorMatriculeLbl: Label 'Vendor matricule :';


        ProductCodeLbl: Label 'Product code';
        DesignationLbl: Label 'Designation';
        DeliverySiteLbl: Label 'Delivery site';
        QuantityLbl: Label 'Quantity';
        UnitPriceLbl: Label 'Unit price HT';
        DiscountPercentLbl: Label 'Discount';
        DiscountAmountLbl: Label 'Discounted prices HT';
        VATClausesLbl: Label 'VAT clause';

        SubtotalLbl: Label 'Subtotal';
        HTPriceLbl: Label '(A) HT Price';
        VAT20Lbl: Label '(B) VAT 20%';
        TTCPriceLbl: Label '(C) TTC Price';
        // DepositLbl: Label '(D) Deposit';
        // BalanceLbl: Label '(E) Balance';
        // Interest18Lbl: Label '(F) Interest=18% of (E) per year';   //  Interets=18% de (E) par an
        // VATInterestLbl: Label '(G) VAT on Interest';   //  TVA sur interets
        // BalanceToPayLbl: Label '(H) Balance payable';   //  Solde à payer
        // TTCAmountOfOperationLbl: Label '(I) Amount TTC of operation';   //  Montant TTC de l'opération
        ArrestedOfSumLbl: Label 'Arrested at the sum of :';
        CompanySignLbl: Label 'Company signature';
        ClientSignLbl: Label 'Client Signature';
        InvDiscountAmtLbl: Label 'Invoice Discount';
        PaymentTermsDescLbl: Label 'Payment Terms :';
        PaymentMethodDescLbl: Label 'Payment Method :';
        ShptMethodDescLbl: Label 'Shipment Method';
        EMailLbl: Label 'Email';
        HomePageLbl: Label 'Home Page';
        CompanyInfoPhoneNoLbl: Label 'Phone No.';
        CompanyInfoBankNameLbl: Label 'Bank';
        CompanyInfoGiroNoLbl: Label 'Giro No.';



    local procedure InitLogInteraction()
    begin
        LogInteraction := SegManagement.FindInteractionTemplateCode(Enum::"Interaction Log Entry Document Type"::"Sales Inv.") <> '';
    end;

    local procedure InitializeShipmentLine()
    var
        SalesShipmentHeader: Record "Sales Shipment Header";
        SalesShipmentBuffer2: Record "Sales Shipment Buffer";
    begin
        if Line.Type = Line.Type::" " then
            exit;

        if Line."Shipment No." <> '' then
            if SalesShipmentHeader.Get(Line."Shipment No.") then
                exit;

        ShipmentLine.GetLinesForSalesInvoiceLine(Line, Header);

        ShipmentLine.Reset();
        ShipmentLine.SetRange("Line No.", Line."Line No.");
        if ShipmentLine.FindFirst() then begin
            SalesShipmentBuffer2 := ShipmentLine;
            if not DisplayShipmentInformation then
                if ShipmentLine.Next() = 0 then begin
                    ShipmentLine.Get(SalesShipmentBuffer2."Document No.", SalesShipmentBuffer2."Line No.", SalesShipmentBuffer2."Entry No.");
                    ShipmentLine.Delete();
                    exit;
                end;
            ShipmentLine.CalcSums(Quantity);
            if ShipmentLine.Quantity <> Line.Quantity then begin
                ShipmentLine.DeleteAll();
                exit;
            end;
        end;
    end;

    local procedure DocumentCaption(): Text[250]
    var
        DocCaption: Text;
    begin
        OnBeforeGetDocumentCaption(Header, DocCaption);
        if DocCaption <> '' then
            exit(CopyStr(DocCaption, 1, 250));
        exit(SalesInvoiceLbl);
    end;

    /// <summary>
    /// IsReportInPreviewMode.
    /// </summary>
    /// <returns>Return value of type Boolean.</returns>
    procedure InitializeRequest(NewLogInteraction: Boolean; DisplayAsmInfo: Boolean)
    begin
        LogInteraction := NewLogInteraction;
        DisplayAssemblyInformation := DisplayAsmInfo;
    end;

    protected procedure IsReportInPreviewMode(): Boolean
    var
        MailManagement: Codeunit "Mail Management";
    begin
        exit(CurrReport.Preview() or MailManagement.IsHandlingGetEmailBody());
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
                if Header."Prices Including VAT" then
                    ReportTotalsLine.Add(TotalInclVATText, TotalAmountInclVAT, true, false, false)
                else
                    ReportTotalsLine.Add(TotalExclVATText, TotalAmount, true, false, false);
        end;
        if TotalAmountVAT <> 0 then
            ReportTotalsLine.Add(VATAmountLine.VATAmountText(), TotalAmountVAT, false, true, false);
    end;

    local procedure GetLineFeeNoteOnReportHist(SalesInvoiceHeaderNo: Code[20])
    var
        CustLedgerEntry: Record "Cust. Ledger Entry";
        Customer: Record Customer;
        LineFeeNoteOnReportHist: Record "Line Fee Note on Report Hist.";
        Language: Codeunit Language;
    begin
        TempLineFeeNoteOnReportHist.DeleteAll();
        CustLedgerEntry.SetRange("Document Type", CustLedgerEntry."Document Type"::Invoice);
        CustLedgerEntry.SetRange("Document No.", SalesInvoiceHeaderNo);
        if not CustLedgerEntry.FindFirst() then
            exit;

        if not Customer.Get(CustLedgerEntry."Customer No.") then
            exit;

        LineFeeNoteOnReportHist.SetRange("Cust. Ledger Entry No", CustLedgerEntry."Entry No.");
        LineFeeNoteOnReportHist.SetRange("Language Code", Customer."Language Code");
        if LineFeeNoteOnReportHist.FindSet() then begin
            repeat
                TempLineFeeNoteOnReportHist.Init();
                TempLineFeeNoteOnReportHist.Copy(LineFeeNoteOnReportHist);
                TempLineFeeNoteOnReportHist.Insert();
            until LineFeeNoteOnReportHist.Next() = 0;
        end else begin
            LineFeeNoteOnReportHist.SetRange("Language Code", Language.GetUserLanguageCode());
            if LineFeeNoteOnReportHist.FindSet() then
                repeat
                    TempLineFeeNoteOnReportHist.Init();
                    TempLineFeeNoteOnReportHist.Copy(LineFeeNoteOnReportHist);
                    TempLineFeeNoteOnReportHist.Insert();
                until LineFeeNoteOnReportHist.Next() = 0;
        end;
    end;

    local procedure FillLeftHeader()
    begin
        LeftHeader.DeleteAll();

        FillNameValueTable(LeftHeader, Header.FieldCaption("External Document No."), Header."External Document No.");
        FillNameValueTable(LeftHeader, Header.FieldCaption("Bill-to Customer No."), Header."Bill-to Customer No.");
        FillNameValueTable(LeftHeader, Header.GetCustomerVATRegistrationNumberLbl(), Header.GetCustomerVATRegistrationNumber());
        FillNameValueTable(LeftHeader, Header.GetCustomerGlobalLocationNumberLbl(), Header.GetCustomerGlobalLocationNumber());
        FillNameValueTable(LeftHeader, InvNoLbl, Header."No.");
        //FillNameValueTable(LeftHeader, Header.FieldCaption("Order No."), Header."Order No.");
        FillNameValueTable(LeftHeader, Header.FieldCaption("Document Date"), Format(Header."Document Date", 0, 4));
        FillNameValueTable(LeftHeader, Header.FieldCaption("Due Date"), Format(Header."Due Date", 0, 4));
        FillNameValueTable(LeftHeader, PaymentTermsDescLbl, PaymentTerms.Description);
        FillNameValueTable(LeftHeader, PaymentMethodDescLbl, PaymentMethod.Description);
        FillNameValueTable(LeftHeader, Cust.GetLegalEntityTypeLbl(), Cust.GetLegalEntityType());
        FillNameValueTable(LeftHeader, ShptMethodDescLbl, ShipmentMethod.Description);

        OnAfterFillLeftHeader(LeftHeader, Header);
    end;

    local procedure FillRightHeader()
    begin
        RightHeader.DeleteAll();

        FillNameValueTable(RightHeader, EMailLbl, CompanyInfo."E-Mail");
        FillNameValueTable(RightHeader, HomePageLbl, CompanyInfo."Home Page");
        FillNameValueTable(RightHeader, CompanyInfoPhoneNoLbl, CompanyInfo."Phone No.");
        FillNameValueTable(RightHeader, CompanyInfo.GetRegistrationNumberLbl(), CompanyInfo.GetRegistrationNumber());
        FillNameValueTable(RightHeader, CompanyInfoBankNameLbl, CompanyBankAccount.Name);
        FillNameValueTable(RightHeader, CompanyInfoGiroNoLbl, CompanyInfo."Giro No.");
        FillNameValueTable(RightHeader, CompanyBankAccount.FieldCaption(IBAN), CompanyBankAccount.IBAN);
        FillNameValueTable(RightHeader, CompanyBankAccount.FieldCaption("SWIFT Code"), CompanyBankAccount."SWIFT Code");
        //FillNameValueTable(RightHeader, Header.GetPaymentReferenceLbl, Header.GetPaymentReference);

        OnAfterFillRightHeader(RightHeader, Header);
    end;

    local procedure FillNameValueTable(var NameValueBuffer: Record "Name/Value Buffer"; Name: Text; Value: Text)
    var
        KeyIndex: Integer;
    begin
        if Value <> '' then begin
            Clear(NameValueBuffer);
            if NameValueBuffer.FindLast() then
                KeyIndex := NameValueBuffer.ID + 1;

            NameValueBuffer.Init();
            NameValueBuffer.ID := KeyIndex;
            NameValueBuffer.Name := CopyStr(Name, 1, MaxStrLen(NameValueBuffer.Name));
            NameValueBuffer.Value := CopyStr(Value, 1, MaxStrLen(NameValueBuffer.Value));
            NameValueBuffer.Insert();
        end;
    end;

    local procedure FormatAddressFields(var SalesInvoiceHeader: Record "Sales Invoice Header")
    var
    // i: Integer;
    begin
        FormatAddr.GetCompanyAddr(SalesInvoiceHeader."Responsibility Center", RespCenter, CompanyInfo, CompanyAddr);
        FormatAddr.SalesInvBillTo(CustAddr, SalesInvoiceHeader);
        // ShowShippingAddr := FormatAddr.SalesInvShipTo(ShipToAddr, CustAddr, SalesInvoiceHeader);
        // if ShowShippingAddr then begin
        //     for i := 1 to 8 do
        //         AlternativeAddress[i] := ShipToAddr[i];
        //     AlternativeAddressTxt := ShiptoAddrLbl;
        // end;
    end;

    local procedure FormatDocumentFields(SalesInvoiceHeader: Record "Sales Invoice Header")
    begin
        // with SalesInvoiceHeader do begin
        FormatDocument.SetTotalLabels(SalesInvoiceHeader.GetCurrencySymbol(), TotalText, TotalInclVATText, TotalExclVATText);
        FormatDocument.SetSalesPerson(SalespersonPurchaser, SalesInvoiceHeader."Salesperson Code", SalesPersonText);
        FormatDocument.SetPaymentTerms(PaymentTerms, SalesInvoiceHeader."Payment Terms Code", SalesInvoiceHeader."Language Code");
        FormatDocument.SetPaymentMethod(PaymentMethod, SalesInvoiceHeader."Payment Method Code", SalesInvoiceHeader."Language Code");
        FormatDocument.SetShipmentMethod(ShipmentMethod, SalesInvoiceHeader."Shipment Method Code", SalesInvoiceHeader."Language Code");

        // OnAfterFormatDocumentFields(SalesInvoiceHeader);
        // end;
    end;

    local procedure GetJobTaskDescription(JobN: Code[20]; JobTaskN: Code[20]): Text[100]
    var
        JobTask: Record "Job Task";
    begin
        JobTask.SetRange("Job No.", JobN);
        JobTask.SetRange("Job Task No.", JobTaskN);
        if JobTask.FindFirst() then
            exit(JobTask.Description);

        exit('');
    end;

    [IntegrationEvent(false, false)]
    local procedure OnAfterLineOnPreDataItem(var SalesInvoiceHeader: Record "Sales Invoice Header"; var SalesInvoiceLine: Record "Sales Invoice Line")
    begin
    end;

    [IntegrationEvent(false, false)]
    local procedure OnAfterFillLeftHeader(var LeftHeader: Record "Name/Value Buffer"; SalesInvoiceHeader: Record "Sales Invoice Header")
    begin
    end;

    [IntegrationEvent(false, false)]
    local procedure OnAfterFillRightHeader(var RightHeader: Record "Name/Value Buffer"; SalesInvoiceHeader: Record "Sales Invoice Header")
    begin
    end;

    [IntegrationEvent(false, false)]
    local procedure OnBeforeLineOnAfterGetRecord(var SalesInvoiceHeader: Record "Sales Invoice Header"; var SalesInvoiceLine: Record "Sales Invoice Line")
    begin
    end;

    [IntegrationEvent(false, false)]
    local procedure OnBeforeGetDocumentCaption(SalesInvoiceHeader: Record "Sales Invoice Header"; var DocCaption: Text)
    begin
    end;

    [IntegrationEvent(TRUE, FALSE)]
    local procedure OnAfterGetSalesHeader(SalesInvoiceHeader: Record "Sales Invoice Header")
    begin
    end;

    local procedure FormatLineValues(CurrLine: Record "Sales Invoice Line")
    var
        IsHandled: Boolean;
    begin
        IsHandled := false;
        OnBeforeFormatLineValues(CurrLine, FormattedQuantity, FormattedUnitPrice, FormattedVATPct, FormattedLineAmount, IsHandled);
        if not IsHandled then
            FormatDocument.SetSalesInvoiceLine(CurrLine, FormattedQuantity, FormattedUnitPrice, FormattedVATPct, FormattedLineAmount);
    end;

    [IntegrationEvent(false, false)]
    local procedure OnBeforeFormatLineValues(SalesInvoiceLine: Record "Sales Invoice Line"; var FormattedQuantity: Text; var FormattedUnitPrice: Text; var FormattedVATPercentage: Text; var FormattedLineAmount: Text; var IsHandled: Boolean)
    begin
    end;

    local procedure ShowVATClause(VATClauseCode: Code[20]): Boolean
    begin
        if VATClauseCode = '' then
            exit(false);

        exit(true);
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