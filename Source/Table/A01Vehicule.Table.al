table 50050 "A01 Vehicule"
{
    Caption = 'Vehicule';
    DataClassification = CustomerContent;

    fields
    {
        field(1; "Registration No."; Code[30])
        {
            Caption = 'Registration No.';
        }
        field(2; "Vehicle Type"; Enum "A01 Vehicle Status")
        {
            Caption = 'Vehicle Type';
        }
        field(3; Brand; Text[50])
        {
            Caption = 'Brand';
        }
        field(4; Mode; Text[50])
        {
            Caption = 'Mode';
        }
        field(5; "Useful length (m)"; Decimal)
        {
            Caption = 'Useful length (m)';
            trigger OnValidate()
            begin
                CalcVolume();
            end;
        }
        field(6; "Useful width (m)"; Decimal)
        {
            Caption = 'Useful width (m)';
            trigger OnValidate()
            begin
                CalcVolume();
            end;
        }
        field(7; "Useful height (m)"; Decimal)
        {
            Caption = 'Useful height (m)';
            trigger OnValidate()
            begin
                CalcVolume();
            end;
        }
        field(8; "Useful volume (cbm)"; Decimal)
        {
            Caption = 'Useful volume (cbm)';
            Editable = false;
        }
        field(9; "Payload (kg)"; Decimal)
        {
            Caption = 'Payload (kg)';
        }
        field(10; "Carrier No."; Code[20])
        {
            Caption = 'Carrier No.';
            TableRelation = Vendor;
        }
        field(11; "Default Driver No."; Code[20])
        {
            Caption = 'Default Driver No.';
            TableRelation = "A01 driver";
        }
        field(12; "Vehicle Status"; Enum "A01 Vehicle Status")
        {
            Caption = 'Vehicle Status';
        }
        field(13; "Fixed Asset No."; Code[20])
        {
            Caption = 'Fixed Asset No.';
            TableRelation = "Fixed Asset";
        }
    }
    keys
    {
        key(PK; "Registration No.")
        {
            Clustered = true;
        }
    }
    local procedure CalcVolume()
    var
    begin
        "Useful volume (cbm)" := "Useful length (m)" * "Useful width (m)" * "Useful height (m)";
    end;
}
