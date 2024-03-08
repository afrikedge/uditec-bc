/// <summary>
/// Table AFK01 Document Step History (ID 50000).
/// </summary>
table 50000 "A01 Document Step History"
{
    Caption = 'Document Step History';
    DataClassification = CustomerContent;

    fields
    {
        field(1; "Document Type"; Enum "A01 DocTypeStepHistory")
        {
            Caption = 'Document Type';
        }
        field(2; "Document No."; Code[50])
        {
            Caption = 'Document No.';
        }
        field(3; "Step ID"; Integer)
        {
            Caption = 'Step ID';
        }
        field(4; "Action"; Enum "A01 ActionStepHistory")
        {
            Caption = 'Action';
        }
        field(5; "New Status"; Text[50])
        {
            Caption = 'New Status';
        }
        field(6; "User ID"; Code[50])
        {
            Caption = 'User ID';
        }
        field(7; "Action Date"; DateTime)
        {
            Caption = 'Action Date';
        }
        field(8; "Created Document"; Code[20])
        {
            Caption = 'Created Document';
        }
        field(9; "New Status ID"; Integer)
        {
            Caption = 'New Status ID';
        }
        field(10; "User Name"; Text[100])
        {
            Caption = 'User Name';
        }
    }
    keys
    {
        key(PK; "Document Type", "Document No.", "Step ID")
        {
            Clustered = true;
        }
    }
}
