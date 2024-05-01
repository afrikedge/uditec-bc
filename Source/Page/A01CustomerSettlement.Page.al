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
                // field("Shortcut Dimension 1 Code"; Rec."Shortcut Dimension 1 Code")
                // {
                // }
                // field("Shortcut Dimension 2 Code"; Rec."Shortcut Dimension 2 Code")
                // {
                // }
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
                Caption = 'Application';
                ShortCutKey = 'Shift+F11';
                // Promoted = true;
                // PromotedCategory = Process;
                ToolTip = 'Apply the customer or vendor payment on the selected payment slip.';

                trigger OnAction()
                begin
                    ApplyPayment();
                end;
            }
            action(Post)
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
            action(PostPreview)
            {
                ApplicationArea = All;
                Caption = 'Preview Posting';
                Image = PreviewChecks;

                trigger OnAction()
                var
                    CustPaymentPost: Codeunit "A01 Customer Settlement Post";
                begin
                    CustPaymentPost.Preview(Rec);
                end;
            }
            action(PostAndPrint)
            {
                Image = PostPrint;
                ApplicationArea = Basic, Suite;
                Caption = '&Post and print';
                ShortCutKey = 'Shift+F11';
                // Promoted = true;
                // PromotedCategory = Process;
                //ToolTip = 'Apply the customer or vendor payment on the selected payment slip.';

                trigger OnAction()
                var
                    CustPaymentPost: Codeunit "A01 Customer Settlement Post";
                begin
                    CustPaymentPost.SetToPrint(true);
                    CustPaymentPost.Run(Rec);
                end;

                // trigger OnAction()
                // begin
                //     CODEUNIT.Run(CODEUNIT::"A01 Customer Settlement Post", Rec);
                // end;
            }
            action("A01 AddPaymentRequest")
            {
                ApplicationArea = All;
                Caption = 'Create payment request';
                Image = PickLines;
                trigger OnAction()
                var
                    QstLabel: Label 'Do you want to create an payment request?';
                begin
                    if (not confirm(QstLabel)) then
                        exit;
                    RequestMgt.AddPaymentRequest(Rec);//*******************
                end;
            }
            // action(Print)
            // {
            //     Image = PrintForm;
            //     ApplicationArea = Basic, Suite;
            //     Caption = '&Print';
            //     trigger OnAction()
            //     var
            //         CustomerSettlement: Record "A01 Payment Document";

            //     begin
            //         CustomerSettlement.SetRange("No.", Rec."No.");
            //         Report.Run(50021, true, false, CustomerSettlement);
            //     end;
            // }
        }
        area(navigation)
        {
            action(Dimensions)
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Dimensions';
                Image = Dimensions;
                ToolTip = 'View or change the dimension settings for this payment slip. If you change the dimension, you can update all lines on the payment slip.';

                trigger OnAction()
                begin
                    Rec.ShowDocDim();
                    CurrPage.SaveRecord();
                end;
            }
        }
    }
    trigger OnNewRecord(BelowxRec: Boolean)
    var
    //SecMgt: Codeunit "A01 Security Mgt";
    begin
        //Rec.Validate("Responsibility Center", SecMgt.GetMainUserResponsibilityCenter());
    end;

    local procedure ApplyPayment()
    begin
        CODEUNIT.Run(CODEUNIT::"A01 Doc Payment-Apply", Rec);
    end;

    var
        RequestMgt: Codeunit "A01 Document Request Mgt";
}
