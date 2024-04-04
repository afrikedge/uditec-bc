/// <summary>
/// PageExtension A01 PhysInventoryJournal (ID 50025) extends Phys. Inventory Journal
/// </summary>
pageextension 50025 "A01 Phys Inventory Journal" extends "Phys. Inventory Journal"
{
    layout
    {

    }

    actions
    {
        addafter(Print)
        {
            action("A01 Inventory Report")
            {
                ApplicationArea = All;
                Image = PrintForm;
                Caption = 'Print Inventory report';
                trigger OnAction()
                var
                    PhysInvRec: Record "Item Journal Batch";
                begin
                    PhysInvRec.SetRange("Journal Template Name", Rec."Journal Template Name");
                    PhysInvRec.SetRange(Name, Rec."Journal Batch Name");
                    Report.Run(50015, true, false, PhysInvRec);
                end;
            }
        }
    }
}