/// <summary>
/// PageExtension A01 Paymentournal (ID 50027) extends Payment Journal
/// </summary>
pageextension 50027 "A01 PaymentJournal" extends "Payment Journal"
{
    layout
    {

    }

    actions
    {
        addafter("&Line")
        {
            action("A01 BankTransferOrder")
            {
                ApplicationArea = All;
                Image = PrintForm;
                Caption = 'Print Bank Transfer order';
                trigger OnAction()
                var
                    PaymentRec: Record "Gen. Journal Line";
                begin
                    PaymentRec.SetRange("Document No.", Rec."Document No.");
                    Report.Run(50017, true, false, PaymentRec);
                end;
            }

            action("A01 RequisitionCheck")
            {
                ApplicationArea = All;
                Image = PrintForm;
                Caption = 'Print Check requisition';
                trigger OnAction()
                var
                    PaymentRec: Record "Gen. Journal Line";
                begin
                    PaymentRec.SetRange("Document No.", Rec."Document No.");
                    Report.Run(50033, true, false, PaymentRec);
                end;
            }
        }
    }
}