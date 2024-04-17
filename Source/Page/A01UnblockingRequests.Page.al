page 50065 "A01 Unblocking Requests"
{
    ApplicationArea = All;
    Caption = 'Unblocking Requests';
    PageType = List;
    CardPageId = "A01 UnBlocking Request";
    SourceTable = "A01 Request On Document";
    SourceTableView = where("Request Type" = const(Unblocking));
    UsageCategory = Lists;
    Editable = false;

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
                field("Credit Limit"; Rec."Credit Limit")
                {
                }
                field("Due Balance"; Rec."Due Balance")
                {
                }
                field("In progress Balance"; Rec."In progress Balance")
                {
                }
                field("Created By"; Rec."Created By")
                {
                }
                field("Modified By"; Rec."Modified By")
                {
                }
                field("Risk level"; Rec."Risk level")
                {
                }
                field("Sales Person"; Rec."Sales Person")
                {
                }
                field("Sequence No."; Rec."Sequence No.")
                {
                }
                field(Status; Rec.Status)
                {
                }
                field("Worst Current Status"; Rec."Worst Current Status")
                {
                }
                field(Exceeding; Rec.Exceeding)
                {
                }
                field("Gross exposure"; Rec."Gross exposure")
                {
                }
            }
        }
    }
}
