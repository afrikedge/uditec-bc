codeunit 50018 "A01 General Legder Mgt"
{
    Permissions = tabledata 21 = rm;
    procedure CheckCashboxClosingDateOnGenJnlLine(GenJnlLine: Record "Gen. Journal Line")
    var
        BankAcc: Record "Bank Account";
        CashboxClosingLine: Record "A01 Cashbox closing Line";
        Err001: Label 'You cannot validate this operation on this date. There is a cash closing validated on the %1 for this point of sale.', Comment = '%1=date';
    begin
        if (GenJnlLine."Account Type" = GenJnlLine."Account Type"::"Bank Account") then begin
            BankAcc.get(GenJnlLine."Account No.");
            BankAcc.TestField("Global Dimension 1 Code");

            CashboxClosingLine.Reset();
            CashboxClosingLine.SetRange("Store Code", BankAcc."Global Dimension 1 Code");
            CashboxClosingLine.setfilter("Closing Date", '>=%1', GenJnlLine."Posting Date");
            CashboxClosingLine.SetRange(Status, CashboxClosingLine.Status::Posted);
            if (CashboxClosingLine.FindFirst()) then
                Error(Err001, CashboxClosingLine."Closing Date");
            // insert newline here
        end;
        if (GenJnlLine."Bal. Account Type" = GenJnlLine."Account Type"::"Bank Account") then begin
            BankAcc.get(GenJnlLine."Bal. Account No.");
            BankAcc.TestField("Global Dimension 1 Code");

            CashboxClosingLine.Reset();
            CashboxClosingLine.SetRange("Store Code", BankAcc."Global Dimension 1 Code");
            CashboxClosingLine.setfilter("Closing Date", '>=%1', GenJnlLine."Posting Date");
            CashboxClosingLine.SetRange(Status, CashboxClosingLine.Status::Posted);
            if (CashboxClosingLine.FindFirst()) then
                Error(Err001, CashboxClosingLine."Closing Date");
        end;
    end;

    procedure CheckCashboxClosingDateOnCustSettlement(CustSettlement: Record "A01 Payment Document")
    var
        CashboxClosingLine: Record "A01 Cashbox closing Line";
        RespCenter: Record "Responsibility Center";
        UserSetup: Record "User Setup";
        Err001: Label 'You cannot validate this operation on this date. There is a cash closing validated on the %1 for this point of sale.', Comment = '%1=date';
    begin

        UserSetup.get(UserId);
        if (UserSetup."A01 Can Bypass Closed Period") then exit;

        CustSettlement.TestField("Responsibility Center");
        CustSettlement.TestField("Posting Date");
        RespCenter.Get(CustSettlement."Responsibility Center");
        RespCenter.TestField("Global Dimension 1 Code");

        CashboxClosingLine.Reset();
        CashboxClosingLine.SetRange("Store Code", RespCenter."Global Dimension 1 Code");
        CashboxClosingLine.setfilter("Closing Date", '>=%1', CustSettlement."Posting Date");
        CashboxClosingLine.SetRange(Status, CashboxClosingLine.Status::Posted);
        if (CashboxClosingLine.FindFirst()) then
            Error(Err001, CashboxClosingLine."Closing Date");
    end;

    [TryFunction]
    procedure PostApplication(i: Integer; DocumentNo: Code[20]; DocumentNo2: Code[20]; ApplyAmount: Decimal; ApplyDate: Date)
    var
        CustLedgEntry: Record "Cust. Ledger Entry";
        ApplyUnapplyParameters: Record "Apply Unapply Parameters";
        CustLedgEntry2: Record "Cust. Ledger Entry";
        //ApplyCu: Codeunit "CustEntry-Apply Posted Entries";
        ApplyCu: Codeunit "A01 Lettrage Mgt";
        LblError: Label 'The customer code is different on the documents %1 - %2 to be lettered. Line %3', Comment = '%1=line %2=line %3=line';
    begin
        CustLedgEntry.SetCurrentKey("Document No.");
        CustLedgEntry.SETRANGE("Document No.", DocumentNo);
        if (not CustLedgEntry.FindFirst()) then exit;
        if (not CustLedgEntry.Open) then exit;

        CustLedgEntry2.SetCurrentKey("Document No.");
        CustLedgEntry2.SetRange("Document No.", DocumentNo2);
        if (not CustLedgEntry2.FindFirst()) then exit;
        if (not CustLedgEntry2.Open) then exit;

        CustLedgEntry."Applies-to ID" := Copystr('USERID' + Format(i), 1, 50);
        IF (CustLedgEntry.Positive) THEN
            CustLedgEntry."Amount to Apply" := ABS(ApplyAmount)
        ELSE
            CustLedgEntry."Amount to Apply" := -ABS(ApplyAmount);
        CustLedgEntry.Modify();

        CustLedgEntry2."Applies-to ID" := CustLedgEntry."Applies-to ID";
        CustLedgEntry2."Amount to Apply" := -CustLedgEntry."Amount to Apply";
        CustLedgEntry2.Modify();

        if (CustLedgEntry2."Customer No." <> CustLedgEntry."Customer No.") then
            error(LblError, DocumentNo, DocumentNo2, i);

        ApplyUnapplyParameters."Posting Date" := ApplyDate;

        ApplyCu.Apply(CustLedgEntry, ApplyUnapplyParameters);
        //exit(true);
    end;
}
