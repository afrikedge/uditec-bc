xmlport 50002 "A01 Import Lettrage"
{
    Caption = 'Import Lettrage';
    Direction = Import;
    Format = VariableText;
    TextEncoding = UTF8;
    FieldDelimiter = '<None>';
    FieldSeparator = '<TAB>';
    UseRequestPage = true;

    schema
    {
        textelement(RootNodeName)
        {
            tableelement("ImportDocument"; "A01 Import Document")
            {
                SourceTableView = sorting("Entry No.") order(ascending);
                AutoSave = false;

                fieldattribute(InitialDoc; ImportDocument.Code20_1) { }
                fieldattribute(ApplyingDoc; ImportDocument.Code20_2) { }
                fieldattribute(ApplyAmount; ImportDocument.Amount) { }
                fieldattribute(ApplyDate; ImportDocument.Code20_3) { }




                trigger OnBeforeInsertRecord()
                var
                    GLMgt: codeunit "A01 General Legder Mgt";
                    DocNo: Code[20];
                    DocNo2: Code[20];
                    ApplyDate: Date;
                    ApplyAmt: Decimal;
                    Processed: Boolean;
                begin
                    i := i + 1;
                    Window.UPDATE(1,
                    ROUND(i / NbreTotalLignes * 10000, 1));

                    DocNo := ImportDocument.Code20_1;
                    DocNo2 := ImportDocument.Code20_2;
                    ApplyAmt := ImportDocument.Amount;
                    Evaluate(ApplyDate, ImportDocument.Code20_3);

                    Processed := GLMgt.PostApplication(i, DocNo, DocNo2, ApplyAmt, ApplyDate);

                    if (Processed) then
                        ProcessedLines := ProcessedLines + 1;
                end;
            }
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
                    field(NosOfLines; NbreTotalLignes)
                    {
                        ApplicationArea = All;
                        Caption = 'Number of lines to import';
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
    trigger OnPreXmlPort()
    var
    begin
        i := 0;
        Window.OPEN(Text008);
        if (NbreTotalLignes = 0) then
            NbreTotalLignes := 100;
    end;

    trigger OnPostXmlPort()
    begin
        Window.CLOSE();
        Message(StrSubstNo(LblEndOfProcess, ProcessedLines));
    end;

    var
        LblEndOfProcess: Label 'End of importation. %1 lines processed', Comment = '%1=...';
        i: Integer;
        NbreTotalLignes: Integer;
        ProcessedLines: Integer;
        Window: Dialog;
        Text008: Label 'Traitement @1@@@@@@@@@@@@@@@@@@@@@@@@@@@@\';
}

