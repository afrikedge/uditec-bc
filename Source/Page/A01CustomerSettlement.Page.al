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
                field(Amount; Rec.Amount)
                {
                }
                field("Validated Amount"; Rec."Validated Amount")
                {
                }
                field("Applies-to ID"; Rec."Applies-to ID")
                {
                }
                field("External Document No."; Rec."External Document No.")
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
    actions
    {
        area(Processing)
        {
            action(Application)
            {
                Image = ApplyEntries;
                ApplicationArea = Basic, Suite;
                Caption = '&Application';
                ShortCutKey = 'Shift+F11';
                // Promoted = true;
                // PromotedCategory = Process;
                ToolTip = 'Apply the customer or vendor payment on the selected payment slip.';

                trigger OnAction()
                begin
                    ApplyPayment();
                end;
            }
            action(Pos)
            {
                Image = Post;
                ApplicationArea = Basic, Suite;
                Caption = '&Post';
                ShortCutKey = 'Shift+F11';
                // Promoted = true;
                // PromotedCategory = Process;
                //ToolTip = 'Apply the customer or vendor payment on the selected payment slip.';

                trigger OnAction()
                begin
                    CODEUNIT.Run(CODEUNIT::"A01 Customer Settlement Post", Rec);
                end;
            }
            action("A01 AddPaymentRequest")
            {
                ApplicationArea = All;
                Caption = 'Create payment request';
                Image = PickLines;
                trigger OnAction()
                var
                    CreateDoc: Record "A01 Request on Document";
                    QstLabel: Label 'Do you want to create an payment request?';
                begin
                    if (not confirm(QstLabel)) then
                        exit;
                    CreateDoc.AddPaymentRequest(Rec);//*******************
                end;
            }

        }
    }
    local procedure ApplyPayment()
    begin
        CODEUNIT.Run(CODEUNIT::"A01 Doc Payment-Apply", Rec);
    end;
}
