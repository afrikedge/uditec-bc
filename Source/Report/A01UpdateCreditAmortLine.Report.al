report 50032 "A01 Update Credit Amort Line"
{
    ApplicationArea = All;
    Caption = 'Update Credit Amort Line';
    UsageCategory = Tasks;
    ProcessingOnly = true;
    Permissions = tabledata "Cust. Ledger Entry" = rm;
    dataset
    {
        dataitem(CustLedgerEntryItem; "Cust. Ledger Entry")
        {
            trigger OnPreDataItem()
            var
            begin
                TotalLines := CustLedgerEntryItem.Count;
                Window.OPEN(LblErr002);
            end;

            trigger OnAfterGetRecord()
            begin
                LineNo += 1;
                Window.UPDATE(1, ROUND(LineNo / TotalLines * 10000, 1));

                ProcessCustLedgerEntry(CustLedgerEntryItem);
            end;




            trigger OnPostDataItem()
            var
                Cust: Record customer;
                DebtStatus: Code[20];
            begin

                TotalLines := CustLedgerEntryItem.Count;
                LineNo := 0;
                if Cust.FindSet() then
                    repeat
                        LineNo += 1;
                        Window.UPDATE(1, ROUND(LineNo / TotalLines * 10000, 1));

                        DebtStatus := Cust.A01CalcCustStatus();
                        if (Cust."A01 Calc Risk Level" <> DebtStatus) then begin
                            Cust."A01 Calc Risk Level" := DebtStatus;
                            Cust.Modify();
                        end;
                    until Cust.Next() < 1;

                Window.CLOSE();
                MESSAGE(LblErr003);
            end;
        }

    }
    requestpage
    {
        layout
        {
            area(content)
            {
                group(GroupName)
                {
                }
            }
        }
        actions
        {
            area(processing)
            {
            }
        }
    }
    var
        TotalLines: Integer;
        LineNo: Integer;
        Window: Dialog;
        LblErr002: Label 'Processing @1@@@@@@@@@@@@@@@@@@@@@@@@@@@@\';
        LblErr003: Label 'End of process !';

    local procedure Min(Amt1: Decimal; Amt2: Decimal): Decimal
    var
    begin
        if (Amt1 < Amt2) then exit(Amt1);
        exit(Amt2);
    end;

    local procedure GetPaymentEntryId(InitialDetailEntry: record "Detailed Cust. Ledg. Entry"): Integer
    var
        DetailCustLedgEntry: record "Detailed Cust. Ledg. Entry";
    begin
        if (InitialDetailEntry."Application No." > 0) then
            if DetailCustLedgEntry.Get(InitialDetailEntry."Application No.") then
                exit(DetailCustLedgEntry."Cust. Ledger Entry No.");
        exit(InitialDetailEntry."Applied Cust. Ledger Entry No.");
    end;

    procedure ProcessCustLedgerEntry(CustLedgerEntry: record "Cust. Ledger Entry")
    var
        DetailledPaymentEntry: Record "Detailed Cust. Ledg. Entry";
        CreditAmortLine: Record "A01 Credit Depreciation Table";
        PayEntry: Record "Cust. Ledger Entry";
        LinePaymentAmt: Decimal;
        RemainingAmt: Decimal;
        AmountToPay: Decimal;
        monthlyPayment: Decimal;
    begin
        CustLedgerEntry.CalcFields(Amount, "Remaining Amount");
        LinePaymentAmt := Abs(CustLedgerEntry.Amount - CustLedgerEntry."Remaining Amount");

        CreditAmortLine.Reset();
        CreditAmortLine.SetRange("Document Type", CreditAmortLine."Document Type"::"Posted Sales invoice");
        CreditAmortLine.SetRange("Document No.", CustLedgerEntry."Document No.");
        CreditAmortLine.modifyall("Paid Amount", 0);
        CreditAmortLine.modifyall("Payment Date", 0D);


        DetailledPaymentEntry.Reset();
        DetailledPaymentEntry.SetCurrentKey("Cust. Ledger Entry No.", "Entry Type", "Posting Date");
        DetailledPaymentEntry.SetRange("Cust. Ledger Entry No.", CustLedgerEntry."Entry No.");
        DetailledPaymentEntry.SetRange("Entry Type", DetailledPaymentEntry."Entry Type"::Application);
        if DetailledPaymentEntry.FindSet(true) then
            repeat
                LinePaymentAmt := Abs(DetailledPaymentEntry.Amount);
                if ((not DetailledPaymentEntry.Unapplied) and (LinePaymentAmt > 0)) then begin
                    CreditAmortLine.Reset();
                    CreditAmortLine.SetRange("Document Type", CreditAmortLine."Document Type"::"Posted Sales invoice");
                    //CreditAmortLine.SetRange("Document No.", CustLedgerEntry."Document No.");
                    CreditAmortLine.SetRange("Cust Ledger Entry No.", CustLedgerEntry."Entry No.");
                    if CreditAmortLine.FindSet() then
                        repeat

                            //RemainingAmt := CreditAmortLine."Monthly payment" - CreditAmortLine."Paid Amount";
                            monthlyPayment := CreditAmortLine."Amount to pay";
                            RemainingAmt := monthlyPayment - CreditAmortLine."Paid Amount";

                            if ((RemainingAmt > 0) and (LinePaymentAmt > 0)) then begin

                                AmountToPay := Min(RemainingAmt, LinePaymentAmt);

                                CreditAmortLine."Paid Amount" += AmountToPay;

                                LinePaymentAmt := LinePaymentAmt - AmountToPay;

                                if (CreditAmortLine."Dimension Set ID" = 0) then
                                    CreditAmortLine."Dimension Set ID" := CustLedgerEntry."Dimension Set ID";
                                if (CreditAmortLine."Cust Ledger Entry No." = 0) then
                                    CreditAmortLine."Cust Ledger Entry No." := CustLedgerEntry."Entry No.";

                                CreditAmortLine.Closed := CreditAmortLine."Paid Amount" = monthlyPayment;

                                if (monthlyPayment = CreditAmortLine."Paid Amount") then begin
                                    //if (PayEntry.get(GetPaymentEntryId(DetailledPaymentEntry))) then
                                    //    CreditAmortLine."Payment Date" := PayEntry."Posting Date";
                                    CreditAmortLine."Payment Date" := DetailledPaymentEntry."Posting Date";
                                end;

                                if (CreditAmortLine."Customer No." = '') then
                                    CreditAmortLine."Customer No." := CustLedgerEntry."Customer No.";

                                CreditAmortLine.Modify();

                            end;

                        until ((CreditAmortLine.Next() < 1) or (LinePaymentAmt <= 0));
                end;
            until DetailledPaymentEntry.Next() < 1;
    end;

    procedure UpdateDueDateOnAmortisationLines(CustLedgerEntry: record "Cust. Ledger Entry")
    var
        CreditAmortLine: Record "A01 Credit Depreciation Table";
        NextCustLedgerEntry: record "Cust. Ledger Entry";
        LineDueDate: Date;

    begin
        LineDueDate := CustLedgerEntry."Due Date";
        CreditAmortLine.Reset();
        CreditAmortLine.SetRange("Document Type", CreditAmortLine."Document Type"::"Posted Sales invoice");
        CreditAmortLine.SetRange("Document No.", CustLedgerEntry."Document No.");
        if CreditAmortLine.FindSet(true) then
            repeat
                if (CreditAmortLine."Customer No." = CustLedgerEntry."Customer No.") then begin
                    CreditAmortLine."Due Date" := LineDueDate;
                    CreditAmortLine.Modify();
                    LineDueDate := CalcDate('<1M>', LineDueDate);
                end;
            until CreditAmortLine.Next() < 1;

        if (CustLedgerEntry."External Document No." <> '') then begin
            LineDueDate := CustLedgerEntry."Due Date";
            NextCustLedgerEntry.Reset();
            NextCustLedgerEntry.SetCurrentKey("External Document No.");
            NextCustLedgerEntry.SetRange("External Document No.", CustLedgerEntry."External Document No.");
            if NextCustLedgerEntry.FindSet(true) then
                repeat
                    if ((NextCustLedgerEntry."Customer No." = CustLedgerEntry."Customer No.") and (NextCustLedgerEntry."Entry No." <> CustLedgerEntry."Entry No.")) then begin
                        NextCustLedgerEntry."Due Date" := LineDueDate;
                        NextCustLedgerEntry.Modify();
                        CODEUNIT.RUN(CODEUNIT::"Cust. Entry-Edit", NextCustLedgerEntry);
                    end;
                    LineDueDate := CalcDate('<1M>', LineDueDate);
                until NextCustLedgerEntry.Next() < 1;
        end;

    end;

    procedure UpdateDueDateOnOneAmortisationLine(CustLedgerEntry: record "Cust. Ledger Entry")
    var
        CreditAmortLine: Record "A01 Credit Depreciation Table";
        LineDueDate: Date;
    begin
        LineDueDate := CustLedgerEntry."Due Date";

        CreditAmortLine.Reset();
        CreditAmortLine.SetCurrentKey("Cust Ledger Entry No.");
        CreditAmortLine.SetRange("Cust Ledger Entry No.", CustLedgerEntry."Entry No.");
        if CreditAmortLine.FindFirst() then begin
            CreditAmortLine."Due Date" := LineDueDate;
            CreditAmortLine.Modify();
        end;

        CreditAmortLine.Reset();
        CreditAmortLine.SetRange("Document Type", CreditAmortLine."Document Type"::"Posted Sales invoice");
        CreditAmortLine.SetRange("Document No.", CustLedgerEntry."Document No.");
        if CreditAmortLine.FindFirst() then
            if (CreditAmortLine."Customer No." = CustLedgerEntry."Customer No.") then begin
                CreditAmortLine."Due Date" := LineDueDate;
                CreditAmortLine.Modify();
            end;
    end;

}
