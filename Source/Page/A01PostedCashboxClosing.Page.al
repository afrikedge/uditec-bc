/// <summary>
/// Page A01 Posted Cashbox Closing (ID 50081).
/// </summary>
page 50081 "A01 Posted Cashbox Closing"
{
    ApplicationArea = All;
    Caption = 'Posted Cashbox Closing';
    PageType = Card;
    SourceTable = "A01 Cashbox closing";
    SourceTableView = where(Status = const(Posted));
    UsageCategory = Documents;
    Editable = false;

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
}
