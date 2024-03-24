pageextension 50008 "A01 Payment Slip_Document" extends "Payment Slip"
{
    layout
    {
        // Add changes to page layout here
    }

    actions
    {
        addafter("P&osting")
        {
            action("A01 Cash Receipt")
            {
                ApplicationArea = All;
                Image = PrintForm;
                Caption = 'Print Cash Receipt';
                trigger OnAction()
                var
                    Cash: Report "A01 CashReceiptPrint";
                begin
                    Cash.RunModal();
                end;
            }
        }
    }

}