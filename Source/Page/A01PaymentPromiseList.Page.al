/// <summary>
/// Page A01 Payment Promise List (ID 50054).
/// </summary>
page 50054 "A01 Payment Promise List"
{
    ApplicationArea = All;
    Caption = 'Payment Promise List';
    PageType = List;
    SourceTable = "A01 Payment Promise";
    CardPageId = "A01 Payment Promise";
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("No."; Rec."No.")
                {
                }
                field(Object; Rec.Object)
                {
                }
                field(Origin; Rec.Origin)
                {
                }
                field("Promise Date"; Rec."Promise Date")
                {
                }
                field("Customer No."; Rec."Customer No.")
                {
                }
                field("Contact No."; Rec."Contact No.")
                {
                }
                field(Description; Rec.Description)
                {
                }
                field("Amount promised"; Rec."Amount promised")
                {
                }
                field("Amount honored"; Rec."Amount honored")
                {
                }
                field("Followed by"; Rec."Followed by")
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
