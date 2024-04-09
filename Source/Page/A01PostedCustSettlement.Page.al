/// <summary>
/// Page A01 Posted Cust Settlement (ID 50063).
/// </summary>
page 50063 "A01 Posted Cust Settlement"
{
    ApplicationArea = All;
    Caption = 'Posted Cust Settlement';
    PageType = Card;
    SourceTable = "A01 Posted Payment Document";

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
            part(SalesLines; "A01 Post CustSettlementSubform")
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
