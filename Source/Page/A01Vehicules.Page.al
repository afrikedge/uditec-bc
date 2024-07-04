page 50100 "A01 Vehicules"
{
    ApplicationArea = All;
    Caption = 'Vehicules';
    PageType = List;
    SourceTable = "A01 Vehicule";
    UsageCategory = Lists;
    
    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field("Registration No."; Rec."Registration No.")
                {
                }
                field("Vehicle Type"; Rec."Vehicle Type")
                {
                }
                field(Brand; Rec.Brand)
                {
                }
                field(Mode; Rec.Mode)
                {
                }
                field("Useful height (m)"; Rec."Useful height (m)")
                {
                }
                field("Useful length (m)"; Rec."Useful length (m)")
                {
                }
                field("Useful width (m)"; Rec."Useful width (m)")
                {
                }
                field("Useful volume (cbm)"; Rec."Useful volume (cbm)")
                {
                }
                field("Payload (kg)"; Rec."Payload (kg)")
                {
                }
                field("Carrier No."; Rec."Carrier No.")
                {
                }
                field("Default Driver No."; Rec."Default Driver No.")
                {
                }
                field("Vehicle Status"; Rec."Vehicle Status")
                {
                }
                field("Fixed Asset No."; Rec."Fixed Asset No.")
                {
                }
            }
        }
    }
}
