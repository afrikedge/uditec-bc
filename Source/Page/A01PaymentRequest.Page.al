page 50070 "A01 Payment Request"
{
    ApplicationArea = All;
    Caption = 'Payment Request';
    PageType = Card;
    SourceTable = "A01 Request On Document";
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General';

                field("Request No."; Rec."Request No.")
                {
                }
                field(Object; Rec.Object)
                {
                }
                field("Customer No."; Rec."Customer No.")
                {
                }
                field("Created By"; Rec."Created By")
                {
                }
                field("Modified By"; Rec."Modified By")
                {
                }
                field(Status; Rec.Status)
                {
                }
            }
        }
    }
}
