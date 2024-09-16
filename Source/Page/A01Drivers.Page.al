page 50099 "A01 Drivers"
{
    ApplicationArea = All;
    Caption = 'Drivers';
    PageType = List;
    SourceTable = "A01 Driver";
    UsageCategory = Lists;

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field("Code"; Rec."Code")
                {
                }
                field("Identification No."; Rec."Identification No.")
                {
                }
                field(Name; Rec.Name)
                {
                }
                field("License No."; Rec."License No.")
                {
                }
                field("Licence Expiration Date"; Rec."Licence Expiration Date")
                {
                }
                field("Phone No."; Rec."Phone No.")
                {

                }
            }
        }
    }
}
