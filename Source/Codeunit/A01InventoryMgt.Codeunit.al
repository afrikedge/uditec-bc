codeunit 50020 "A01 Inventory Mgt"
{
    Permissions = tabledata 7322 = rm;

    var
        SecMgt: Codeunit "A01 Security Mgt";
        Selection: Integer;
        LblAction01: Label '&Send to approval';
        LblAction02: Label '&Approve,&Return to draft';
        ErrValidationNotEnabled: Label 'Transfer approbation is not enabled for this store';
        ErrDone: Label 'the transfer has already been approved';
        ErrNeedValidation: Label 'The transfer must be approved before being delivered';
        ErrNotAutorise: Label 'You are not authorized to validate this transfer';

    procedure ValidateItemTransfer(TransHeader: Record "Transfer Header")
    var
    begin

        if (TransHeader."A01 Approval Status" = TransHeader."A01 Approval Status"::Validated) then
            error(ErrDone);

        if (not TransferNeedValidation(TransHeader)) then
            error(ErrValidationNotEnabled);

        case TransHeader."A01 Approval Status" of

            TransHeader."A01 Approval Status"::" ":
                begin
                    Selection := dialog.StrMenu(LblAction01, 1);
                    if Selection = 0 then exit;
                    if Selection = 1 then SendToApproval(TransHeader);
                    exit;
                end;

            TransHeader."A01 Approval Status"::"Awaiting Approbation":
                begin
                    Selection := dialog.StrMenu(LblAction02, 1);
                    if Selection = 0 then exit;
                    if Selection = 1 then ValidateTransfer(TransHeader);
                    if Selection = 2 then ReturnOnHold(TransHeader);
                    exit;
                end;
        end;
    end;

    local procedure ValidateTransfer(var TransHeader: Record "Transfer Header")
    var
        Loc: Record Location;
    begin

        if (not TransferNeedValidation(TransHeader)) then
            exit;

        TransHeader.TestField("Transfer-from Code");
        Loc.Get(TransHeader."Transfer-from Code");

        if (loc."A01 Transfer Val Manager" <> UserId) then
            Error(ErrNotAutorise);

        TransHeader."A01 Approval Status" := TransHeader."A01 Approval Status"::Validated;
        TransHeader."A01 Approval User" := Copystr(UserId, 1, 50);
        TransHeader."A01 Approval Date" := Today;
        TransHeader.Modify();

    end;

    local procedure ReturnOnHold(var TransHeader: Record "Transfer Header")
    var
        Loc: Record Location;
    begin

        if (not TransferNeedValidation(TransHeader)) then
            exit;

        TransHeader.TestField("Transfer-from Code");
        Loc.Get(TransHeader."Transfer-from Code");

        SecMgt.CheckWharehouseUser(TransHeader."Transfer-from Code");

        if (loc."A01 Transfer Val Manager" <> UserId) then
            Error(ErrNotAutorise);

        TransHeader."A01 Approval Status" := TransHeader."A01 Approval Status"::" ";
        TransHeader."A01 Approval User" := Copystr(UserId, 1, 50);
        TransHeader."A01 Approval Date" := Today;
        TransHeader.Modify();

    end;

    local procedure SendToApproval(var TransHeader: Record "Transfer Header")
    var
    begin

        if (not TransferNeedValidation(TransHeader)) then
            exit;

        TransHeader."A01 Approval Status" := TransHeader."A01 Approval Status"::"Awaiting Approbation";
        //TransHeader."A01 Approval User" := Copystr(UserId, 1, 50);
        //TransHeader."A01 Approval Date" := Today;
        TransHeader.Modify();

    end;

    local procedure TransferNeedValidation(TransHeader: Record "Transfer Header"): Boolean
    var
        Loc: Record Location;
    begin
        if (TransHeader."A01 Approval Status" = TransHeader."A01 Approval Status"::"Validated") then
            exit(false);
        TransHeader.TestField("Transfer-from Code");
        Loc.Get(TransHeader."Transfer-from Code");
        exit(Loc."A01 Transfer Val Required");
    end;

    procedure CheckValidation(TransHeader: Record "Transfer Header")
    var
    begin
        if TransferNeedValidation(TransHeader) then
            error(ErrNeedValidation);
    end;

    procedure CheckModification(TransHeader: Record "Transfer Header")
    var
    begin
        if TransferNeedValidation(TransHeader) then
            TransHeader.TestField(TransHeader."A01 Approval Status", TransHeader."A01 Approval Status"::" ");
    end;

    procedure CheckLineModification(TransLine: Record "Transfer Line")
    var
        TransHeader: Record "Transfer Header";
    begin
        TransHeader.get(TransLine."Document No.");
        if TransferNeedValidation(TransHeader) then
            TransHeader.TestField(TransHeader."A01 Approval Status", TransHeader."A01 Approval Status"::" ");
    end;

    procedure ConfirmPrintReport50027(var PostedWhseShip: Record "Posted Whse. Shipment Header")
    var
    begin
        PostedWhseShip.Find();
        PostedWhseShip."A01 No. Printed" := PostedWhseShip."A01 No. Printed" + 1;
        PostedWhseShip.Modify();
        Commit();
    end;

    procedure CreateItemAdjustmentEntry_ServiceRequest(ServiceRequest: record "A01 Service Request")
    var
        ItemJnlLine: record "Item Journal Line";
        SRSparePart: record "A01 SR Spare Part";
        Item1: record Item;
        ItemJnlPostLine: Codeunit "Item Jnl.-Post Line";
        Text002: Label '%1 %2';
        DefaultDimSource: List of [Dictionary of [Integer, Code[20]]];
        NextDocNo: Code[20];
    begin

        NextDocNo := NoSeriesMgt.GetNextNo(AddOnSetup."Service Request Adj Nos", Today, true);
        AddOnSetup.GetRecordOnce();
        AddOnSetup.TestField("Service Request Adj Nos");
        ServiceRequest.TestField("Responsibility Center");

        SRSparePart.Reset();
        SRSparePart.SetRange("Service Request No.", ServiceRequest."No.");
        SRSparePart.SetRange("Spare Status", SRSparePart."Spare Status"::" ");
        SRSparePart.SetRange("Usage Status", SRSparePart."Usage Status"::Used);
        SRSparePart.SetFilter("Item No.", '<>%1', '');
        SRSparePart.SetFilter("Item Entry Doc No", '=%1', '');
        if SRSparePart.FindSet(true) then
            repeat
                ItemJnlLine.Init();
                ItemJnlLine."Posting Date" := WorkDate();
                ItemJnlLine."Document Date" := WorkDate();

                ItemJnlLine."Document No." := NextDocNo;
                ItemJnlLine."Entry Type" := ItemJnlLine."Entry Type"::"Negative Adjmt.";

                ItemJnlLine."External Document No." := ServiceRequest."No.";

                ItemJnlLine.VALIDATE("Item No.", SRSparePart."Item No.");
                ItemJnlLine.Description := STRSUBSTNO(Text002, ServiceRequest.TableCaption(), ServiceRequest."No.");

                ItemJnlLine.VALIDATE("Location Code", GetLocation(ServiceRequest));
                ItemJnlLine.Validate("Bin Code", AddOnSetup."SR Workshop Bin Code");

                ItemJnlLine.VALIDATE(Quantity, SRSparePart.Quantity);

                ItemJnlLine.VALIDATE("Unit of Measure Code", SRSparePart."Unit of Measure Code");

                ItemJnlLine."Source Code" := AddOnSetup."SR Item Source Code";
                Item1.Get(SRSparePart."Item No.");
                ItemJnlLine."Gen. Prod. Posting Group" := Item1."Gen. Prod. Posting Group";

                DimMgt.AddDimSource(DefaultDimSource, Database::Item, SRSparePart."Item No.");
                //DimMgt.AddDimSource(DefaultDimSource, Database::Customer, ServiceRequest."Customer No.");
                DimMgt.AddDimSource(DefaultDimSource, Database::"Responsibility Center", ServiceRequest."Responsibility Center");
                ItemJnlLine.CreateDim(DefaultDimSource);

                if ItemJnlLine.Quantity <> 0 then begin
                    ItemJnlPostLine.RunWithCheck(ItemJnlLine);
                    SRSparePart."Item Entry Doc No" := NextDocNo;
                    SRSparePart.Modify();
                end;
            until SRSparePart.Next() < 1;


        SRSparePart.Reset();
        SRSparePart.SetRange("Service Request No.", ServiceRequest."No.");
        SRSparePart.SetRange("Spare Status", SRSparePart."Spare Status"::Defective);
        SRSparePart.SetFilter("Item No.", '<>%1', '');
        SRSparePart.SetFilter("Item Entry Doc No", '=%1', '');
        if SRSparePart.FindSet(true) then
            repeat
                ItemJnlLine.Init();
                ItemJnlLine."Posting Date" := WorkDate();
                ItemJnlLine."Document Date" := WorkDate();

                ItemJnlLine."Document No." := NextDocNo;
                ItemJnlLine."Entry Type" := ItemJnlLine."Entry Type"::"Positive Adjmt.";

                ItemJnlLine."External Document No." := ServiceRequest."No.";

                ItemJnlLine.VALIDATE("Item No.", SRSparePart."Item No.");
                ItemJnlLine.Description := STRSUBSTNO(Text002, ServiceRequest.TableCaption(), ServiceRequest."No.");

                ItemJnlLine.VALIDATE("Location Code", GetLocation(ServiceRequest));
                ItemJnlLine.Validate("Bin Code", AddOnSetup."SR Workshop Bin Code");
                ItemJnlLine.VALIDATE(Quantity, SRSparePart.Quantity);

                ItemJnlLine.VALIDATE("Unit of Measure Code", SRSparePart."Unit of Measure Code");

                ItemJnlLine."Source Code" := AddOnSetup."SR Item Source Code";
                Item1.Get(SRSparePart."Item No.");
                ItemJnlLine."Gen. Prod. Posting Group" := Item1."Gen. Prod. Posting Group";

                DimMgt.AddDimSource(DefaultDimSource, Database::Item, SRSparePart."Item No.");
                DimMgt.AddDimSource(DefaultDimSource, Database::Customer, ServiceRequest."Customer No.");
                //DimMgt.AddDimSource(DefaultDimSource, Database::Item, SRSparePart."Item No.");
                ItemJnlLine.CreateDim(DefaultDimSource);

                if ItemJnlLine.Quantity <> 0 then begin
                    ItemJnlPostLine.RunWithCheck(ItemJnlLine);
                    SRSparePart."Item Entry Doc No" := NextDocNo;
                    SRSparePart.Modify();
                end;
            until SRSparePart.Next() < 1;
    end;


    procedure CreateSalesReturnOnServiceRequest(ServiceRequest: record "A01 Service Request")
    var
        SalesH: record "Sales header";
        SalesL: record "Sales Line";
        SRSparePart: record "A01 SR Spare Part";
    begin
        AddOnSetup.GetRecordOnce();
        ServiceRequest.TestField("Responsibility Center");
        ServiceRequest.TestField("Item No.");

        SalesH.Init();
        SalesH."Document Type" := SalesH."Document Type"::"Return Order";
        SalesH."No." := '';
        SalesH.Insert(true);

        SalesH.Validate("Sell-to Customer No.", ServiceRequest."Customer No.");
        SalesH.Validate("Sell-to Contact", ServiceRequest."Contact No.");
        SalesH."External Document No." := ServiceRequest."No.";
        SalesH.Validate("Responsibility Center", ServiceRequest."Responsibility Center");
        SalesH.Validate("Posting Date", WorkDate());
        SalesH.Modify();


        SalesL.Init();
        SalesL."Document Type" := SalesL."Document Type"::"Return Order";
        SalesL."Document No." := SalesH."No.";
        SalesL.Validate(Type, SalesL.Type::Item);
        SalesL.VALIDATE("Location Code", GetLocation(ServiceRequest));
        SalesL.Validate("Bin Code", AddOnSetup."SR Workshop Bin Code");
        SalesL.Validate("No.", ServiceRequest."Item No.");
        SalesL.Validate(Quantity, SRSparePart.Quantity);
        SalesL.Validate("Unit of Measure Code", SRSparePart."Unit of Measure Code");
        SalesL.Validate("Unit Price", 0);
        SalesL.insert();

    end;

    local procedure GetLocation(ServiceHeader: record "A01 Service Request"): Code[20]
    var
        RespCenter: Record "Responsibility Center";
    begin
        RespCenter.Get(ServiceHeader."Responsibility Center");
        exit(RespCenter."Location Code");
    end;

    var
        AddOnSetup: record "A01 Afk Setup";
        NoSeriesMgt: Codeunit NoSeriesManagement;
        DimMgt: Codeunit DimensionManagement;



}
