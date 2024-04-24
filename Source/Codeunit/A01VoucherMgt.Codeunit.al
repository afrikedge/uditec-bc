/// <summary>
/// Codeunit A01 Voucher Mgt (ID 50017).
/// </summary>
codeunit 50017 "A01 Voucher Mgt"
{
    var
        AddOnSetup: Record "A01 Afk Setup";

    procedure PostVoucherEmission(ItemLedgerEntry: Record "Item Ledger Entry"; var InventoryPostingToGL: Codeunit "Inventory Posting To G/L"; VoucherAmount: decimal)
    var
        VoucherLedgerEntry: Record "A01 Purchase Voucher Entry";
        Voucher: Record "A01 Purchase Voucher";
        isApplicable: Boolean;
        ErrLblNoValue: Label 'Voucher %1 must not have a zero value', Comment = '%1=Bon';
        NextEntryId: Integer;
    begin

        if (ItemLedgerEntry."Entry Type" = ItemLedgerEntry."Entry Type"::Sale) then
            //if (ItemLedgerEntry."Document Type" = ItemLedgerEntry."Document Type"::"Sales Shipment") then
                isApplicable := true;

        if (ItemLedgerEntry."Entry Type" = ItemLedgerEntry."Entry Type"::Purchase) then
            if (ItemLedgerEntry."Document Type" = ItemLedgerEntry."Document Type"::"Purchase Return Shipment") then
                isApplicable := true;

        //if (ItemLedgerEntry."Entry Type" = ItemLedgerEntry."Entry Type"::"Negative Adjmt.") then
        //    isApplicable := true;

        if (not isApplicable) then
            exit;


        AddOnSetup.GetRecordOnce();
        AddOnSetup.TestField("Item Category Code (Voucher)");
        if (ItemLedgerEntry."Item Category Code" <> AddOnSetup."Item Category Code (Voucher)") then
            exit;

        ItemLedgerEntry.TestField("Serial No.");

        if (VoucherAmount = 0) then
            error(ErrLblNoValue, ItemLedgerEntry."Serial No.");

        Voucher.Init();
        Voucher."No." := ItemLedgerEntry."Serial No.";
        Voucher."Initial Amount" := VoucherAmount;
        Voucher."Item Ledger Entry Id" := ItemLedgerEntry."Entry No.";
        Voucher."Emission Date" := Today;
        Voucher."Emission By" := CopyStr(UserId, 1, 50);
        Voucher.Insert(true);


        NextEntryId := GetNextVoucherLedgerEntry();

        VoucherLedgerEntry.Init();
        VoucherLedgerEntry."Entry No." := NextEntryId;
        VoucherLedgerEntry."Document No." := ItemLedgerEntry."Document No.";
        VoucherLedgerEntry."Document Type" := ItemLedgerEntry."Document Type";
        VoucherLedgerEntry."Entry Type" := VoucherLedgerEntry."Entry Type"::Emission;
        VoucherLedgerEntry."Posting Date" := ItemLedgerEntry."Posting Date";
        VoucherLedgerEntry.Amount := VoucherAmount;
        VoucherLedgerEntry."Voucher No." := Voucher."No.";
        VoucherLedgerEntry."Item Ledger Entry No." := ItemLedgerEntry."Entry No.";
        VoucherLedgerEntry.Insert(true);

        //if (ItemLedgerEntry."Entry Type" = ItemLedgerEntry."Entry Type"::"Negative Adjmt.") then
        if (ItemLedgerEntry."Entry Type" = ItemLedgerEntry."Entry Type"::Sale) then
            if (ItemLedgerEntry."Document Type" = ItemLedgerEntry."Document Type"::" ") then
                PostEmissionGLEntryOnNegAdjustment(ItemLedgerEntry, InventoryPostingToGL, VoucherAmount);

    end;

    local procedure PostEmissionGLEntryOnNegAdjustment(ItemLedgerEntry: Record "Item Ledger Entry"; var InventoryPostingToGL: Codeunit "Inventory Posting To G/L"; VoucherAmount: decimal)
    var
        //VoucherLedgerEntry: Record "A01 Purchase Voucher Entry";
        GenJnlLine: Record "Gen. Journal Line";
        SourceCodeSetup: Record "Source Code Setup";

    begin
        AddOnSetup.GetRecordOnce();
        AddOnSetup.TestField(AddOnSetup."Charge Account (Voucher)");
        AddOnSetup.TestField(AddOnSetup."Suspense Account (Voucher)");
        SourceCodeSetup.Get();

        CLEAR(GenJnlLine);
        GenJnlLine."Document Type" := GenJnlLine."Document Type"::" ";
        //GenJnlLine."FA Posting Type" := GenJnlLine."FA Posting Type"::"Acquisition Cost";
        GenJnlLine."Document Date" := ItemLedgerEntry."Posting Date";
        GenJnlLine."Posting Date" := ItemLedgerEntry."Posting Date";
        //GenJnlLine."Document No." := NosSeriesMgt.GetNextNo(AddOnSetup."Debit Notes Nos.",GenJnlLine."Posting Date",TRUE);
        GenJnlLine."Document No." := ItemLedgerEntry."Document No.";
        GenJnlLine."Account Type" := GenJnlLine."Account Type"::"G/L Account";
        GenJnlLine."Gen. Posting Type" := GenJnlLine."Gen. Posting Type"::" ";
        GenJnlLine.VALIDATE(GenJnlLine."Account No.", AddOnSetup."Charge Account (Voucher)");
        //GenJnlLine.VALIDATE(GenJnlLine."Depreciation Book Code", AddOnSetup."Fiscal Depreciation Book");
        GenJnlLine.Description := ItemLedgerEntry.Description;
        GenJnlLine.VALIDATE(GenJnlLine.Amount, VoucherAmount);

        GenJnlLine."External Document No." := ItemLedgerEntry."External Document No.";
        GenJnlLine."Source Code" := SourceCodeSetup."Item Journal";
        GenJnlLine.SetHideValidation(true);
        GenJnlLine."Bal. Account Type" := GenJnlLine."Bal. Account Type"::"G/L Account";

        GenJnlLine.VALIDATE("Bal. Account No.", AddOnSetup."Suspense Account (Voucher)");
        //GenJnlLine."Bal. Gen. Posting Type" := GenJnlLine."Bal. Gen. Posting Type"::" ";
        //GenJnlLine."Bal. VAT Prod. Posting Group" := AddOnSetup."NoVAT Prod. Posting Group";

        GenJnlLine."Shortcut Dimension 1 Code" := ItemLedgerEntry."Global Dimension 1 Code";
        GenJnlLine."Shortcut Dimension 2 Code" := ItemLedgerEntry."Global Dimension 2 Code";
        GenJnlLine."Dimension Set ID" := ItemLedgerEntry."Dimension Set ID";

        //GenJnlPostLine.RunWithCheck(GenJnlLine);
        InventoryPostingToGL.PostGenJnlLine(GenJnlLine);

    end;

    local procedure GetNextVoucherLedgerEntry(): Integer
    var
        VoucherLedgerEntry: Record "A01 Purchase Voucher Entry";
    begin
        VoucherLedgerEntry.Reset();
        if (VoucherLedgerEntry.FindLast()) then
            exit(VoucherLedgerEntry."Entry No." + 1)
        else
            exit(1);
    end;

    procedure PostVoucherConsumption(GenJnlLine: Record "Gen. Journal Line")
    var
        Voucher: Record "A01 Purchase Voucher";
        VoucherLedgerEntry: Record "A01 Purchase Voucher Entry";
        Err01Lbl: Label 'The voucher balance %1 is insufficient for this operation', Comment = '%1=balance';
        Err01Lbl2: Label 'Voucher %1 expired on %2', Comment = '%1=bon, %2=expiration';
        NextEntryId: Integer;
    begin

        if (GenJnlLine."Account Type" <> GenJnlLine."Account Type"::Customer) then
            exit;
        if (GenJnlLine."Document Type" <> GenJnlLine."Document Type"::Payment) then
            exit;

        AddOnSetup.GetRecordOnce();
        AddOnSetup.TestField(AddOnSetup."Payment Method (Voucher)");

        if (GenJnlLine."Payment Method Code" <> AddOnSetup."Payment Method (Voucher)") then
            exit;

        GenJnlLine.TestField("Payment Reference");

        Voucher.Get(GenJnlLine."Payment Reference");

        if (Voucher."Validity Date" <> 0D) then
            if (Voucher."Validity Date" < Today) then
                Error(Err01Lbl2, Voucher."No.", Voucher."Validity Date");

        Voucher.CalcFields(Balance);

        if (Voucher.Balance < Abs(GenJnlLine.Amount)) then
            Error(Err01Lbl, Voucher.Balance);

        NextEntryId := GetNextVoucherLedgerEntry();

        VoucherLedgerEntry.Init();
        VoucherLedgerEntry."Entry No." := NextEntryId;
        VoucherLedgerEntry."Document No." := GenJnlLine."Document No.";
        VoucherLedgerEntry."Document Type" := VoucherLedgerEntry."Document Type"::" ";
        VoucherLedgerEntry."Entry Type" := VoucherLedgerEntry."Entry Type"::Consumption;
        VoucherLedgerEntry."Posting Date" := GenJnlLine."Posting Date";
        VoucherLedgerEntry.Amount := -Abs(GenJnlLine.Amount);
        VoucherLedgerEntry."Voucher No." := Voucher."No.";
        VoucherLedgerEntry.Insert(true);
    end;
}
