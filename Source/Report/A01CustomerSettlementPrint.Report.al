/// <summary>
/// Report A01 CustomerSettlementPrint (ID 50021).
/// </summary>
report 50021 "A01 CustomerSettlementPrint"
{
    DefaultLayout = RDLC;
    Caption = 'A01 Customer Settlement print';
    PreviewMode = PrintLayout;
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;
    RDLCLayout = './Source/Report/Layout/CustomerSettlementPrint.rdl';
    dataset
    {
        dataitem("A01 Posted Payment Document"; "A01 Posted Payment Document")
        {
            DataItemTableView = sorting("No.");
            RequestFilterFields = "No.";
            RequestFilterHeading = 'Cash Receipt';
            column(DocumentNo_; "No.")
            {
            }
            column(CompanyName; COMPANYPROPERTY.DisplayName())
            {
            }
            column(CompanyPicture; CompanyInfo.Picture)
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
            column(A01_Description; Object)
            {
            }
            column(ReportTitleLbl; ReportTitleLbl)
            {
            }
            column(Validated_Amount; "Validated Amount")
            {
                AutoFormatExpression = "A01 Posted Payment Document"."Currency Code";
                AutoFormatType = 1;
            }
            column(Partner_No_; "Partner No.")
            {
            }
            column(Partner_Name; "Partner Name")
            {
            }
            column(CashReceiptNumberLbl; CashReceiptNumberLbl)
            {
            }
            column(DateOfPrintLbl; DateOfPrintLbl)
            {
            }
            column(CustNameLbl; CustNameLbl)
            {
            }
            column(CustIdentityLbl; CustIdentityLbl)
            {
            }
            column(CustAddressLbl; CustAddressLbl)
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
            column(CustPhoneLbl; CustPhoneLbl)
            {
            }
            column(CustName; CustName)
            {
            }
            column(CustAddress; CustAddress)
            {
            }
            column(CustPhone; CustPhone)
            {
            }
            column(RefLbl; RefLbl)
            {
            }
            column(DesignationLbl; DesignationLbl)
            {
            }
            column(ObjectLbl; ObjectLbl)
            {
            }
            column(PaymentModeLbl; PaymentModeLbl)
            {
            }
            column(CustIdentity; CustIdentity)
            {
            }
            column(CustAddressName; CustAddressName)
            {
            }
            column(AmountLbl; AmountLbl)
            {
            }
            column(ArrestedSumLbl; ArrestedSumLbl)
            {
            }
            column(CustSignLbl; CustSignLbl)
            {
            }
            column(CompanySignLbl; CompanySignLbl)
            {
            }
            column(TotalAmountLbl; TotalAmountLbl)
            {
            }
            column(AfkCurrCode; AfkCurrCode)
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
            dataitem("A01 Posted Payment Doc Line"; "A01 Posted Payment Doc Line")
            {
                DataItemTableView = sorting("Document No.");
                DataItemLinkReference = "A01 Posted Payment Document";
                DataItemLink = "Document No." = field("No.");
                column(Document_No_; "Document No.")
                {
                }
                column(Amount__LCY_; "Amount (LCY)")
                {
                }
                column(Credit_Amount; Amount)
                {
                    AutoFormatExpression = "A01 Posted Payment Document"."Currency Code";
                    AutoFormatType = 1;
                }
                column(ValidatedAmount_; "Validated Amount")
                {
                    AutoFormatExpression = "A01 Posted Payment Document"."Currency Code";
                    AutoFormatType = 1;
                }
                column(Payment_Method; "Payment Method")
                {
                }
                column(AmountInWords; AmountInWords)
                {
                }
                column(TotalAmount; TotalAmount)
                {
                    AutoFormatExpression = "A01 Posted Payment Document"."Currency Code";
                    AutoFormatType = 1;
                }
                column(A01Total_LCY; A01Total_LCY)
                {
                    AutoFormatExpression = "A01 Posted Payment Document"."Currency Code";
                    AutoFormatType = 1;
                }
                column(A01Total_LCYText; A01Total_LCYText)
                {
                }
                column(Total; Total)
                {
                }
                column(MontantTotal; MontantTotal)
                {
                    AutoFormatExpression = "A01 Posted Payment Document"."Currency Code";
                    AutoFormatType = 1;
                }
                column(Reference; Reference)
                {
                }
                // trigger OnAfterGetRecord()
                // begin
                //     "A01 Posted Payment Doc Line".Reset();
                //     "A01 Posted Payment Doc Line".SetRange("Document No.", "A01 Posted Payment Document"."No.");
                // end;
            }
            trigger OnAfterGetRecord()
            begin
                GLSetup.Get();
                GLSetup.TestField("LCY Code");

                AfkCurrCode := GLSetup."Local Currency Symbol";
                if Cust.Get("A01 Posted Payment Document"."Partner No.") then begin
                    CustName := Cust.Name;
                    CustIdentity := Cust.Contact;
                    CustPhone := Cust."Phone No.";
                    CustAddress := Cust."Ship-to Code";
                    rcs := Cust."A01 RCS";
                    stat := Cust."A01 STAT";
                    nif := Cust."A01 NIF";
                end;

                CurrCode := "A01 Posted Payment Document"."Currency Code";
                if (CurrCode = '') then
                    CurrCode := GLSetup."LCY Code";

                AfkCurrencyName := CurrCode;
                if AfkCurrency.Get(CurrCode) then
                    AfkCurrencyName := AfkCurrency.Description;

                if (AfkLocalCurrency.Get(GLSetup."LCY Code") and (CurrCode <> GLSetup."LCY Code")) then
                    AfkLocalCurrencyName := AfkLocalCurrency.Description;

                if "Currency Code" <> '' then begin
                    CurrencyExchangeRate.FindCurrency("Posting Date", "Currency Code", 1);
                    // CalculatedExchRate :=
                    //   Round(1 / "Currency Factor" * CurrencyExchangeRate."Exchange Rate Amount", 0.000001);
                    // ExchangeRateText := StrSubstNo(ExchangeRateTxt, CalculatedExchRate, CurrencyExchangeRate."Exchange Rate Amount");
                end;

                // A01Total_LCY := CurrencyExchangeRate.ExchangeAmtFCYToLCY("A01 Payment Document"."Posting Date",
                //    "A01 Payment Document"."Currency Code", "Validated Amount", "A01 Payment Document"."Currency Factor");
                A01Total_LCY := ROUND("Validated Amount", AfkLocalCurrency."Amount Rounding Precision");
                A01Total_LCYText :=
                  Format(A01Total_LCY, 0,
                  AutoFormat.ResolveAutoFormat("Auto Format"::AmountFormat, AfkLocalCurrency.Code));
                A01Total_LCYText := Format(A01Total_LCY);

                Check.InitTextVariable();
                Check.FormatNoText(NoText, A01Total_LCY, AfkLocalCurrency.Code);
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

        }

        actions
        {

        }
    }
    trigger OnPreReport()
    begin
        CompanyInfo.Get();
        CompanyInfo.CalcFields(Picture);
    end;


    var
        CompanyInfo: Record "Company Information";
        Cust: Record Customer;
        GLSetup: Record "General Ledger Setup";
        CurrencyExchangeRate: Record "Currency Exchange Rate";
        // Currency: Record Currency;
        AfkLocalCurrency: Record Currency;
        AfkCurrency: Record Currency;
        Check: Report Check;
        AutoFormat: Codeunit "Auto Format";
        CustName: Text[100];
        AfkLocalCurrencyName: Text;
        AfkCurrCode: Code[20];
        CurrCode: Code[20];
        AfkCurrencyName: Text;
        CustAddressName: Text[100];
        // CalculatedExchRate: Decimal;
        // ExchangeRateText: Text;
        A01Total_LCY: Decimal;
        TotalAmount: Decimal;
        CustAddress: Text[100];
        CustIdentity: Text[100];
        A01Total_LCYText: Text[50];
        CustPhone: Text[30];
        rcs: Code[30];
        nif: Code[30];
        stat: Code[30];
        NoText: array[2] of Text;
        // ExchangeRateTxt: Label 'Exchange rate: %1/%2', Comment = '%1 and %2 are both amounts.';
        ReportTitleLbl: Label 'CASH RECEIPT';
        DateOfPrintLbl: Label 'Date :';
        CustNameLbl: Label 'Customer name :';
        CustIdentityLbl: Label 'Customer identity :';
        CustAddressLbl: Label 'Customer address :';
        NIFLbl: Label 'NIF :';
        STATLbl: Label 'STAT :';
        RCSLbl: Label 'RCS :';
        CustPhoneLbl: Label 'Phone :';
        CashReceiptNumberLbl: Label 'Reference :';
        CustSignLbl: Label 'Customer signature';
        CompanySignLbl: Label 'Company signature';
        ArrestedSumLbl: Label 'Arrested at the sum of :';
        RefLbl: Label 'No';
        DesignationLbl: Label 'Designation';
        ObjectLbl: Label 'Reference';
        PaymentModeLbl: Label 'Payment mode';
        AmountLbl: Label 'Amount';
        TotalAmountLbl: Label 'Total Amount';

        Total: Decimal;
        MontantTotal: Decimal;
        AmountInWords: Text;


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