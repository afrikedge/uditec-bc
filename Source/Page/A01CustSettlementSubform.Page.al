/// <summary>
/// Page A01 Cust Settlement Subform (ID 50056).
/// </summary>
page 50056 "A01 Cust Settlement Subform"
{
    ApplicationArea = All;
    Caption = 'Cust Settlement Subform';
    PageType = ListPart;
    SourceTable = "A01 Payment Document Line";

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("Payment Method"; Rec."Payment Method")
                {
                }
                field(Amount; Rec.Amount)
                {
                }
                field("Validated Amount"; Rec."Validated Amount")
                {
                }
                field(Reference; Rec.Reference)
                {
                }
                // field("Applies-to Doc. Type"; Rec."Applies-to Doc. Type")
                // {
                // }
                // field("Applies-to Doc. No."; Rec."Applies-to Doc. No.")
                // {
                // }
                field("Applies-to ID"; Rec."Applies-to ID")
                {
                }
            }
        }
    }

    actions
    {
        area(Processing)
        {

            action(Application)
            {
                Image = ApplyEntries;
                ApplicationArea = Basic, Suite;
                Caption = '&Application';
                ShortCutKey = 'Shift+F11';
                ToolTip = 'Apply the customer or vendor payment on the selected payment slip line.';

                trigger OnAction()
                begin
                    ApplyPayment();
                end;
            }

        }
    }

    local procedure ApplyPayment()
    begin
        CODEUNIT.Run(CODEUNIT::"A01 Doc Payment-Apply", Rec);
    end;
}
