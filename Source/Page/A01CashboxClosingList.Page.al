/// <summary>
/// Page A01 Cashbox Closing List (ID 50077).
/// </summary>
page 50077 "A01 Cashbox Closing List"
{
    ApplicationArea = All;
    Caption = 'Cashbox Closing List';
    PageType = List;
    SourceTable = "A01 Cashbox closing";
    SourceTableView = where(Status = const(Open));
    CardPageId = "A01 Cashbox Closing";
    UsageCategory = Lists;
    Editable = false;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("Store Code"; Rec."Store Code")
                {
                }
                field("Closing Balance"; Rec."Closing Balance")
                {
                }
                field("Closing Date"; Rec."Closing Date")
                {
                }
                field(Status; Rec.Status)
                {
                }
            }
        }
    }
}
