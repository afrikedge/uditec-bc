/// <summary>
/// PageExtension A01 User Setup (ID 50011) extends Record User Setup.
/// </summary>
pageextension 50011 "A01 User Setup" extends "User Setup"
{
    layout
    {
        addafter(LicenseType)
        {
            field("A01 Can Cancel Sales Order"; Rec."A01 Can Cancel Sales Order")
            {
                ApplicationArea = Basic, Suite;
            }
            field("A01 Can Close Sales Order"; Rec."A01 Can Close Sales Order")
            {
                ApplicationArea = Basic, Suite;
            }
            field("A01 CanUpdateSalesOrderVal"; Rec."A01 CanUpdateSalesOrderVal")
            {
                ApplicationArea = Basic, Suite;
            }
            field("A01 Sales Resp. Filter 2"; Rec."A01 Sales Resp. Filter 2")
            {
                ApplicationArea = Basic, Suite;
            }
            field("A01 Sales Resp. Filter 3"; Rec."A01 Sales Resp. Filter 3")
            {
                ApplicationArea = Basic, Suite;
            }
            field("A01 Disable Resp Center Filter"; Rec."A01 Disable Resp Center Filter")
            {
                ApplicationArea = Basic, Suite;
            }
        }
    }
}
