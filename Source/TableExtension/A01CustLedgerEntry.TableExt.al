tableextension 50040 "A01 Cust. Ledger Entry" extends "Cust. Ledger Entry"
{
    fields
    {
        modify("Due Date")
        {
            trigger OnAfterValidate()
            var
            begin
                if (IsMainEntry()) then
                    if (confirm(ConfirmLbl)) then
                        ModifyReport.UpdateDueDateOnAmortisationLines(Rec)
                    else
                        ModifyReport.UpdateDueDateOnOneAmortisationLine(Rec)
                else
                    ModifyReport.UpdateDueDateOnOneAmortisationLine(Rec);
            end;
        }
    }

    var
        ModifyReport: report "A01 Update Credit Amort Line";
        TresoMgt: Codeunit "A01 Treso Mgt";
        ConfirmLbl: Label 'The dates will be changed for the other deadlines. Do you wish to continue?';

    local procedure IsMainEntry(): Boolean
    var
        SalesInvoiceH: Record "Sales Invoice Header";
    begin
        if (SalesInvoiceH.get("Document No.")) then
            if (TresoMgt.IsMultiMeadlinesInvoice(SalesInvoiceH."Payment Terms Code")) then
                if ("Document No." = "External Document No.") then
                    exit(true);
    end;
}
