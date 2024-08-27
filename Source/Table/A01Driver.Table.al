table 50049 "A01 Driver"
{
    Caption = 'Driver';
    DataClassification = CustomerContent;

    fields
    {
        field(1; "Code"; Code[20])
        {
            Caption = 'Code';
        }
        field(2; "Identification No."; Code[50])
        {
            Caption = 'Identification No.';
        }
        field(3; Name; Text[100])
        {
            Caption = 'Full Name';
        }
        field(4; "License No."; Code[50])
        {
            Caption = 'License No.';
        }
        field(5; "Licence Expiration Date"; Date)
        {
            Caption = 'Expiration Date';
        }
        field(6; "Phone No."; Text[30])
        {
            Caption = 'Phone No.';
        }
    }
    keys
    {
        key(PK; "Code")
        {
            Clustered = true;
        }
    }
}
