/// <summary>
/// Page A01 Bank Account User (ID 50071).
/// </summary>
page 50071 "A01 Bank Account Users"
{
    ApplicationArea = All;
    Caption = 'Bank Account Users';
    PageType = List;
    SourceTable = "A01 User Access";
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("User Id"; Rec."User Id")
                {
                    LookupPageID = "User Lookup";
                }
                field("Bank Account"; Rec."Bank Account")
                {
                }
            }
        }
    }
}
