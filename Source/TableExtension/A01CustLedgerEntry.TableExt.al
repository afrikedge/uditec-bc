tableextension 50040 "A01 Cust. Ledger Entry" extends "Cust. Ledger Entry"
{
    fields
    {
        modify("Due Date")
        {
            trigger OnAfterValidate()
            var
                Cust: Record customer;
            begin
                if (Cust.Get("Customer No.")) then
                    Cust.UpdateDueDateOnAmortisationLines("Due Date", "Document No.");
            end;
        }
    }
}
