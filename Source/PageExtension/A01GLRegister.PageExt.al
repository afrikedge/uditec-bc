pageextension 50054 "A01 GL Register" extends "G/L Registers"
{
    actions
    {
        addafter("VAT Entries")
        {
            action(A01Print)
            {
                Image = PrintForm;
                ApplicationArea = Basic, Suite;
                Caption = '&Print Cash voucher';
                trigger OnAction()
                var
                    DisburReceipt: Record "G/L Register";
                begin
                    DisburReceipt.SetRange("No.", Rec."No.");
                    DisburReceipt.SetRange("Journal Templ. Name", Rec."Journal Templ. Name");
                    DisburReceipt.SetRange("Journal Batch Name", Rec."Journal Batch Name");
                    Report.Run(50037, true, false, DisburReceipt);
                end;
            }

        }
    }
}
