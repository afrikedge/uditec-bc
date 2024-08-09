page 50109 "A01 SR SparePart Subform"
{
    ApplicationArea = All;
    Caption = 'SR SparePart';
    PageType = ListPart;
    SourceTable = "A01 SR Spare Part";
    SourceTableView = where("Spare Status" = const(" "));

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field("Item No."; Rec."Item No.")
                {
                }
                field(Description; Rec.Description)
                {
                }
                field("Unit of Measure Code"; Rec."Unit of Measure Code")
                {
                }
                field(Quantity; Rec.Quantity)
                {
                }
                field("Usage Status"; Rec."Usage Status")
                {
                }
                field(Usage; Rec.Usage)
                {
                }
                field("Item Entry Doc No"; Rec."Item Entry Doc No")
                {
                }
            }
        }
    }
}
