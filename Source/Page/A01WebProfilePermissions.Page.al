/// <summary>
/// Page A01 Web Profile Permissions (ID 50087).
/// </summary>
page 50087 "A01 Web Profile Permissions"
{
    ApplicationArea = All;
    Caption = 'Web Profile Permissions';
    PageType = List;
    SourceTable = "A01 Web Profile Permission";
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("Web Profile"; Rec."Web Profile")
                {
                }
                field("Web Function"; Rec."Web Function")
                {
                }
                field(Read; Rec.Read)
                {
                }
                field(Insertion; Rec.Insertion)
                {
                }
                field(Modification; Rec.Modification)
                {
                }
                field(Deletion; Rec.Deletion)
                {
                }
                field(Execution; Rec.Execution)
                {
                }
            }
        }
    }
}
