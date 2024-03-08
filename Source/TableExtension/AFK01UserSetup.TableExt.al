/// <summary>
/// TableExtension AFK01 User Setup (ID 50001) extends Record User Setup.
/// </summary>
tableextension 50001 "AFK01 User Setup" extends "User Setup"
{
    fields
    {
        field(50000; "AFK01 Can Cancel Sales Order"; Boolean)
        {
            Caption = 'Can Cancel Sales Order';
            DataClassification = CustomerContent;
        }
        field(50001; "AFK01 CanUpdateSalesOrderVal"; Boolean)
        {
            Caption = 'Can update Sales Order after vaidation';
            DataClassification = CustomerContent;
        }
    }
}
