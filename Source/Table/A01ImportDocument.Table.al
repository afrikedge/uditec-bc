/// <summary>
/// Table A01 Import Document (ID 50044).
/// </summary>
table 50044 "A01 Import Document"
{
    Caption = 'Import Doc';
    DataClassification = CustomerContent;

    fields
    {
        field(1; "Entry No."; Integer)
        {
            Caption = 'Entry No.';
        }
        field(2; "Posting Date"; Code[20])
        {
            Caption = 'Posting Date';
        }
        field(3; "Document No."; Code[20])
        {
            Caption = 'Document No.';
        }
        field(4; "External Doc No."; Code[20])
        {
            Caption = 'External Doc No.';
        }
        field(5; "Account No."; Code[20])
        {
            Caption = 'Account No.';
        }
        field(6; Amount; Decimal)
        {
            Caption = 'Amount';
        }
        field(7; Description; Text[100])
        {
            Caption = 'Description';
        }
        field(8; UserId; Text[50])
        {
            Caption = 'UserId';
        }
        field(9; IntValue; Integer)
        {
            Caption = 'IntValue';
        }
        field(10; "Account Name"; Text[100])
        {
        }
        field(11; "Reference30_1"; Code[30])
        {
        }
        field(12; "Reference30_2"; Code[30])
        {
        }
        field(13; "Reference30_3"; Code[30])
        {
        }
        field(14; "Reference50_1"; Text[50])
        {
        }
        field(15; "Texte100_1"; Text[100])
        {
        }
        field(16; "Texte100_2"; Text[100])
        {
        }
        field(17; "Texte100_3"; Text[100])
        {
        }
        field(18; Amount2; Decimal)
        {
        }
        field(19; Amount3; Decimal)
        {
        }
        field(20; "Code20_1"; Code[20])
        {
        }
        field(21; "Code20_2"; Code[20])
        {
        }
        field(22; "Code20_3"; Code[20])
        {
        }
        field(23; "Reference30_4"; Code[30])
        {
        }
        field(24; "Code10_1"; Code[10])
        {
        }
    }
    keys
    {
        key(PK; "Entry No.")
        {
            Clustered = true;
        }
    }
}

