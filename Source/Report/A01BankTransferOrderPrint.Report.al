/// <summary>
/// Report A01 BankTransferOrderPrint (ID 50017).
/// </summary>
report 50017 "A01 BankTransferOrderPrint"
{
    DefaultLayout = RDLC;
    Caption = 'A01 Bank Trsanfer Order print';
    PreviewMode = PrintLayout;
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;
    RDLCLayout = './Source/Report/Layout/BankTransferOrderPrint.rdl';

    dataset
    {
        dataitem(Line; "Gen. Journal Line")
        {
            DataItemTableView = sorting("Document No.");
            RequestFilterFields = "Document No.";
            RequestFilterHeading = 'Ordre de virement';
            column(CompanyInfoPicture; CompanyInfo.Picture)
            {
            }
            column(CompanyInfoBranch; CompanyInfo."Bank Branch No.")
            {
            }
            column(CompanyInfoBankAccount; CompanyInfo."Bank Account No.")
            {
            }
            column(Document_No_; "Document No.")
            {
            }
            column(Posting_Date; Format("Posting Date"))
            {
            }
            column(Description; Description)
            {
            }
            column(BankName; BankName)
            {
            }
            column(BankAddress; BankAddress)
            {
            }
            column(Amount__LCY_; "Amount (LCY)")
            {
                AutoFormatExpression = "Currency Code";
                AutoFormatType = 1;
            }
            column(RefLbl; RefLbl)
            {
            }
            column(AntananarivoTxtLbl; AntananarivoTxtLbl)
            {
            }
            column(ObjetLbl; ObjetLbl)
            {
            }
            column(ObjectTextLbl; ObjectTextLbl)
            {
            }
            column(EnterpriseLbl; EnterpriseLbl)
            {
            }
            column(TitleLbl; TitleLbl)
            {
            }
            column(Txt1Lbl; Txt1Lbl)
            {
            }
            column(Txt2Lbl; Txt2Lbl)
            {
            }
            column(BeneficiaryNameLbl; BeneficiaryNameLbl)
            {
            }
            column(BenecifiaryAddressLbl; BenecifiaryAddressLbl)
            {
            }
            column(BenName; BenName)
            {
            }
            column(BankLbl; BankLbl)
            {
            }
            column(BenAddress; BenAddress)
            {
            }
            column(Bank; Bank)
            {
            }
            column(AccountNo; AccountNo)
            {
            }
            column(AccountNoLbl; AccountNoLbl)
            {
            }
            column(Txt3Lbl; Txt3Lbl)
            {
            }
            column(Txt4Lbl; Txt4Lbl)
            {
            }
            column(ALbl; ALbl)
            {
            }
            column(DirectionLbl; DirectionLbl)
            {
            }
            column(AmountIn_LCYText; AmountIn_LCYText)
            {
            }
            column(AmountInWords; AmountInWords)
            {
            }
            column(MGALbl; MGALbl)
            {
            }
            column(AfkCurrCode; AfkCurrCode)
            {
            }
            column(BankAccountNo; BankAccountNo)
            {
            }
            column(AmountInc_LCY; AmountInc_LCY)
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

            trigger OnAfterGetRecord()
            begin
                if OptionValue = OptionValue::LogoCosmos then
                    OptionType := 0
                else
                    OptionType := 1;

                if VendorRec.Get(Line."Account No.") then begin
                    // BenName := VendorRec.Name;
                    BenAddress := VendorRec.Address;
                end;

                if VendorBanckAccRec.Get(Line."Account No.", Line."Recipient Bank Account") then begin
                    BenName := VendorBanckAccRec."A01 Beneficiairy Name";
                    Bank := VendorBanckAccRec.Name;
                    AccountNo := VendorBanckAccRec."Bank Branch No." + ' ' + VendorBanckAccRec."Agency Code" + ' ' + VendorBanckAccRec."Bank Account No." + ' ' + Format(VendorBanckAccRec."RIB Key");
                end;

                if BankAccRec.Get(Line."Bal. Account No.") then begin
                    BankName := BankAccRec.Name;
                    BankAddress := BankAccRec.Address;
                    BankAccountNo := BankAccRec."Bank Branch No." + ' ' + BankAccRec."Agency Code" + ' ' + BankAccRec."Bank Account No." + ' ' + Format(BankAccRec."RIB Key");
                end;

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
                AmountInc_LCY := "Amount (LCY)";
                AmountInc_LCY := ROUND(AmountInc_LCY, AfkLocalCurrency."Amount Rounding Precision");
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
        RespCenterUditec: Record "Responsibility Center";
        GLSetup: Record "General Ledger Setup";
        CurrencyExchangeRate: Record "Currency Exchange Rate";
        VendorBanckAccRec: Record "Vendor Bank Account";
        BankAccRec: Record "Bank Account";
        // LocalCurrency: Record Currency;
        AfkCurrency: Record Currency;
        AfkLocalCurrency: Record Currency;
        RepCheck: Report Check;
        AutoFormat: Codeunit "Auto Format";
        OptionValue: Option LogoCosmos,LogoUditec;
        OptionType: Integer;
        AmountInc_LCY: Decimal;
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
        BankName: Text[100];
        BankAddress: Text[100];
        BenName: Text[250];
        Bank: Text[100];
        AccountNo: Text;
        BankAccountNo: Text;
        RefLbl: Label 'Ref :';
        MGALbl: Label 'MGA';
        ObjetLbl: Label 'Object :';
        ObjectTextLbl: Label 'Payment order';
        ALbl: Label 'A';
        EnterpriseLbl: Label 'Enterprises';
        AntananarivoTxtLbl: Label 'Antananarivo, le';
        TitleLbl: Label 'Madam/Sir,';
        Txt1Lbl: Label 'By debiting our account no:';
        Txt2Lbl: Label 'Please execute the amount transfer :';
        BeneficiaryNameLbl: Label 'Beneficiary name :';
        BenecifiaryAddressLbl: Label 'Address :';
        BankLbl: Label 'Banque :';
        AccountNoLbl: Label 'Account no :';
        Txt3Lbl: Label 'We authorize the corresponding fees and commissions to be debited from our account.';
        Txt4Lbl: Label 'Please accept, Madam/Sir, the expression of our distinguished greetings.';
        DirectionLbl: Label 'The direction,';


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