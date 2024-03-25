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
                    DataItemTableView = sorting("Document Type", "Customer No.") where("Document Type" = filter(invoice));
                    DataItemLinkReference = Line;
                    DataItemLink = "Customer No." = field("Account No."), "Applies-to ID" = field("Applies-to ID");
                    column(Document_No_; "Document No.")
                    {
                    }
                    column(Amount_to_Apply; "Amount to Apply")
                    {
                        AutoFormatExpression = Header."Currency Code";
                        AutoFormatType = 1;
                    }

                    trigger OnAfterGetRecord()
                    begin
                        // Clear(Total);
                        // Clear(MontantTotal);
                        // CustLedgerEntryRec.Reset();
                        // CustLedgerEntryRec.SetRange("Customer No.", Line."Account No.");
                        // CustLedgerEntryRec.SetRange("Applies-to ID", Line."Applies-to ID");
                        // if CustLedgerEntryRec.FindFirst() then
                        //     repeat
                        //         Total := Total + CustLedgerEntryRec."Amount to Apply";
                        //     until CustLedgerEntryRec.Next() = 0;
                        // MontantTotal := Total;

                        // Check.InitTextVariable();
                        // Check.FormatNoText(NoText, "Credit Amount", Currency.Code);
                        // NoText[1] := ReplaceString(NoText[1], '****');
                        // NoText[1] := ReplaceString(NoText[1], 'AND 0/100');
                        // NoText[2] := ReplaceString(NoText[2], '****');
                        // NoText[2] := ReplaceString(NoText[2], 'AND 0/100');
                        // AmountInWords := NoText[1] + ' ' + NoText[2];
                    end;
                }
                trigger OnAfterGetRecord()
                begin
                    if Cust.Get(Line."Account No.") then begin
                        CustName := Cust.Name;
                        CustAddress := Cust.Address;
                        CustPhone := Cust."Phone No.";
                    end;

                    Clear(Total);
                    Clear(MontantTotal);
                    Line.SetRange("No.", Header."No.");
                    if Line.FindFirst() then
                        repeat
                            Total := Total + Line."Credit Amount";
                        until Line.Next() = 0;
                    MontantTotal := Total;

                    A01Total_LCY := CurrencyExchangeRate.ExchangeAmtFCYToLCY(Header."Posting Date",
                       Header."Currency Code", "Credit Amount", Header."Currency Factor");

                    A01Total_LCY := ROUND(MontantTotal, Currency."Amount Rounding Precision");

                    A01Total_LCYText :=
                      Format(A01Total_LCY, 0,
                      AutoFormat.ResolveAutoFormat("Auto Format"::AmountFormat, Currency.Code));

                    Check.InitTextVariable();
                    Check.FormatNoText(NoText, A01Total_LCY, Currency.Code);
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
        layout
        {
            area(Content)
            {
                // group(GroupName)
                // {
                //     field(Name; SourceExpression)
                //     {
                //         ApplicationArea = All;

                //     }
                // }
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
    end;

    var
        CompanyInfo: Record "Company Information";
        Cust: Record Customer;
        CurrencyExchangeRate: Record "Currency Exchange Rate";
        Currency: Record Currency;
        // CustLedgerEntryRec: Record "Cust. Ledger Entry";
        Check: Report Check;
        AutoFormat: Codeunit "Auto Format";
        // RespCenter: Record "Responsibility Center";
        CustName: Text[100];
        // CalculatedExchRate: Decimal;
        // ExchangeRateText: Text;
        A01Total_LCY: Decimal;
        TotalAmount: Decimal;
        CustAddress: Text[100];
        A01Total_LCYText: Text[50];
        CustPhone: Text[30];
        NoText: array[2] of Text;
        // ExchangeRateTxt: Label 'Exchange rate: %1/%2', Comment = '%1 and %2 are both amounts.';
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
        // VendorNameLbl: Label 'Vendor name :';
        CustSignLbl: Label 'Customer signature';
        CompanySignLbl: Label 'Company signature';
        ArrestedSumLbl: Label 'Arrested at the sum of :';
        RefLbl: Label 'No';
        DesignationLbl: Label 'Designation';
        ObjectLbl: Label 'Object';
        PaymentModeLbl: Label 'Payment mode';
        AmountLbl: Label 'Amount';
        TotalAmountLbl: Label 'Total Amount :';

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