/// <summary>
/// Page A01 Cashbox Closing Subform (ID 50080).
/// </summary>
page 50080 "A01 Cashbox Closing Subform"
{
    ApplicationArea = All;
    Caption = 'Cashbox Closing Subform';
    PageType = ListPart;
    SourceTable = "A01 Cashbox Closing Line";

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("Bank Account"; Rec."Bank Account")
                {
                }
                field("Bank Note"; Rec."Bank Note")
                {
                }
                field(Quantity; Rec.Quantity)
                {
                }
                field("Bank Note Value"; Rec."Bank Note Value")
                {
                }

                field("Line Value"; Rec."Line Value")
                {
                }
            }
        }
    }
}
