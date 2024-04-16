/// <summary>
/// Report A01 Generate Insterest Entries (ID 50019).
/// </summary>
report 50019 "A01 Generate Interest Entries"
{
    ApplicationArea = All;
    Caption = 'Generate Insterest Entries';
    UsageCategory = Tasks;
    ProcessingOnly = true;
    dataset
    {
        dataitem(A01CreditDepreciationTable; "A01 Credit Depreciation Table")
        {

            DataItemTableView = sorting("Document Type", "Document No.", "Line No.");

            trigger OnPreDataItem()
            var
                GenJrnLine: Record "Gen. Journal Line";
            begin

                A01CreditDepreciationTable.Reset();
                A01CreditDepreciationTable.SetFilter("Due Date", '<=%1', CalculateUntilDateVar);
                A01CreditDepreciationTable.SetRange("Document Type", A01CreditDepreciationTable."Document Type"::"Posted Sales invoice");
                A01CreditDepreciationTable.SetRange("Interest Posted", false);
                TotalLines := A01CreditDepreciationTable.Count;

                GenJrnLine.Reset();
                GenJrnLine.SETRANGE("Journal Template Name", JournalTemplate);
                GenJrnLine.SETRANGE("Journal Batch Name", JournalCode);
                if not GenJrnLine.IsEmpty then
                    ERROR(LblErr001, JournalCode);

                JournalLineNo := 0;

                Window.OPEN(LblErr002);

                if ((PostingDateVar = 0D) or (CalculateUntilDateVar = 0D)) then ERROR(LblErr004);

                GenJrnTableND.Get(JournalTemplate, JournalCode);
                GenJrnTableND.TESTFIELD("No. Series");

            end;

            trigger OnAfterGetRecord()
            var

                incrDocNo: Boolean;
            begin
                LineNo += 1;
                Window.UPDATE(1,
                ROUND(LineNo / TotalLines * 10000, 1));

                CLEAR(NoSeriesMgt);

                if LastDocNo = '' then
                    LastDocNo := NoSeriesMgt.GetNextNo(GenJrnTableND."No. Series", PostingDateVar, FALSE);

                CreateInterestJournalLine(LastDocNo, A01CreditDepreciationTable, JournalLineNo);

                if (incrDocNo) then
                    LastDocNo := INCSTR(LastDocNo);

            end;

            trigger OnPostDataItem()
            begin
                Window.CLOSE();
                MESSAGE(LblErr003);
            end;
        }
    }


    requestpage
    {
        layout
        {
            area(content)
            {
                group(Options)
                {
                    Caption = 'Options';
                    field(CalculateUntilDate; CalculateUntilDateVar)
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Period Ending Date';
                        ToolTip = 'Specifies the fixed asset posting date to be used by the batch job. The batch job includes ledger entries up to this date. This date appears in the FA Posting Date field in the resulting journal lines. If the Use Same FA+G/L Posting Dates field has been activated in the depreciation book that is used in the batch job, then this date must be the same as the posting date entered in the Posting Date field.';
                    }
                    field(PostingDate; PostingDateVar)
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'PostingDate';
                        ToolTip = 'Specifies the fixed asset posting date to be used by the batch job. The batch job includes ledger entries up to this date. This date appears in the FA Posting Date field in the resulting journal lines. If the Use Same FA+G/L Posting Dates field has been activated in the depreciation book that is used in the batch job, then this date must be the same as the posting date entered in the Posting Date field.';
                    }
                }
            }

        }
        actions
        {
            area(processing)
            {
            }
        }
        trigger OnInit()
        var
        begin
            CalculateUntilDateVar := CalcInitialDate();
            PostingDateVar := CalculateUntilDateVar;
        end;
    }

    trigger OnPreReport()

    begin

    end;

    var
        AddOnSetup: Record "A01 Afk Setup";
        GenJrnTableND: Record "Gen. Journal Batch";
        NoSeriesMgt: Codeunit NoSeriesManagement;
        JournalTemplate: code[10];
        JournalCode: code[10];
        CalculateUntilDateVar: Date;
        PostingDateVar: Date;
        //LineDescription: Text[100];
        LblErr001: Label 'Sheet %1 must be empty to perform this operation!', Comment = '%1 journal';
        LblErr002: Label 'Processing @1@@@@@@@@@@@@@@@@@@@@@@@@@@@@\';
        LblErr003: Label 'End of process !';
        LblErr004: Label 'Please enter valid dates';
        LblDescr: Label 'Monthly interest';
        TotalLines: Integer;
        LineNo: Integer;
        Window: Dialog;
        LastDocNo: code[20];
        JournalLineNo: Integer;

    local procedure CreateInterestJournalLine(DocumentNo: code[20]; CreditDueLine: Record "A01 Credit Depreciation Table"; var JrlLineNo: Integer): Boolean
    var
        GenJrnLine: Record "Gen. Journal Line";
        JrnTmplName: Record "Gen. Journal Template";
        GLAccNo: code[20];
    begin

        CLEAR(GenJrnLine);
        GenJrnLine."Journal Template Name" := JournalTemplate;
        GenJrnLine."Journal Batch Name" := JournalCode;

        JrlLineNo += 10;
        GenJrnLine."Line No." := JrlLineNo;
        JrnTmplName.Get(GenJrnLine."Journal Template Name");
        JrnTmplName.TestField("Source Code");
        GenJrnLine."Source Code" := JrnTmplName."Source Code";
        GenJrnLine.Validate("Posting Date", PostingDateVar);

        GenJrnLine."Document No." := DocumentNo;
        GenJrnLine."External Document No." := CreditDueLine."Document No.";

        GenJrnLine."Account Type" := GenJrnLine."Account Type"::"G/L Account";
        GLAccNo := GetPlannedInterestAcc();
        //GLMgt.CheckParamsGLAcc(GLAccNo);
        GenJrnLine.Validate("Account No.", GLAccNo);
        //GenJrnLine.VALIDATE("VAT Prod. Posting Group", AddOnSetup."NoVAT Prod. Posting Group");

        GenJrnLine.Description := LblDescr;
        //GenJrnLine.Description := BuildDescriptionProvision(PurchH."No.",PurchH."Buy-from Vendor Name");


        GenJrnLine.Validate(GenJrnLine.Amount, CreditDueLine.Interest);

        GenJrnLine."Message to Recipient" := 'AFKGIE' + Format(CreditDueLine."Cust Ledger Entry No.");

        //GenJrnLine.Validate("Currency Code", '');




        GenJrnLine."Bal. Account Type" := GenJrnLine."Bal. Account Type"::"G/L Account";
        GLAccNo := GetRealisedInterestAcc();
        GenJrnLine.Validate("Bal. Account No.", GLAccNo);

        GenJrnLine.Validate("Dimension Set ID", CreditDueLine."Dimension Set ID");

        IF GenJrnLine.Amount <> 0 THEN begin
            GenJrnLine.Insert(true);
            exit(true);
        end;


    end;

    local procedure GetPlannedInterestAcc(): Code[20]
    var
    // Item: Record Item;
    begin
        AddOnSetup.GetRecordOnce();
        // AddOnSetup.TestField("MIR Item for interest");
        // Item.Get(AddOnSetup."MIR Item for interest");
        AddOnSetup.TestField("MIR Planned Interest Account");
        exit(AddOnSetup."MIR Planned Interest Account");
    end;

    local procedure GetRealisedInterestAcc(): Code[20]
    begin
        AddOnSetup.GetRecordOnce();
        AddOnSetup.TestField("MIR Realised Interest Account");
        exit(AddOnSetup."MIR Realised Interest Account");
    end;

    /// <summary>
    /// SetJournal.
    /// </summary>
    /// <param name="JournalTemplate1">code[20].</param>
    /// <param name="JournalCode1">code[20].</param>
    procedure SetJournal(JournalTemplate1: code[10]; JournalCode1: code[10])
    begin
        JournalCode := JournalCode1;
        JournalTemplate := JournalTemplate1;
    end;

    local procedure CalcInitialDate(): Date
    begin
        if (Date2DMY(WorkDate(), 1)) >= 14 then
            exit(CalcDate('<-1D>', GetDebutMois(WorkDate())))
        else
            exit(GetFinMois(WorkDate()));
    end;

    local procedure GetFinMois(DateRef: Date): Date
    var
        Date1: Date;
    begin
        IF DateRef <> 0D THEN BEGIN
            Date1 := GetDebutMois(DateRef);
            exit(CALCDATE('<1M>', Date1) - 1);
        end;
    END;

    local procedure GetDebutMois(DateRef: Date): Date
    var
    begin
        IF DateRef <> 0D THEN
            EXIT(DMY2DATE(1, DATE2DMY(DateRef, 2), DATE2DMY(DateRef, 3)));
    END;


}
