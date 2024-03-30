/// <summary>
/// PageExtension A01 Payment Slip (ID 50009) extends Record Payment Slip.
/// </summary>
pageextension 50009 "A01 Payment Slip" extends "Payment Slip"
{
    layout
    {
        addafter("Partner Type")
        {
            field("A01 Description"; Rec."A01 Description")
            {
                ApplicationArea = Basic, Suite;
            }
            field("A01 Customer No."; Rec."A01 Customer No.")
            {
                ApplicationArea = Basic, Suite;
            }
            field("A01 Origin Document No."; Rec."A01 Origin Document No.")
            {
                ApplicationArea = Basic, Suite;
            }
        }
    }
    actions
    {
        // addafter("P&osting")
        // {
        //     action("A01 Cash Receipt")
        //     {
        //         ApplicationArea = All;
        //         Image = PrintForm;
        //         Caption = 'Print Cash Receipt';
        //         trigger OnAction()
        //         var
        //             PaymentRec: Record "Payment Header";
        //         begin
        //             PaymentRec.SetRange("No.", Rec."No.");
        //             Report.Run(50004, true, false, PaymentRec);
        //         end;
        //     }
        // }

        modify(Print)
        {
            trigger OnBeforeAction()
            var
                PaymentRec: Record "Payment Header";
            begin
                PaymentRec.SetRange("No.", Rec."No.");
                Report.Run(50004, true, false, PaymentRec);
            end;
        }
    }
}
