/// <summary>
/// Page A01 Bank Account User (ID 50071).
/// </summary>
page 50071 "A01 Bank Account Users"
{
    ApplicationArea = All;
    Caption = 'Bank Account Users';
    PageType = List;
    SourceTable = "A01 User Access";
    SourceTableView = where("Access Type" = const("Bank Account"));
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
                field("Bank Account"; Rec."Ressource Code 1")
                {
                    Caption = 'Bank Account';
                }
            }
        }
    }
}
