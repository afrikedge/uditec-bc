/// <summary>
/// Report A01 Posted Customer Settlement Print (ID 50024).
/// </summary>
report 50024 "A01 PostedCustSettlementPrint"
{
    DefaultLayout = RDLC;
    Caption = 'A01 Posted Customer Settlement print';
    PreviewMode = PrintLayout;
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;
    RDLCLayout = './Source/Report/Layout/PostedCustSettlementPrint.rdl';
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
            column(DocNumberLbl; DocNumberLbl)
            {
            }
            column(AppliedAmountLbl; AppliedAmountLbl)
            {
            }
            column(DescriptionLbl; DescriptionLbl)
            {
            }
            column(InitialAmountLbl; InitialAmountLbl)
            {
            }
            column(External_Document_No_; "External Document No.")
            {
            }
            column(Settled_By; "Settled By")
            {
            }
            column(ObjetLbl; ObjetLbl)
            {
            }
            column(ApplyingLbl; ApplyingLbl)
            {
            }
            column(TotalAmount2Lbl; TotalAmount2Lbl)
            {
            }
            column(CashierLbl; CashierLbl)
            {
            }
            column(Numberlbl; Numberlbl)
            {
            }
            column(UnitName__Caption; UnitName__Caption)
            {
            }
            column(UnitAddress__Caption; UnitAddress__Caption)
            {
            }
            column(City__Caption; City__Caption)
            {
            }
            column(PostalCode__Caption; PostalCode__Caption)
            {
            }
            column(UnitName; UnitName)
            {
            }
            column(unitAddress; unitAddress)
            {
            }
            column(City; City)
            {
            }
            column(PostCode; PostCode)
            {
            }
            column(DueDateLbl; DueDateLbl)
            {
            }
            column(Object; Object)
            {
            }
            column(LyneType; LyneType)
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
            column(RemainingAmountLbl; RemainingAmountLbl)
            {
            }
            dataitem("A01 Posted Payment Doc Line"; "A01 Posted Payment Doc Line")
            {
                DataItemTableView = sorting("Document No.");
                DataItemLinkReference = "A01 Posted Payment Document";
                DataItemLink = "Document No." = field("No."), "Account No." = field("Partner No.");
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
                column(Due_Date; Format("Due Date"))
                {
                }
                trigger OnAfterGetRecord()
                begin
                    LyneType := 1;
                end;
            }
            dataitem("Detailed Cust. Ledg. Entry"; "Detailed Cust. Ledg. Entry")
            {
                DataItemLinkReference = "A01 Posted Payment Document";
                DataItemLink = "Document No." = field("No.");
                DataItemTableView = sorting("Entry No.")
                        where("Entry Type" = filter(Application), "Document Type" = filter(Payment), "Initial Document Type" = filter(Invoice));
                column(CreditAmount; "Credit Amount")
                {
                }
                column(TotalAmt; ROUND("Credit Amount", AfkLocalCurrency."Amount Rounding Precision"))
                {
                    AutoFormatExpression = "A01 Posted Payment Document"."Currency Code";
                    AutoFormatType = 1;
                }
                column(TotalAmt_LCYText; TotalAmt_LCYText)
                {
                }
                column(Cust__Ledger_Entry_No_; "Cust. Ledger Entry No.")
                {
                }

                dataitem("Cust. Ledger Entry"; "Cust. Ledger Entry")
                {
                    DataItemLinkReference = "Detailed Cust. Ledg. Entry";
                    DataItemLink = "Entry No." = field("Cust. Ledger Entry No.");
                    DataItemTableView = sorting("Entry No.") where("Document Type" = filter(Invoice));

                    column(DocumentNo; "Document No.")
                    {
                    }
                    column(Description; Description)
                    {
                    }
                    column(Original_Amount; "Original Amount")
                    {
                    }
                    column(OriginAmt; OriginAmt)
                    {
                    }
                    column(OriginAmt_LCYText; OriginAmt_LCYText)
                    {
                    }
                    column(Remaining_Amount; Round("Remaining Amount"))
                    {
                    }
                    trigger OnAfterGetRecord()
                    begin
                        CalcFields("Remaining Amount");
                        OriginAmt := ROUND("Original Amount", AfkLocalCurrency."Amount Rounding Precision");
                        OriginAmt_LCYText := Format(OriginAmt, 0, AutoFormat.ResolveAutoFormat("Auto Format"::AmountFormat, AfkLocalCurrency.Code));
                        OriginAmt_LCYText := Format(OriginAmt);
                    end;
                }
                trigger OnAfterGetRecord()
                begin
                    LyneType := 2;

                    TotalAmt := ROUND("Credit Amount", AfkLocalCurrency."Amount Rounding Precision");
                    TotalAmt_LCYText := Format(TotalAmt, 0, AutoFormat.ResolveAutoFormat("Auto Format"::AmountFormat, AfkLocalCurrency.Code));
                    TotalAmt_LCYText := Format(TotalAmt);

                    A01Total_LCY := ROUND("A01 Posted Payment Document"."Validated Amount", AfkLocalCurrency."Amount Rounding Precision");
                    A01Total_LCYText :=
                      Format(A01Total_LCY, 0,
                      AutoFormat.ResolveAutoFormat("Auto Format"::AmountFormat, AfkLocalCurrency.Code));
                    A01Total_LCYText := Format(A01Total_LCY);
                end;
            }

            trigger OnAfterGetRecord()
            begin
                if OptionValue = OptionValue::LogoCosmos then
                    OptionType := 1
                else
                    OptionType := 0;

                GLSetup.Get();
                GLSetup.TestField("LCY Code");

                AfkCurrCode := GLSetup."Local Currency Symbol";
                if Cust.Get("A01 Posted Payment Document"."Partner No.") then begin
                    CustName := Cust.Name;
                    CustIdentity := Cust."No.";
                    CustPhone := Cust."Phone No.";
                    CustAddress := Cust."Ship-to Code";
                    rcs := Cust."A01 RCS";
                    stat := Cust."A01 STAT";
                    nif := Cust."A01 NIF";
                end;

                if ResponsibilityInfo.Get("A01 Posted Payment Document"."Responsibility Center") then begin
                    UnitName := ResponsibilityInfo.Name;
                    City := ResponsibilityInfo.City;
                    unitAddress := ResponsibilityInfo.Address;
                    PostCode := ResponsibilityInfo."Post Code";
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
            area(Content)
            {
                group(groupName)
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
        Cust: Record Customer;
        // Line: Record "A01 Posted Payment Doc Line";
        RespCenterUditec: Record "Responsibility Center";
        GLSetup: Record "General Ledger Setup";
        CurrencyExchangeRate: Record "Currency Exchange Rate";
        ResponsibilityInfo: Record "Responsibility Center";
        // DetailCustLedg: Record "Detailed Cust. Ledg. Entry";
        // Currency: Record Currency;
        AfkLocalCurrency: Record Currency;
        AfkCurrency: Record Currency;
        // DetailCustLedgEntr: Record "Detailed Cust. Ledg. Entry";
        Check: Report Check;
        AutoFormat: Codeunit "Auto Format";
        OptionValue: Option LogoCosmos,LogoUditec;
        OptionType: Integer;
        CustName: Text[100];
        LyneType: Integer;
        UnitName: Text[100];
        City: Code[30];
        unitAddress: Text[100];
        PostCode: Code[20];
        AfkLocalCurrencyName: Text;
        AfkCurrCode: Code[20];
        CurrCode: Code[20];
        TotalAmt_LCYText: Text[50];
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
        OriginAmt_LCYText: Text[50];
        OriginAmt: Decimal;
        NoText: array[2] of Text;
        // ExchangeRateTxt: Label 'Exchange rate: %1/%2', Comment = '%1 and %2 are both amounts.';
        ReportTitleLbl: Label 'CASH RECEIPT';
        RemainingAmountLbl: Label 'Remaining Amount';
        ObjetLbl: Label 'Object :';
        ApplyingLbl: Label 'Applying';
        CashierLbl: Label 'Cashier :';
        Numberlbl: Label 'N° :';
        DateOfPrintLbl: Label 'Date :';
        DueDateLbl: Label 'Due date';
        CustNameLbl: Label 'Customer name :';
        CustIdentityLbl: Label 'Customer identity :';
        CustAddressLbl: Label 'Customer address :';
        UnitName__Caption: Label 'Unit name :';
        UnitAddress__Caption: Label 'Unit address :';
        City__Caption: Label 'City';
        PostalCode__Caption: Label 'Postal code :';
        NIFLbl: Label 'NIF :';
        STATLbl: Label 'STAT :';
        RCSLbl: Label 'RCS :';
        CustPhoneLbl: Label 'Phone :';
        CashReceiptNumberLbl: Label 'Ref :';
        CustSignLbl: Label 'Customer signature';
        CompanySignLbl: Label 'Company signature';
        ArrestedSumLbl: Label 'Arrested at the sum of :';
        RefLbl: Label 'No';
        DesignationLbl: Label 'Designation';
        ObjectLbl: Label 'Reference';
        PaymentModeLbl: Label 'Payment mode';
        AmountLbl: Label 'Amount';
        TotalAmountLbl: Label 'Total Amount';
        TotalAmount2Lbl: Label 'Total Amount';
        DocNumberLbl: Label 'Document N°';
        DescriptionLbl: Label 'Description';
        InitialAmountLbl: Label 'Initial Amount';
        AppliedAmountLbl: Label 'Applied Amount';

        Total: Decimal;
        MontantTotal: Decimal;
        TotalAmt: Decimal;
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