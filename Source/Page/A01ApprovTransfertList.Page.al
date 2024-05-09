page 50090 "A01 Approv Transfert List"
{
    ApplicationArea = All;
    Caption = 'Approv Transfert List';
    PageType = List;
    SourceTable = "Transfer Header";
    SourceTableView = where("A01 Approval Status" = const("Awaiting Approbation"));
    CardPageId = "Transfer Order";
    Editable = false;
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("No."; Rec."No.")
                {
                }
                field("Transfer-to Code"; Rec."Transfer-to Code")
                {
                }
                field("Transfer-to Name"; Rec."Transfer-to Name")
                {
                }
                field("Transfer-from Code"; Rec."Transfer-from Code")
                {
                }
                field("Transfer-from Name"; Rec."Transfer-from Name")
                {
                }
                field("Transport Method"; Rec."Transport Method")
                {
                }
                field(Status; Rec.Status)
                {
                }
                field("Shortcut Dimension 1 Code"; Rec."Shortcut Dimension 1 Code")
                {
                }
                field("Shortcut Dimension 2 Code"; Rec."Shortcut Dimension 2 Code")
                {
                }
                field("A01 Approval Status"; Rec."A01 Approval Status")
                {
                }
                field("In-Transit Code"; Rec."In-Transit Code")
                {
                }
                field("Posting Date"; Rec."Posting Date")
                {
                }
            }
        }
    }
}
