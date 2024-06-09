/// <summary>
/// Report A01 Requisition check (ID 50033).
/// </summary>
report 50033 "A01 RequisitionCheck"
{
    DefaultLayout = RDLC;
    Caption = 'A01 Requisition check';
    PreviewMode = PrintLayout;
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;
    RDLCLayout = './Source/Report/Layout/RequisitionCheck.rdl';

    dataset
    {
        dataitem(Line; "Gen. Journal Line")
        {
            DataItemTableView = sorting("Document No.");
            RequestFilterFields = "Document No.";
            RequestFilterHeading = 'Requisition check';
            column(CompanyInfoPicture; CompanyInfo.Picture)
            {
            }
            column(CompanyInfoName; CompanyInfo.Name)
            {
            }
            column(CompanyInfoAddress; CompanyInfo.Address)
            {
            }
            column(CompanyInfoCity; CompanyInfo.City)
            {
            }
            column(CompanyInfoPostCode; CompanyInfo."Post Code")
            {
            }
            column(Document_No_; "Document No.")
            {
            }
            column(External_Document_No_; "External Document No.")
            {
            }
            column(Posting_Date; Format("Posting Date", 0, 4))
            {
            }
            column(PrintDate; Format(Today, 0, 4))
            {
            }
            column(Description; Description)
            {
            }
            column(Applies_to_Doc__No_; "Applies-to Doc. No.")
            {
            }
            column(Amount; Amount)
            {
                AutoFormatExpression = "Currency Code";
                AutoFormatType = 1;
            }
            column(Debit_Amount; "Debit Amount")
            {
                AutoFormatExpression = "Currency Code";
                AutoFormatType = 1;
            }
            column(Amount__LCY_; "Amount (LCY)")
            {
                AutoFormatExpression = "Currency Code";
                AutoFormatType = 1;
            }
            column(PurchaseInvoiceLbl; PurchaseInvoiceLbl)
            {
            }
            column(DocumentDateLbl; DocumentDateLbl)
            {
            }
            column(DescriptionLbl; DescriptionLbl)
            {
            }
            column(VatLbl; VatLbl)
            {
            }
            column(SupplierInvoiceLbl; SupplierInvoiceLbl)
            {
            }
            column(NoteLbl; NoteLbl)
            {
            }
            column(NetAmountMgaLbl; NetAmountMgaLbl)
            {
            }
            column(TotalLbl; TotalLbl)
            {
            }
            column(OrdonatorLbl; OrdonatorLbl)
            {
            }
            column(PrepareByLbl; PrepareByLbl)
            {
            }
            column(ApprouvedByLbl; ApprouvedByLbl)
            {
            }
            column(VerifiedByLbl; VerifiedByLbl)
            {
            }
            column(ReceivedByLbl; ReceivedByLbl)
            {
            }


            column(LogoOption; OptionValue)
            {
            }
            column(RespCenterUditec; RespCenterUditec."A01 Logo")
            {
            }
            column(OptionType; OptionType)
            {
            }
            column(BenName; BenName)
            {
            }
            column(VendAddress; VendAddress)
            {
            }
            column(DocumentDate; DocumentDate)
            {
            }
            column(CredAmount; CredAmount)
            {
            }
            column(CredAmount_Txt; CredAmount_Txt)
            {
            }
            column(VatTxt; VatTxt)
            {
            }
            column(BenAddress; BenAddress)
            {
            }
            column(AmountIn_LCYText; AmountIn_LCYText)
            {
            }
            column(AmountInWords; AmountInWords)
            {
            }
            column(AfkCurrCode; AfkCurrCode)
            {
            }
            column(AmountInc_LCY; AmountInc_LCY)
            {
            }
            trigger OnAfterGetRecord()
            begin
                if OptionValue = OptionValue::LogoCosmos then
                    OptionType := 1
                else
                    OptionType := 0;

                if VendorRec.Get(Line."Account No.") then begin
                    BenName := VendorRec.Name;
                    VendAddress := VendorRec.Address;
                end;

                VatVallue := CurrencyExchangeRate.ExchangeAmtFCYToLCY(Line."Posting Date",
                                    Line."Currency Code", VatVallue, Line."Currency Factor");
                VatVallue := "VAT Amount";
                // VatVallue := ROUND(AmountInc_LCY, AfkLocalCurrency."Amount Rounding Precision");
                VatTxt := Format(VatVallue, 0, AutoFormat.ResolveAutoFormat("Auto Format"::AmountFormat, AfkLocalCurrency.Code));
                VatTxt := Format(VatVallue);

                if VendorLedgEnt.Get(Line."Account No.") then begin
                    DocumentDate := VendorLedgEnt."Posting Date";
                    CredAmount := VendorLedgEnt."Credit Amount";
                end;
                CredAmount := CurrencyExchangeRate.ExchangeAmtFCYToLCY(Line."Posting Date",
                               Line."Currency Code", CredAmount, Line."Currency Factor");
                CredAmount := "Credit Amount";
                // CredAmount := ROUND(CredAmount, AfkLocalCurrency."Amount Rounding Precision");
                CredAmount_Txt := Format(CredAmount, 0, AutoFormat.ResolveAutoFormat("Auto Format"::AmountFormat, AfkLocalCurrency.Code));
                CredAmount_Txt := Format(CredAmount_Txt);


                GLSetup.Get();
                GLSetup.TestField("LCY Code");

                AfkCurrCode := Line."Currency Code";
                if (AfkCurrCode = '') then
                    AfkCurrCode := GLSetup."LCY Code";

                AfkCurrencyName := AfkCurrCode;
                if AfkCurrency.Get(AfkCurrCode) then
                    AfkCurrencyName := AfkCurrency.Description;

                if (AfkLocalCurrency.Get(GLSetup."LCY Code") and (AfkCurrCode <> GLSetup."LCY Code")) then
                    AfkLocalCurrencyName := AfkLocalCurrency.Description;

                if "Currency Code" <> '' then begin
                    CurrencyExchangeRate.FindCurrency("Posting Date", "Currency Code", 1);
                    CalculatedExchRate :=
                      Round(1 / "Currency Factor" * CurrencyExchangeRate."Exchange Rate Amount", 0.000001);
                    ExchangeRateText := StrSubstNo(ExchangeRateTxt, CalculatedExchRate, CurrencyExchangeRate."Exchange Rate Amount");
                end;

                AmountInc_LCY := CurrencyExchangeRate.ExchangeAmtFCYToLCY(Line."Posting Date",
                                    Line."Currency Code", AmountInc_LCY, Line."Currency Factor");
                AmountInc_LCY := "Debit Amount";
                // AmountInc_LCY := ROUND(AmountInc_LCY, AfkLocalCurrency."Amount Rounding Precision");
                AmountIn_LCYText := Format(AmountInc_LCY, 0, AutoFormat.ResolveAutoFormat("Auto Format"::AmountFormat, AfkLocalCurrency.Code));
                AmountIn_LCYText := Format(AmountInc_LCY);

                RepCheck.InitTextVariable();
                RepCheck.FormatNoText(NoText, AmountInc_LCY, AfkLocalCurrency.Code);

                NoText[1] := ReplaceString(NoText[1], '****');
                NoText[1] := ReplaceString(NoText[1], 'AND 0/100');
                NoText[2] := ReplaceString(NoText[2], '****');
                NoText[2] := ReplaceString(NoText[2], 'AND 0/100');
                AmountInWords := NoText[1] + ' ' + NoText[2];

            end;
        }
    }

    requestpage
    {
        layout
        {
            area(Content)
            {
                group(groupName)
                {
                    Caption = 'Option';
                    field(OptionVal; OptionValue)
                    {
                        Caption = 'Logo';
                        OptionCaption = 'Uditec, Cosmos';
                        ApplicationArea = Basic, Suite;
                    }
                }
            }


        }

        actions
        {
        }
    }

    trigger OnInitReport()
    begin
        CompanyInfo.Get();
        CompanyInfo.CalcFields(Picture);

        RespCenterUditec.Get('UDT');
    end;


    var
        CompanyInfo: Record "Company Information";
        VendorRec: Record Vendor;
        VendorLedgEnt: Record "Vendor Ledger Entry";
        GLSetup: Record "General Ledger Setup";
        RespCenterUditec: Record "Responsibility Center";
        CurrencyExchangeRate: Record "Currency Exchange Rate";
        // VendorBanckAccRec: Record "Vendor Bank Account";
        // BankAccRec: Record "Bank Account";
        // LocalCurrency: Record Currency;
        AfkCurrency: Record Currency;
        AfkLocalCurrency: Record Currency;
        RepCheck: Report Check;
        AutoFormat: Codeunit "Auto Format";
        OptionValue: Option LogoUditec,LogoCosmos;
        OptionType: Integer;
        AmountInc_LCY: Decimal;
        VatVallue: Decimal;
        VatTxt: Text[50];
        CredAmount: Decimal;
        CredAmount_Txt: Text[50];
        DocumentDate: Date;
        CalculatedExchRate: Decimal;
        ExchangeRateText: Text;
        ExchangeRateTxt: Label 'Exchange rate: %1/%2', Comment = '%1 and %2 are both amounts.';
        AfkLocalCurrencyName: Text;
        AfkCurrCode: Code[20];
        AmountIn_LCYText: Text[50];
        NoText: array[2] of Text;
        AmountInWords: Text;
        AfkCurrencyName: Text;
        BenAddress: Text[100];
        VendAddress: Text[100];
        // BankAddress: Text[100];
        BenName: Text[100];
        // Bank: Text[100];
        // AccountNo: Text;
        // BankAccountNo: Text;
        PurchaseInvoiceLbl: Label 'Purchase Invoice';
        SupplierInvoiceLbl: Label 'Supplier Invoice';
        DocumentDateLbl: Label 'Document Date';
        DescriptionLbl: Label 'Description';
        VatLbl: Label 'VAT';
        NetAmountMgaLbl: Label 'Net Amount MGA';

        NoteLbl: Label 'Note :';
        TotalLbl: Label 'Total';
        PrepareByLbl: Label 'Prepared by :';
        OrdonatorLbl: Label 'Ordonator :';
        VerifiedByLbl: Label 'Verified by :';
        ApprouvedByLbl: Label 'Approuved by :';
        ReceivedByLbl: Label 'Received by :';


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