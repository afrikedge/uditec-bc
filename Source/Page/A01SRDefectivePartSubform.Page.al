page 50110 "A01 SR Defective Part Subform"
{
    ApplicationArea = All;
    Caption = 'SR Defective Part';
    PageType = ListPart;
    SourceTable = "A01 SR Spare Part";
    SourceTableView = where("Spare Status" = const(Defective));

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
                field(Observations; Rec.Observations)
                {
                }
            }
        }
    }
}
