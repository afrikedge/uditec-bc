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
                PaymentEntry: Record "Detailed Cust. Ledg. Entry";
                CreditAmortLine: Record "A01 Credit Depreciation Table";
                PaidAmount: Decimal;
            begin
                LineNo += 1;
                Window.UPDATE(1, ROUND(LineNo / TotalLines * 10000, 1));

                CustLedgerEntry.CalcFields(Amount, "Remaining Amount");
                PaidAmount := Abs(CustLedgerEntry.Amount - CustLedgerEntry."Remaining Amount");


                // PaymentEntry.


                CreditAmortLine.Reset();
                CreditAmortLine.SetRange("Document Type", CreditAmortLine."Document Type"::"Posted Sales invoice");
                CreditAmortLine.SetRange("Document No.", CustLedgerEntry."Document No.");
                if CreditAmortLine.FindSet() then
                    repeat
                        if (PaidAmount > 0) then begin
                            if (CreditAmortLine."Monthly payment" < PaidAmount) then
                                CreditAmortLine."Paid Amount" := CreditAmortLine."Monthly payment"
                            else
                                CreditAmortLine."Paid Amount" := PaidAmount;
                            PaidAmount := PaidAmount - CreditAmortLine."Paid Amount";
                        end;
                        if (CreditAmortLine."Dimension Set ID" = 0) then
                            CreditAmortLine."Dimension Set ID" := CustLedgerEntry."Dimension Set ID";
                        if (CreditAmortLine."Cust Ledger Entry No." = 0) then
                            CreditAmortLine."Cust Ledger Entry No." := CustLedgerEntry."Entry No.";

                        CreditAmortLine.Closed := CreditAmortLine."Paid Amount" = CreditAmortLine."Monthly payment";
                        CreditAmortLine.Modify();
                    until CreditAmortLine.Next() < 1;
            end;

            trigger OnPostDataItem()
            begin
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
}
