/// <summary>
/// Page A01 Sales Payment Methods (ID 50046).
/// </summary>
page 50046 "A01 Sales Payment Methods"
{
    ApplicationArea = All;
    Caption = 'Sales Payment Methods';
    PageType = ListPart;
    SourceTable = "A01 Sales Payment Method";

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
