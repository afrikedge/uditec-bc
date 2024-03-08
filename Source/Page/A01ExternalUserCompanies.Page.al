page 50021 "A01 External User Companies"
{
    ApplicationArea = All;
    Caption = 'External User Companies';
    PageType = ListPart;
    SourceTable = "A01 External User Company";

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("Company Code"; Rec."Company Code")
                {
                }
                field("Profile"; Rec."Profile")
                {
                }
                field(Active; Rec.Active)
                {
                }
            }
        }
    }
}
