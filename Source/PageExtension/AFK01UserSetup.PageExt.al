/// <summary>
/// PageExtension AFK01 User Setup (ID 50001) extends Record User Setup.
/// </summary>
pageextension 50001 "AFK01 User Setup" extends "User Setup"
{
    layout
    {
        addafter(Email)
        {
            field("AFK01 Can Cancel Sales Order"; Rec."AFK01 Can Cancel Sales Order")
            {
                ApplicationArea = All;
            }
            field("AFK01 CanUpdateSalesOrderVal"; Rec."AFK01 CanUpdateSalesOrderVal")
            {
                ApplicationArea = All;
            }
        }
    }
}
