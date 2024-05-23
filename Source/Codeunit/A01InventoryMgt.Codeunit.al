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

}
