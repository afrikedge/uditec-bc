/// <summary>
/// Report A01 InventoryListPrint (ID 50014).
/// </summary>
report 50014 "A01 InventoryListPrint"
{
    DefaultLayout = RDLC;
    Caption = 'A01 Inventory List print';
    PreviewMode = PrintLayout;
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;
    RDLCLayout = './Source/Report/Layout/InventoryListPrint.rdl';

    dataset
    {
        dataitem(PageLoop; "Integer")
        {
            DataItemTableView = sorting(Number) where(Number = const(1));
            column(ShowLotSN; ShowLotSN)
            {
            }
            column(CaptionFilter_ItemJnlBatch; "Item Journal Batch".TableCaption() + ': ' + ItemJnlBatchFilter)
            {
            }
            column(ItemJnlBatchFilter; ItemJnlBatchFilter)
            {
            }
            column(CaptionFilter_ItemJnlLine; "Item Journal Line".TableCaption + ': ' + ItemJnlLineFilter)
            {
            }
            column(ItemJnlLineFilter; ItemJnlLineFilter)
            {
            }
            column(ShowQtyCalculated; ShowQtyCalculated)
            {
            }
            column(Note1; Note1Lbl)
            {
            }
            column(SummaryPerItem; SummaryPerItemLbl)
            {
            }
            column(ShowNote; ShowNote)
            {
            }
            column(PhysInventoryListCaption; PhysInventoryListCaptionLbl)
            {
            }
            column(CurrReportPageNoCaption; CurrReportPageNoCaptionLbl)
            {
            }
            column(ItemJnlLinePostDtCaption; ItemJnlLinePostDtCaptionLbl)
            {
            }
            column(GetShorDimCodeCaption1; CaptionClassTranslate('1,1,1'))
            {
            }
            column(GetShorDimCodeCaption2; CaptionClassTranslate('1,1,2'))
            {
            }
            column(QtyPhysInventoryCaption; QtyPhysInventoryCaptionLbl)
            {
            }
            dataitem("Item Journal Batch"; "Item Journal Batch")
            {
                // RequestFilterFields = "Journal Template Name", Name;
                column(TemplateName_ItemJnlBatch; "Journal Template Name")
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
                column(TodayFormatted; Format(Today, 0, 4))
                {
                }
                column(DateOfPrintLbl; DateOfPrintLbl)
                {
                }
                column(PostingDateCaptionLbl; PostingDateCaptionLbl)
                {
                }
                column(InventoryDateLbl; InventoryDateLbl)
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
                column(QuantityCalculateLbl; QuantityCalculateLbl)
                {
                }
                column(QuantityObservedLbl; QuantityObservedLbl)
                {
                }
                dataitem("Item Journal Line"; "Item Journal Line")
                {
                    DataItemLink = "Journal Template Name" = field("Journal Template Name"), "Journal Batch Name" = field(Name);
                    DataItemTableView = sorting("Journal Template Name", "Journal Batch Name", "Line No.");
                    RequestFilterFields = "Item No.", "Location Code", "Bin Code";
                    column(PostingDt_ItemJournalLine; Format("Posting Date"))
                    {
                    }
                    column(DocNo_ItemJournalLine; "Document No.")
                    {
                        IncludeCaption = true;
                    }
                    column(ItemNo_ItemJournalLine; "Item No.")
                    {
                        IncludeCaption = true;
                    }
                    column(Desc_ItemJournalLine; Description)
                    {
                        IncludeCaption = true;
                    }
                    column(ShotcutDim1Code_ItemJnlLin; "Shortcut Dimension 1 Code")
                    {
                    }
                    column(ShotcutDim2Code_ItemJnlLin; "Shortcut Dimension 2 Code")
                    {
                    }
                    column(LocCode_ItemJournalLine; "Location Code")
                    {
                        IncludeCaption = true;
                    }
                    column(QtyCalculated_ItemJnlLin; "Qty. (Calculated)")
                    {
                        IncludeCaption = true;
                    }
                    column(Qty___Phys__Inventory_; "Qty. (Phys. Inventory)")
                    {
                        IncludeCaption = true;
                    }
                    column(Variant_Code; "Variant Code")
                    {
                    }
                    column(BinCode_ItemJournalLine; "Bin Code")
                    {
                        IncludeCaption = true;
                    }
                    column(Note; Note)
                    {
                    }
                    column(ShowSummary; ShowSummary)
                    {
                    }
                    column(LineNo_ItemJournalLine; "Line No.")
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
                    dataitem(ItemTrackingSpecification; "Integer")
                    {
                        DataItemTableView = sorting(Number);
                        column(PackageNoCaption; GetPackageNoCaption)
                        {
                        }
                        column(LotNoCaption; GetLotNoCaption)
                        {
                        }
                        column(SerialNoCaption; GetSerialNoCaption)
                        {
                        }
                        column(QuantityBaseCaption; GetQuantityBaseCaption)
                        {
                        }
                        column(ReservEntryBufferPackageNo; TempReservationEntryBuffer."Package No.")
                        {
                        }
                        column(ReservEntryBufferLotNo; TempReservationEntryBuffer."Lot No.")
                        {
                        }
                        column(ReservEntryBufferSerialNo; TempReservationEntryBuffer."Serial No.")
                        {
                        }
                        column(ReservEntryBufferQtyBase; TempReservationEntryBuffer."Quantity (Base)")
                        {
                            DecimalPlaces = 0 : 0;
                        }
                        column(SummaryperItemCaption; SummaryperItemCaptionLbl)
                        {
                        }
                        trigger OnAfterGetRecord()
                        begin
                            if Number = 1 then
                                TempReservationEntryBuffer.FindSet()
                            else
                                TempReservationEntryBuffer.Next();
                        end;

                        trigger OnPreDataItem()
                        begin
                            TempReservationEntryBuffer.SetCurrentKey("Source ID", "Source Ref. No.", "Source Type", "Source Subtype", "Source Batch Name");
                            TempReservationEntryBuffer.SetRange("Source ID", "Item Journal Line"."Journal Template Name");
                            TempReservationEntryBuffer.SetRange("Source Ref. No.", "Item Journal Line"."Line No.");
                            TempReservationEntryBuffer.SetRange("Source Type", DATABASE::"Item Journal Line");
                            TempReservationEntryBuffer.SetFilter("Source Subtype", '=%1', TempReservationEntryBuffer."Source Subtype"::"0");
                            TempReservationEntryBuffer.SetRange("Source Batch Name", "Item Journal Line"."Journal Batch Name");
                            if TempReservationEntryBuffer.IsEmpty() then
                                CurrReport.Break();
                            SetRange(Number, 1, TempReservationEntryBuffer.Count);

                            GetPackageNoCaption := TempReservationEntryBuffer.FieldCaption("Package No.");
                            GetLotNoCaption := TempReservationEntryBuffer.FieldCaption("Lot No.");
                            GetSerialNoCaption := TempReservationEntryBuffer.FieldCaption("Serial No.");
                            GetQuantityBaseCaption := TempReservationEntryBuffer.FieldCaption("Quantity (Base)");
                        end;
                    }
                    trigger OnAfterGetRecord()
                    begin
                        if ShowLotSN then begin
                            Note := '';
                            ShowSummary := false;
                            if "Bin Code" <> '' then
                                if not ItemTrackingManagement.GetWhseItemTrkgSetup("Item No.") then begin
                                    Note := NoteTxt;
                                    ShowSummary := true;
                                end;
                            Clear(TempReservationEntryBuffer);
                        end;

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
                }
                trigger OnAfterGetRecord()
                begin
                    if ItemJournalTemplate.Get("Journal Template Name") then
                        if ItemJournalTemplate.Type <> ItemJournalTemplate.Type::"Phys. Inventory" then
                            CurrReport.Skip();
                end;

            }
        }
    }

    requestpage
    {
        SaveValues = true;
        layout
        {
            area(Content)
            {
                group(Options)
                {
                    // Caption = 'Options';
                    // field(ShowCalculatedQty; ShowQtyCalculated)
                    // {
                    //     ApplicationArea = Basic, Suite;
                    //     Caption = 'Show Qty. (Calculated)';
                    //     ToolTip = 'Specifies if you want the report to show the calculated quantity of the items.';
                    // }
                    // field(ShowSerialLotNumber; ShowLotSN)
                    // {
                    //     ApplicationArea = ItemTracking;
                    //     Caption = 'Show Item Tracking Numbers';
                    //     ToolTip = 'Specifies if you want the report to show item tracking numbers.';
                    // }
                }
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

    trigger OnPreReport()
    begin
        ItemJnlLineFilter := "Item Journal Line".GetFilters();
        ItemJnlBatchFilter := "Item Journal Batch".GetFilters();
        if ShowLotSN then begin
            ShowNote := false;
            ItemJournalLine.CopyFilters("Item Journal Line");
            "Item Journal Batch".CopyFilter("Journal Template Name", ItemJournalLine."Journal Template Name");
            "Item Journal Batch".CopyFilter(Name, ItemJournalLine."Journal Batch Name");
            CreateItemTrackingEntries(ItemJournalLine);
        end;
    end;


    var
        CompanyInfo: Record "Company Information";
        ItemJournalTemplate: Record "Item Journal Template";
        TempReservationEntryBuffer: Record "Reservation Entry" temporary;
        LocRec: Record Location;
        ItemTrackingManagement: Codeunit "Item Tracking Management";
        UnitName: Text[100];
        UnitAddress: Text[100];
        UnitCity: Text[50];
        UnitPostalCode: Text[50];

        Note: Text[1];
        ShowNote: Boolean;
        ShowSummary: Boolean;
        NoteTxt: Label '*', Locked = true;
        EntryNo: Integer;
        GetPackageNoCaption: Text;
        GetLotNoCaption: Text;
        GetSerialNoCaption: Text;
        GetQuantityBaseCaption: Text;
        UnitNameLbl: Label 'Warehouse name :';
        UnitAddressLbl: Label 'Warehouse address :';
        UnitCityLbl: Label 'City';
        UnitPostalCodeLbl: Label 'Postal code :';
        Note1Lbl: Label '*Note:';
        SummaryPerItemLbl: Label 'Your system is set up to use Bin Mandatory and not Warehouse Item Tracking. Therefore, you will not see item tracking numbers by bin but merely as a summary per item.';
        PhysInventoryListCaptionLbl: Label 'Phys. Inventory List';
        CurrReportPageNoCaptionLbl: Label 'Page';
        ItemJnlLinePostDtCaptionLbl: Label 'Posting Date';
        QtyPhysInventoryCaptionLbl: Label 'Qty. (Phys. Inventory)';
        SummaryperItemCaptionLbl: Label 'Summary per Item *';

        PostingDateCaptionLbl: Label 'Posting Date';
        DateOfPrintLbl: Label 'Date__ofprint :';
        ReportTitleLbl: Label 'INVENTORY LIST';
        InventoryDateLbl: Label 'Inventory date';
        ProductCodeLbl: Label 'Product code';
        ProductVariantCodeLbl: Label 'Variant__code';
        DesignationLbl: Label 'Designation';
        QuantityCalculateLbl: Label 'Quantity (Calculated)';
        QuantityObservedLbl: Label 'Quantity (Observed)';
        WarehouseLbl: Label 'Warehouse code';
        LocationLbl: Label 'Location';

    protected var
        ItemJournalLine: Record "Item Journal Line";
        ItemJnlLineFilter: Text;
        ItemJnlBatchFilter: Text;
        ShowQtyCalculated: Boolean;
        ShowLotSN: Boolean;

    procedure Initialize(ShowQtyCalculated2: Boolean)
    begin
        ShowQtyCalculated := ShowQtyCalculated2;
        OnAfterInitialize(ShowQtyCalculated);
    end;

    local procedure CreateItemTrackingEntries(var ItemJournalLine2: Record "Item Journal Line")
    begin
        EntryNo := 0;
        if ItemJournalLine2.FindSet() then
            repeat
                if ItemJournalLine2."Bin Code" <> '' then begin
                    if ItemTrackingManagement.GetWhseItemTrkgSetup(ItemJournalLine2."Item No.") then
                        PickItemTrackingFromWhseEntry(ItemJournalLine2)
                    else begin
                        CreateSummary(ItemJournalLine2);
                        ShowNote := true;
                    end;
                end else
                    if DirectedPutAwayAndPick(ItemJournalLine2."Location Code") then
                        CreateSummary(ItemJournalLine2)
                    else
                        PickItemTrackingFromItemledgerEntry(ItemJournalLine2);
            until ItemJournalLine2.Next() = 0;
    end;

    local procedure PickItemTrackingFromItemledgerEntry(ItemJournalLine2: Record "Item Journal Line")
    var
        ItemLedgerEntry: Record "Item Ledger Entry";
        ItemTrackingSetup: Record "Item Tracking Setup";
    begin
        ItemLedgerEntry.SetCurrentKey("Item No.", Open, "Variant Code", "Location Code");
        ItemLedgerEntry.SetRange("Item No.", ItemJournalLine2."Item No.");
        if ItemJournalLine2."Qty. (Phys. Inventory)" = 0 then  // Item Not on Inventory, show old SN/Lot
            ItemLedgerEntry.SetRange(Open, false)
        else
            ItemLedgerEntry.SetRange(Open, true);
        ItemLedgerEntry.SetRange("Variant Code", ItemJournalLine2."Variant Code");
        ItemLedgerEntry.SetRange("Location Code", ItemJournalLine2."Location Code");
        ItemLedgerEntry.SetFilter("Item Tracking", '<>%1', ItemLedgerEntry."Item Tracking"::None);

        if ItemLedgerEntry.FindSet() then
            repeat
                ItemTrackingSetup.CopyTrackingFromItemLedgerEntry(ItemLedgerEntry);
                CreateReservEntry(ItemJournalLine2, ItemLedgerEntry."Remaining Quantity", ItemTrackingSetup, ItemLedgerEntry."Item Tracking");
            until ItemLedgerEntry.Next() = 0;
    end;

    local procedure PickItemTrackingFromWhseEntry(ItemJournalLine2: Record "Item Journal Line")
    var
        WarehouseEntry: Record "Warehouse Entry";
        ItemTrackingSetup: Record "Item Tracking Setup";
        ReservationEntry: Record "Reservation Entry";
        ItemTrackingEntryType: Enum "Item Tracking Entry Type";
    begin
        WarehouseEntry.SetCurrentKey(
          "Item No.", "Bin Code", "Location Code", "Variant Code", "Unit of Measure Code",
          "Lot No.", "Serial No.", "Entry Type");
        WarehouseEntry.SetRange("Item No.", ItemJournalLine2."Item No.");
        WarehouseEntry.SetRange("Bin Code", ItemJournalLine2."Bin Code");
        WarehouseEntry.SetRange("Location Code", ItemJournalLine2."Location Code");
        WarehouseEntry.SetRange("Variant Code", ItemJournalLine2."Variant Code");
        WarehouseEntry.SetRange("Unit of Measure Code", ItemJournalLine2."Unit of Measure Code");
        if WarehouseEntry.FindSet() then
            repeat
                ReservationEntry.CopyTrackingFromWhseEntry(WarehouseEntry);
                ItemTrackingEntryType := ReservationEntry.GetItemTrackingEntryType();
                ItemTrackingSetup.CopyTrackingFromWhseEntry(WarehouseEntry);
                CreateReservEntry(ItemJournalLine2, WarehouseEntry."Qty. (Base)", ItemTrackingSetup, ItemTrackingEntryType);
            until WarehouseEntry.Next() = 0;
    end;

    local procedure CreateReservEntry(ItemJournalLine2: Record "Item Journal Line"; Qty: Decimal; ItemTrackingSetup2: Record "Item Tracking Setup"; ItemTracking: Enum "Item Tracking Entry Type")
    var
        FoundRec: Boolean;
    begin
        TempReservationEntryBuffer.SetCurrentKey(
          "Item No.", "Variant Code", "Location Code", "Item Tracking", "Reservation Status", "Lot No.", "Serial No.", "Package No.");
        TempReservationEntryBuffer.SetRange("Item No.", ItemJournalLine2."Item No.");
        TempReservationEntryBuffer.SetRange("Variant Code", ItemJournalLine2."Variant Code");
        TempReservationEntryBuffer.SetRange("Location Code", ItemJournalLine2."Location Code");
        TempReservationEntryBuffer.SetRange("Reservation Status", TempReservationEntryBuffer."Reservation Status"::Prospect);
        TempReservationEntryBuffer.SetRange("Item Tracking", ItemTracking);
        TempReservationEntryBuffer.SetTrackingFilterFromItemTrackingSetup(ItemTrackingSetup2);
        if TempReservationEntryBuffer.FindSet() then
            repeat
                if (TempReservationEntryBuffer."Source Ref. No." = ItemJournalLine2."Line No.") and
                   (TempReservationEntryBuffer."Source ID" = ItemJournalLine2."Journal Template Name") and
                   (TempReservationEntryBuffer."Source Batch Name" = ItemJournalLine2."Journal Batch Name")
                then
                    FoundRec := true;
            until (TempReservationEntryBuffer.Next() = 0) or FoundRec;

        if not FoundRec then begin
            EntryNo += 1;
            TempReservationEntryBuffer."Entry No." := EntryNo;
            TempReservationEntryBuffer."Item No." := ItemJournalLine2."Item No.";
            TempReservationEntryBuffer."Location Code" := ItemJournalLine2."Location Code";
            TempReservationEntryBuffer."Quantity (Base)" := Qty;
            TempReservationEntryBuffer."Variant Code" := ItemJournalLine2."Variant Code";
            TempReservationEntryBuffer."Reservation Status" := TempReservationEntryBuffer."Reservation Status"::Prospect;
            TempReservationEntryBuffer."Creation Date" := WorkDate();
            TempReservationEntryBuffer."Source Type" := DATABASE::"Item Journal Line";
            TempReservationEntryBuffer."Source ID" := ItemJournalLine2."Journal Template Name";
            TempReservationEntryBuffer."Source Batch Name" := ItemJournalLine2."Journal Batch Name";
            TempReservationEntryBuffer."Source Ref. No." := ItemJournalLine2."Line No.";
            TempReservationEntryBuffer."Qty. per Unit of Measure" := ItemJournalLine2."Qty. per Unit of Measure";
            TempReservationEntryBuffer.CopyTrackingFromItemTrackingSetup(ItemTrackingSetup2);
            TempReservationEntryBuffer."Item Tracking" := ItemTracking;
            TempReservationEntryBuffer.Insert();
        end
        else begin
            TempReservationEntryBuffer."Quantity (Base)" += Qty;
            if (TempReservationEntryBuffer."Quantity (Base)" = 0) and (ItemJournalLine2."Qty. (Calculated)" <> 0) then
                TempReservationEntryBuffer.Delete()
            else
                TempReservationEntryBuffer.Modify();
        end;
    end;

    local procedure DirectedPutAwayAndPick(LocationCode: Code[10]): Boolean
    var
        Location: Record Location;
    begin
        if LocationCode = '' then
            exit(false);
        Location.Get(LocationCode);
        exit(Location."Directed Put-away and Pick");
    end;

    local procedure CreateSummary(var ItemJournalLine2: Record "Item Journal Line")
    var
        ItemJournalLine3: Record "Item Journal Line";
        ItemNo: Code[20];
        VariantCode: Code[10];
        LocationCode: Code[10];
        NewGroup: Boolean;
    begin
        // Create SN/Lot/Package entry only for the last journal line in the group
        ItemNo := ItemJournalLine2."Item No.";
        VariantCode := ItemJournalLine2."Variant Code";
        LocationCode := ItemJournalLine2."Location Code";
        NewGroup := false;
        ItemJournalLine3 := ItemJournalLine2;
        repeat
            if (ItemNo <> ItemJournalLine2."Item No.") or
               (VariantCode <> ItemJournalLine2."Variant Code") or
               (LocationCode <> ItemJournalLine2."Location Code")
            then
                NewGroup := true
            else
                ItemJournalLine3 := ItemJournalLine2;
        until (ItemJournalLine2.Next() = 0) or NewGroup;
        ItemJournalLine2 := ItemJournalLine3;
        PickItemTrackingFromItemledgerEntry(ItemJournalLine2);
    end;

    [IntegrationEvent(true, false)]
    local procedure OnAfterInitialize(var ShowQtyCalculated: Boolean)
    begin
    end;

}