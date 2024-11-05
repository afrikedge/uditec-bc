page 50115 "A01 Neighborhood List"
{
    ApplicationArea = All;
    Caption = 'Neighborhood List';
    PageType = List;
    SourceTable = "A01 Neighborhood";
    UsageCategory = Lists;

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field(City; Rec.City)
                {
                }
                field(Municipality; Rec.Municipality)
                {
                }
                field(Neighborhood; Rec.Neighborhood)
                {
                }
                field("Delivery Axis"; Rec."Delivery Axis")
                {
                }
            }
        }
    }
}
