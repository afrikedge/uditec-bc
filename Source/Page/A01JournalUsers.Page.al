/// <summary>
/// Page A01 Journal Users (ID 50082).
/// </summary>
page 50082 "A01 Journal Users"
{
    ApplicationArea = All;
    Caption = 'Journal Users';
    PageType = List;
    SourceTable = "A01 User Access";
    SourceTableView = where("Access Type" = const(Journal));
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("User ID"; Rec."User ID")
                {
                    LookupPageID = "User Lookup";
                }
                field("Ressource Code 1"; Rec."Ressource Code 1")
                {
                    Caption = 'Journal Template Name';
                }
                field("Ressource Code 2"; Rec."Ressource Code 2")
                {
                    Caption = 'Journal Batch Name';
                }
            }
        }
    }
}
