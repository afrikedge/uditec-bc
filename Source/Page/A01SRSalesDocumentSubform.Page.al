page 50111 "A01 SR Sales Document Subform"
{
    ApplicationArea = All;
    Caption = 'SR Sales Document Subform';
    PageType = ListPart;
    SourceTable = "A01 SR Sales Document";
    
    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field("Document Type"; Rec."Document Type")
                {
                }
                field("Document Date"; Rec."Document Date")
                {
                }
                field("Document Amount"; Rec."Document Amount")
                {
                }
                field("Processing Status"; Rec."Processing Status")
                {
                }
            }
        }
    }
}
