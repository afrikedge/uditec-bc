/// <summary>
/// Report A01 Recu Deciassement (ID 50039).
/// </summary>
report 50039 "A01 RecuDecaissement"
{
    DefaultLayout = RDLC;
    Caption = 'Reçu de décaissement';
    PreviewMode = PrintLayout;
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;
    RDLCLayout = './Source/Report/Layout/RecuDecaissement.rdl';

    dataset
    {
        dataitem(Line; "Gen. Journal Line")
        {
            DataItemTableView = sorting("Document No.");
            RequestFilterFields = "Document No.";
            RequestFilterHeading = 'Reçu de décaissement';
            column(CompanyPicture; CompanyInfo.Picture)
            {
            }
            column(CompanyName; COMPANYPROPERTY.DisplayName())
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
            column(Posting_Date; Format("Posting Date"))
            {
            }
            column(Document_No_; "Document No.")
            {
            }
            column(Description; Description)
            {
            }
            column(Amount; Amount)
            {
            }
            column(Account_No_; "Account No.")
            {
            }
            column(ReportTitleLbl; ReportTitleLbl)
            {
            }
            column(RefLbl; RefLbl)
            {
            }
            column(AmountLbl; AmountLbl)
            {
            }
            column(DescriptionLbl; DescriptionLbl)
            {
            }
            column(TotalAmountLbl; TotalAmountLbl)
            {
            }
            column(CustSignLbl; CustSignLbl)
            {
            }
            column(CompanySignLbl; CompanySignLbl)
            {
            }
            column(DateOfPrintLbl; DateOfPrintLbl)
            {
            }
            column(AccountNumberLbl; AccountNumberLbl)
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

            column(AmountInWords; AmountInWords)
            {
            }
            column(AfkCurrCode; AfkCurrCode)
            {
            }
            column(AmountInc_LCY; AmountInc_LCY)
            {
            }
            column(Payment_Method_Code; "Payment Method Code")
            {
            }


            trigger OnAfterGetRecord()
            begin
                if OptionValue = OptionValue::LogoCosmos then
                    OptionType := 1
                else
                    OptionType := 0;

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
        GLSetup: Record "General Ledger Setup";
        RespCenterUditec: Record "Responsibility Center";
        CurrencyExchangeRate: Record "Currency Exchange Rate";
        AfkCurrency: Record Currency;
        AfkLocalCurrency: Record Currency;
        RepCheck: Report Check;
        AutoFormat: Codeunit "Auto Format";
        AfkCurrCode: Code[20];
        OptionValue: Option LogoUditec,LogoCosmos;
        OptionType: Integer;
        AfkLocalCurrencyName: Text;
        AmountIn_LCYText: Text[50];
        NoText: array[2] of Text;
        AmountInWords: Text;
        AfkCurrencyName: Text;
        AmountInc_LCY: Decimal;
        CalculatedExchRate: Decimal;
        ExchangeRateText: Text;
        ExchangeRateTxt: Label 'Exchange rate: %1/%2', Comment = '%1 and %2 are both amounts.';
        ReportTitleLbl: Label 'BON DE CAISSE';
        RefLbl: Label 'No';
        AccountNumberLbl: Label 'N° compte';
        AmountLbl: Label 'Montant';
        TotalAmountLbl: Label 'Montant Total';
        DateOfPrintLbl: Label 'Date :';
        DescriptionLbl: Label 'Description';
        CustSignLbl: Label 'Signature caisse';
        CompanySignLbl: Label 'Signature bénéficiaire';


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