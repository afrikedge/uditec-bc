/// <summary>
/// Page A01 Cashbox Closing (ID 50079).
/// </summary>
page 50079 "A01 Cashbox Closing"
{
    ApplicationArea = All;
    Caption = 'Cashbox Closing';
    PageType = Card;
    SourceTable = "A01 Cashbox closing";
    SourceTableView = where(Status = const(Open));
    UsageCategory = Documents;

    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General';

                field("Store Code"; Rec."Store Code")
                {
                }
                field("Closing Date"; Rec."Closing Date")
                {
                }
                field(Status; Rec.Status)
                {
                }
                field("Closing Balance"; Rec."Closing Balance")
                {
                }
            }
            part(SalesLines; "A01 Cashbox Closing Subform")
            {
                Caption = 'Lines';
                ApplicationArea = Basic, Suite;
                // Editable = IsSalesLinesEditable;
                // Enabled = IsSalesLinesEditable;
                SubPageLink = "Store Code" = field("Store Code"), "Closing Date" = field("Closing Date");
                UpdatePropagation = Both;
            }
        }
        
    }
    actions
    {
        area(Processing)
        {
            action(Post)
            {
                Image = Post;
                ApplicationArea = Basic, Suite;
                Caption = '&Post';
                ShortCutKey = 'Shift+F11';
                // Promoted = true;
                // PromotedCategory = Process;
                //ToolTip = 'Apply the customer or vendor payment on the selected payment slip.';

                trigger OnAction()
                begin
                    Rec.PostCashboxClosing();
                end;
            }
        }
    }
}
