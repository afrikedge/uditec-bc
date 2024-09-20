/// <summary>
/// PageExtension A01 User Setup (ID 50011) extends Record User Setup.
/// </summary>
pageextension 50011 "A01 User Setup" extends "User Setup"
{
    layout
    {
        addafter(LicenseType)
        {
            field("A01 Discount Limit Group"; Rec."A01 Discount Limit Group")
            {
                ApplicationArea = Basic, Suite;
            }
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
            field("A01 Print Whse Delivery"; Rec."A01 Print Whse Delivery")
            {
                ApplicationArea = Basic, Suite;
            }
            field("A01 Can Bypass Closed Period"; Rec."A01 Can Bypass Closed Period")
            {
                ApplicationArea = Basic, Suite;
            }
            field("A01 Can Set Sales Price"; Rec."A01 Can Set Sales Price")
            {
                ApplicationArea = Basic, Suite;
            }
            field("A01 Can Set Sales Discount"; Rec."A01 Can Set Sales Discount")
            {
                ApplicationArea = Basic, Suite;
            }


        }
        addafter("Allow Posting To")
        {
            field("A01 GL Period Group"; Rec."A01 GL Period Group")
            {
                ApplicationArea = Basic, Suite;
            }
        }
    }
}
