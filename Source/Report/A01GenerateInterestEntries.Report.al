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
            trigger OnPreDataItem()
            var
                GenJrnLine: Record "Gen. Journal Line";
            begin

                CalculateUntilDate := CalcInitialDate();
                PostingDate := CalculateUntilDate;

                A01CreditDepreciationTable.Reset();
                A01CreditDepreciationTable.SetFilter("Due Date", '<=%1', CalculateUntilDate);
                A01CreditDepreciationTable.SetRange("Interest Posted", false);
                TotalLines := A01CreditDepreciationTable.Count;

                GenJrnLine.Reset();
                GenJrnLine.SETRANGE("Journal Template Name", JournalTemplate);
                GenJrnLine.SETRANGE("Journal Batch Name", JournalCode);
                if not GenJrnLine.IsEmpty then
                    ERROR(LblErr001, JournalCode);

                JournalLineNo := 0;

                Window.OPEN(LblErr002);

                IF ((PostingDate = 0D) OR (CalculateUntilDate = 0D)) then ERROR(LblErr004);
            end;

            trigger OnAfterGetRecord()
            var
                GenJrnTableND: Record "Gen. Journal Batch";
                incrDocNo: Boolean;
            begin
                LineNo += 1;
                Window.UPDATE(1,
                ROUND(LineNo / TotalLines * 10000, 1));

                GenJrnTableND.TESTFIELD("No. Series");
                CLEAR(NoSeriesMgt);

                if LastDocNo = '' then
                    LastDocNo := NoSeriesMgt.GetNextNo(GenJrnTableND."No. Series", PostingDate, FALSE);

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
                    field(CalculateUntilDate; CalculateUntilDate)
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Period Ending Date';
                        ToolTip = 'Specifies the fixed asset posting date to be used by the batch job. The batch job includes ledger entries up to this date. This date appears in the FA Posting Date field in the resulting journal lines. If the Use Same FA+G/L Posting Dates field has been activated in the depreciation book that is used in the batch job, then this date must be the same as the posting date entered in the Posting Date field.';
                    }
                    field(PostingDate; PostingDate)
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
    }

    var
        AddOnSetup: Record "A01 Afk Setup";
        NoSeriesMgt: Codeunit NoSeriesManagement;
        JournalTemplate: code[10];
        JournalCode: code[10];
        CalculateUntilDate: Date;
        PostingDate: Date;
        LineDescription: Text[100];
        LblErr001: Label 'Sheet %1 must be empty to perform this operation!';
        LblErr002: Label 'Processing @1@@@@@@@@@@@@@@@@@@@@@@@@@@@@\';
        LblErr003: Label 'End of process !';
        LblErr004: Label 'Please enter valid dates';
        TotalLines: Integer;
        LineNo: Integer;
        Window: Dialog;
        LastDocNo: code[20];
        JournalLineNo: Integer;

    local procedure CreateInterestJournalLine(DocumentNo: code[20]; CreditDueLine: Record "A01 Credit Depreciation Table"; var JournalLineNo: Integer): Boolean
    var
        GenJrnLine: Record "Gen. Journal Line";
        JrnTmplName: Record "Gen. Journal Template";
        GLAccNo: code[20];
    begin

        CLEAR(GenJrnLine);
        GenJrnLine."Journal Template Name" := JournalTemplate;
        GenJrnLine."Journal Batch Name" := JournalCode;

        JournalLineNo += 10;
        GenJrnLine."Line No." := JournalLineNo;
        JrnTmplName.Get(GenJrnLine."Journal Template Name");
        JrnTmplName.TestField("Source Code");
        GenJrnLine."Source Code" := JrnTmplName."Source Code";
        GenJrnLine.Validate("Posting Date", PostingDate);

        GenJrnLine."Document No." := DocumentNo;
        GenJrnLine."External Document No." := '';

        GenJrnLine."Account Type" := GenJrnLine."Account Type"::"G/L Account";
        GLAccNo := GetPlannedInterestAcc();
        //GLMgt.CheckParamsGLAcc(GLAccNo);
        GenJrnLine.Validate("Account No.", GLAccNo);
        //GenJrnLine.VALIDATE("VAT Prod. Posting Group", AddOnSetup."NoVAT Prod. Posting Group");

        GenJrnLine.Description := LineDescription;
        //GenJrnLine.Description := BuildDescriptionProvision(PurchH."No.",PurchH."Buy-from Vendor Name");


        GenJrnLine.Validate(GenJrnLine.Amount, CreditDueLine.Interest);

        GenJrnLine."Reason Code" := Format(CreditDueLine."Cust Ledger Entry No.");

        //GenJrnLine.Validate("Currency Code", '');

        //GenJrnLine."Dimension Set ID" := LigneCde."Dimension Set ID";


        GenJrnLine."Bal. Account Type" := GenJrnLine."Bal. Account Type"::"G/L Account";
        GLAccNo := GetRealisedInterestAcc();
        GenJrnLine.Validate("Bal. Account No.", GLAccNo);

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
            EXIT(CALCDATE('<1M>', Date1) - 1);
        end;
    END;

    local procedure GetDebutMois(DateRef: Date): Date
    var
    begin
        IF DateRef <> 0D THEN
            EXIT(DMY2DATE(1, DATE2DMY(DateRef, 2), DATE2DMY(DateRef, 3)));
    END;


}
