pageextension 50044 "A01 Customer Ledger Entries" extends "Customer Ledger Entries"
{
    layout
    {
        modify("Due Date")
        {
            Editable = DueDateIsEditable;
        }
    }
    actions
    {
        addafter(Dimensions)
        {
            action("A01AGPDueLine")
            {
                ApplicationArea = All;
                Image = AllLines;
                Caption = 'Credit Amortisation Lines';
                RunObject = page "A01 Posted Credit Amort Lines";
                RunPageLink = "Document Type" = const("Posted Sales invoice"), "Document No." = field("Document No.");
            }
        }
        addbefore("Show Document")
        {
            action("A01 Recu client")
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
                    Receipt: Record "Cust. Ledger Entry";
                begin
                    Receipt.SetRange("Document No.", Rec."Document No.");
                    Receipt.SetRange("Entry No.", Rec."Entry No.");
                    Report.Run(50041, true, false, Receipt);
                end;
            }
        }
    }
    trigger OnAfterGetCurrRecord()
    var
    begin
        DueDateIsEditable := CanEditDueDate();
    end;

    local procedure CanEditDueDate(): Boolean
    var
        UserSetup: Record "User Setup";
    begin
        if (UserSetup.get(UserId)) then
            exit(UserSetup."A01 Can Edit Due Date");
    end;

    var
        DueDateIsEditable: Boolean;
}