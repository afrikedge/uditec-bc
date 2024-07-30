table 50058 "A01 SR Spare Part"
{
    Caption = 'SR Spare Part';
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
        field(3; "Item No."; Code[20])
        {
            Caption = 'Item No.';
        }
        field(4; Description; Text[100])
        {
            Caption = 'Description';
        }
        field(5; "Unit of Measure Code"; Code[20])
        {
            Caption = 'Unit of Measure Code';
        }
        field(6; Quantity; Decimal)
        {
            Caption = 'Quantity';
        }
        field(7; "Usage Status"; Enum "A01 Usage Status")
        {
            Caption = 'Usage Status';
        }
        field(8; Usage; Text[100])
        {
            Caption = 'Usage';
        }
        field(9; Observations; Text[250])
        {
            Caption = 'Observations';
        }
        field(10; "Spare Status"; enum "A01 SR Spare Status")
        {
            Caption = 'Status';
        }

    }
    keys
    {
        key(PK; "Service Request No.", "Spare Status", "Line No.")
        {
            Clustered = true;
        }
    }
}
