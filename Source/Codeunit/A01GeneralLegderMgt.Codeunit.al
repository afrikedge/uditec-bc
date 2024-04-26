codeunit 50018 "A01 General Legder Mgt"
{
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
        Err001: Label 'You cannot validate this operation on this date. There is a cash closing validated on the %1 for this point of sale.', Comment = '%1=date';
    begin
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
}
