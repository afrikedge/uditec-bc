/// <summary>
/// Page A01 Discount Requests (ID 50058).
/// </summary>
page 50058 "A01 Discount Requests"
{
    ApplicationArea = All;
    Caption = 'Discount Requests';
    PageType = List;
    CardPageId = "A01 Discount Request";
    SourceTable = "A01 Request On Document";
    SourceTableView = where("Request Type" = filter("Discount on order" | "Discount on quote"));
    UsageCategory = Lists;
    Editable = false;


    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("Request Type"; Rec."Request Type")
                {
                }
                field("Request No."; Rec."Request No.")
                {
                }
                field(Object; Rec.Object)
                {
                }
                field("Customer No."; Rec."Customer No.")
                {
                }
                field("Sales Person"; Rec."Sales Person")
                {
                }
                field("Requested Discount (%)"; Rec."Requested Discount (%)")
                {
                }
                field("Validated Discount (%)"; Rec."Validated Discount (%)")
                {
                }
                field(Status; Rec.Status)
                {
                }
                field("Sequence No."; Rec."Sequence No.")
                {
                }
                field("Created By"; Rec."Created By")
                {
                }
                field("Modified By"; Rec."Modified By")
                {
                }
            }
        }
    }
}
