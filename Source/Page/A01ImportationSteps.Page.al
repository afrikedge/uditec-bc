/// <summary>
/// Page A01 Importation Steps (ID 50089).
/// </summary>
page 50089 "A01 Importation Steps"
{
    ApplicationArea = All;
    Caption = 'Importation Steps';
    PageType = List;
    SourceTable = "A01 Parameter Record";
    SourceTableView = sorting("Line Order") where(Type = const(ImportStep));
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
                field("Order"; Rec."Line Order")
                {
                }
            }
        }
    }
}
