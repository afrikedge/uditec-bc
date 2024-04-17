/// <summary>
/// Report A01 OutputStock Print (ID 50013).
/// </summary>
report 50013 "A01 OutputStockPrint"
{
    DefaultLayout = RDLC;
    Caption = 'A01 Output stock print';
    PreviewMode = PrintLayout;
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;
    WordMergeDataItem = "Item Journal Batch";
    RDLCLayout = './Source/Report/Layout/OutputStockPrint.rdl';

    dataset
    {
        dataitem("Item Journal Batch"; "Item Journal Batch")
        {
            DataItemTableView = sorting("Journal Template Name", Name);
            // RequestFilterFields = "Journal Template Name", Name;
            // RequestFilterHeading = 'Output Stock';
            column(JournalTempName_ItemJournalBatch; "Journal Template Name")
            {
            }
            column(Name_ItemJournalBatch; Name)
            {
            }
            column(InventoryMovementCaption; InventoryMovementCaptionLbl)
            {
            }
            column(PageCaption; PageCaptionLbl)
            {
            }
            column(JournalTempNameFieldCaption; "Item Journal Line".FieldCaption("Journal Template Name"))
            {
            }
            column(JournalBatchNameFieldCaption; "Item Journal Line".FieldCaption("Journal Batch Name"))
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
            column(TodayFormatted; Format(Today, 0, 4))
            {
            }
            column(DateOfPrintLbl; DateOfPrintLbl)
            {
            }
            column(Time; Time)
            {
            }
            column(OutputDateLbl; OutputDateLbl)
            {
            }
            column(ProductCodeLbl; ProductCodeLbl)
            {
            }
            column(ProductVariantCodeLbl; ProductVariantCodeLbl)
            {
            }
            column(DesignationLbl; DesignationLbl)
            {
            }
            column(WarehouseLbl; WarehouseLbl)
            {
            }
            column(LocationLbl; LocationLbl)
            {
            }
            column(QuantityOutputLbl; QuantityOutputLbl)
            {
            }
            dataitem("Item Journal Line"; "Item Journal Line")
            {
                DataItemLink = "Journal Template Name" = field("Journal Template Name"), "Journal Batch Name" = field(Name);
                RequestFilterFields = "Journal Template Name", "Journal Batch Name", "Location Code", "Bin Code", "Item No.", "Variant Code";
                column(JournalTempName_ItemJournalLine; "Journal Template Name")
                {
                }
                column(AfkIsLine; AfkIsLine)
                {
                }
                column(AfkNumLigne; NumLigneText)
                {
                }
                column(JournalBatchName_ItemJournalLine; "Journal Batch Name")
                {
                }
                column(ActivityType; ActivityType)
                {
                    OptionCaption = ' ,Put-away,Pick,Movement';
                }
                column(ItemJnlLineActTypeShowOutput; ActivityType <> ActivityType::" ")
                {
                }
                column(ItemJournalLineTableCaption; TableCaption + ': ' + ItemJnlLineFilter)
                {
                }
                column(ItemJnlLineFilter; ItemJnlLineFilter)
                {
                }
                column(ItemJnlLineHeader1ShowOutput; ItemJnlTemplate.Type in [ItemJnlTemplate.Type::Item, ItemJnlTemplate.Type::Consumption, ItemJnlTemplate.Type::Output, ItemJnlTemplate.Type::"Prod. Order"])
                {
                }
                column(ItemJnlLineHeader2ShowOutput; ItemJnlTemplate.Type = ItemJnlTemplate.Type::Transfer)
                {
                }
                column(UOM_ItemJournalLine; "Unit of Measure Code")
                {
                }
                column(Qty_ItemJournalLine; Quantity)
                {
                }
                column(BinCode_ItemJournalLine; "Bin Code")
                {
                }
                column(LocationCode_ItemJournalLine; "Location Code")
                {
                }
                column(VariantCode_ItemJournalLine; "Variant Code")
                {
                }
                column(Description_ItemJournalLine; Description)
                {
                }
                column(ItemNo_ItemJournalLine; "Item No.")
                {
                }
                column(PostingDate_ItemJournalLine; Format("Posting Date"))
                {
                }
                column(EntryType_ItemJournalLine; "Entry Type")
                {
                }
                column(QuantityBase_ItemJournalLine; "Quantity (Base)")
                {
                }
                column(QuantityFormat; Quantity)
                {
                }
                column(NewBinCode_ItemJournalLine; "New Bin Code")
                {
                }
                column(NewLocationCode_ItemJournalLine; "New Location Code")
                {
                }
                column(QuantityBaseFormat; "Quantity (Base)")
                {
                }
                column(ActivityTypeCaption; ActivityTypeCaptionLbl)
                {
                }
                column(UOMFieldCaption; FieldCaption("Unit of Measure Code"))
                {
                }
                column(QtyFieldCaption; FieldCaption(Quantity))
                {
                }
                column(BinCodeFieldCaption; FieldCaption("Bin Code"))
                {
                }
                column(LocationCodeFieldCaption; FieldCaption("Location Code"))
                {
                }
                column(VariantCodeFieldCaption; FieldCaption("Variant Code"))
                {
                }
                column(DescriptionFieldCaption; FieldCaption(Description))
                {
                }
                column(ItemNoFieldCaption; FieldCaption("Item No."))
                {
                }
                column(PostingDateCaption; PostingDateCaptionLbl)
                {
                }
                column(EntryTypeFieldCaption; FieldCaption("Entry Type"))
                {
                }
                column(QuantityBaseFieldCaption; FieldCaption("Quantity (Base)"))
                {
                }
                column(NewBinCodeFieldCaption; FieldCaption("New Bin Code"))
                {
                }
                column(NewLocationCodeFieldCaption; FieldCaption("New Location Code"))
                {
                }
                column(UnitName; UnitName)
                {
                }
                column(UnitAddress; UnitAddress)
                {
                }
                column(UnitCity; UnitCity)
                {
                }
                column(UnitPostalCode; UnitPostalCode)
                {
                }
                column(UnitNameLbl; UnitNameLbl)
                {
                }
                column(UnitAddressLbl; UnitAddressLbl)
                {
                }
                column(UnitCityLbl; UnitCityLbl)
                {
                }
                column(UnitPostalCodeLbl; UnitPostalCodeLbl)
                {
                }
                column(WarehouseSignLbl; WarehouseSignLbl)
                {
                }
                column(RecipientSignLbl; RecipientSignLbl)
                {
                }
                trigger OnAfterGetRecord()
                begin
                    AfkIsLine := 1;
                    NumLigne := NumLigne + 1;
                    if (NumLigne < 10) then
                        NumLigneText := '0' + Format(NumLigne)
                    else
                        NumLigneText := Format(NumLigne);

                    if ("Entry Type" in ["Entry Type"::"Positive Adjmt.", "Entry Type"::Purchase, "Entry Type"::Output]) and
                       (Quantity > 0) and
                       (ActivityType in [ActivityType::Pick, ActivityType::Movement])
                    then
                        CurrReport.Skip();

                    if ("Entry Type" in ["Entry Type"::"Negative Adjmt.", "Entry Type"::Sale, "Entry Type"::Consumption]) and
                       (Quantity < 0) and
                       (ActivityType in [ActivityType::Pick, ActivityType::Movement])
                    then
                        CurrReport.Skip();

                    if ("Entry Type" in ["Entry Type"::"Positive Adjmt.", "Entry Type"::Purchase, "Entry Type"::Output]) and
                       (Quantity < 0) and
                       (ActivityType in [ActivityType::"Put-away", ActivityType::Movement])
                    then
                        CurrReport.Skip();

                    if ("Entry Type" in ["Entry Type"::"Negative Adjmt.", "Entry Type"::Sale, "Entry Type"::Consumption]) and
                       (Quantity > 0) and
                       (ActivityType in [ActivityType::"Put-away", ActivityType::Movement])
                    then
                        CurrReport.Skip();

                    if ("Entry Type" <> "Entry Type"::Transfer) and
                       (ActivityType = ActivityType::Movement)
                    then
                        CurrReport.Skip();

                    if LocRec.Get("Item Journal Line"."Location Code") then begin
                        UnitName := LocRec.Name;
                        UnitAddress := LocRec.Address;
                        UnitCity := LocRec.City;
                        UnitPostalCode := LocRec."Post Code";
                    end;

                    if "No." = 'MIR_FEES' then
                        CurrReport.Skip();
                    if "No." = 'mir_fees' then
                        CurrReport.Skip();
                    if "No." = 'MIR_INTEREST' then
                        CurrReport.Skip();
                    if "No." = 'mir_interest' then
                        CurrReport.Skip();
                end;

                trigger OnPreDataItem()
                begin
                    ItemJnlTemplate.Get("Item Journal Batch"."Journal Template Name");
                end;
            }
            dataitem(AfkFooterline; "Integer")
            {
                DataItemTableView = SORTING(Number);
                column(AfkNumLigne2; NumLigneText)
                {
                }
                column(AfkIsLine2; AfkIsLine)
                {
                }

                trigger OnAfterGetRecord()
                begin
                    AfkIsLine := 1;
                    NumLigne := NumLigne + 1;
                    if (NumLigne < 10) then
                        NumLigneText := '0' + Format(NumLigne)
                    else
                        NumLigneText := Format(NumLigne);
                end;

                trigger OnPreDataItem()
                begin
                    SetRange(Number, 1, 0);
                end;
            }
            trigger OnAfterGetRecord()
            begin
                NumLigne := 0;
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
                    // Caption = 'Options';
                    // field(ActivityTyp; ActivityType)
                    // {
                    //     ApplicationArea = Warehouse;
                    //     Caption = 'Activity Type';
                    //     OptionCaption = ' ,Put-away,Pick,Movement';
                    //     ToolTip = 'Specifies the inventory movement activity that a warehouse employee will follow to move items.';
                    // }
                }
            }
        }

        actions
        {
        }
        var
    }

    trigger OnPreReport()
    begin
        ItemJnlLineFilter := "Item Journal Line".GetFilters();

        CompanyInfo.Get();
        CompanyInfo.CalcFields(Picture);
    end;


    var
        ItemJnlTemplate: Record "Item Journal Template";
        CompanyInfo: Record "Company Information";
        LocRec: Record Location;
        ItemJnlLineFilter: Text;
        UnitName: Text[100];
        UnitAddress: Text[100];
        UnitCity: Text[50];
        UnitPostalCode: Text[50];
        AfkIsLine: Integer;
        NumLigne: Integer;
        NumLigneText: Code[2];
        ActivityType: Option " ","Put-away",Pick,Movement;
        InventoryMovementCaptionLbl: Label 'Inventory Movement';
        PageCaptionLbl: Label 'Page';
        DateOfPrintLbl: Label 'Date :';
        ActivityTypeCaptionLbl: Label 'Activity Type';
        PostingDateCaptionLbl: Label 'Posting Date';
        ReportTitleLbl: Label 'OUTPUT STOCK';
        UnitNameLbl: Label 'Warehouse name :';
        UnitAddressLbl: Label 'Warehouse address :';
        UnitCityLbl: Label 'City';
        UnitPostalCodeLbl: Label 'Postal code :';
        WarehouseSignLbl: Label 'Warehouse signature';
        RecipientSignLbl: Label 'Recipient signature';


        OutputDateLbl: Label 'Output date';
        ProductCodeLbl: Label 'Product code';
        ProductVariantCodeLbl: Label 'Variant';
        DesignationLbl: Label 'Designation';
        QuantityOutputLbl: Label 'Quantity';
        WarehouseLbl: Label 'Location code';
        LocationLbl: Label 'Location';


    procedure InitializeRequest(NewActivityType: Option)
    begin
        ActivityType := NewActivityType;
    end;
}