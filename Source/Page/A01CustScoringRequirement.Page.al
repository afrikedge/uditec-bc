/// <summary>
/// Page A01 Cust Scoring Requirement (ID 50036).
/// </summary>
page 50036 "A01 Cust Scoring Requirement"
{
    ApplicationArea = All;
    Caption = 'Cust Scoring Requirement';
    PageType = List;
    SourceTable = "A01 Cust Scoring Requirement";
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("Customer Type"; Rec."Customer Type")
                {
                }
                field("Legal Form"; Rec."Legal Form")
                {
                }
                field("Identification Mode"; Rec."Identification Mode")
                {
                }
                field("Scoring Criteria"; Rec."Scoring Criteria")
                {
                }
                field("Requirement Status"; Rec."Requirement Status")
                {
                }
                field("Sales Mode"; Rec."Sales Mode")
                {
                }
                // field("Criteria Status"; Rec."Criteria Status")
                // {
                // }
                field("Income Orientation"; Rec."Income Orientation")
                {
                }
            }
        }
    }
}
