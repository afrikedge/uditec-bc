/// <summary>
/// PageExtension A01 Posted Sales Invoice (ID 50023) extends Posted Sales Invoice.
/// </summary>
pageextension 50000 "A01 Posted Sales Invoice" extends "Posted Sales Invoice"
{
    layout
    {

    }

    actions
    {
        addafter(Print)
        {
            action("A01 Sales Invoice Credit")
            {
                ApplicationArea = All;
                Image = PrintForm;
                Caption = 'Print Sales Invoice Credit';
                trigger OnAction()
                var
                    SalesInvRec: Record "Sales Invoice Header";
                begin
                    SalesInvRec.SetRange("No.", Rec."No.");
                    SalesInvRec.SetRange("Sell-to Customer No.", Rec."Sell-to Customer No.");
                    Report.Run(50010, true, false, SalesInvRec);
                end;
            }
        }
        addafter(Statistics)
        {
            action("A01AGPDueLine")
            {
                ApplicationArea = All;
                Image = AllLines;
                Caption = 'Credit Amortisation Lines';
                RunObject = page "A01 Posted Credit Amort Lines";
                RunPageLink = "Document Type" = const("Posted Sales invoice"), "Document No." = field("No.");
            }
        }
    }
}