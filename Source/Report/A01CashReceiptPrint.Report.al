/// <summary>
/// Report A01 CashReceiptPrint (ID 50004).
/// </summary>
report 50004 "A01 CashReceiptPrint"
{
    Caption = 'A01 Cash Receipt Print';
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;
    DefaultLayout = RDLC;
    PreviewMode = PrintLayout;
    EnableHyperlinks = true;
    WordMergeDataItem = Header;
    RDLCLayout = './Source/Report/Layout/CashReceiptPrint.rdl';

    dataset
    {
        dataitem(Header; "Payment Header")
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
            column(A01_Description; "A01 Description")
            {
            }
            column(ReportTitleLbl; ReportTitleLbl)
            {
            }
            column(Payment_Class_Name; "Payment Class Name")
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
            column(rcs; rcs)
            {
            }
            column(nif; nif)
            {
            }
            column(stat; stat)
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
            dataitem(Line; "Payment Line")
            {
                DataItemTableView = sorting("No.", "Document No.");
                DataItemLinkReference = Header;
                DataItemLink = "No." = field("No.");
                column(No_; "No.")
                {
                }
                column(Amount__LCY_; "Amount (LCY)")
                {
                }
                column(Credit_Amount; "Credit Amount")
                {
                    AutoFormatExpression = Header."Currency Code";
                    AutoFormatType = 1;
                }
                column(AmountInWords; AmountInWords)
                {
                }
                column(TotalAmount; TotalAmount)
                {
                    AutoFormatExpression = Header."Currency Code";
                    AutoFormatType = 1;
                }
                column(A01Total_LCY; A01Total_LCY)
                {
                    AutoFormatExpression = Header."Currency Code";
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
                    AutoFormatExpression = Header."Currency Code";
                    AutoFormatType = 1;
                }
                dataitem("Cust. Ledger Entry"; "Cust. Ledger Entry")
                {
                    DataItemTableView = sorting("Document No.", "Document Type", Open) where("Document Type" = filter(1), Open = filter(0));
                    DataItemLinkReference = Header;
                    DataItemLink = "Document No." = field("No.");
                    column(Document_No_; "Document No.")
                    {
                    }
                    dataitem(CustLedgerEntry; "Cust. Ledger Entry")
                    {
                        DataItemTableView = sorting("Document No.", "Document Type", Open) where("Document Type" = filter(2), Open = filter(0));
                        DataItemLinkReference = "Cust. Ledger Entry";
                        DataItemLink = "Closed by Entry No." = field("Entry No.");
                        column(Closed_by_Amount__LCY_; "Closed by Amount (LCY)")
                        {
                            AutoFormatExpression = Header."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(Document_No; "Document No.")
                        {
                        }
                        column(External_Document_No_; "External Document No.")
                        {
                        }
                        column(Description; Description)
                        {
                        }
                        trigger OnAfterGetRecord()
                        begin
                            CustLedgerEntry.Reset();
                            CustLedgerEntry.SetRange("Closed by Entry No.", "Cust. Ledger Entry"."Entry No.");
                        end;
                    }
                }
                trigger OnAfterGetRecord()
                begin
                    GLSetup.Get();
                    GLSetup.TestField("LCY Code");

                    AfkCurrCode := GLSetup."Local Currency Symbol";

                    Line.Reset();
                    Line.SetRange("No.", "Cust. Ledger Entry"."Document No.");
                    Line.SetRange("No.", Header."No.");

                    if Cust.Get(Line."Account No.") then begin
                        CustName := Cust.Name;
                        rcs := Cust."A01 RCS";
                        stat := Cust."A01 STAT";
                        nif := Cust."A01 NIF";
                        CustIdentity := Cust.Contact;
                        CustPhone := Cust."Phone No.";
                        CustAddress := Cust."Ship-to Code";
                    end;

                    CurrCode := Header."Currency Code";
                    if (CurrCode = '') then
                        CurrCode := GLSetup."LCY Code";

                    AfkCurrencyName := CurrCode;
                    if AfkCurrency.Get(CurrCode) then
                        AfkCurrencyName := AfkCurrency.Description;

                    if (AfkLocalCurrency.Get(GLSetup."LCY Code") and (CurrCode <> GLSetup."LCY Code")) then
                        AfkLocalCurrencyName := AfkLocalCurrency.Description;

                    if "Currency Code" <> '' then begin
                        CurrencyExchangeRate.FindCurrency("Posting Date", "Currency Code", 1);
                        CalculatedExchRate :=
                          Round(1 / "Currency Factor" * CurrencyExchangeRate."Exchange Rate Amount", 0.000001);
                        ExchangeRateText := StrSubstNo(ExchangeRateTxt, CalculatedExchRate, CurrencyExchangeRate."Exchange Rate Amount");
                    end;

                    A01Total_LCY := CurrencyExchangeRate.ExchangeAmtFCYToLCY(Header."Posting Date",
                       Header."Currency Code", "Credit Amount", Header."Currency Factor");
                    A01Total_LCY := ROUND(A01Total_LCY, AfkLocalCurrency."Amount Rounding Precision");
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
    }

    requestpage
    {
        SaveValues = true;
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
        rcs: Code[30];
        nif: Code[30];
        stat: Code[30];
        AfkLocalCurrencyName: Text;
        AfkCurrCode: Code[20];
        CurrCode: Code[20];
        AfkCurrencyName: Text;
        CustAddressName: Text[100];
        CalculatedExchRate: Decimal;
        ExchangeRateText: Text;
        A01Total_LCY: Decimal;
        TotalAmount: Decimal;
        CustAddress: Text[100];
        CustIdentity: Text[100];
        A01Total_LCYText: Text[50];
        CustPhone: Text[30];
        NoText: array[2] of Text;
        ExchangeRateTxt: Label 'Exchange rate: %1/%2', Comment = '%1 and %2 are both amounts.';
        ReportTitleLbl: Label 'CASH RECEIPT';
        DateOfPrintLbl: Label 'Date of print :';
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