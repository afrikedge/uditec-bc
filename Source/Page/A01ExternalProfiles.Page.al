/// <summary>
/// Page A01 External Profiles (ID 50020).
/// </summary>
page 50020 "A01 External Profiles"
{
    ApplicationArea = All;
    Caption = 'External Profiles';
    PageType = List;
    SourceTable = "A01 External Profile";
    UsageCategory = Lists;

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
                field(Active; Rec.Active)
                {
                }
            }
        }
    }
}
