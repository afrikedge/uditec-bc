/// <summary>
/// Page A01 Deadline Assignment List (ID 50049).
/// </summary>
page 50049 "A01 Deadline Assignment List"
{
    ApplicationArea = All;
    Caption = 'Deadlines Assignment';
    PageType = List;
    SourceTable = "A01 Deadline Assignment";
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("Customer No."; Rec."Customer No.")
                {
                }
                field("Deadline No."; Rec."Deadline No.")
                {
                }
                field("Document No."; Rec."Document No.")
                {
                }
                field("Assigned to"; Rec."Assigned to")
                {
                }
                field("Assigned on"; Rec."Assigned on")
                {
                }
                field("Document Date"; Rec."Document Date")
                {
                }
                field("Due Date"; Rec."Due Date")
                {
                }
                field("Due status"; Rec."Due status")
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

    local procedure GetUserNameFromSecurityId(UserSecurityID: Guid): Code[50]
    var
        User: Record User;
    begin
        if (User.Get(UserSecurityID)) then
            exit(User."User Name");
    end;
}
