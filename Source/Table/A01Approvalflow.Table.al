/// <summary>
/// Table A01 Approval flow (ID 50022).
/// </summary>
table 50022 "A01 Approval Flow"
{
    Caption = 'Approval flow';
    DataClassification = CustomerContent;

    fields
    {
        field(1; "Document Type"; Enum "A01 Approval Flow Doc Type")
        {
            Caption = 'Document No.';
        }
        field(2; "Document No."; Code[20])
        {
            Caption = 'Document No.';
        }
        field(3; "Sequence No."; Integer)
        {
            Caption = 'Sequence No.';
        }
        field(4; Method; Enum "A01 Approval Flow Method")
        {
            Caption = 'Method';
        }
        field(5; "Approved On"; DateTime)
        {
            Caption = 'Approved On';
        }
        field(6; "Approved By"; Code[50])
        {
            Caption = 'Approved By';
        }
        field(7; "Approved As"; Code[50])
        {
            Caption = 'Approved As';
        }
        field(8; "Actual Status"; Enum "A01 Propect Validation Status")
        {
            Caption = 'Actual Status';
        }
        field(9; "Next Status"; Enum "A01 Propect Validation Status")
        {
            Caption = 'Next Status';
        }
        field(10; Comments; Text[150])
        {
            Caption = 'Comments';
        }
    }
    keys
    {
        key(PK; "Document Type", "Document No.", "Sequence No.")
        {
            Clustered = true;
        }
    }
}
