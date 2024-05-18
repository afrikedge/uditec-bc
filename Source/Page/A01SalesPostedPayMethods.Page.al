page 50095 "A01 Sales Posted Pay Methods"
{
    ApplicationArea = All;
    Caption = 'Sales Posted Pay Methods';
    PageType = ListPart;
    SourceTable = "A01 Posted Sales Pay Method";
    Editable = false;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("Payment Method"; Rec."Payment Method")
                {
                }
                field(Reference; Rec.Reference)
                {
                }
                field(Amount; Rec.Amount)
                {
                }
                field("Validated Amount"; Rec."Validated Amount")
                {
                }
            }
        }
    }
}
