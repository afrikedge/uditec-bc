report 50023 "A01 Reminder Letter 3"
{
    Caption = 'Reminder Letter 3';
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;
    DefaultLayout = RDLC;
    PreviewMode = PrintLayout;
    EnableHyperlinks = true;
    RDLCLayout = './Source/Report/Layout/ReminderLetter3.rdl';

    dataset
    {
        dataitem("Issued Reminder Header"; "Issued Reminder Header")
        {
            DataItemTableView = sorting("No.");
            RequestFilterFields = "No.";
            RequestFilterHeading = 'Reminder';
            column(No_IssuedReminderHeader; "No.")
            {
            }

            column(DueDateCaption; DueDateCaptionLbl)
            {
            }
            column(VATAmountCaption; VATAmountCaptionLbl)
            {
            }
            column(VATBaseCaption; VATBaseCaptionLbl)
            {
            }
            column(VATPercentCaption; VATPercentCaptionLbl)
            {
            }
            column(TotalCaption; TotalCaptionLbl)
            {
            }
            column(PageCaption; PageCaptionLbl)
            {
            }
            column(DocDateCaption; DocDateCaptionLbl)
            {
            }
            column(HomePageCaption; HomePageCaptionLbl)
            {
            }
            column(EMailCaption; EMailCaptionLbl)
            {
            }
            column(ShowMIRLines; ShowMIRLines)
            {
            }
            column(ContactPhoneNoLbl; ContactPhoneNoLbl)
            {
            }
            column(ContactMobilePhoneNoLbl; ContactMobilePhoneNoLbl)
            {
            }
            column(ContactEmailLbl; ContactEmailLbl)
            {
            }
            column(ContactPhoneNo; PrimaryContact."Phone No.")
            {
            }
            column(ContactMobilePhoneNo; PrimaryContact."Mobile Phone No.")
            {
            }
            column(ContactEmail; PrimaryContact."E-mail")
            {
            }
            dataitem("Integer"; "Integer")
            {
                DataItemTableView = sorting(Number) where(Number = const(1));

                column(CompanyInfo1Picture; CompanyInfo1.Picture)
                {
                }
                column(CompanyInfo2Picture; CompanyInfo2.Picture)
                {
                }
                column(CompanyInfo3Picture; CompanyInfo3.Picture)
                {
                }
                column(DueDate_IssuedReminderHdr; Format("Issued Reminder Header"."Due Date"))
                {
                }
                column(PostDate_IssuedReminderHdr; Format("Issued Reminder Header"."Posting Date"))
                {
                }
                column(No1_IssuedReminderHdr; "Issued Reminder Header"."No.")
                {
                }
                column(YourRef_IssueReminderHdr; "Issued Reminder Header"."Your Reference")
                {
                }
                column(Contact_IssuedReminderHdr; "Issued Reminder Header".Contact)
                {
                }
                column(ReferenceText; ReferenceText)
                {
                }
                column(VatRegNo_IssueReminderHdr; "Issued Reminder Header".GetCustomerVATRegistrationNumber())
                {
                }
                column(VATNoText; VATNoText)
                {
                }
                column(DocDate_IssueReminderHdr; Format("Issued Reminder Header"."Document Date"))
                {
                }
                column(CustNo_IssueReminderHdr; "Issued Reminder Header"."Customer No.")
                {
                }
                column(CompanyInfoBankAccNo; CompanyBankAccount."Bank Account No.")
                {
                }
                column(CompanyInfoIBAN; CompanyBankAccount.IBAN)
                {
                }
                column(CompanyInfoBankName; CompanyBankAccount.Name)
                {
                }
                column(CompanyInfoGiroNo; CompanyInfo."Giro No.")
                {
                }
                column(CompanyInfoVATRegNo; CompanyInfo.GetVATRegistrationNumber())
                {
                }
                column(CompanyInfoHomePage; CompanyInfo."Home Page")
                {
                }
                column(CompanyInfoEMail; CompanyInfo."E-Mail")
                {
                }
                column(CustAddr8; CustAddr[8])
                {
                }
                column(CompanyAddr8; CompanyAddr[8])
                {
                }
                column(CompanyInfoPhoneNo; CompanyInfo."Phone No.")
                {
                }
                column(CustAddr7; CustAddr[7])
                {
                }
                column(CompanyAddr7; CompanyAddr[7])
                {
                }
                column(CustAddr6; CustAddr[6])
                {
                }
                column(CompanyAddr6; CompanyAddr[6])
                {
                }
                column(CustAddr5; CustAddr[5])
                {
                }
                column(CompanyAddr5; CompanyAddr[5])
                {
                }
                column(CustAddr4; CustAddr[4])
                {
                }
                column(CompanyAddr4; CompanyAddr[4])
                {
                }
                column(CustAddr3; CustAddr[3])
                {
                }
                column(CompanyAddr3; CompanyAddr[3])
                {
                }
                column(CustAddr2; CustAddr[2])
                {
                }
                column(CompanyAddr2; CompanyAddr[2])
                {
                }
                column(CustAddr1; CustAddr[1])
                {
                }
                column(CompanyAddr1; CompanyAddr[1])
                {
                }
                column(TextPage; TextPageLbl)
                {
                }
                column(PostingDateCaption; PostingDateCaptionLbl)
                {
                }
                column(ReminderNoCaption; ReminderNoCaptionLbl)
                {
                }
                column(BankAccNoCaption; BankAccNoCaptionLbl)
                {
                }
                column(IBANCaption; IBANCaptionLbl)
                {
                }
                column(BankNameCaption; BankNameCaptionLbl)
                {
                }
                column(GiroNoCaption; GiroNoCaptionLbl)
                {
                }
                column(VATRegNoCaption; "Issued Reminder Header".GetCustomerVATRegistrationNumberLbl())
                {
                }
                column(PhoneNoCaption; PhoneNoCaptionLbl)
                {
                }
                column(ReminderCaption; ReminderCaptionLbl)
                {
                }
                column(CustNo_IssueReminderHdrCaption; "Issued Reminder Header".FieldCaption("Customer No."))
                {
                }
                column(CompanyVATRegistrationNoCaption; CompanyInfo.GetVATRegistrationNumberLbl())
                {
                }
                column(BodyLabelText; BodyLabelText)
                {
                }
                column(BodyLabelText2; BodyLabelText2)
                {
                }
                column(ReminderLevelText; ReminderLevelText)
                {
                }


                dataitem("Issued Reminder Line"; "Issued Reminder Line") //Line
                {
                    DataItemLink = "Reminder No." = field("No.");
                    DataItemLinkReference = "Issued Reminder Header";
                    DataItemTableView = sorting("Reminder No.", "Line No.");
                    column(RemAmt_IssuedReminderLine; "Remaining Amount")
                    {
                        AutoFormatExpression = GetCurrencyCodeFromHeader();
                        AutoFormatType = 1;
                    }
                    column(Desc_IssuedReminderLine; Description)
                    {
                    }
                    column(Type_IssuedReminderLine; Format(Type, 0, 2))
                    {
                    }
                    column(DocDate_IssuedReminderLine; Format("Document Date"))
                    {
                    }
                    column(DocNo_IssuedReminderLine; "Document No.")
                    {
                    }
                    column(DocNoCaption_IssuedReminderLine; FieldCaption("Document No."))
                    {
                    }
                    column(DueDate_IssuedReminderLine; Format("Due Date"))
                    {
                    }
                    column(InterestRate_IssuedReminderLine; "Interest Rate")
                    {
                    }
                    column(InterestRateCaption_IssuedReminderLine; FieldCaption("Interest Rate"))
                    {
                    }
                    column(OriginalAmt_IssuedReminderLine; "Original Amount")
                    {
                        AutoFormatExpression = GetCurrencyCodeFromHeader();
                        AutoFormatType = 1;
                    }
                    column(DocType_IssuedReminderLine; "Document Type")
                    {
                    }
                    column(PostingDate_IssuedReminderLine; "Issued Reminder Line"."Posting Date")
                    {
                    }
                    column(LineNo_IssuedReminderLine; "No.")
                    {
                    }
                    column(ShowInternalInfo; ShowInternalInfoVar)
                    {
                    }
                    column(NNCInterestAmt; NNC_InterestAmount)
                    {
                    }
                    column(TotalText; TotalText)
                    {
                    }
                    column(MIREntry_IssuedReminderLine; "Detailed Interest Rates Entry")
                    {
                    }
                    column(NNCTotal; NNC_Total)
                    {
                    }
                    column(TotalInclVATText; TotalInclVATText)
                    {
                    }
                    column(NNCVATAmt; NNC_VATAmount)
                    {
                    }
                    column(NNCTotalInclVAT; NNC_TotalInclVAT)
                    {
                    }
                    column(TotalVATAmt; TotalVATAmount)
                    {
                    }
                    column(RemNo_IssuedReminderLine; "Reminder No.")
                    {
                    }
                    column(DocumentDateCaption1; DocumentDateCaption1Lbl)
                    {
                    }
                    column(InterestAmountCaption; InterestAmountCaptionLbl)
                    {
                    }
                    column(RemAmt_IssuedReminderLineCaption; FieldCaption("Remaining Amount"))
                    {
                    }
                    column(DocNo_IssuedReminderLineCaption; FieldCaption("Document No."))
                    {
                    }
                    column(OriginalAmt_IssuedReminderLineCaption; FieldCaption("Original Amount"))
                    {
                    }
                    column(DocType_IssuedReminderLineCaption; FieldCaption("Document Type"))
                    {
                    }
                    column(Interest; Interest)
                    {
                    }
                    column(RemainingAmountText; RemainingAmt)
                    {
                    }
                    column(DueDays; DueDays)
                    {
                    }
                    column(Lieu; Lieu)
                    {
                    }
                    column(PaidAmount; PaidAmount)
                    {
                    }




                    trigger OnAfterGetRecord()//"Issued Reminder Line"
                    var
                        CustLedgEntry: Record "Cust. Ledger Entry";
                        DimensionValue: Record "Dimension Value";

                    begin
                        if not "Detailed Interest Rates Entry" then begin
                            TempVATAmountLine.Init();
                            TempVATAmountLine."VAT Identifier" := "VAT Identifier";
                            TempVATAmountLine."VAT Calculation Type" := "VAT Calculation Type";
                            TempVATAmountLine."Tax Group Code" := "Tax Group Code";
                            TempVATAmountLine."VAT %" := "VAT %";
                            TempVATAmountLine."VAT Base" := Amount;
                            TempVATAmountLine."VAT Amount" := "VAT Amount";
                            TempVATAmountLine."Amount Including VAT" := Amount + "VAT Amount";
                            TempVATAmountLine."VAT Clause Code" := "VAT Clause Code";
                            TempVATAmountLine.InsertLine();

                            ReminderInterestAmount := 0;

                            case Type of
                                Type::"G/L Account":
                                    "Remaining Amount" := Amount;
                                Type::"Line Fee":
                                    "Remaining Amount" := Amount;
                                Type::"Customer Ledger Entry":
                                    ReminderInterestAmount := Amount;
                            end;

                            NNC_InterestAmountTotal += ReminderInterestAmount;
                            NNC_RemainingAmountTotal += "Remaining Amount";
                            NNC_VATAmountTotal += "VAT Amount";

                            NNC_InterestAmount := (NNC_InterestAmountTotal + NNC_VATAmountTotal + "Issued Reminder Header"."Additional Fee" -
                                                   AddFeeInclVAT + "Issued Reminder Header"."Add. Fee per Line" - AddFeePerLineInclVAT) /
                              (VATInterest / 100 + 1);
                            NNC_Total := NNC_RemainingAmountTotal + NNC_InterestAmountTotal;
                            NNC_VATAmount := NNC_VATAmountTotal;
                            NNC_TotalInclVAT := NNC_RemainingAmountTotal + NNC_InterestAmountTotal + NNC_VATAmountTotal;

                            TotalRemAmt += "Remaining Amount";



                        end;

                        RemainingAmt := '';

                        if ("Remaining Amount" = 0) and ("Due Date" = 0D) then
                            RemainingAmt := ''
                        else
                            RemainingAmt := Format("Remaining Amount");

                        PaidAmount := "Original Amount" - "Remaining Amount";
                        if ("Remaining Amount" <= 0) then
                            CurrReport.Skip();

                        DueDays := 0;
                        if (CustLedgEntry.Get("Entry No.")) then begin
                            DueDays := TresoMgt.GetDueDays(CustLedgEntry);
                            if (DimensionValue.Get(GLSetup."Global Dimension 1 Code", CustLedgEntry."Global Dimension 1 Code")) then
                                Lieu := DimensionValue.Name;
                        end;
                    end;

                    trigger OnPreDataItem()
                    begin
                        Clear(CompanyInfo.Picture);
                        Clear(CompanyInfo1.Picture);
                        Clear(CompanyInfo2.Picture);
                        Clear(CompanyInfo3.Picture);

                        if FindLast() then begin
                            EndLineNo := "Line No." + 1;
                            repeat
                                Continue :=
                                  not ShowNotDueAmountsVar and
                                  ("No. of Reminders" = 0) and
                                  (((Type = Type::"Customer Ledger Entry") or (Type = Type::"Line Fee")) or (Type = Type::" ")) or
                                  "Detailed Interest Rates Entry" and not ShowMIRLines;
                                if Continue then
                                    EndLineNo := "Line No.";
                            until (Next(-1) = 0) or not Continue;
                        end;

                        TempVATAmountLine.DeleteAll();
                        SetFilter("Line No.", '<%1', EndLineNo);
                    end;
                }
            }

            trigger OnAfterGetRecord()//"Issued Reminder Header"
            var
                GLAcc: Record "G/L Account";
                CustPostingGroup: Record "Customer Posting Group";
                VATPostingSetup: Record "VAT Posting Setup";
                //FirstReminderDate: Date;
                FirstReminderDateText: Text;
                SecondReminderDateText: Text;
            //FirstReminderNo: Code[20];
            begin
                // CurrReport.Language := LanguageRec.GetLanguageIdOrDefault("Language Code");
                CurrReport.Language := 1036;
                CurrReport.FormatRegion := LanguageRec.GetFormatRegionOrDefault("Format Region");
                FormatAddr.SetLanguageCode("Language Code");

                DimSetEntry.SetRange("Dimension Set ID", "Dimension Set ID");

                if not CompanyBankAccount.Get("Issued Reminder Header"."Company Bank Account Code") then
                    CompanyBankAccount.CopyBankFieldsFromCompanyInfo(CompanyInfo);

                FormatAddr.IssuedReminder(CustAddr, "Issued Reminder Header");
                if "Your Reference" = '' then
                    ReferenceText := ''
                else
                    ReferenceText := copystr(FieldCaption("Your Reference"), 1, 35);
                if "Issued Reminder Header".GetCustomerVATRegistrationNumber() = '' then
                    VATNoText := ''
                else
                    VATNoText := copystr("Issued Reminder Header".GetCustomerVATRegistrationNumberLbl(), 1, 30);
                if "Currency Code" = '' then begin
                    GLSetup.TestField("LCY Code");
                    TotalText := StrSubstNo(Text000, GLSetup."LCY Code");
                    TotalInclVATText := StrSubstNo(Text001, GLSetup."LCY Code");
                end else begin
                    TotalText := StrSubstNo(Text000, "Currency Code");
                    TotalInclVATText := StrSubstNo(Text001, "Currency Code");
                end;
                if not IsReportInPreviewMode() then
                    IncrNoPrinted();

                Customer.GetPrimaryContact("Customer No.", PrimaryContact);
                CalcFields("Additional Fee");
                CustPostingGroup.Get("Customer Posting Group");
                if GLAcc.Get(CustPostingGroup."Additional Fee Account") then begin
                    VATPostingSetup.Get("VAT Bus. Posting Group", GLAcc."VAT Prod. Posting Group");
                    AddFeeInclVAT := "Additional Fee" * (1 + VATPostingSetup."VAT %" / 100);
                end else
                    AddFeeInclVAT := "Additional Fee";

                CalcFields("Add. Fee per Line");
                AddFeePerLineInclVAT := "Add. Fee per Line" + CalculateLineFeeVATAmount();

                CalcFields("Interest Amount", "VAT Amount");
                if ("Interest Amount" <> 0) and ("VAT Amount" <> 0) then begin
                    GLAcc.Get(CustPostingGroup."Interest Account");
                    VATPostingSetup.Get("VAT Bus. Posting Group", GLAcc."VAT Prod. Posting Group");
                    VATInterest := VATPostingSetup."VAT %";
                    Interest :=
                      ("Interest Amount" +
                       "VAT Amount" + "Additional Fee" - AddFeeInclVAT + "Add. Fee per Line" - AddFeePerLineInclVAT) / (VATInterest / 100 + 1);
                end else begin
                    Interest := "Interest Amount";
                    VATInterest := 0;
                end;

                "Issued Reminder Header".CalcFields("Remaining Amount");
                TotalRemainingAmt := "Issued Reminder Header"."Remaining Amount";
                TotalRemainingAmtText := Format(TotalRemainingAmt);


                RepCheck.InitTextVariable();
                RepCheck.FormatNoText(NoText, TotalRemainingAmt, GLSetup."LCY Code");
                NoText[1] := ReplaceString(NoText[1], '****');
                NoText[1] := ReplaceString(NoText[1], 'AND 0/100');
                NoText[2] := ReplaceString(NoText[2], '****');
                NoText[2] := ReplaceString(NoText[2], 'AND 0/100');

                TotalRemainingAmtInLetters := NoText[1] + ' ' + NoText[2];

                SecondReminderDateText := '';
                FirstReminderDateText := '';
                BodyLabelText := StrSubstNo(BodyLabel01, FirstReminderDateText, SecondReminderDateText, TotalRemainingAmtText, TotalRemainingAmtInLetters);
                BodyLabelText2 := StrSubstNo(BodyLabel02, TotalRemainingAmtText, TotalRemainingAmtInLetters);
                //ReminderLevelText := 'Mise en démeure';

                TotalVATAmount := "VAT Amount";
                NNC_InterestAmountTotal := 0;
                NNC_RemainingAmountTotal := 0;
                NNC_VATAmountTotal := 0;
                NNC_InterestAmount := 0;
                NNC_Total := 0;
                NNC_VATAmount := 0;
                NNC_TotalInclVAT := 0;
                TotalRemAmt := 0;
            end;

            trigger OnPreDataItem()
            begin
                CompanyInfo.Get();
                FormatAddr.Company(CompanyAddr, CompanyInfo);
            end;
        }
    }

    requestpage
    {
        SaveValues = true;

        layout
        {
            area(content)
            {
                group(Options)
                {
                    Caption = 'Options';
                    field(ShowInternalInfo; ShowInternalInfoVar)
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Show Internal Information';
                        ToolTip = 'Specifies if you want the printed report to show information that is only for internal use.';
                    }
                    field(LogInteraction; LogInteractionVar)
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Log Interaction';
                        Enabled = LogInteractionEnable;
                        ToolTip = 'Specifies if you want the reminder that you print to be recorded as interaction, and to be added to the Interaction Log Entry table.';
                    }
                    field(ShowNotDueAmounts; ShowNotDueAmountsVar)
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Show Not Due Amounts';
                        ToolTip = 'Specifies if you want to show amounts that are not due from customers.';
                    }
                    field(ShowMIR; ShowMIRLines)
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Show MIR Detail';
                        ToolTip = 'Specifies if you want multiple interest rate details for the journal lines to be included in the report.';
                    }
                }
            }
        }

        actions
        {
        }

        trigger OnInit()
        begin
            LogInteractionEnable := true;
        end;

        trigger OnOpenPage()
        begin
            LogInteractionVar := SegManagement.FindInteractionTemplateCode(Enum::"Interaction Log Entry Document Type"::"Sales Rmdr.") <> '';
            LogInteractionEnable := LogInteractionVar;
        end;
    }

    // rendering
    // {
    //     layout("Reminder.rdlc")
    //     {
    //         Type = RDLC;
    //         LayoutFile = './Sales/Reminder/Reminder.rdlc';
    //         Caption = 'Reminder (RDLC)';
    //         Summary = 'The Reminder (RDLC) provides a detailed layout.';
    //     }
    //     layout("DefaultReminderEmail.docx")
    //     {
    //         Type = Word;
    //         LayoutFile = './Sales/Reminder/DefaultReminderEmail.docx';
    //         Caption = 'Default Reminder Email (Word)';
    //         Summary = 'The Default Reminder Email (Word) provides an email body for the reminder.';
    //     }
    // }

    labels
    {
    }

    trigger OnInitReport()
    begin
        GLSetup.Get();
        SalesSetup.Get();

        case SalesSetup."Logo Position on Documents" of
            SalesSetup."Logo Position on Documents"::"No Logo":
                ;
            SalesSetup."Logo Position on Documents"::Left:
                begin
                    CompanyInfo1.Get();
                    CompanyInfo1.CalcFields(Picture);
                end;
            SalesSetup."Logo Position on Documents"::Center:
                begin
                    CompanyInfo2.Get();
                    CompanyInfo2.CalcFields(Picture);
                end;
            SalesSetup."Logo Position on Documents"::Right:
                begin
                    CompanyInfo3.Get();
                    CompanyInfo3.CalcFields(Picture);
                end;
        end;
    end;

    trigger OnPostReport()
    begin
        // if LogInteractionVar and not IsReportInPreviewMode() then
        //     if "Issued Reminder Header".FindSet() then
        //         repeat
        //             SegManagement.LogDocument(
        //               8, "Issued Reminder Header"."No.", 0, 0, DATABASE::Customer, "Issued Reminder Header"."Customer No.",
        //               '', '', "Issued Reminder Header"."Posting Description", '');
        //         until "Issued Reminder Header".Next() = 0;
    end;

    var

        PrimaryContact: Record Contact;
        Customer: Record Customer;
        //CustEntry: Record "Cust. Ledger Entry";
        GLSetup: Record "General Ledger Setup";
        SalesSetup: Record "Sales & Receivables Setup";
        CompanyBankAccount: Record "Bank Account";
        DimSetEntry: Record "Dimension Set Entry";
        //CurrExchRate: Record "Currency Exchange Rate";
        RepCheck: Report "Check";
        LanguageRec: Codeunit Language;
        FormatAddr: Codeunit "Format Address";
        SegManagement: Codeunit SegManagement;
        TresoMgt: Codeunit "A01 Treso Mgt";
        CustAddr: array[8] of Text[100];
        CompanyAddr: array[8] of Text[100];
        ReminderInterestAmount: Decimal;
        Continue: Boolean;
        Text000: Label 'Total %1', Comment = '%1 = amt';
        Text001: Label 'Total %1 Incl. VAT', Comment = '%1 = amt';
        AddFeeInclVAT: Decimal;
        NoText: array[2] of Text;
        AddFeePerLineInclVAT: Decimal;
        TotalVATAmount: Decimal;
        VATInterest: Decimal;
        LogInteractionEnable: Boolean;
        TextPageLbl: Label 'Page';
        PostingDateCaptionLbl: Label 'Posting Date';
        ReminderNoCaptionLbl: Label 'Reminder No.';
        BankAccNoCaptionLbl: Label 'Account No.';
        IBANCaptionLbl: Label 'IBAN';
        BankNameCaptionLbl: Label 'Bank';
        GiroNoCaptionLbl: Label 'Giro No.';
        PhoneNoCaptionLbl: Label 'Phone No.';
        ReminderCaptionLbl: Label 'Reminder';
        DocumentDateCaption1Lbl: Label 'Document Date';
        InterestAmountCaptionLbl: Label 'Interest Amount';
        DueDateCaptionLbl: Label 'Due Date';
        VATAmountCaptionLbl: Label 'VAT Amount';
        VATBaseCaptionLbl: Label 'VAT Base';
        VATPercentCaptionLbl: Label 'VAT %';
        TotalCaptionLbl: Label 'Total';
        PageCaptionLbl: Label 'Page';
        DocDateCaptionLbl: Label 'Document Date';
        HomePageCaptionLbl: Label 'Home Page';
        EMailCaptionLbl: Label 'Email';
        ContactPhoneNoLbl: Label 'Contact Phone No.';
        ContactMobilePhoneNoLbl: Label 'Contact Mobile Phone No.';
        ContactEmailLbl: Label 'Contact E-Mail';
        RemainingAmt: Text;
        BodyLabel01: Label '        Par les deux lettres de relance vous ayant été envoyées respectivement aux dates du %1 et du %2, nous vous avons demandé de procéder au règlement de la somme de %3 Ariary (%4).', Comment = '%1=...,%2=...%3=...%4=...';
        BodyLabel02: Label '        Aussi, par la présente, nous vous mettons en demeure de nous verser la somme de %1 Ariary (%2) dans un délai de 48h à compter de la réception de la présente.', Comment = '%1=...,%2=...';
        BodyLabelText: Text;
        BodyLabelText2: Text;
        DueDays: Integer;
        TotalRemainingAmt: Decimal;
        PaidAmount: Decimal;
        TotalRemainingAmtText: Text;
        TotalRemainingAmtInLetters: Text;
        ReminderLevelText: Text;
        //ReminderLevelLbl: Label 'Lettre de relance N° %1', Comment = '%1=num';

        Lieu: Text;

    protected var
        TempVATAmountLine: Record "VAT Amount Line" temporary;
        //VATClause: Record "VAT Clause";
        CompanyInfo: Record "Company Information";
        CompanyInfo1: Record "Company Information";
        CompanyInfo2: Record "Company Information";
        CompanyInfo3: Record "Company Information";
        ReferenceText: Text[35];
        VATNoText: Text[30];
        EndLineNo: Integer;
        LogInteractionVar: Boolean;
        ShowInternalInfoVar: Boolean;
        ShowNotDueAmountsVar: Boolean;
        ShowMIRLines: Boolean;
        Interest: Decimal;
        NNC_InterestAmount: Decimal;
        NNC_InterestAmountTotal: Decimal;
        NNC_RemainingAmountTotal: Decimal;
        NNC_Total: Decimal;
        NNC_TotalInclVAT: Decimal;
        NNC_VATAmount: Decimal;
        NNC_VATAmountTotal: Decimal;
        TotalRemAmt: Decimal;
        TotalText: Text[50];
        TotalInclVATText: Text[50];

    protected procedure IsReportInPreviewMode(): Boolean
    var
        MailManagement: Codeunit "Mail Management";
    begin
        exit(CurrReport.Preview or MailManagement.IsHandlingGetEmailBody());
    end;

    local procedure ReplaceString(OriginString: Text; ReplaceString1: Text): Text
    var
        Rep: Text;
        pos: Integer;
    begin
        Rep := OriginString;
        pos := StrPos(OriginString, ReplaceString1);
        if (pos >= 1) then begin
            Rep := DelStr(OriginString, pos, StrLen(ReplaceString1));
        end;
        exit(Rep);
    end;


    // [IntegrationEvent(false, false)]
    // local procedure OnLetterTextOnPreDataItemOnAfterSetAmtDueTxt(var IssuedReminderHeader: Record "Issued Reminder Header"; var AmtDueTxt: Text)
    // begin
    // end;
}


