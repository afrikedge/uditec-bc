/// <summary>
/// Report A01 Disbursement Receipt Print (ID 50031).
/// </summary>
report 50031 "A01 DisbursementReceipt"
{
    DefaultLayout = RDLC;
    Caption = 'A01 Disbursement Receipt';
    PreviewMode = PrintLayout;
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;
    RDLCLayout = './Source/Report/Layout/DisbursementReceipt.rdl';

    dataset
    {
        dataitem(Batch; "Gen. Journal Batch")
        {
            column(TemplateName_GenJnlBatch; "Journal Template Name")
            {
            }
            column(Name_ItemJournalBatch; Name)
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
            column(AfkCurrCode; AfkCurrCode)
            {
            }
            column(DateOfPrintLbl; DateOfPrintLbl)
            {
            }
            column(AccountNumberLbl; AccountNumberLbl)
            {
            }
            dataitem(Line; "Gen. Journal Line")
            {
                DataItemLink = "Journal Template Name" = field("Journal Template Name"), "Journal Batch Name" = field(Name);
                DataItemTableView = sorting("Journal Template Name", "Journal Batch Name", "Line No.");
                DataItemLinkReference = Batch;
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
            }
            trigger OnAfterGetRecord()
            begin
                if GenJournalTemplate.Get("Journal Template Name") then
                    if GenJournalTemplate.Type <> GenJournalTemplate.Type::Payments then
                        CurrReport.Skip();

                GLSetup.Get();
                GLSetup.TestField("LCY Code");

                AfkCurrCode := GLSetup."Local Currency Symbol";
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
    end;

    var
        CompanyInfo: Record "Company Information";
        GLSetup: Record "General Ledger Setup";
        GenJournalTemplate: Record "Gen. Journal Template";
        AfkCurrCode: Code[20];

        ReportTitleLbl: Label 'CASH VOUCHER';
        RefLbl: Label 'No';
        AccountNumberLbl: Label 'Account N°';
        AmountLbl: Label 'Amount';
        TotalAmountLbl: Label 'Total Amount';
        DateOfPrintLbl: Label 'Date :';
        DescriptionLbl: Label 'Description';
        CustSignLbl: Label 'Cash signature';
        CompanySignLbl: Label 'Beneficiairy''s signature';
}