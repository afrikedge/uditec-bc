/// <summary>
/// Page A01 Payment Promise (ID 50055).
/// </summary>
page 50055 "A01 Payment Promise"
{
    ApplicationArea = All;
    Caption = 'Payment Promise';
    PageType = Card;
    SourceTable = "A01 Payment Promise";
    UsageCategory = Documents;

    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General';

                field("No."; Rec."No.")
                {
                    ToolTip = 'Specifies the value of the No. field.';
                }
                field("Customer No."; Rec."Customer No.")
                {
                }
                field("Contact No."; Rec."Contact No.")
                {
                }
                field(Object; Rec.Object)
                {
                }
                field(Description; Rec.Description)
                {
                }
                field(Origin; Rec.Origin)
                {
                }
                field("Promise Date"; Rec."Promise Date")
                {
                }
                field(Reminder; Rec.Reminder)
                {
                }
                field("Reminder date"; Rec."Reminder date")
                {
                }
                field("Reminder deadline"; Rec."Reminder deadline")
                {
                }
                field(Status; Rec.Status)
                {
                }
                field("Amount honored"; Rec."Amount honored")
                {
                }
                field("Amount promised"; Rec."Amount promised")
                {
                }
                field("Created By"; Rec."Created By")
                {
                }
                field("Followed by"; Rec."Followed by")
                {
                }
                field("Modified By"; Rec."Modified By")
                {
                }
                field("Honoration Date"; Rec."Honoration Date")
                {
                }
                field(Observations; Rec.Observations)
                {
                    MultiLine = true;
                }

            }
        }
    }
}
