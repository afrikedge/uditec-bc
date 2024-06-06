page 50064 "A01 Discount Request"
{
    ApplicationArea = All;
    Caption = 'Discount Request';
    PageType = Card;
    SourceTable = "A01 Request On Document";
    SourceTableView = where("Request Type" = filter("Discount on order" | "Discount on quote"));
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
                field("Sales Person"; Rec."Sales Person")
                {
                }
                field("Created By"; Rec."Created By")
                {
                }
                field("Modified By"; Rec."Modified By")
                {
                }
                field("Requested Discount (%)"; Rec."Requested Discount (%)")
                {
                    Editable = RequestedDiscountIsEditable;
                }
                field("Validated Discount (%)"; Rec."Validated Discount (%)")
                {
                    Editable = ValidatedDiscountIsEditable;
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
                end;
            }
        }
    }
    trigger OnAfterGetRecord()
    var
    begin
        RequestedDiscountIsEditable := Rec.Status = Rec.Status::Initialization;
        ValidatedDiscountIsEditable := GetValidatedDiscountIsEditable();
    end;

    var
        RequestedDiscountIsEditable: Boolean;
        ValidatedDiscountIsEditable: Boolean;

    local procedure GetValidatedDiscountIsEditable(): Boolean
    var
    begin
        if (Rec.Status = Rec.Status::Validated) then
            exit(false);
        if (Rec.Status = Rec.Status::Initialization) then
            exit(false);
        exit(true);
    end;
}
