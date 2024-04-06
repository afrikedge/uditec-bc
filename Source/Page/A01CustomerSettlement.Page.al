/// <summary>
/// Page A01 Customer Settlement (ID 50057).
/// </summary>
page 50057 "A01 Customer Settlement"
{
    ApplicationArea = All;
    Caption = 'Customer Settlement';
    PageType = Card;
    SourceTable = "A01 Payment Document";
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
                }
                field(Object; Rec.Object)
                {
                }
                field("Partner No."; Rec."Partner No.")
                {
                }
                field("Partner Name"; Rec."Partner Name")
                {
                }
                field("Posting Date"; Rec."Posting Date")
                {
                }
                field("Responsibility Center"; Rec."Responsibility Center")
                {
                }
                field(Status; Rec.Status)
                {
                }
                field("Modified By"; Rec."Modified By")
                {
                }
            }
            part(SalesLines; "A01 Cust Settlement Subform")
            {
                ApplicationArea = Basic, Suite;
                // Editable = IsSalesLinesEditable;
                // Enabled = IsSalesLinesEditable;
                SubPageLink = "Document No." = field("No."), "Responsibility Center" = field("Responsibility Center");
                UpdatePropagation = Both;
            }
        }
    }
}
