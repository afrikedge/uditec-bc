table 50055 "A01 Transport Order Detail"
{
    Caption = 'Transport Order Detail';
    DataClassification = CustomerContent;

    fields
    {
        field(1; "Transport Order No."; Code[20])
        {
            Caption = 'Transport Order No.';
        }
        field(2; "Order No."; Code[20])
        {
            Caption = 'Order No.';
        }
        field(3; "Line No."; Integer)
        {
            Caption = 'Line No.';
        }
        field(4; "Customer No."; Code[20])
        {
            Caption = 'Customer No.';
        }
        field(5; "Address Code"; Code[20])
        {
            Caption = 'Address Code';
        }
        field(6; "Time preference"; Enum "A01 Time Slot")
        {
            Caption = 'Time preference';
        }
        field(7; "Transport Direction"; Enum "A01 Transport Direction")
        {
            Caption = 'Transport Direction';
        }
        field(8; "Item No."; Code[20])
        {
            Caption = 'Item No.';
        }
        field(9; "Unit of Mesure Code"; Code[20])
        {
            Caption = 'Unit of Mesure Code';
        }
        field(10; "Quantity (Planned)"; Decimal)
        {
            Caption = 'Quantity (Planned)';
        }
        field(11; "Unloading Duration"; Decimal)
        {
            Caption = 'Unloading Duration';
        }
        field(12; "Total Volume (cbm)"; Decimal)
        {
            Caption = 'Total Volume (cbm)';
        }
        field(13; "Total Weight (Kg)"; Decimal)
        {
            Caption = 'Total Weight (Kg)';
        }
        field(14; "Quantity (Actual)"; Decimal)
        {
            Caption = 'Quantity (Actual)';
        }
        field(15; "Quantity (Gap)"; Decimal)
        {
            Caption = 'Quantity (Gap)';
        }
        field(16; "Gap Reason Code"; Code[20])
        {
            Caption = 'Gap Reason Code';
        }
        field(17; "Anomaly Type"; Enum "A01 Anomaly Type")
        {
            Caption = 'Anomaly Type';
        }
        field(18; "Anomaly Description"; Text[200])
        {
            Caption = 'Anomaly Description';
        }

    }
    keys
    {
        key(PK; "Transport Order No.", "Order No.", "Line No.")
        {
            Clustered = true;
        }
    }
}
