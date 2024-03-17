/// <summary>
/// Page A01 Payment Type Configuration (ID 50032).
/// </summary>
page 50032 "A01 Payment Type Configuration"
{
    ApplicationArea = All;
    Caption = 'Payment Type Configuration';
    PageType = List;
    SourceTable = "A01 Payment Type Configuration";
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("Journal Template Name"; Rec."Journal Template Name")
                {
                }
                field("Journal Batch Name"; Rec."Journal Batch Name")
                {
                }
                field("Payment Type"; Rec."Payment Type")
                {
                }
                field("Payment Class"; Rec."Payment Class")
                {
                }
            }
        }
    }
}
