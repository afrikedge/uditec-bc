/// <summary>
/// Page A01 Post CustSettlementSubform (ID 50061).
/// </summary>
page 50061 "A01 Post CustSettlementSubform"
{
    ApplicationArea = All;
    Caption = 'Post CustSettlementSubform';
    PageType = ListPart;
    SourceTable = "A01 Posted Payment Doc Line";


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
                field("Due Date"; Rec."Due Date")
                {
                }
                // field("Applies-to Doc. No."; Rec."Applies-to Doc. No.")
                // {
                // }
                // field("Applies-to ID"; Rec."Applies-to ID")
                // {
                // }
            }
        }
    }




}
