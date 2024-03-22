/// <summary>
/// Page A01 External User (ID 50022).
/// </summary>
page 50022 "A01 External User"
{
    ApplicationArea = All;
    Caption = 'External User';
    PageType = Card;
    SourceTable = "A01 External User";
    UsageCategory = None;

    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General';

                field("Code"; Rec."Code")
                {
                }
                field(Name; Rec.Name)
                {
                }
                field(Email; Rec.Email)
                {
                }
                field(Active; Rec.Active)
                {
                }
                field("Default Company"; Rec."Default Company")
                {
                }
                field(PasswordIsSet; Rec.PasswordIsSet)
                {
                }
                field("Sales Person Code"; Rec."Sales Person Code")
                {
                }
                field("Responsibility Center"; Rec."Responsibility Center")
                {
                }
            }
            part(Companies; "A01 External User Companies")
            {
                ApplicationArea = Basic, Suite;
                SubPageLink = "User Code" = field(Code);
                UpdatePropagation = Both;
            }
        }
    }
    actions
    {
        area(navigation)
        {
            group(Process)
            {
                action(CreatePassword)
                {
                    ApplicationArea = All;
                    Image = Create;
                    Caption = 'Create or reset password';
                    //Promoted = true;
                    //PromotedCategory = Process;
                    trigger OnAction()
                    var
                        ResetPasswordPage: Report "A01 CreateResetPassword";
                    begin
                        ResetPasswordPage.SetUserCode(Rec.Code);
                        ResetPasswordPage.RunModal();
                    end;
                }
                action(CreatePasswordTest)
                {
                    ApplicationArea = All;
                    Image = Create;
                    Caption = 'TestJP';
                    //Promoted = true;
                    //PromotedCategory = Process;
                    trigger OnAction()
                    var
                        ApiMgt: Codeunit "A01 Api Mgt";
                    begin
                        ApiMgt.DebugApiFunction();
                    end;
                }
            }
        }
    }
}
