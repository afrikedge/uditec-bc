report 50032 "A01 Update Credit Amort Line"
{
    ApplicationArea = All;
    Caption = 'Update Credit Amort Line';
    UsageCategory = Tasks;
    ProcessingOnly = true;
    dataset
    {
        dataitem(CustLedgerEntry; "Cust. Ledger Entry")
        {
            trigger OnPreDataItem()
            var
            begin
                TotalLines := CustLedgerEntry.Count;
                Window.OPEN(LblErr002);
            end;

            trigger OnAfterGetRecord()
            var
                DetailledPaymentEntry: Record "Detailed Cust. Ledg. Entry";
                CreditAmortLine: Record "A01 Credit Depreciation Table";
                PayEntry: Record "Cust. Ledger Entry";
                LinePaymentAmt: Decimal;
                RemainingAmt: Decimal;
                AmountToPay: Decimal;
            begin
                LineNo += 1;
                Window.UPDATE(1, ROUND(LineNo / TotalLines * 10000, 1));

                CustLedgerEntry.CalcFields(Amount, "Remaining Amount");
                LinePaymentAmt := Abs(CustLedgerEntry.Amount - CustLedgerEntry."Remaining Amount");

                CreditAmortLine.Reset();
                CreditAmortLine.SetRange("Document Type", CreditAmortLine."Document Type"::"Posted Sales invoice");
                CreditAmortLine.SetRange("Document No.", CustLedgerEntry."Document No.");
                CreditAmortLine.modifyall("Paid Amount", 0);
                CreditAmortLine.modifyall("Payment Date", 0D);


                // DetailledPaymentEntry.Reset();
                // DetailledPaymentEntry.SetCurrentKey("Applied Cust. Ledger Entry No.", "Entry Type", "Posting Date");
                // DetailledPaymentEntry.SetRange("Applied Cust. Ledger Entry No.", CustLedgerEntry."Entry No.");
                // DetailledPaymentEntry.SetRange("Entry Type", DetailledPaymentEntry."Entry Type"::Application);
                // DetailledPaymentEntry.SetRange("Initial Document Type", DetailledPaymentEntry."Initial Document Type"::Payment);
                // //DetailledPaymentEntry.SetRange(A01CreditProcessed,false);

                DetailledPaymentEntry.Reset();
                DetailledPaymentEntry.SetCurrentKey("Cust. Ledger Entry No.", "Entry Type", "Posting Date");
                DetailledPaymentEntry.SetRange("Cust. Ledger Entry No.", CustLedgerEntry."Entry No.");
                DetailledPaymentEntry.SetRange("Entry Type", DetailledPaymentEntry."Entry Type"::Application);
                if DetailledPaymentEntry.FindSet(true) then
                    repeat
                        LinePaymentAmt := Abs(DetailledPaymentEntry.Amount);
                        if (LinePaymentAmt > 0) then begin
                            CreditAmortLine.Reset();
                            CreditAmortLine.SetRange("Document Type", CreditAmortLine."Document Type"::"Posted Sales invoice");
                            CreditAmortLine.SetRange("Document No.", CustLedgerEntry."Document No.");
                            if CreditAmortLine.FindSet() then
                                repeat

                                    RemainingAmt := CreditAmortLine."Monthly payment" - CreditAmortLine."Paid Amount";

                                    if (RemainingAmt > 0) then begin

                                        AmountToPay := Min(RemainingAmt, LinePaymentAmt);

                                        CreditAmortLine."Paid Amount" += AmountToPay;

                                        LinePaymentAmt := LinePaymentAmt - AmountToPay;

                                        if (CreditAmortLine."Dimension Set ID" = 0) then
                                            CreditAmortLine."Dimension Set ID" := CustLedgerEntry."Dimension Set ID";
                                        if (CreditAmortLine."Cust Ledger Entry No." = 0) then
                                            CreditAmortLine."Cust Ledger Entry No." := CustLedgerEntry."Entry No.";

                                        CreditAmortLine.Closed := CreditAmortLine."Paid Amount" = CreditAmortLine."Monthly payment";

                                        if (CreditAmortLine."Monthly payment" = CreditAmortLine."Paid Amount") then begin
                                            if (PayEntry.get(GetPaymentEntryId(DetailledPaymentEntry))) then
                                                CreditAmortLine."Payment Date" := PayEntry."Posting Date";
                                        end;

                                        if (CreditAmortLine."Customer No." = '') then
                                            CreditAmortLine."Customer No." := CustLedgerEntry."Customer No.";

                                        CreditAmortLine.Modify();

                                    end;

                                until CreditAmortLine.Next() < 1;
                        end;
                    until DetailledPaymentEntry.Next() < 1;
            end;




            trigger OnPostDataItem()
            var
                Cust: Record customer;
                DebtStatus: Code[20];
            begin

                TotalLines := CustLedgerEntry.Count;
                LineNo := 0;
                if Cust.FindSet() then
                    repeat
                        LineNo += 1;
                        Window.UPDATE(1, ROUND(LineNo / TotalLines * 10000, 1));

                        DebtStatus := Cust.CalcCustStatus();
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
}
