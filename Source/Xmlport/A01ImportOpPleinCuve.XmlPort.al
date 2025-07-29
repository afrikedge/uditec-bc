xmlport 50005 "A01 Import Op Plein Cuve"
{
    Caption = 'Import Operation Plein Cuve';
    Direction = Import;
    Format = VariableText;
    TextEncoding = UTF8;
    FieldDelimiter = '<None>';
    FieldSeparator = '<TAB>';
    UseRequestPage = false;

    schema
    {
        textelement(RootNodeName)
        {
            tableelement("ImportDocument"; "A01 Import Document")
            {
                SourceTableView = sorting("Entry No.") order(ascending);
                AutoSave = false;

                fieldattribute(CustNo; ImportDocument.Code20_1) { }
                fieldattribute(StartingDate; ImportDocument.Date1) { }
                fieldattribute(EndingDate; ImportDocument.Date2) { }
                fieldattribute(Inactive; ImportDocument.Boolean1) { }



                trigger OnBeforeInsertRecord()
                var
                begin
                    i := i + 1;
                    Window.UPDATE(1,
                    ROUND(i / NbreTotalLignes * 10000, 1));

                    ImportDoc.Init();
                    ImportDoc."Customer No." := ImportDocument.Code20_1;
                    ImportDoc."Starting Date" := ImportDocument.Date1;
                    ImportDoc."Ending Date" := ImportDocument.Date2;
                    ImportDoc.Inactif := ImportDocument.Boolean1;
                    ImportDoc.Insert();

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
                // group(Options)
                // {
                //     field(NosOfLines; NbreTotalLignes)
                //     {
                //         ApplicationArea = All;
                //         Caption = 'Number of lines to import';
                //     }
                // }
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
            NbreTotalLignes := 300;


    end;

    trigger OnPostXmlPort()
    begin
        Window.Close();
        Message(StrSubstNo(LblEndOfProcess, ProcessedLines));
    end;

    var
        ImportDoc: Record "A01 Operation Plein Cuve";
        LblEndOfProcess: Label 'End of importation. %1 lines processed', Comment = '%1=...';
        i: Integer;
        NbreTotalLignes: Integer;
        ProcessedLines: Integer;
        Window: Dialog;
        Text008: Label 'Traitement @1@@@@@@@@@@@@@@@@@@@@@@@@@@@@\';
    //PriceListCode: Code[20];
    //NextLineNo: Integer;
}

