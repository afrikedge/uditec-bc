table 50057 "A01 SR Item Movement"
{
    Caption = 'SR Item Movement';
    DataClassification = CustomerContent;

    fields
    {
        field(1; "Service Request No."; Code[20])
        {
            Caption = 'Service Request No.';
        }
        field(2; "Line No."; Integer)
        {
            Caption = 'Line No.';
        }
        field(3; "Movement Date"; Date)
        {
            Caption = 'Movement Date';
        }
        field(4; "Movement Type"; Enum "A01 ItemMovementType")
        {
            Caption = 'Movement Type';
        }
        field(5; "From Location Code"; Code[20])
        {
            Caption = 'From Location Code';
            TableRelation = "Location";
        }
        field(6; "From Bin Code"; Code[20])
        {
            Caption = 'From Bin Code';
            TableRelation = "Bin".Code where("Location Code" = field("From Location Code"));
        }
        field(7; "To Location Code"; Code[20])
        {
            Caption = 'To Location Code';
            TableRelation = "Location";
        }
        field(8; "To Bin Code"; Code[20])
        {
            Caption = 'To Bin Code';
            TableRelation = "Bin".Code where("Location Code" = field("To Location Code"));
        }
        field(9; "Movement Description"; Text[100])
        {
            Caption = 'Movement Description';
        }
    }
    keys
    {
        key(PK; "Service Request No.", "Line No.")
        {
            Clustered = true;
        }
    }
}
