/// <summary>
/// Report A01 Cash Voucher (ID 50037).
/// </summary>
report 50037 "A01 Cash Voucher"
{
    DefaultLayout = RDLC;
    Caption = 'A01 Cash voucher';
    PreviewMode = PrintLayout;
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;
    RDLCLayout = './Source/Report/Layout/CashVoucher.rdl';

    dataset
    {
        dataitem(Batch; "G/L Register")
        {
            RequestFilterFields = "No.";
            RequestFilterHeading = 'Cash voucher';
            column(TemplateName_GenJnlBatch; "Journal Templ. Name")
            {
            }
            column(Name_ItemJournalBatch; "Journal Batch Name")
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
            column(LyneType; LyneType)
            {
            }
            dataitem(Line; "Bank Account Ledger Entry")
            {
                DataItemLink = "Journal Templ. Name" = field("Journal Templ. Name"), "Journal Batch Name" = field("Journal Batch Name");
                DataItemTableView = sorting("Entry No.");
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
                column(Amount; -Amount)
                {
                }
                column(Credit_Amount; "Credit Amount")
                {
                }
                dataitem("Allocation Account"; "Allocation Account")
                {
                    DataItemTableView = sorting("No.");
                    DataItemLinkReference = Line;
                    DataItemLink = Name = field(Description);
                    column(No_; "No.")
                    {
                    }
                }
                trigger OnPreDataItem()
                begin
                    Line.SetRange("Entry No.", Batch."From Entry No.", Batch."To Entry No.");
                end;
            }
            trigger OnAfterGetRecord()
            begin
                // if GenJournalTemplate.Get("Journal Templ. Name") then
                //     if GenJournalTemplate.Type <> GenJournalTemplate.Type::Payments then
                //         CurrReport.Skip();

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
        // GenJournalTemplate: Record "Gen. Journal Template";
        AfkCurrCode: Code[20];
        LyneType: Integer;
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