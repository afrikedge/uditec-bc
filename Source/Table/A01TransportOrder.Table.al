table 50054 "A01 Transport Order"
{
    Caption = 'Transport Order';
    DataClassification = CustomerContent;

    fields
    {
        field(1; "No."; Code[20])
        {
            Caption = 'No.';
            Editable = false;

            trigger OnValidate()
            begin
                if "No." <> xRec."No." then begin
                    AddOnSetup.Get();
                    NoSeriesManagement.TestManual(AddOnSetup."Transport Order Nos");
                    "No. Series" := '';
                end;
            end;
        }
        field(2; "TransportOrder Status"; Enum "A01 TransportOrder Status")
        {
            Caption = 'TransportOrder Status';
            trigger OnValidate()
            var
            begin
                if ("TransportOrder Status" = Rec."TransportOrder Status"::Planned) then begin
                    CreateShipmentDocumentsOnPlanning();
                end;
                if ("TransportOrder Status" = Rec."TransportOrder Status"::Closed) then begin
                    CreateSalesReturnsOnClosing();
                end;
            end;
        }
        field(3; "Carrier No."; Code[20])
        {
            Caption = 'Carrier No.';
            TableRelation = Vendor;
        }
        field(4; "Vehicle No."; Code[20])
        {
            Caption = 'Vehicle No.';
            TableRelation = "A01 Vehicule";
        }
        field(5; " Driver No."; Code[20])
        {
            Caption = ' Driver No.';
            TableRelation = "A01 Driver";
        }
        field(6; "Route No."; Code[20])
        {
            Caption = 'Route No.';
            TableRelation = "A01 Route";
        }
        field(7; "Departure Date (Planned)"; DateTime)
        {
            Caption = 'Departure Date (Planned)';
        }
        field(8; "Departure Time (Planned)"; Time)
        {
            Caption = 'Departure Time (Planned)';
        }
        field(9; "Return Date (Planned)"; DateTime)
        {
            Caption = 'Return Date (Planned)';
        }
        field(10; "Return Time (Planned)"; Time)
        {
            Caption = 'Return Time (Planned)';
        }
        field(11; "Departure Date (Actual)"; DateTime)
        {
            Caption = 'Departure Date (Actual)';
        }
        field(12; "Departure Time (Actual)"; Time)
        {
            Caption = 'Departure Time (Actual)';
        }
        field(13; "Return Date (Actual)"; DateTime)
        {
            Caption = 'Return Date (Actual)';
        }
        field(14; "Return Time (Actual)"; Time)
        {
            Caption = 'Return Time (Actual)';
        }
        field(15; "Duration (Actual)"; Integer)
        {
            Caption = 'Duration (Actual)';
        }
        field(16; "Duration (Planned)"; Integer)
        {
            Caption = 'Duration (Planned)';
        }
        field(17; "Useful volume (cbm)"; Decimal)
        {
            Caption = 'Useful volume (cbm)';
            Editable = false;
        }
        field(18; "Payload (kg)"; Decimal)
        {
            Caption = 'Payload (kg)';
            Editable = false;
        }

        field(19; "Outbound Package Count"; Decimal)
        {
            Caption = 'Outbound Package Count';
            Editable = false;
        }
        field(20; "Outbound Volume Loaded (cbm)"; Decimal)
        {
            Caption = 'Outbound Volume Loaded (cbm)';
            Editable = false;
        }

        field(21; "Outbound Weight Load (Kg)"; Decimal)
        {
            Caption = 'Outbound Weight Load (Kg)';
            Editable = false;
        }

        field(22; "Outbound Unloading Dura (Plan)"; Decimal)
        {
            Caption = 'Outbound Unloading Duration (Planned)';
            Editable = false;
        }
        field(23; "Inbound Package Count"; Decimal)
        {
            Caption = 'Inbound Package Count';
            Editable = false;
        }
        field(24; "Inbound Volume Loaded (cbm)"; Decimal)
        {
            Caption = 'Inbound Volume Loaded (cbm)';
            Editable = false;
        }
        field(25; "Inbound Weight Load (Kg)"; Decimal)
        {
            Caption = 'Inbound Weight Load (Kg)';
            Editable = false;
        }
        field(26; "Inbound Unloading Dura (Plan)"; Decimal)
        {
            Caption = 'Inbound Unloading Duration (Planned)';
            Editable = false;
        }
        field(27; "No. Series"; Code[20])
        {
            Caption = 'No. Series';
            TableRelation = "No. Series";
        }
        field(28; "Web User Id"; Code[50])
        {
            Caption = 'Web User Id';
            DataClassification = CustomerContent;
            Editable = false;
        }

        field(29; "Delivery Agent"; Code[50])
        {
            Caption = 'Delivery Agent';
            DataClassification = CustomerContent;
            Editable = false;
            TableRelation = "A01 External User";
        }
        field(30; "Initial Location"; Code[50])
        {
            Caption = 'Delivery Agent';
            DataClassification = CustomerContent;
            Editable = false;
            TableRelation = Location;
        }









    }
    keys
    {
        key(PK; "No.")
        {
            Clustered = true;
        }
    }

    trigger OnInsert()
    begin
        if "No." = '' then begin
            AddOnSetup.Get();
            AddOnSetup.TestField("Transport Order Nos");
            NoSeriesManagement.InitSeries(AddOnSetup."Transport Order Nos", xRec."No. Series", 0D, "No.", "No. Series");
        end;
        InitHeader();
    end;

    trigger OnDelete()
    var
        TransportOrderDetail: Record "A01 Transport Order Detail";
    begin
        TransportOrderDetail.Reset();
        TransportOrderDetail.SetRange("Transport Order No.", Rec."No.");
        if (not TransportOrderDetail.IsEmpty) then
            TransportOrderDetail.DeleteAll();
    end;

    local procedure CreateShipmentDocumentsOnPlanning()
    var
        TransportOrderDetail: Record "A01 Transport Order Detail";
        WhseShptHeader: record "Warehouse Shipment Header";
        SalesLine: record "Sales Line";
        TransferLine: record "Transfer Line";
        OrderType: enum "A01 Transport Order Type";
        LineNo: integer;
        LocationCode: Code[20];
    begin
        LocationCode := '';
        TransportOrderDetail.Reset();
        TransportOrderDetail.SetCurrentKey("Transport Order No.", "Order Type", "Location Code");
        TransportOrderDetail.SetRange("Transport Order No.", Rec."No.");
        if TransportOrderDetail.FindSet() then
            repeat

                if (IsAdvanceLocation(TransportOrderDetail."Location Code")) then begin
                    if ((OrderType <> TransportOrderDetail."Order Type") or (LocationCode <> TransportOrderDetail."Location Code")) then begin
                        CreateWarehouseShipmentDocument(Rec, TransportOrderDetail, WhseShptHeader);
                        OrderType := TransportOrderDetail."Order Type";
                        LocationCode := TransportOrderDetail."Location Code";
                    end;

                    LineNo := LineNo + 10000;
                    if (OrderType = TransportOrderDetail."Order Type"::"Sales Order") then begin
                        SalesLine.get(SalesLine."Document Type"::Order, TransportOrderDetail."Order No.", TransportOrderDetail."Order Line No.");
                        AddWhseShptLineFromSalesLine(WhseShptHeader, TransportOrderDetail, SalesLine, LineNo);
                    end;
                    if (OrderType = TransportOrderDetail."Order Type"::Transfer) then begin
                        TransferLine.get(TransportOrderDetail."Order No.", TransportOrderDetail."Order Line No.");
                        AddWhseShptLineFromTransferLine(WhseShptHeader, TransportOrderDetail, TransferLine, LineNo);
                    end;

                end else begin

                    if (OrderType = TransportOrderDetail."Order Type"::"Sales Order") then begin
                        SalesLine.get(SalesLine."Document Type"::Order, TransportOrderDetail."Order No.", TransportOrderDetail."Order Line No.");
                        SalesLine.Validate("Qty. to Ship", TransportOrderDetail."Quantity (Planned)");
                        SalesLine.Modify();
                    end;
                    if (OrderType = TransportOrderDetail."Order Type"::Transfer) then begin
                        TransferLine.get(TransportOrderDetail."Order No.", TransportOrderDetail."Order Line No.");
                        TransferLine.Validate("Qty. to Ship", TransportOrderDetail."Quantity (Planned)");
                        TransferLine.Modify();
                    end;

                end;
                ;

            until TransportOrderDetail.Next() < 1;
    end;


    local procedure CreateSalesReturnsOnClosing()
    var
        TransportOrderDetail: Record "A01 Transport Order Detail";
        SalesHeader: record "Sales Header";
        LineNo: integer;
        CustCode: Code[20];
    begin
        CustCode := '';
        TransportOrderDetail.Reset();
        TransportOrderDetail.SetCurrentKey("Transport Order No.", "Customer No.");
        TransportOrderDetail.SetRange("Transport Order No.", Rec."No.");
        if TransportOrderDetail.FindSet() then
            repeat
                if (TransportOrderDetail."Return Status" = TransportOrderDetail."Return Status"::Return) then begin
                    if (CustCode <> TransportOrderDetail."Customer No.") then begin
                        AddSalesReturnHeader(SalesHeader, TransportOrderDetail);
                        CustCode := TransportOrderDetail."Customer No.";
                    end;

                    LineNo := LineNo + 10000;
                    AddSalesReturnLine(SalesHeader, TransportOrderDetail, LineNo);
                end;
            until TransportOrderDetail.Next() < 1;
    end;


    local procedure IsAdvanceLocation(LocationCode: code[20]): Boolean
    var
        Loc: record Location;
    begin
        Loc.Get(LocationCode);
        exit(Loc."Require Shipment");
    end;

    local procedure CreateWarehouseShipmentDocument(TransportOrder: Record "A01 Transport Order"; TransportOrderDetail: Record "A01 Transport Order Detail"; var WhseShptHeader: record "Warehouse Shipment Header")
    var
        WhseShptLine: record "Warehouse Shipment Line";
    begin
        WhseShptHeader.INIT();
        WhseShptHeader."No." := '';
        WhseShptHeader."Location Code" := TransportOrderDetail."Location Code";
        //WhseShptHeader."Bin Code" := TransportOrderDetail.;
        WhseShptHeader."External Document No." := TransportOrder."No.";
        WhseShptLine.LOCKTABLE();
        WhseShptHeader.INSERT(true);
        //ActivitiesCreated := ActivitiesCreated + 1;

    end;

    local procedure AddWhseShptLineFromSalesLine(WhseShptHeader: record "Warehouse Shipment Header"; TransportOrderDetail: Record "A01 Transport Order Detail"; SalesLine: record "Sales Line"; LineNo: integer)
    var
        Location: record Location;
        SalesHeader: record "Sales Header";
        WhseShptLine: record "Warehouse Shipment Line";
        Item: record Item;
        WhseMgt: codeunit "Whse. Management";
        TotalOutstandingWhseShptQty: Decimal;
        ShipQtyError: label 'Invalid qty to ship';
    begin
        SalesHeader.get(SalesLine."Document Type", SalesLine."Document No.");
        SalesLine.CALCFIELDS("Whse. Outstanding Qty.", "ATO Whse. Outstanding Qty.", "Whse. Outstanding Qty. (Base)", "ATO Whse. Outstd. Qty. (Base)");
        TotalOutstandingWhseShptQty := ABS(SalesLine."Outstanding Quantity") - SalesLine."Whse. Outstanding Qty.";
        if (TotalOutstandingWhseShptQty <= 0) then Error(ShipQtyError);

        WhseShptLine.Init();
        WhseShptLine."No." := WhseShptHeader."No.";
        WhseShptLine."Line No." := LineNo;
        WhseShptLine."Source Type" := DATABASE::"Sales Line";
        WhseShptLine."Source Subtype" := SalesLine."Document Type".AsInteger();
        WhseShptLine."Source No." := SalesLine."Document No.";
        WhseShptLine."Source Line No." := SalesLine."Line No.";
        WhseShptLine.Validate("Source Document", WhseMgt.GetSourceDocument(DATABASE::"Sales Line", SalesLine."Document Type".AsInteger()));
        SalesLine.TESTFIELD("Unit of Measure Code");

        WhseShptLine."Item No." := SalesLine."No.";
        WhseShptLine.Description := SalesLine.Description;
        WhseShptLine."Description 2" := SalesLine."Description 2";
        WhseShptLine."Location Code" := SalesLine."Location Code";
        WhseShptLine."Variant Code" := SalesLine."Variant Code";
        WhseShptLine."Unit of Measure Code" := SalesLine."Unit of Measure Code";
        WhseShptLine."Qty. per Unit of Measure" := SalesLine."Qty. per Unit of Measure";

        WhseShptLine.Validate(Quantity, TransportOrderDetail."Quantity (Planned)");
        //"Qty. (Base)" := QtyBase;
        WhseShptLine.InitOutstandingQtys();
        WhseShptLine.CheckSourceDocLineQty();
        if Location.GET(WhseShptLine."Location Code") then
            if Location."Directed Put-away and Pick" then
                WhseShptLine.CheckBin(0, 0);

        if SalesLine."Document Type" = SalesLine."Document Type"::Order then
            WhseShptLine."Due Date" := SalesLine."Planned Shipment Date";
        if SalesLine."Document Type" = SalesLine."Document Type"::"Return Order" then
            WhseShptLine."Due Date" := WORKDATE();
        if WhseShptHeader."Shipment Date" = 0D then
            WhseShptLine."Shipment Date" := SalesLine."Shipment Date"
        else
            WhseShptLine."Shipment Date" := WhseShptHeader."Shipment Date";
        WhseShptLine."Destination Type" := WhseShptLine."Destination Type"::Customer;
        WhseShptLine."Destination No." := SalesLine."Sell-to Customer No.";
        WhseShptLine."Shipping Advice" := SalesHeader."Shipping Advice";
        if WhseShptLine."Location Code" = WhseShptHeader."Location Code" then
            WhseShptLine."Bin Code" := WhseShptHeader."Bin Code";
        if WhseShptLine."Bin Code" = '' then
            WhseShptLine."Bin Code" := SalesLine."Bin Code";

        if WhseShptHeader."Zone Code" <> '' then
            WhseShptLine.VALIDATE("Zone Code", WhseShptHeader."Zone Code");
        if WhseShptHeader."Bin Code" <> '' then
            WhseShptLine.VALIDATE("Bin Code", WhseShptHeader."Bin Code");

        Item."No." := WhseShptLine."Item No.";
        Item.ItemSKUGet(Item, WhseShptLine."Location Code", WhseShptLine."Variant Code");
        WhseShptLine."Shelf No." := Item."Shelf No.";
        WhseShptLine.INSERT();
        //WhseShptLine.OnAfterWhseShptLineInsert(WhseShptLine);
        WhseShptLine.CreateWhseItemTrackingLines();
    end;

    local procedure AddWhseShptLineFromTransferLine(WhseShptHeader: record "Warehouse Shipment Header"; TransportOrderDetail: Record "A01 Transport Order Detail"; TransferLine: record "Transfer Line"; LineNo: integer)
    var
        Location: record Location;
        TransHeader: record "Transfer Header";
        WhseShptLine: record "Warehouse Shipment Line";
        Item: record Item;
        WhseMgt: codeunit "Whse. Management";
    // TotalOutstandingWhseShptQty: Decimal;
    // ShipQtyError: label 'Invalid qty to ship';
    begin
        TransHeader.get(TransferLine."Document No.");
        // SalesLine.CALCFIELDS("Whse. Outstanding Qty.", "ATO Whse. Outstanding Qty.", "Whse. Outstanding Qty. (Base)", "ATO Whse. Outstd. Qty. (Base)");
        // TotalOutstandingWhseShptQty := ABS(SalesLine."Outstanding Quantity") - SalesLine."Whse. Outstanding Qty.";
        // if (TotalOutstandingWhseShptQty <= 0) then Error(ShipQtyError);

        WhseShptLine.Init();
        WhseShptLine."No." := WhseShptHeader."No.";
        WhseShptLine."Line No." := LineNo;
        WhseShptLine."Source Type" := DATABASE::"Transfer Line";
        WhseShptLine."Source Subtype" := 0;
        WhseShptLine."Source No." := TransferLine."Document No.";
        WhseShptLine."Source Line No." := TransferLine."Line No.";
        WhseShptLine.Validate("Source Document", WhseMgt.GetSourceDocument(DATABASE::"Transfer Line", 0));
        TransferLine.TESTFIELD("Unit of Measure Code");

        WhseShptLine."Item No." := TransferLine."Item No.";
        WhseShptLine.Description := TransferLine.Description;
        WhseShptLine."Description 2" := TransferLine."Description 2";
        WhseShptLine."Location Code" := TransferLine."Transfer-from Code";
        WhseShptLine."Variant Code" := TransferLine."Variant Code";
        WhseShptLine."Unit of Measure Code" := TransferLine."Unit of Measure Code";
        WhseShptLine."Qty. per Unit of Measure" := TransferLine."Qty. per Unit of Measure";

        WhseShptLine.Validate(Quantity, TransportOrderDetail."Quantity (Planned)");
        //"Qty. (Base)" := QtyBase;
        WhseShptLine.InitOutstandingQtys();
        WhseShptLine.CheckSourceDocLineQty();
        if Location.GET(WhseShptLine."Location Code") then
            if Location."Directed Put-away and Pick" then
                WhseShptLine.CheckBin(0, 0);

        WhseShptLine."Due Date" := TransferLine."Shipment Date";
        if WhseShptHeader."Shipment Date" = 0D then
            WhseShptLine."Shipment Date" := WORKDATE()
        else
            WhseShptLine."Shipment Date" := WhseShptHeader."Shipment Date";
        WhseShptLine."Destination Type" := WhseShptLine."Destination Type"::Location;
        WhseShptLine."Destination No." := TransferLine."Transfer-to Code";
        if TransHeader.GET(TransferLine."Document No.") then
            WhseShptLine."Shipping Advice" := TransHeader."Shipping Advice";
        if WhseShptLine."Location Code" = WhseShptHeader."Location Code" then
            WhseShptLine."Bin Code" := WhseShptHeader."Bin Code";
        if WhseShptLine."Bin Code" = '' then
            WhseShptLine."Bin Code" := TransferLine."Transfer-from Bin Code";

        Item."No." := WhseShptLine."Item No.";
        Item.ItemSKUGet(Item, WhseShptLine."Location Code", WhseShptLine."Variant Code");
        WhseShptLine."Shelf No." := Item."Shelf No.";
        WhseShptLine.INSERT();
        //WhseShptLine.OnAfterWhseShptLineInsert(WhseShptLine);
        WhseShptLine.CreateWhseItemTrackingLines();
    end;



    local procedure AddSalesReturnHeader(var SalesReturn: record "Sales Header"; TransportOrderDetail: Record "A01 Transport Order Detail")
    var
        SalesReturnLine: record "Sales Line";
    begin
        SalesReturn.Init();
        SalesReturn."Document Type" := SalesReturn."Document Type"::"Return Order";
        SalesReturn."No." := '';
        SalesReturn."External Document No." := Rec."No.";
        SalesReturnLine.LOCKTABLE();
        SalesReturn.Insert(true);
        SalesReturn.Validate("Sell-to Customer No.", TransportOrderDetail."Customer No.");
        SalesReturn.Modify();
    end;

    local procedure AddSalesReturnLine(SalesReturn: record "Sales Header"; TransportOrderDetail: Record "A01 Transport Order Detail"; LineNo: integer)
    var

        SalesReturnLine: record "Sales Line";

    begin
        if (TransportOrderDetail."Return Status" = TransportOrderDetail."Return Status"::Return) then begin

            SalesReturnLine.Init();
            SalesReturnLine."Document Type" := SalesReturn."Document Type";
            SalesReturnLine."Document No." := SalesReturn."No.";
            SalesReturnLine."Line No." := LineNo;
            SalesReturnLine.Type := SalesReturnLine.Type::Item;
            SalesReturnLine.Validate("No.", TransportOrderDetail."Item No.");
            SalesReturnLine.Validate(Quantity, TransportOrderDetail."Quantity (Planned)");
            SalesReturnLine.Validate("Unit of Measure Code", TransportOrderDetail."Unit of Mesure Code");
            SalesReturnLine.Validate(SalesReturnLine."Location Code", TransportOrderDetail."Location Code");
            SalesReturnLine.Insert(true);
        end;
    end;

    var
        AddOnSetup: Record "A01 Afk Setup";
        //Currency: Record Currency;
        NoSeriesManagement: Codeunit NoSeriesManagement;
    //RequestMgt: Codeunit "A01 Document Request Mgt";
    //DimensionManagement: Codeunit DimensionManagement;

    local procedure InitHeader()
    begin
    end;
}
