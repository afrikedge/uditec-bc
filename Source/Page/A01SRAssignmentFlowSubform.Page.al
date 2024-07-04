page 50112 "A01 SR Assignment Flow Subform"
{
    ApplicationArea = All;
    Caption = 'SR Assignment Flow Subform';
    PageType = ListPart;
    SourceTable = "A01 SR Assignment Flow";
    
    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field("Assigned On"; Rec."Assigned On")
                {
                }
                field("Assigned By"; Rec."Assigned By")
                {
                }
                field("Current Status"; Rec."Current Status")
                {
                }
                field("Assigned To"; Rec."Assigned To")
                {
                }
                field("Next Status"; Rec."Next Status")
                {
                }
                field(Deadline; Rec.Deadline)
                {
                }
                field(Notes; Rec.Notes)
                {
                }
                field("Starting Date"; Rec."Starting Date")
                {
                }
            }
        }
    }
}
