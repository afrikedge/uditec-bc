xmlport 50003 "A01 Import Sales Prices"
{
    Caption = 'Import Sales Price lines';
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
                fieldattribute(VariantCode; ImportDocument.Code20_2) { }
                fieldattribute(UOM; ImportDocument.Code20_3) { }
                fieldattribute(Price; ImportDocument.Amount) { }


                trigger OnBeforeInsertRecord()
                var
                    PriceListLine: Record "Price List Line";
                    PriceListHeader: Record "Price List Header";
                    Item: Record Item;
                    ItemCode: Code[20];
                    VariantCode: Code[20];
                    UOM: Code[20];
                    Price: Decimal;
                begin
                    i := i + 1;
                    Window.UPDATE(1,
                    ROUND(i / NbreTotalLignes * 10000, 1));

                    PriceListHeader.Get(PriceListCode);


                    ItemCode := ImportDocument.Code20_1;
                    Item.Get(ItemCode);
                    VariantCode := ImportDocument.Code20_2;
                    UOM := ImportDocument.Code20_3;
                    Price := ImportDocument.Amount;

                    PriceListLine.Reset();
                    PriceListLine.SetRange(PriceListLine."Price List Code", PriceListCode);
                    PriceListLine.SetRange(PriceListLine."Asset No.", ItemCode);
                    PriceListLine.SetRange(PriceListLine."Variant Code", VariantCode);
                    PriceListLine.SetRange(PriceListLine."Unit of Measure Code", UOM);
                    if (PriceListLine.FindFirst()) then begin
                        PriceListLine.Validate("Unit Price", Price);
                        if (PriceListLine."Source Type" = PriceListHeader."Source Type") then
                            PriceListLine.Validate("Source Type", PriceListHeader."Source Type");
                        PriceListLine.Modify(true);
                    end else begin
                        PriceListLine.Init();
                        //PriceListLine.TransferFields(PriceListHeader);
                        PriceListLine.Validate("Price List Code", PriceListCode);
                        PriceListLine."Line No." := NextLineNo;
                        PriceListLine.Validate("Source Type", PriceListHeader."Source Type");
                        PriceListLine.Validate("Source No.", PriceListHeader."Source No.");
                        PriceListLine.Validate("Source ID", PriceListHeader."Source ID");

                        PriceListLine.Validate(PriceListLine."Source Group", PriceListHeader."Source Group");
                        PriceListLine."Price Includes VAT" := PriceListHeader."Price Includes VAT";
                        PriceListLine."Starting Date" := PriceListHeader."Starting Date";
                        PriceListLine."Ending Date" := PriceListHeader."Ending Date";
                        PriceListLine."Currency Code" := PriceListHeader."Currency Code";
                        PriceListLine."Amount Type" := PriceListHeader."Amount Type";
                        PriceListLine."Price Type" := PriceListHeader."Price Type";
                        PriceListLine."Parent Source No." := PriceListHeader."Parent Source No.";



                        PriceListLine.Insert(true);

                        PriceListLine.Validate("Asset No.", ItemCode);
                        PriceListLine.Validate("Variant Code", VariantCode);
                        PriceListLine.Validate("Unit of Measure Code", UOM);
                        PriceListLine.Validate("Unit Price", Price);
                        PriceListLine.Modify(true);
                    end;

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
        PriceListLine: Record "Price List Line";
    begin
        i := 0;
        Window.OPEN(Text008);
        if (NbreTotalLignes = 0) then
            NbreTotalLignes := 300;

        if (PriceListCode = '') then
            Error('No Pricelist found for this import');

        PriceListLine.Reset();
        PriceListLine.SetRange(PriceListLine."Asset No.", PriceListCode);
        if (PriceListLine.FindLast()) then
            NextLineNo := PriceListLine."Line No."
        else
            NextLineNo := 0;
    end;

    trigger OnPostXmlPort()
    begin
        Window.Close();
        Message(StrSubstNo(LblEndOfProcess, ProcessedLines));
    end;

    procedure SetPriceListCode(PriceListCode1: code[20])
    var
    begin
        PriceListCode := PriceListCode1;
    end;

    var
        LblEndOfProcess: Label 'End of importation. %1 lines processed', Comment = '%1=...';
        i: Integer;
        NbreTotalLignes: Integer;
        ProcessedLines: Integer;
        Window: Dialog;
        Text008: Label 'Traitement @1@@@@@@@@@@@@@@@@@@@@@@@@@@@@\';
        PriceListCode: Code[20];
        NextLineNo: Integer;
}
