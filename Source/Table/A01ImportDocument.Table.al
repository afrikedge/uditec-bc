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
    }
    keys
    {
        key(PK; "Entry No.")
        {
            Clustered = true;
        }
    }
}

