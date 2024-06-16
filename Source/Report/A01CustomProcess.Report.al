report 50035 A01CustomProcess
{
    ApplicationArea = All;
    Caption = 'Custom process';
    UsageCategory = Tasks;
    ProcessingOnly = true;
    dataset
    {
        dataitem("CreditDepreciationTable"; "A01 Credit Depreciation Table")
        {
            trigger OnPreDataItem()
            var
            begin
                TotalLines := CreditDepreciationTable.Count;
                Window.OPEN(LblErr002);
            end;

            trigger OnAfterGetRecord()
            var
            // CreditAmortLine: Record "A01 Credit Depreciation Table";
            // PaidAmount: Decimal;
            begin
                LineNo += 1;
                Window.UPDATE(1, ROUND(LineNo / TotalLines * 10000, 1));

                if (CustLedgerEntry.get(CreditDepreciationTable."Cust Ledger Entry No.")) then begin
                    CreditDepreciationTable."Customer No." := CustLedgerEntry."Customer No.";
                    CreditDepreciationTable.Modify();
                end;
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
        CustLedgerEntry: record "Cust. Ledger Entry";
        TotalLines: Integer;
        LineNo: Integer;
        Window: Dialog;
        LblErr002: Label 'Processing @1@@@@@@@@@@@@@@@@@@@@@@@@@@@@\';
        LblErr003: Label 'End of process !';
}

