/// <summary>
/// Table A012 Reminder (ID 50026).
/// </summary>
table 50026 "A01 Reminder"
{
    Caption = '2 Reminder';
    DataClassification = CustomerContent;

    fields
    {
        field(1; "Type"; Enum "A01 Activity Type")
        {
            Caption = 'Type';
        }
        field(2; Description; Text[50])
        {
            Caption = 'Description';
        }
        field(3; "Created By"; Code[50])
        {
            Caption = 'Created By';
        }
        field(4; "Expected start date and time"; DateTime)
        {
            Caption = 'Expected start date and time';
        }
        field(5; "Expected end date and time"; DateTime)
        {
            Caption = 'Expected end date and time';
        }
        field(6; "Actual start date and time"; DateTime)
        {
            Caption = 'Actual start date and time';
        }
        field(7; "Actual end date and time"; DateTime)
        {
            Caption = 'Actual end date and time';
        }
        field(8; "Reminder date and time"; DateTime)
        {
            Caption = 'Reminder date and time';
        }
        field(9; "Related activity"; Integer)
        {
            Caption = 'Related activity';
        }
        field(10; Status; Enum "A01 Activity Status")
        {
            Caption = 'Status';
        }
        field(11; Observation; Text[150])
        {
            Caption = 'Observation';
        }
    }
    keys
    {
        key(PK; "Type")
        {
            Clustered = true;
        }
    }
}
