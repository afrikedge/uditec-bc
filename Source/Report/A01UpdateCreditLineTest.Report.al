report 50036 "A01 Update Credit Line Test"
{
    ApplicationArea = All;
    Caption = 'Update Credit Line Test';
    //UsageCategory = Tasks;

    dataset
    {
        dataitem(Customer; Customer)
        {
            RequestFilterFields = "No.";
            trigger OnAfterGetRecord()
            var
                CustLedgerEntry: record "Cust. Ledger Entry";
                DebtStatus: Code[20];
            begin
                CustLedgerEntry.SetCurrentKey("Customer No.", "Posting Date", "Currency Code");
                CustLedgerEntry.SetRange("Customer No.", Customer."No.");
                if CustLedgerEntry.FindSet() then
                    repeat
                        UpdateCreditMgt.ProcessCustLedgerEntry(CustLedgerEntry);
                    until CustLedgerEntry.Next() < 1;

                DebtStatus := Customer.CalcCustStatus();
                if (Customer."A01 Calc Risk Level" <> DebtStatus) then begin
                    Customer."A01 Calc Risk Level" := DebtStatus;
                    Customer.Modify();
                end;
            end;

        }
    }
    requestpage
    {
        layout
        {
            area(Content)
            {
                group(GroupName)
                {
                }
            }
        }
        actions
        {
            area(Processing)
            {
            }
        }
    }
    var
        UpdateCreditMgt: report "A01 Update Credit Amort Line";
}
