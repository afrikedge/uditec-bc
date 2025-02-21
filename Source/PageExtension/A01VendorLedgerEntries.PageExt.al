pageextension 50056 "A01 Vendor Ledger Entries" extends "Vendor Ledger Entries"
{
    layout
    {
    }

    actions
    {
        addbefore("Show Document")
        {
            action("A01 Recu fournisseur")
            {
                ToolTip = 'Imprimer le reçu de décaissement';
                Caption = 'Imprimer le reçu de décaissement';
                Image = PrintForm;
                ApplicationArea = All;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;

                trigger OnAction()
                var
                    Receipt: Record "Vendor Ledger Entry";
                begin
                    Receipt.SetRange("Document No.", Rec."Document No.");
                    Receipt.SetRange("Entry No.", Rec."Entry No.");
                    Report.Run(50042, true, false, Receipt);
                end;
            }
        }
    }
}