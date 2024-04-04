/// <summary>
/// Report A01 PurchaseOrderPrint (ID 50006).
/// </summary>
report 50006 "A01 PurchaseOrderPrint"
{
    Caption = 'Purchase Order Print';
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;
    DefaultLayout = RDLC;
    PreviewMode = PrintLayout;
    WordMergeDataItem = "Purchase Header";
    RDLCLayout = './Source/Report/Layout/PurchaseOrderPrint.rdl';

    dataset
    {
        dataitem("Purchase Header"; "Purchase Header")
        {
            DataItemTableView = sorting("Document Type", "No.") where("Document Type" = const(Order));
            RequestFilterFields = "No.", "Buy-from Vendor No.", "No. Printed";
            RequestFilterHeading = 'Purchase Order';
            column(No_PurchHeader; "No.")
            {
            }
            column(CompanyInfo_Picture; CompanyInfo.Picture)
            {
            }
            column(CompanyInfo_Name; COMPANYPROPERTY.displayname())
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
            column(A01Order_Date; Format("Order Date"))
            {
            }
            column(A01UditecInvoice_No_; "Vendor Invoice No.")
            {
            }
            column(A01SupplierPhone; A01SupplierPhone)
            {
            }
            column(A01VendorIdentity; A01VendorIdentity)
            {
            }
            column(A01Vendor_Name; "Buy-from Vendor Name")
            {
            }
            column(A01VendorAddress; A01VendorAddress)
            {
            }
            column(A01PurchaseOrder__Caption; A01PurchaseOrder__Caption)
            {
            }
            column(A01PurchaseNumber__Lbl; A01PurchaseNumber__Lbl)
            {
            }
            column(A01PurchaseDate__Lbl; A01PurchaseDate__Lbl)
            {
            }
            column(A01UditecInvoiceNo__Lbl; A01UditecInvoiceNo__Lbl)
            {
            }
            column(A01NameOfSupplier__Lbl; A01NameOfSupplier__Lbl)
            {
            }
            column(A01SupplierIdentity__Lbl; A01SupplierIdentity__Lbl)
            {
            }
            column(A01NameAddress__Lbl; A01NameAddress__Lbl)
            {
            }
            column(A01SupplierNIF__Lbl; A01SupplierNIF__Lbl)
            {
            }
            column(A01SupplierSTAT__Lbl; A01SupplierSTAT__Lbl)
            {
            }
            column(A01SupplierRCS__Lbl; A01SupplierRCS__Lbl)
            {
            }
            column(A01SupplierPhone__Lbl; A01SupplierPhone__Lbl)
            {
            }
            column(A01ProductCodeLbl; A01ProductCodeLbl)
            {
            }
            column(A01DesignationLbl; A01DesignationLbl)
            {
            }
            column(A01QuantityLbl; A01QuantityLbl)
            {
            }
            column(A01DiscountPercentLbl; A01DiscountPercentLbl)
            {
            }
            column(A01DiscountAmountLbl; A01DiscountAmountLbl)
            {
            }
            column(A01_mountInWords; A01_AmountInWords)
            {
            }
            column(A01TotalHT__Lbl; A01TotalHT__Lbl)
            {
            }
            column(A01TotalVAT__Lbl; A01TotalVAT__Lbl)
            {
            }
            column(A01TotalTTC__Lbl; A01TotalTTC__Lbl)
            {
            }
            column(A01UnitPriceLbl; A01UnitPriceLbl)
            {
            }
            column(PaymenTerms__Caption; PaymenTerms__Caption)
            {
            }
            column(PaymentMode__Caption; PaymentMode__Caption)
            {
            }
            column(Requested_Receipt_DateLbl; Requested_Receipt_DateLbl)
            {
            }
            column(Requested_Receipt_Date; Format("Requested Receipt Date"))
            {
            }
            column(A01PaymentTermName; A01PaymentTermName)
            {
            }
            column(A01PaymentModeName; A01PaymentModeName)
            {
            }
            column(AfkCurrCode; AfkCurrCode)
            {
            }


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
            column(CompanyHomePage_Lbl; HomePageCaptionLbl)
            {
            }
            column(CompanyHomePage; CompanyInfo."Home Page")
            {
            }
            column(CompanyEmail_Lbl; EmailIDCaptionLbl)
            {
            }
            column(CompanyEMail; CompanyInfo."E-Mail")
            {
            }
            column(CompanyPicture; CompanyInfo.Picture)
            {
            }
            column(CompanyPhoneNo; CompanyInfo."Phone No.")
            {
            }
            column(CompanyPhoneNo_Lbl; CompanyInfoPhoneNoCaptionLbl)
            {
            }
            column(CompanyGiroNo; CompanyInfo."Giro No.")
            {
            }
            column(CompanyGiroNo_Lbl; CompanyInfoGiroNoCaptionLbl)
            {
            }
            column(CompanyBankName; CompanyInfo."Bank Name")
            {
            }
            column(CompanyBankName_Lbl; CompanyInfoBankNameCaptionLbl)
            {
            }
            column(VendorItemRefLbl; VendorItemRefLbl)
            {
            }
            column(CompanyBankBranchNo; CompanyInfo."Bank Branch No.")
            {
            }
            column(CompanyBankBranchNo_Lbl; CompanyInfo.FieldCaption("Bank Branch No."))
            {
            }
            column(CompanyBankAccountNo; CompanyInfo."Bank Account No.")
            {
            }
            column(CompanyBankAccountNo_Lbl; CompanyInfoBankAccNoCaptionLbl)
            {
            }
            column(CompanyIBAN; CompanyInfo.IBAN)
            {
            }
            column(CompanyIBAN_Lbl; CompanyInfo.FieldCaption(IBAN))
            {
            }
            column(AuthoriseSignLbl; AuthoriseSignLbl)
            {
            }
            column(CompanySWIFT; CompanyInfo."SWIFT Code")
            {
            }
            column(CompanySWIFT_Lbl; CompanyInfo.FieldCaption("SWIFT Code"))
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
            column(DocType_PurchHeader; "Document Type")
            {
            }
            column(DocumentTitle_Lbl; DocumentTitleLbl)
            {
            }
            column(Amount_Lbl; AmountCaptionLbl)
            {
            }
            column(PurchLineInvDiscAmt_Lbl; PurchLineInvDiscAmtCaptionLbl)
            {
            }
            column(Subtotal_Lbl; SubtotalCaptionLbl)
            {
            }
            column(VATAmtLineVAT_Lbl; VATAmtLineVATCaptionLbl)
            {
            }
            column(VATAmtLineVATAmt_Lbl; VATAmtLineVATAmtCaptionLbl)
            {
            }
            column(VATAmtSpec_Lbl; VATAmtSpecCaptionLbl)
            {
            }
            column(VATIdentifier_Lbl; VATIdentifierCaptionLbl)
            {
            }
            column(VATAmtLineInvDiscBaseAmt_Lbl; VATAmtLineInvDiscBaseAmtCaptionLbl)
            {
            }
            column(VATAmtLineLineAmt_Lbl; VATAmtLineLineAmtCaptionLbl)
            {
            }
            column(VALVATBaseLCY_Lbl; VALVATBaseLCYCaptionLbl)
            {
            }
            column(Total_Lbl; TotalCaptionLbl)
            {
            }
            column(PaymentTermsDesc_Lbl; PaymentTermsDescCaptionLbl)
            {
            }
            column(ShipmentMethodDesc_Lbl; ShipmentMethodDescCaptionLbl)
            {
            }
            column(PrepymtTermsDesc_Lbl; PrepymtTermsDescCaptionLbl)
            {
            }
            column(HomePage_Lbl; HomePageCaptionLbl)
            {
            }
            column(EmailID_Lbl; EmailIDCaptionLbl)
            {
            }
            column(AllowInvoiceDisc_Lbl; AllowInvoiceDiscCaptionLbl)
            {
            }
            column(DocumentDate; Format("Document Date", 0, 4))
            {
            }
            column(DueDate; Format("Due Date", 0, 4))
            {
            }
            column(ExptRecptDt_PurchaseHeader; Format("Expected Receipt Date", 0, 4))
            {
            }
            column(OrderDate_PurchaseHeader; Format("Order Date", 0, 4))
            {
            }
            column(VATNoText; VATNoText)
            {
            }
            column(VATRegNo_PurchHeader; "VAT Registration No.")
            {
            }
            column(PurchaserText; PurchaserText)
            {
            }
            column(SalesPurchPersonName; SalespersonPurchaser.Name)
            {
            }
            column(ReferenceText; ReferenceText)
            {
            }
            column(YourRef_PurchHeader; "Your Reference")
            {
            }
            column(BuyFrmVendNo_PurchHeader; "Buy-from Vendor No.")
            {
            }
            column(BuyFromAddr1; BuyFromAddr[1])
            {
            }
            column(BuyFromAddr2; BuyFromAddr[2])
            {
            }
            column(BuyFromAddr3; BuyFromAddr[3])
            {
            }
            column(BuyFromAddr4; BuyFromAddr[4])
            {
            }
            column(BuyFromAddr5; BuyFromAddr[5])
            {
            }
            column(BuyFromAddr6; BuyFromAddr[6])
            {
            }
            column(BuyFromAddr7; BuyFromAddr[7])
            {
            }
            column(BuyFromAddr8; BuyFromAddr[8])
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
            column(PricesIncludingVAT_Lbl; PricesIncludingVATCaptionLbl)
            {
            }
            column(PricesInclVAT_PurchHeader; "Prices Including VAT")
            {
            }
            column(OutputNo; OutputNo)
            {
            }
            column(VATBaseDisc_PurchHeader; "VAT Base Discount %")
            {
            }
            column(PricesInclVATtxt; PricesInclVATtxtLbl)
            {
            }
            column(PaymentTermsDesc; PaymentTerms.Description)
            {
            }
            column(ShipmentMethodDesc; ShipmentMethod.Description)
            {
            }
            column(PrepmtPaymentTermsDesc; PrepmtPaymentTerms.Description)
            {
            }
            column(DimText; DimText)
            {
            }
            column(OrderNo_Lbl; OrderNoCaptionLbl)
            {
            }
            column(Page_Lbl; PageCaptionLbl)
            {
            }
            column(DocumentDate_Lbl; DocumentDateCaptionLbl)
            {
            }
            column(BuyFrmVendNo_PurchHeader_Lbl; FieldCaption("Buy-from Vendor No."))
            {
            }
            column(PricesInclVAT_PurchHeader_Lbl; FieldCaption("Prices Including VAT"))
            {
            }
            column(Receiveby_Lbl; ReceivebyCaptionLbl)
            {
            }
            column(Buyer_Lbl; BuyerCaptionLbl)
            {
            }
            column(PayToVendNo_PurchHeader; "Pay-to Vendor No.")
            {
            }
            column(VendAddr8; VendAddr[8])
            {
            }
            column(VendAddr7; VendAddr[7])
            {
            }
            column(VendAddr6; VendAddr[6])
            {
            }
            column(VendAddr5; VendAddr[5])
            {
            }
            column(VendAddr4; VendAddr[4])
            {
            }
            column(VendAddr3; VendAddr[3])
            {
            }
            column(VendAddr2; VendAddr[2])
            {
            }
            column(VendAddr1; VendAddr[1])
            {
            }
            column(PaymentDetails_Lbl; PaymentDetailsCaptionLbl)
            {
            }
            column(VendNo_Lbl; VendNoCaptionLbl)
            {
            }
            column(SellToCustNo_PurchHeader; "Sell-to Customer No.")
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
            column(ShiptoAddress_Lbl; ShiptoAddressCaptionLbl)
            {
            }
            column(SellToCustNo_PurchHeader_Lbl; FieldCaption("Sell-to Customer No."))
            {
            }
            column(ItemNumber_Lbl; ItemNumberCaptionLbl)
            {
            }
            column(ItemDescription_Lbl; ItemDescriptionCaptionLbl)
            {
            }
            column(ItemQuantity_Lbl; ItemQuantityCaptionLbl)
            {
            }
            column(ItemUnit_Lbl; ItemUnitCaptionLbl)
            {
            }
            column(ItemUnitPrice_Lbl; ItemUnitPriceCaptionLbl)
            {
            }
            column(ItemLineAmount_Lbl; ItemLineAmountCaptionLbl)
            {
            }
            column(ToCaption_Lbl; ToCaptionLbl)
            {
            }
            column(VendorIDCaption_Lbl; VendorIDCaptionLbl)
            {
            }
            column(ConfirmToCaption_Lbl; ConfirmToCaptionLbl)
            {
            }
            column(PurchOrderCaption_Lbl; PurchOrderCaptionLbl)
            {
            }
            column(PurchOrderNumCaption_Lbl; PurchOrderNumCaptionLbl)
            {
            }
            column(PurchOrderDateCaption_Lbl; PurchOrderDateCaptionLbl)
            {
            }
            column(TaxIdentTypeCaption_Lbl; TaxIdentTypeCaptionLbl)
            {
            }
            column(OrderDate_Lbl; OrderDateLbl)
            {
            }
            column(VendorInvoiceNo_Lbl; VendorInvoiceNoLbl)
            {
            }
            column(VendorInvoiceNo; "Vendor Invoice No.")
            {
            }
            column(VendorOrderNo_Lbl; VendorOrderNoLbl)
            {
            }
            column(VendorOrderNo; "Vendor Order No.")
            {
            }
            dataitem("Purchase Line"; "Purchase Line")
            {
                DataItemLink = "Document Type" = field("Document Type"), "Document No." = field("No.");
                DataItemTableView = sorting("Document Type", "Document No.", "Line No.");
                DataItemLinkReference = "Purchase Header";
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
                column(A01DiscountedPrice; A01DiscountedPriceText)
                {
                    AutoFormatExpression = "Purchase Header"."Currency Code";
                    AutoFormatType = 2;
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
                column(Vendor_Item_No_; "Vendor Item No.")
                {
                }


                column(VendorItemNo_PurchLine; "Vendor Item No.")
                {
                }
                column(ItemReferenceNo_PurchLine; "Item Reference No.")
                {
                }
                column(Desc_PurchLine; Description)
                {
                }
                column(Qty_PurchLine; FormattedQuanitity)
                {
                }
                column(UOM_PurchLine; "Unit of Measure")
                {
                }
                column(DirUnitCost_PurchLine; FormattedDirectUnitCost)
                {
                    AutoFormatExpression = "Purchase Header"."Currency Code";
                    AutoFormatType = 2;
                }
                column(LineDisc_PurchLine; "Line Discount %")
                {
                }
                column(LineAmt_PurchLine; FormattedLineAmount)
                {
                }
                column(AllowInvDisc_PurchLine; "Allow Invoice Disc.")
                {
                }
                column(VATIdentifier_PurchLine; "VAT Identifier")
                {
                }
                column(InvDiscAmt_PurchLine; -"Inv. Discount Amount")
                {
                    AutoFormatExpression = "Currency Code";
                    AutoFormatType = 1;
                }
                column(TotalInclVAT; "Line Amount" - "Inv. Discount Amount")
                {
                    AutoFormatExpression = "Purchase Header"."Currency Code";
                    AutoFormatType = 1;
                }
                column(DirectUniCost_Lbl; DirectUniCostCaptionLbl)
                {
                }
                column(PurchLineLineDisc_Lbl; PurchLineLineDiscCaptionLbl)
                {
                }
                column(VATDiscountAmount_Lbl; VATDiscountAmountCaptionLbl)
                {
                }
                column(No_PurchLine_Lbl; FieldCaption("No."))
                {
                }
                column(Desc_PurchLine_Lbl; FieldCaption(Description))
                {
                }
                column(Qty_PurchLine_Lbl; FieldCaption(Quantity))
                {
                }
                column(UOM_PurchLine_Lbl; ItemUnitOfMeasureCaptionLbl)
                {
                }
                column(VATIdentifier_PurchLine_Lbl; FieldCaption("VAT Identifier"))
                {
                }
                column(AmountIncludingVAT; "Amount Including VAT")
                {
                }
                column(TotalPriceCaption_Lbl; TotalPriceCaptionLbl)
                {
                }
                column(InvDiscCaption_Lbl; InvDiscCaptionLbl)
                {
                }
                column(UnitPrice_PurchLine; "Unit Price (LCY)")
                {
                }
                column(UnitPrice_PurchLine_Lbl; UnitPriceLbl)
                {
                }
                column(JobNo_PurchLine; "Job No.")
                {
                }
                column(JobNo_PurchLine_Lbl; JobNoLbl)
                {
                }
                column(JobTaskNo_PurchLine; "Job Task No.")
                {
                }
                column(JobTaskNo_PurchLine_Lbl; JobTaskNoLbl)
                {
                }
                column(PlannedReceiptDateLbl; PlannedReceiptDateLbl)
                {
                }
                column(PlannedReceiptDate; Format("Planned Receipt Date", 0, 4))
                {
                }
                column(ExpectedReceiptDateLbl; ExpectedReceiptDateLbl)
                {
                }
                column(ExpectedReceiptDate; Format("Expected Receipt Date", 0, 4))
                {
                }
                column(PromisedReceiptDateLbl; PromisedReceiptDateLbl)
                {
                }
                column(PromisedReceiptDate; Format("Promised Receipt Date", 0, 4))
                {
                }
                column(RequestedReceiptDateLbl; RequestedReceiptDateLbl)
                {
                }
                column(RequestedReceiptDate; Format("Requested Receipt Date", 0, 4))
                {
                }
                column(TransHeaderAmount; TransHeaderAmount)
                {
                    AutoFormatExpression = "Currency Code";
                    AutoFormatType = 1;
                }
                column(PurchLine_VATPct; "VAT %")
                {
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
                            // tempHTD := "Purchase Line"."Direct Unit Cost" - "Purchase Line"."Line Discount Amount";
                            tempPU := "Purchase Line"."Direct Unit Cost" * (1 / (1 + "Purchase Line"."VAT %" / 100));
                            tempVAT := "Purchase Line"."Amount Including VAT" - tempHT;
                            tempTTC := "Purchase Line"."Amount Including VAT";

                        end else begin
                            tempHT := "Purchase Line"."Line Amount";
                            // tempHTD := "Purchase Line"."Direct Unit Cost" - "Purchase Line"."Line Discount Amount";
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
                    A01DiscountedPrice := Round(tempPU - "Purchase Line"."Line Discount Amount", 0.001, '<');

                    A01LineQtyFormatted := Format(A01LineQty);
                    A01LinePUFormatted := Format(A01LinePU);
                    A01DiscountedPriceText := Format(A01DiscountedPrice);

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
                    // FirstLineHasBeenOutput := false;
                    // DummyCompanyInfo.Picture := CompanyInfo.Picture;

                    // OnAfterLineOnPreDataItem(Header, Line);
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
            dataitem(VATCounter; "Integer")
            {
                DataItemTableView = sorting(Number);
                column(VATAmtLineVATBase; TempVATAmountLine."VAT Base")
                {
                    AutoFormatExpression = "Purchase Header"."Currency Code";
                    AutoFormatType = 1;
                }
                column(VATAmtLineVATAmt; TempVATAmountLine."VAT Amount")
                {
                    AutoFormatExpression = "Purchase Header"."Currency Code";
                    AutoFormatType = 1;
                }
                column(VATAmtLineLineAmt; TempVATAmountLine."Line Amount")
                {
                    AutoFormatExpression = "Purchase Header"."Currency Code";
                    AutoFormatType = 1;
                }
                column(VATAmtLineInvDiscBaseAmt; TempVATAmountLine."Inv. Disc. Base Amount")
                {
                    AutoFormatExpression = "Purchase Header"."Currency Code";
                    AutoFormatType = 1;
                }
                column(VATAmtLineInvDiscAmt; TempVATAmountLine."Invoice Discount Amount")
                {
                    AutoFormatExpression = "Purchase Header"."Currency Code";
                    AutoFormatType = 1;
                }
                column(VATAmtLineVAT; TempVATAmountLine."VAT %")
                {
                    DecimalPlaces = 0 : 5;
                }
                column(VATAmtLineVATIdentifier; TempVATAmountLine."VAT Identifier")
                {
                }
                trigger OnAfterGetRecord()
                begin
                    TempVATAmountLine.GetLine(Number);
                end;

                trigger OnPreDataItem()
                begin
                    if VATAmount = 0 then
                        CurrReport.Break();
                    SetRange(Number, 1, TempVATAmountLine.Count);
                end;

            }
            dataitem(VATCounterLCY; "Integer")
            {
                DataItemTableView = sorting(Number);
                column(VALExchRate; VALExchRate)
                {
                }
                column(VALSpecLCYHeader; VALSpecLCYHeader)
                {
                }
                column(VALVATAmountLCY; VALVATAmountLCY)
                {
                    AutoFormatType = 1;
                }
                column(VALVATBaseLCY; VALVATBaseLCY)
                {
                    AutoFormatType = 1;
                }
                trigger OnAfterGetRecord()
                begin
                    TempVATAmountLine.GetLine(Number);
                    VALVATBaseLCY :=
                      TempVATAmountLine.GetBaseLCY(
                        "Purchase Header"."Posting Date", "Purchase Header"."Currency Code", "Purchase Header"."Currency Factor");
                    VALVATAmountLCY :=
                      TempVATAmountLine.GetAmountLCY(
                        "Purchase Header"."Posting Date", "Purchase Header"."Currency Code", "Purchase Header"."Currency Factor");
                end;

                trigger OnPreDataItem()
                begin
                    if (not GLSetup."Print VAT specification in LCY") or
                       ("Purchase Header"."Currency Code" = '') or
                       (TempVATAmountLine.GetTotalVATAmount() = 0)
                    then
                        CurrReport.Break();

                    SetRange(Number, 1, TempVATAmountLine.Count);

                    if GLSetup."LCY Code" = '' then
                        VALSpecLCYHeader := VATAmountSpecificationLbl + LocalCurrentyLbl
                    else
                        VALSpecLCYHeader := VATAmountSpecificationLbl + Format(GLSetup."LCY Code");

                    CurrExchRate.FindCurrency("Purchase Header"."Posting Date", "Purchase Header"."Currency Code", 1);
                    VALExchRate := StrSubstNo(ExchangeRateLbl, CurrExchRate."Relational Exch. Rate Amount", CurrExchRate."Exchange Rate Amount");
                end;

            }
            dataitem(PrepmtLoop; "Integer")
            {
                DataItemTableView = sorting(Number) where(Number = filter(1 ..));
                column(PrepmtLineAmount; PrepmtLineAmount)
                {
                    AutoFormatExpression = "Purchase Header"."Currency Code";
                    AutoFormatType = 1;
                }
                column(PrepmtInvBufGLAccNo; TempPrepaymentInvLineBuffer."G/L Account No.")
                {
                }
                column(PrepmtInvBufDesc; TempPrepaymentInvLineBuffer.Description)
                {
                }
                column(TotalInclVATText2; TotalInclVATText)
                {
                }
                column(TotalExclVATText2; TotalExclVATText)
                {
                }
                column(PrepmtInvBufAmt; TempPrepaymentInvLineBuffer.Amount)
                {
                    AutoFormatExpression = "Purchase Header"."Currency Code";
                    AutoFormatType = 1;
                }
                column(PrepmtVATAmountText; TempPrepmtVATAmountLine.VATAmountText())
                {
                }
                column(PrepmtVATAmount; PrepmtVATAmount)
                {
                    AutoFormatExpression = "Purchase Header"."Currency Code";
                    AutoFormatType = 1;
                }
                column(PrepmtTotalAmountInclVAT; PrepmtTotalAmountInclVAT)
                {
                    AutoFormatExpression = "Purchase Header"."Currency Code";
                    AutoFormatType = 1;
                }
                column(PrepmtVATBaseAmount; PrepmtVATBaseAmount)
                {
                    AutoFormatExpression = "Purchase Header"."Currency Code";
                    AutoFormatType = 1;
                }
                column(PrepmtInvBuDescCaption; PrepmtInvBuDescCaptionLbl)
                {
                }
                column(PrepmtInvBufGLAccNoCaption; PrepmtInvBufGLAccNoCaptionLbl)
                {
                }
                column(PrepaymentSpecCaption; PrepaymentSpecCaptionLbl)
                {
                }
                trigger OnAfterGetRecord()
                begin
                    if Number = 1 then begin
                        if not TempPrepaymentInvLineBuffer.Find('-') then
                            CurrReport.Break();
                    end else
                        if TempPrepaymentInvLineBuffer.Next() = 0 then
                            CurrReport.Break();

                    if "Purchase Header"."Prices Including VAT" then
                        PrepmtLineAmount := TempPrepaymentInvLineBuffer."Amount Incl. VAT"
                    else
                        PrepmtLineAmount := TempPrepaymentInvLineBuffer.Amount;
                end;

            }
            dataitem(PrepmtVATCounter; "Integer")
            {
                DataItemTableView = sorting(Number);
                column(PrepmtVATAmtLineVATAmt; TempPrepmtVATAmountLine."VAT Amount")
                {
                    AutoFormatExpression = "Purchase Header"."Currency Code";
                    AutoFormatType = 1;
                }
                column(PrepmtVATAmtLineVATBase; TempPrepmtVATAmountLine."VAT Base")
                {
                    AutoFormatExpression = "Purchase Header"."Currency Code";
                    AutoFormatType = 1;
                }
                column(PrepmtVATAmtLineLineAmt; TempPrepmtVATAmountLine."Line Amount")
                {
                    AutoFormatExpression = "Purchase Header"."Currency Code";
                    AutoFormatType = 1;
                }
                column(PrepmtVATAmtLineVAT; TempPrepmtVATAmountLine."VAT %")
                {
                    DecimalPlaces = 0 : 5;
                }
                column(PrepmtVATAmtLineVATId; TempPrepmtVATAmountLine."VAT Identifier")
                {
                }
                column(PrepymtVATAmtSpecCaption; PrepymtVATAmtSpecCaptionLbl)
                {
                }

                trigger OnAfterGetRecord()
                begin
                    TempPrepmtVATAmountLine.GetLine(Number);
                end;

                trigger OnPreDataItem()
                begin
                    SetRange(Number, 1, TempPrepmtVATAmountLine.Count);
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

                    TempPrepaymentInvLineBuffer.DeleteAll();
                    PurchasePostPrepayments.GetPurchLines("Purchase Header", 0, TempPrepmtPurchLine);
                    if not TempPrepmtPurchLine.IsEmpty() then begin
                        PurchasePostPrepayments.GetPurchLinesToDeduct("Purchase Header", TempPurchLine);
                        if not TempPurchLine.IsEmpty() then
                            PurchasePostPrepayments.CalcVATAmountLines("Purchase Header", TempPurchLine, TempPrePmtVATAmountLineDeduct, 1);
                    end;
                    PurchasePostPrepayments.CalcVATAmountLines("Purchase Header", TempPrepmtPurchLine, TempPrepmtVATAmountLine, 0);
                    TempPrepmtVATAmountLine.DeductVATAmountLine(TempPrePmtVATAmountLineDeduct);
                    PurchasePostPrepayments.UpdateVATOnLines("Purchase Header", TempPrepmtPurchLine, TempPrepmtVATAmountLine, 0);
                    PurchasePostPrepayments.BuildInvLineBuffer("Purchase Header", TempPrepmtPurchLine, 0, TempPrepaymentInvLineBuffer);
                    PrepmtVATAmount := TempPrepmtVATAmountLine.GetTotalVATAmount();
                    PrepmtVATBaseAmount := TempPrepmtVATAmountLine.GetTotalVATBase();
                    PrepmtTotalAmountInclVAT := TempPrepmtVATAmountLine.GetTotalAmountInclVAT();
                end;

            }
            trigger OnAfterGetRecord()
            var
                Language: Codeunit Language;
            begin
                // TotalAmount := 0;
                // TotalSubTotal := 0;
                // TotalInvoiceDiscountAmount := 0;
                CurrReport.Language := Language.GetLanguageIdOrDefault("Language Code");
                FormatAddr.SetLanguageCode("Language Code");

                GLSetup.Get();
                GLSetup.TestField("LCY Code");

                AfkCurrCode := "Purchase Header"."Currency Code";
                if (AfkCurrCode = '') then
                    AfkCurrCode := GLSetup."LCY Code";

                AfkCurrencyName := AfkCurrCode;
                if AfkCurrency.Get(AfkCurrCode) then
                    AfkCurrencyName := AfkCurrency.Description;

                if (AfkLocalCurrency.Get(GLSetup."LCY Code") and (AfkCurrCode <> GLSetup."LCY Code")) then
                    AfkLocalCurrencyName := AfkLocalCurrency.Description;

                if BuyFromContact.Get("Purchase Header"."Buy-from Contact No.") then begin
                    A01SupplierPhone := BuyFromContact."Phone No.";
                    A01VendorIdentity := BuyFromContact.Name;
                end;

                if ShipToAddrr.Get("Purchase Header"."Ship-to Code") then
                    A01VendorAddress := ShipToAddrr.Name;

                NumLigne := 0;

                FormatAddressFields("Purchase Header");
                FormatDocumentFields("Purchase Header");
                if BuyFromContact.Get("Buy-from Contact No.") then;
                if PayToContact.Get("Pay-to Contact No.") then;

                if not IsReportInPreviewMode() then begin
                    CODEUNIT.Run(CODEUNIT::"Purch.Header-Printed", "Purchase Header");
                    if ArchiveDocument then
                        ArchiveManagement.StorePurchDocument("Purchase Header", LogInteraction);
                end;

                if PaymentTermRec.Get("Purchase Header"."Payment Terms Code") then
                    A01PaymentTermName := PaymentTermRec.Description;

                if PaymentMethodRec.Get("Purchase Header"."Payment Method Code") then
                    A01PaymentModeName := PaymentMethodRec.Description;

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
        SaveValues = true;
        layout
        {
            area(Content)
            {
                group(Options)
                {
                    // Caption = 'Options';
                    // field(ArchiveDocument; ArchiveDocument)
                    // {
                    //     ApplicationArea = Suite;
                    //     Caption = 'Archive Document';
                    //     ToolTip = 'Specifies whether to archive the order.';
                    // }
                    // field(LogInteraction; LogInteraction)
                    // {
                    //     ApplicationArea = Suite;
                    //     Caption = 'Log Interaction';
                    //     Enabled = LogInteractionEnable;
                    //     ToolTip = 'Specifies if you want to log this interaction.';
                    // }
                }
            }
        }

        actions
        {
        }
        trigger OnInit()
        begin
            // LogInteractionEnable := true;
            ArchiveDocument := PurchSetup."Archive Orders";
        end;

        trigger OnOpenPage()
        begin
            // LogInteractionEnable := LogInteraction;
        end;
    }

    trigger OnInitReport()
    var
        IsHandled: Boolean;
    begin
        GLSetup.Get();
        CompanyInfo.Get();
        PurchSetup.Get();
        CompanyInfo.CalcFields(Picture);

        IsHandled := false;
        OnInitReportForGlobalVariable(IsHandled, LegalOfficeTxt, LegalOfficeLbl, CustomGiroTxt, CustomGiroLbl);
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
            if "Purchase Header".FindSet() then
                repeat
                    SegManagement.LogDocument(
                      13, "Purchase Header"."No.", 0, 0, DATABASE::Vendor, "Purchase Header"."Buy-from Vendor No.",
                      "Purchase Header"."Purchaser Code", '', "Purchase Header"."Posting Description", '');
                until "Purchase Header".Next() = 0;
    end;

    trigger OnPreReport()
    begin
        if not CurrReport.UseRequestPage then
            InitLogInteraction();

        if CompanyInfo.Get() then
            CompanyInfo.CalcFields(Picture);
    end;

    var
        BuyFromContact: Record Contact;
        PaymentTermRec: Record "Payment Terms";
        PaymentMethodRec: Record "Payment Method";
        PayToContact: Record Contact;
        ShipToAddrr: Record "Ship-to Address";
        PurchSetup: Record "Purchases & Payables Setup";
        ShipmentMethod: Record "Shipment Method";
        PaymentTerms: Record "Payment Terms";
        PrepmtPaymentTerms: Record "Payment Terms";
        SalespersonPurchaser: Record "Salesperson/Purchaser";
        TempVATAmountLine: Record "VAT Amount Line" temporary;
        TempPrepmtVATAmountLine: Record "VAT Amount Line" temporary;
        TempPrepaymentInvLineBuffer: Record "Prepayment Inv. Line Buffer" temporary;
        TempPrePmtVATAmountLineDeduct: Record "VAT Amount Line" temporary;
        GLSetup: Record "General Ledger Setup";
        TempPurchLine: Record "Purchase Line" temporary;
        CurrExchRate: Record "Currency Exchange Rate";
        CompanyInfo: Record "Company Information";
        CurrencyExchangeRate: Record "Currency Exchange Rate";
        AfkLocalCurrency: Record Currency;
        ResponsibilityCenter: Record "Responsibility Center";
        // Vendor: Record Vendor;
        AfkCurrency: Record Currency;
        // LanguageMgt: Codeunit Language;
        FormatAddr: Codeunit "Format Address";
        FormatDocument: Codeunit "Format Document";
        PurchPost: Codeunit "Purch.-Post";
        SegManagement: Codeunit SegManagement;
        PurchasePostPrepayments: Codeunit "Purchase-Post Prepayments";
        ArchiveManagement: Codeunit ArchiveManagement;
        AutoFormat: Codeunit "Auto Format";
        VATNoText: Text[80];
        A01PaymentTermName: Text[100];
        A01PaymentModeName: Text[100];
        A01VendorIdentity: Text[100];
        TransHeaderAmount: Decimal;
        ReferenceText: Text[80];
        A01LinePU: Decimal;
        A01LineQty: Decimal;
        OutputNo: Integer;
        DimText: Text[120];
        VATAmount: Decimal;
        A01DiscountedPrice: Decimal;
        A01DiscountedPriceText: Text[50];
        VATBaseAmount: Decimal;
        AfkIsLine: Integer;
        NumLigneText: Code[2];
        // TotalInvDiscAmount: Decimal;
        // TotalPaymentDiscOnVAT: Decimal;
        TotalAmountVAT: Decimal;
        VATDiscountAmount: Decimal;
        PrevLineAmount: Decimal;
        TotalAmountInclVAT: Decimal;
        VALVATBaseLCY: Decimal;
        // AfkLinesNumber: Integer;
        MoreLines: Boolean;
        VALVATAmountLCY: Decimal;
        VALSpecLCYHeader: Text[80];
        VALExchRate: Text[50];
        PrepmtVATAmount: Decimal;
        PrepmtVATBaseAmount: Decimal;
        PrepmtTotalAmountInclVAT: Decimal;
        PrepmtLineAmount: Decimal;
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
        A01VendorAddress: Text[100];
        NumLigne: Integer;
        A01TotalVAT_LCY: Decimal;
        A01LinePUFormatted: Text[50];
        A01FormattedVAT: Text[50];
        // AllowInvDisctxt: Text[30];
        CompanyLogoPosition: Integer;
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
        A01SupplierPhone: Text[50];
        TotalAmountExclInclVATTextValue: Text;
        TotalAmountExclInclVATValue: Decimal;
        A01PurchaseOrder__Caption: Label 'PURCHASE ORDER';
        PaymenTerms__Caption: Label 'Payment terms :';
        PaymentMode__Caption: Label 'Payment mode :';
        Requested_Receipt_DateLbl: Label 'Requested receipt date :';
        A01NameOfSupplier__Lbl: Label 'Name of supplier :';
        A01SupplierIdentity__Lbl: Label 'Supplier identity :';
        A01NameAddress__Lbl: Label 'Supplier address :';
        A01SupplierPhone__Lbl: Label 'Phone :';
        A01SupplierNIF__Lbl: Label 'NIF :';
        A01SupplierSTAT__Lbl: Label 'STAT :';
        A01SupplierRCS__Lbl: Label 'RCS :';
        A01PurchaseNumber__Lbl: Label 'Purchase order numbe :';
        A01PurchaseDate__Lbl: Label 'OrderDate :';
        A01UditecInvoiceNo__Lbl: Label 'Vendor proforma reference :';
        AuthoriseSignLbl: Label 'Authorized signatures';
        A01TotalHT__Lbl: Label 'Total HT :';
        A01TotalVAT__Lbl: Label 'Total VAT :';
        A01TotalTTC__Lbl: Label 'Total TTC :';
        // A01Sgnature__Lbl: Label 'Signature :';
        A01ProductCodeLbl: Label 'Product code';
        A01DesignationLbl: Label 'Designation';
        A01QuantityLbl: Label 'qty';
        A01UnitPriceLbl: Label 'Unit price HT';
        A01DiscountPercentLbl: Label 'Discount';
        A01DiscountAmountLbl: Label 'Discounted prices HT';
        VATAmountSpecificationLbl: Label 'VAT Amount Specification in ';
        LocalCurrentyLbl: Label 'Local Currency';
        ExchangeRateLbl: Label 'Exchange rate: %1/%2', Comment = '%1 = CurrExchRate."Relational Exch. Rate Amount", %2 = CurrExchRate."Exchange Rate Amount"';
        CompanyInfoPhoneNoCaptionLbl: Label 'Phone No.';
        CompanyInfoGiroNoCaptionLbl: Label 'Giro No.';
        CompanyInfoBankNameCaptionLbl: Label 'Bank';
        CompanyInfoBankAccNoCaptionLbl: Label 'Account No.';
        OrderNoCaptionLbl: Label 'Order No.';
        PageCaptionLbl: Label 'Page';
        DocumentDateCaptionLbl: Label 'Document Date';
        DirectUniCostCaptionLbl: Label 'Direct Unit Cost';
        PurchLineLineDiscCaptionLbl: Label 'Discount %';
        VATDiscountAmountCaptionLbl: Label 'Payment Discount on VAT';
        PaymentDetailsCaptionLbl: Label 'Payment Details';
        VendNoCaptionLbl: Label 'Vendor No.';
        ShiptoAddressCaptionLbl: Label 'Ship-to Address';
        PrepmtInvBuDescCaptionLbl: Label 'Description';
        PrepmtInvBufGLAccNoCaptionLbl: Label 'G/L Account No.';
        PrepaymentSpecCaptionLbl: Label 'Prepayment Specification';
        PrepymtVATAmtSpecCaptionLbl: Label 'Prepayment VAT Amount Specification';
        AmountCaptionLbl: Label 'Amount';
        PurchLineInvDiscAmtCaptionLbl: Label 'Invoice Discount Amount';
        SubtotalCaptionLbl: Label 'Subtotal';
        VATAmtLineVATCaptionLbl: Label 'VAT %';
        VATAmtLineVATAmtCaptionLbl: Label 'VAT Amount';
        VATAmtSpecCaptionLbl: Label 'VAT Amount Specification';
        VATIdentifierCaptionLbl: Label 'VAT Identifier';
        VATAmtLineInvDiscBaseAmtCaptionLbl: Label 'Invoice Discount Base Amount';
        VATAmtLineLineAmtCaptionLbl: Label 'Line Amount';
        VALVATBaseLCYCaptionLbl: Label 'VAT Base';
        PricesInclVATtxtLbl: Label 'Prices Including VAT';
        TotalCaptionLbl: Label 'Total';
        PaymentTermsDescCaptionLbl: Label 'Payment Terms';
        ShipmentMethodDescCaptionLbl: Label 'Shipment Method';
        PrepymtTermsDescCaptionLbl: Label 'Prepmt. Payment Terms';
        HomePageCaptionLbl: Label 'Home Page';
        EmailIDCaptionLbl: Label 'Email';
        AllowInvoiceDiscCaptionLbl: Label 'Allow Invoice Discount';
        BuyFromContactPhoneNoLbl: Label 'Buy-from Contact Phone No.';
        BuyFromContactMobilePhoneNoLbl: Label 'Buy-from Contact Mobile Phone No.';
        BuyFromContactEmailLbl: Label 'Buy-from Contact E-Mail';
        PayToContactPhoneNoLbl: Label 'Pay-to Contact Phone No.';
        PayToContactMobilePhoneNoLbl: Label 'Pay-to Contact Mobile Phone No.';
        PayToContactEmailLbl: Label 'Pay-to Contact E-Mail';
        DocumentTitleLbl: Label 'Purchase Order';
        ReceivebyCaptionLbl: Label 'Receive By';
        BuyerCaptionLbl: Label 'Buyer';
        ItemNumberCaptionLbl: Label 'Item No.';
        ItemDescriptionCaptionLbl: Label 'Description';
        ItemQuantityCaptionLbl: Label 'Quantity';
        ItemUnitCaptionLbl: Label 'Unit';
        ItemUnitPriceCaptionLbl: Label 'Unit Price';
        ItemLineAmountCaptionLbl: Label 'Line Amount';
        PricesIncludingVATCaptionLbl: Label 'Prices Including VAT';
        ItemUnitOfMeasureCaptionLbl: Label 'Unit';
        ToCaptionLbl: Label 'To:';
        VendorIDCaptionLbl: Label 'Vendor ID';
        ConfirmToCaptionLbl: Label 'Confirm To';
        PurchOrderCaptionLbl: Label 'PURCHASE ORDER';
        PurchOrderNumCaptionLbl: Label 'Purchase Order Number:';
        PurchOrderDateCaptionLbl: Label 'Purchase Order Date:';
        VendorItemRefLbl: label 'Vendor reference';
        TaxIdentTypeCaptionLbl: Label 'Tax Ident. Type';
        TotalPriceCaptionLbl: Label 'Total Price';
        InvDiscCaptionLbl: Label 'Invoice Discount:';
        GreetingLbl: Label 'Hello';
        ClosingLbl: Label 'Sincerely';
        BodyLbl: Label 'The purchase order is attached to this message.';
        OrderDateLbl: Label 'Order Date';
        VendorOrderNoLbl: Label 'Vendor Order No.';
        VendorInvoiceNoLbl: Label 'Vendor Invoice No.';
        UnitPriceLbl: Label 'Unit Price (LCY)';
        JobNoLbl: Label 'Job No.';
        JobTaskNoLbl: Label 'Job Task No.';
        PromisedReceiptDateLbl: Label 'Promised Receipt Date';
        RequestedReceiptDateLbl: Label 'Requested Receipt Date';
        ExpectedReceiptDateLbl: Label 'Expected Receipt Date';
        PlannedReceiptDateLbl: Label 'Planned Receipt Date';
        LegalOfficeTxt, LegalOfficeLbl, CustomGiroTxt, CustomGiroLbl : Text;

        // protected var

        BuyFromAddr: array[8] of Text[100];
        CompanyAddr: array[8] of Text[100];
        VendAddr: array[8] of Text[100];
        ShipToAddr: array[8] of Text[100];
        FormattedQuanitity: Text;
        FormattedDirectUnitCost: Text;
        FormattedVATPct: Text;
        FormattedLineAmount: Text;
        PurchaserText: Text[50];
        TotalText: Text[50];
        TotalInclVATText: Text[50];
        TotalExclVATText: Text[50];
        ArchiveDocument: Boolean;
        LogInteraction: Boolean;
        // LogInteractionEnable: Boolean;
        TotalSubTotal, TotalAmount, TotalInvoiceDiscountAmount : Decimal;

    /// <summary>
    /// IsReportInPreviewMode.
    /// </summary>
    /// <returns>Return value of type Boolean.</returns>
    procedure InitializeRequest(LogInteractionParam: Boolean)
    begin
        LogInteraction := LogInteractionParam;
    end;

    protected procedure IsReportInPreviewMode(): Boolean
    var
        MailManagement: Codeunit "Mail Management";
    begin
        exit(CurrReport.Preview() or MailManagement.IsHandlingGetEmailBody());
    end;

    local procedure FormatAddressFields(var PurchaseHeader: Record "Purchase Header")
    begin
        FormatAddr.GetCompanyAddr(PurchaseHeader."Responsibility Center", ResponsibilityCenter, CompanyInfo, CompanyAddr);
        FormatAddr.PurchHeaderBuyFrom(BuyFromAddr, PurchaseHeader);
        if PurchaseHeader."Buy-from Vendor No." <> PurchaseHeader."Pay-to Vendor No." then
            FormatAddr.PurchHeaderPayTo(VendAddr, PurchaseHeader);
        FormatAddr.PurchHeaderShipTo(ShipToAddr, PurchaseHeader);
    end;

    local procedure FormatDocumentFields(PurchaseHeader: Record "Purchase Header")
    begin
        // with PurchaseHeader do begin
        FormatDocument.SetTotalLabels(PurchaseHeader."Currency Code", TotalText, TotalInclVATText, TotalExclVATText);
        FormatDocument.SetPurchaser(SalespersonPurchaser, PurchaseHeader."Purchaser Code", PurchaserText);
        FormatDocument.SetPaymentTerms(PaymentTerms, PurchaseHeader."Payment Terms Code", PurchaseHeader."Language Code");
        FormatDocument.SetPaymentTerms(PrepmtPaymentTerms, PurchaseHeader."Prepmt. Payment Terms Code", PurchaseHeader."Language Code");
        FormatDocument.SetShipmentMethod(ShipmentMethod, PurchaseHeader."Shipment Method Code", PurchaseHeader."Language Code");

        ReferenceText := FormatDocument.SetText(PurchaseHeader."Your Reference" <> '', PurchaseHeader."Your Reference");
        VATNoText := FormatDocument.SetText(PurchaseHeader."VAT Registration No." <> '', PurchaseHeader."VAT Registration No.");
        // end;

        OnAfterFormatDocumentFields(PurchaseHeader);
    end;

    local procedure InitLogInteraction()
    begin
        LogInteraction := SegManagement.FindInteractionTemplateCode(Enum::"Interaction Log Entry Document Type"::"Purch. Ord.") <> '';
    end;

    [IntegrationEvent(true, false)]
    local procedure OnAfterFormatDocumentFields(var PurchaseHeader: Record "Purchase Header")
    begin
    end;

    [IntegrationEvent(false, false)]
    local procedure OnInitReportForGlobalVariable(var IsHandled: Boolean; var LegalOfficeTxt: Text; var LegalOfficeLbl: Text; var CustomGiroTxt: Text; var CustomGiroLbl: Text)
    begin
    end;
}