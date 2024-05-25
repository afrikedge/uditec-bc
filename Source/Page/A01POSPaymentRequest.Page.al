page 50068 "A01 POS Payment Request"
{
    ApplicationArea = All;
    Caption = 'POS Payment Request';
    PageType = Card;
    SourceTable = "A01 Request On Document";
    SourceTableView = where("Request Type" = const("POS Payment"));
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
                field("Credit Limit"; Rec."Credit Limit")
                {
                }
                field(Status; Rec.Status)
                {
                }
                field("Sales Person"; Rec."Sales Person")
                {
                }
                field("Risk level"; Rec."Risk level")
                {
                }
                field("Created By"; Rec."Created By")
                {
                }
                field("Modified By"; Rec."Modified By")
                {
                }
                field("Gross exposure"; Rec."Gross exposure")
                {
                }
                field(Exceeding; Rec.Exceeding)
                {
                }
                field("Due Balance"; Rec."Due Balance")
                {
                }
                field("Worst Current Status"; Rec."Worst Current Status")
                {
                }
                field("In progress Balance"; Rec."In progress Balance")
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
