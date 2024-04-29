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
                }
                field("Validated Discount (%)"; Rec."Validated Discount (%)")
                {
                }
            }
        }
    }
    actions
    {
        area(navigation)
        {
            group(Process)
            {
                action(Validate)
                {
                    ApplicationArea = All;
                    Image = Create;
                    Caption = 'Validate';
                    //Promoted = true;
                    //PromotedCategory = Process;
                    trigger OnAction()
                    var
                        DocRequestMgt: Codeunit "A01 Document Request Mgt";
                    begin
                        Rec.Status := Rec.Status::Validated;
                        DocRequestMgt.CloseRequest(Rec);
                    end;
                }
            }
        }
    }
}
