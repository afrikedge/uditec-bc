/// <summary>
/// Page A01 RC Payment Methods (ID 50041).
/// </summary>
page 50041 "A01 RC Payment Methods"
{
    ApplicationArea = All;
    Caption = 'Responsability center payment methods';
    PageType = List;
    SourceTable = "A01 RC Payment Method";
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("Responsability Center"; Rec."Responsability Center")
                {
                }
                field("Payment Method"; Rec."Payment Method")
                {
                }
                field("Bal. Account Type"; Rec."Bal. Account Type")
                {
                }
                field("Bal. Account No."; Rec."Bal. Account No.")
                {
                }
                field("Payment Class"; Rec."Payment Class")
                {
                }
            }
        }
    }
}
