/// <summary>
/// Page A01 Item Ticket Format List (ID 50029).
/// </summary>
page 50029 "A01 Item Ticket Format List"
{
    ApplicationArea = All;
    Caption = 'Item Ticket Format List';
    PageType = List;
    SourceTable = "A01 Parameter Record";
    SourceTableView = where(Type = const(TicketFormat));
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("Code"; Rec."Code")
                {
                }
                field(Description; Rec.Description)
                {
                }
            }
        }
    }
}
