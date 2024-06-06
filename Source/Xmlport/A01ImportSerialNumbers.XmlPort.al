xmlport 50004 "A01 Import Serial Numbers"
{
    Caption = 'Import Serial Numbers';
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

                fieldattribute(ItemCode; ImportDocument.Code20_1) { }


                trigger OnBeforeInsertRecord()
                var
                    // PriceListLine: Record "Price List Line";
                    // Item: Record Item;
                    SerialNo: Code[20];
                begin
                    i := i + 1;
                    Window.UPDATE(1,
                    ROUND(i / NbreTotalLignes * 10000, 1));

                    SerialNo := ImportDocument.Code20_1;

                    TempImportDoc."Entry No." := i;
                    TempImportDoc."Document No." := SerialNo;
                    TempImportDoc.Insert();

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

    procedure SetTempImportDoc(var TempImportDoc1: Record "A01 Import Document" temporary)
    var
    begin
        TempImportDoc := TempImportDoc1;
    end;

    var
        TempImportDoc: Record "A01 Import Document" temporary;
        LblEndOfProcess: Label 'End of importation. %1 lines processed', Comment = '%1=...';
        i: Integer;
        NbreTotalLignes: Integer;
        ProcessedLines: Integer;
        Window: Dialog;
        Text008: Label 'Traitement @1@@@@@@@@@@@@@@@@@@@@@@@@@@@@\';
        PriceListCode: Code[20];
        NextLineNo: Integer;
}

