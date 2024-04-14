page 50069 "A01 Payment Requests"
{
    ApplicationArea = All;
    Caption = 'Payment Requests';
    PageType = List;
    CardPageId = "A01 Payment Request";
    SourceTable = "A01 Request On Document";
    UsageCategory = Lists;

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
                field(Status; Rec.Status)
                {
                }
                field("Sequence No."; Rec."Sequence No.")
                {
                }
                field("Created By"; Rec."Created By")
                {
                }
                field("Customer No."; Rec."Customer No.")
                {
                }
                field("Modified By"; Rec."Modified By")
                {
                }
            }
        }
    }
}
