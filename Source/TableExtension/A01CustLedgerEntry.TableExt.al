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
        CreditAmortLine: Record "A01 Credit Depreciation Table";
        SalesInvoiceH: Record "Sales Invoice Header";
    begin
        if (SalesInvoiceH.get("Document No.")) then
            if (TresoMgt.IsMultiMeadlinesInvoice(SalesInvoiceH."Payment Terms Code")) then
                if ("Document No." = "External Document No.") then
                    exit(true);

        CreditAmortLine.Reset();
        CreditAmortLine.SetRange("Document Type", CreditAmortLine."Document Type"::"Posted Sales invoice");
        CreditAmortLine.SetRange("Document No.", "Document No.");
        if (CreditAmortLine.Count > 1) then
            exit(true);
    end;
}
