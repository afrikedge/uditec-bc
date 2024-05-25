page 50066 "A01 UnBlocking Request"
{
    ApplicationArea = All;
    Caption = 'UnBlocking Request';
    PageType = Card;
    SourceTable = "A01 Request On Document";
    SourceTableView = where("Request Type" = const(Unblocking));
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General';

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
                field("Credit Limit"; Rec."Credit Limit")
                {
                }
                field("Due Balance"; Rec."Due Balance")
                {
                }
                field(Exceeding; Rec.Exceeding)
                {
                }
                field("Gross exposure"; Rec."Gross exposure")
                {
                }
                field("In progress Balance"; Rec."In progress Balance")
                {
                }
                field("Risk level"; Rec."Risk level")
                {
                }
                field("Sales Person"; Rec."Sales Person")
                {
                }
                field("Created By"; Rec."Created By")
                {
                }
                field("Modified By"; Rec."Modified By")
                {
                }
                field("Worst Current Status"; Rec."Worst Current Status")
                {
                }
            }
        }
    }
    actions
    {
        area(navigation)
        {
            action(Validate)
            {
                ApplicationArea = All;
                Image = Create;
                Caption = 'Validate';
                trigger OnAction()
                var
                    DocRequestMgt: Codeunit "A01 Document Request Mgt";
                    LabConfirmation: label 'Do you want to validate this request?';
                begin
                    if (not confirm(LabConfirmation)) then
                        exit;
                    DocRequestMgt.ModifyStatus(Rec, '', Rec.Status::Validated);
                    //Message('Modification terminée');
                end;
            }
        }
    }
}
