/// <summary>
/// Table A01 Payment Promise (ID 50030).
/// </summary>
table 50030 "A01 Payment Promise"
{
    Caption = 'Payment Promise';
    DataClassification = CustomerContent;

    fields
    {
        field(1; "No."; Code[20])
        {
            Caption = 'No.';
        }
        field(2; Object; Text[30])
        {
            Caption = 'Object';
        }
        field(3; "Customer Account Type"; Enum "A01 Customer Account Type")
        {
            Caption = 'Customer Account Type';
        }
        field(4; "Customer Account No."; Code[20])
        {
            Caption = 'Customer Account No.';
        }
        field(5; Description; Text[50])
        {
            Caption = 'Description';
        }
        field(6; "Created By"; Code[50])
        {
            Caption = 'Created By';
            TableRelation = "A01 External User";
        }
        field(7; "Promise Date"; Date)
        {
            Caption = 'Promise Date';
        }
        field(8; "Amount promised"; Decimal)
        {
            Caption = 'Amount promised';
        }
        field(9; "Amount honored"; Decimal)
        {
            Caption = 'Amount honored';
        }
        field(10; "Followed by"; Code[50])
        {
            Caption = 'Followed by';
            TableRelation = "A01 External User";
        }
        field(11; Origin; Code[20])
        {
            Caption = 'Origin';
            TableRelation = "A01 Reminder";
        }
        field(12; Reminder; Enum "A01 Activity Type")
        {
            Caption = 'Reminder';
        }
        field(13; "Reminder deadline"; Date)
        {
            Caption = 'Reminder deadline';
        }
        field(14; Status; Enum "A01 Promise status")
        {
            Caption = 'Status';
        }
    }
    keys
    {
        key(PK; "No.")
        {
            Clustered = true;
        }
    }
}
