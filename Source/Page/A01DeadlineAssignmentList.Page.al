/// <summary>
/// Page A01 Deadline Assignment List (ID 50049).
/// </summary>
page 50049 "A01 Deadline Assignment List"
{
    ApplicationArea = All;
    Caption = 'Customer Assignments';
    PageType = List;
    SourceTable = "A01 Deadline Assignment";
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("No."; Rec."No.")
                {
                }
                field("Customer No."; Rec."Customer No.")
                {
                }
                field("Due status"; Rec."Due status")
                {
                }
                field("Assigment Status"; Rec."Assigment Status")
                {
                }
                field("Assigned to"; Rec."Assigned to")
                {
                }
                field("Assigned on"; Rec."Assigned on")
                {
                }
                field("Required action"; Rec."Required action")
                {
                }
                field("Customer Name"; Rec."Customer Name")
                {
                }
                field(Comment; Rec.Comment)
                {
                }
                field("Assigned by"; Rec."Assigned by")
                {
                }

                field(SystemModifiedBy; GetUserNameFromSecurityId(Rec.SystemModifiedBy))
                {
                    Caption = 'Modify by';
                }
                field(SystemModifiedAt; Rec.SystemModifiedAt)
                {
                }
                field(SystemCreatedBy; GetUserNameFromSecurityId(Rec.SystemCreatedBy))
                {
                    Caption = 'Created by';
                }
                field(SystemCreatedAt; Rec.SystemCreatedAt)
                {
                }

            }
        }
    }
    actions
    {
        area(Processing)
        {
            action(Application)
            {
                Image = ImportDatabase;
                ApplicationArea = Basic, Suite;
                Caption = 'Import Affectations';
                ShortCutKey = 'Shift+F11';
                RunObject = xmlport "A01 Import Affectations";
            }
        }
    }

    local procedure GetUserNameFromSecurityId(UserSecurityID: Guid): Code[50]
    var
        User: Record User;
    begin
        if (User.Get(UserSecurityID)) then
            exit(User."User Name");
    end;
}
