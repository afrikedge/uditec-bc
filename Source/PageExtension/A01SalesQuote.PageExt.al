/// <summary>
/// PageExtension A01 Sales Quote (ID 50009) extends Record Sales Quote.
/// </summary>
pageextension 50009 "A01 Sales Quote" extends "Sales Quote"
{
    layout
    {
        // Add changes to page layout here
    }

    actions
    {
        modify(Print)
        {
            trigger OnAfterAction()
            var
                ApprovalsMgmt: Codeunit "Approvals Mgmt.";
            // Msg: Label 'Le document est au statut ouvert';
            begin
                if Rec.Status = Rec.Status::Open then begin
                    if ApprovalsMgmt.PrePostApprovalCheckSales(Rec) then begin
                        Codeunit.Run(Codeunit::"Sales-Quote to Order (Yes/No)", Rec);
                    end;
                    // Error(Msg);
                end;
            end;

        }
    }
}