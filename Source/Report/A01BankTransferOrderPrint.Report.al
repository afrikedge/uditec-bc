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

            trigger OnAfterGetRecord()
            begin

                if VendorRec.Get(Line."Account No.") then begin
                    BenName := VendorRec.Name;
                    BenAddress := VendorRec.Address;
                end;

                if VendorBanckAccRec.Get(Line."Account No.", Line."Recipient Bank Account") then begin
                    Bank := VendorBanckAccRec.Name;
                    AccountNo := VendorBanckAccRec."Bank Branch No." + ' ' + VendorBanckAccRec."Agency Code" + ' ' + VendorBanckAccRec."Bank Account No." + ' ' + Format(VendorBanckAccRec."RIB Key");
                end;

                if BankAccRec.Get(Line."Bal. Account No.") then begin
                    BankName := BankAccRec.Name;
                    BankAddress := BankAccRec.Address;
                end;

                AmountInc_LCY := CurrencyExchangeRate.ExchangeAmtFCYToLCY(Line."Posting Date",
                                    Line."Currency Code", AmountInc_LCY, Line."Currency Factor");
                AmountInc_LCY := "Amount (LCY)";
                AmountInc_LCY := ROUND(AmountInc_LCY, LocalCurrency."Amount Rounding Precision");
                AmountIn_LCYText := Format(AmountInc_LCY, 0, AutoFormat.ResolveAutoFormat("Auto Format"::AmountFormat, LocalCurrency.Code));

                RepCheck.InitTextVariable();
                RepCheck.FormatNoText(NoText, AmountInc_LCY, LocalCurrency.Code);

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

    trigger OnInitReport()
    begin
        CompanyInfo.Get();
        CompanyInfo.CalcFields(Picture);
    end;


    var
        CompanyInfo: Record "Company Information";
        VendorRec: Record Vendor;
        CurrencyExchangeRate: Record "Currency Exchange Rate";
        VendorBanckAccRec: Record "Vendor Bank Account";
        BankAccRec: Record "Bank Account";
        LocalCurrency: Record Currency;
        RepCheck: Report Check;
        AutoFormat: Codeunit "Auto Format";
        AmountInc_LCY: Decimal;
        AmountIn_LCYText: Text[50];
        NoText: array[2] of Text;
        AmountInWords: Text;
        BenAddress: Text[100];
        BankName: Text[100];
        BankAddress: Text[100];
        BenName: Text[100];
        Bank: Text[100];
        AccountNo: Text;
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