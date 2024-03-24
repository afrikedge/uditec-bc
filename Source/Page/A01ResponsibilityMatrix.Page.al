/// <summary>
/// Page A01 Responsibility Matrix (ID 50043).
/// </summary>
page 50043 "A01 Responsibility Matrix"
{
    ApplicationArea = All;
    Caption = 'Responsibility Matrix';
    PageType = List;
    SourceTable = "A01 Responsibility Matrix";
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field(Object; Rec.Object)
                {
                }
                field("Sales Mode"; Rec."Sales Mode")
                {
                }
                field("Responsibility Center"; Rec."Responsibility Center")
                {
                }
                field(Status; Rec.Status)
                {
                }
                field(Validator; Rec.Validator)
                {
                }
                field(Substitute; Rec.Substitute)
                {
                }
                field("Minimal Value"; Rec."Minimal Value")
                {
                }
                field("Maximal Value"; Rec."Maximal Value")
                {
                }
                field(Required; Rec.Required)
                {
                }
                field(Parallel; Rec.Parallel)
                {
                }
            }
        }
    }
}
