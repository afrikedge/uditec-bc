pageextension 50040 "A01 Transfer Order" extends "Transfer Order"
{
    layout
    {
        addafter("Status")
        {
            field("A01 Approval Status"; Rec."A01 Approval Status")
            {
                ApplicationArea = All;
            }
            field("A01 Approval User"; Rec."A01 Approval User")
            {
                ApplicationArea = All;
            }
            field("A01 Approval Date"; Rec."A01 Approval Date")
            {
                ApplicationArea = All;
            }
        }
    }
    actions
    {
        addbefore("&Print")
        {
            action(A01Process)
            {
                ApplicationArea = all;
                Caption = 'Process';
                Ellipsis = true;
                Image = Process;

                trigger OnAction()
                var
                    ItemMgt: Codeunit "A01 Inventory Mgt";
                begin
                    ItemMgt.ValidateItemTransfer(Rec);
                end;
            }
        }
    }
}
