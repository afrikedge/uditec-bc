table 50059 "A01 SR Assignment Flow"
{
    Caption = 'SR Assignment Flow';
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
        field(3; "Assigned On"; Date)
        {
            Caption = 'Assigned On';
        }
        field(4; "Assigned By"; Code[50])
        {
            Caption = 'Assigned By';
        }
        field(5; "Current Status"; Enum "A01 ServiceRequest Status")
        {
            Caption = 'Current Status';
        }
        field(6; "Assigned To"; Code[50])
        {
            Caption = 'Assigned To';
        }
        field(7; "Next Status"; Enum "A01 ServiceRequest Status")
        {
            Caption = 'Next Status';
        }
        field(8; Notes; Text[250])
        {
            Caption = 'Notes';
        }
        field(9; "Starting Date"; Date)
        {
            Caption = 'Starting Date';
        }
        field(10; Deadline; Date)
        {
            Caption = 'Deadline';
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
