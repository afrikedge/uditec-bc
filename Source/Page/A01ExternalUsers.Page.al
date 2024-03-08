/// <summary>
/// Page A01 External Users (ID 50019).
/// </summary>
page 50019 "A01 External Users"
{
    ApplicationArea = All;
    Caption = 'External Users';
    PageType = List;
    SourceTable = "A01 External User";
    CardPageId = "A01 External User";
    UsageCategory = Lists;
    Editable = false;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("Code"; Rec."Code")
                {
                }
                field(Name; Rec.Name)
                {
                }
                field(Email; Rec.Email)
                {
                }
                field("Active"; Rec."Active")
                {
                }
                field("Default Company"; Rec."Default Company")
                {
                }
                field(PasswordIsSet; Rec.PasswordIsSet)
                {
                }
                field(UserMustChangePassword; Rec.UserMustChangePassword)
                {
                }
            }
        }
    }
}
