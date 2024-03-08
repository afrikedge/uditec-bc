/// <summary>
/// PageExtension A01 Administrator Main RC (ID 50004) extends Record Administrator Main Role Center.
/// </summary>
pageextension 50004 "A01 Administrator Main RC" extends "Security Admin Role Center"
{
    actions
    {
        addafter("User Management")
        {
            group(A01_ExernalUser)
            {
                Caption = 'Afk External Users';
                Image = Setup;
                action(A01External_profiles)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'External profiles';
                    RunObject = Page "A01 External Profiles";
                }
                action(A01ExternalUsers)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'External users';
                    RunObject = Page "A01 External Users";
                }
            }
        }
    }
}
