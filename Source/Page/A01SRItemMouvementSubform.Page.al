page 50108 "A01 SR Item Mouvement Subform"
{
    ApplicationArea = All;
    Caption = 'SR Item Mouvement Subform';
    PageType = ListPart;
    SourceTable = "A01 SR Item Movement";

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field("Movement Date"; Rec."Movement Date")
                {
                }
                field("Movement Type"; Rec."Movement Type")
                {
                }
                field("Movement Description"; Rec."Movement Description")
                {
                }
                field("From Location Code"; Rec."From Location Code")
                {
                }
                field("From Bin Code"; Rec."From Bin Code")
                {
                }
                field("To Bin Code"; Rec."To Bin Code")
                {
                }
                field("To Location Code"; Rec."To Location Code")
                {
                }
            }
        }
    }
}
