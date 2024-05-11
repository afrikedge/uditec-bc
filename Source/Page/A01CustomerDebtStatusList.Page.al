/// <summary>
/// Page A01 Customer Debt Status List (ID 50031).
/// </summary>
page 50031 "A01 Customer Debt Status List"
{
    ApplicationArea = All;
    Caption = 'Customer Debt Status List';
    PageType = List;
    SourceTable = "A01 Customer Debt Status";
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("Code"; Rec."Code")
                {
                }
                field(Description; Rec.Description)
                {
                }
                field("Risk Level"; Rec."Risk Level")
                {
                }
                field("Minimum (Days)"; Rec."Minimum (Days)")
                {
                }
                field("Maximum (Days)"; Rec."Maximum (Days)")
                {
                }
                field("Company fees (%)"; Rec."Company fees (%)")
                {
                }
                field("Agent fees partial (%)"; Rec."Agent fees partial (%)")
                {
                }
                field("Agent fees full (%)"; Rec."Agent fees full (%)")
                {
                }
                field("WSCA Point"; Rec."WSCA Point")
                {
                }
                field("WSSA Point"; Rec."WSSA Point")
                {
                }
            }
        }
    }
}
