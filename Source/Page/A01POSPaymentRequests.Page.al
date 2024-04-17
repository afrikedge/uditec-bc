page 50067 "A01 POS Payment Requests"
{
    ApplicationArea = All;
    Caption = 'POS Payment Requests';
    PageType = List;
    CardPageId = "A01 POS Payment Request";
    SourceTable = "A01 Request On Document";
    SourceTableView = where("Request Type" = const("POS Payment"));
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("Request Type"; Rec."Request Type")
                {
                }
                field("Request No."; Rec."Request No.")
                {
                }
                field(Object; Rec.Object)
                {
                }
                field("Customer No."; Rec."Customer No.")
                {
                }
                field(Status; Rec.Status)
                {
                }
                field("Sales Person"; Rec."Sales Person")
                {
                }
                field("Sequence No."; Rec."Sequence No.")
                {
                }
                field("Risk level"; Rec."Risk level")
                {
                }
                field("Due Balance"; Rec."Due Balance")
                {
                }
                field("Credit Limit"; Rec."Credit Limit")
                {
                }
                field("Gross exposure"; Rec."Gross exposure")
                {
                }
                field("In progress Balance"; Rec."In progress Balance")
                {
                }
                field("Worst Current Status"; Rec."Worst Current Status")
                {
                }
                field(Exceeding; Rec.Exceeding)
                {
                }
                field("Modified By"; Rec."Modified By")
                {
                }
                field("Created By"; Rec."Created By")
                {
                }
            }
        }
    }
}
