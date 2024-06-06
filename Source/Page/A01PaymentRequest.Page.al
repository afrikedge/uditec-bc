page 50070 "A01 Payment Request"
{
    ApplicationArea = All;
    Caption = 'Payment Request';
    PageType = Card;
    SourceTable = "A01 Request On Document";
    SourceTableView = where("Request Type" = const("Payment Document"));
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
                field("Created By"; Rec."Created By")
                {
                }
                field("Modified By"; Rec."Modified By")
                {
                }
                field(Status; Rec.Status)
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
