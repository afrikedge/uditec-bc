/// <summary>
/// Report A01 Recu Fournisseur (50042)
/// </summary>
report 50042 "A01 Recu fournisseur"
{
    DefaultLayout = RDLC;
    Caption = 'Bon de caisse - Fournisseur';
    PreviewMode = PrintLayout;
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;
    RDLCLayout = './Source/Report/Layout/RecuFour.rdl';
    dataset
    {
        dataitem(Line; "Vendor Ledger Entry")
        {
            DataItemTableView = sorting("Entry No.");
            RequestFilterFields = "Document No.";
            RequestFilterHeading = 'Bon de caisse';

            column(Document_No_; "Document No.")
            {
            }
            column(CompanyPicture; CompanyInfo.Picture)
            {
            }
            column(RespCenterUditec; RespCenterUditec."A01 Logo")
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
            column(Description; Description)
            {
            }
            column(Amount; "Debit Amount")
            {
            }
            column(Account_No_; "Vendor No.")
            {
            }
            column(AfkCurrCode; AfkCurrCode)
            {
            }


            column(LogoOption; OptionValue)
            {
            }
            column(OptionType; OptionType)
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
                    // CalculatedExchRate :=
                    //   Round(1 / "Original Currency Factor" * CurrencyExchangeRate."Exchange Rate Amount", 0.000001);
                    // ExchangeRateText := StrSubstNo(ExchangeRateTxt, CalculatedExchRate, CurrencyExchangeRate."Exchange Rate Amount");
                end;
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
    trigger OnPreReport()
    begin
        CompanyInfo.Get();
        CompanyInfo.CalcFields(Picture);

        RespCenterUditec.Get('UDT');
    end;

    var
        CompanyInfo: Record "Company Information";
        GLSetup: Record "General Ledger Setup";
        CurrencyExchangeRate: Record "Currency Exchange Rate";
        AfkCurrency: Record Currency;
        AfkLocalCurrency: Record Currency;
        RespCenterUditec: Record "Responsibility Center";
        AfkCurrCode: Code[20];
        AfkCurrencyName: Text;
        AfkLocalCurrencyName: Text;
        // CalculatedExchRate: Decimal;
        // ExchangeRateText: Text;
        OptionValue: Option LogoUditec,LogoCosmos;
        OptionType: Integer;

        ReportTitleLbl: Label 'BON DE CAISSE';
        RefLbl: Label 'No';
        AccountNumberLbl: Label 'N° compte';
        AmountLbl: Label 'Montant';
        TotalAmountLbl: Label 'Montant Total';
        DateOfPrintLbl: Label 'Date :';
        DescriptionLbl: Label 'Description';
        CustSignLbl: Label 'Signature caisse';
        CompanySignLbl: Label 'Signature bénéficiaire';


}