/// <summary>
/// Table A01 Deadline assignment (ID 50025).
/// </summary>
table 50025 "A01 Deadline Assignment"
{
    Caption = 'Deadline assignment';
    DataClassification = CustomerContent;

    fields
    {
        field(1; "Deadline No."; Integer)
        {
            Caption = 'Deadline No.';
        }
        field(2; "Document Date"; Date)
        {
            Caption = 'Document Date';
        }
        field(3; "Due Date"; Date)
        {
            Caption = 'Due Date';
        }
        field(4; "Assigned on"; Date)
        {
            Caption = 'Assigned on';
            Editable = false;
        }
        field(5; "Assigned by"; Code[50])
        {
            Caption = 'Assigned by';
            Editable = false;
        }
        field(6; "Assigned to"; Code[50])
        {
            Caption = 'Assigned to';
            Editable = false;
        }
        field(7; "Due status"; Code[10])
        {
            Caption = 'Due status';
            Editable = false;
            TableRelation = "A01 Customer Debt Status";
        }
        field(8; "Required action"; Enum "A01 Activity Type")
        {
            Caption = 'Required action';
        }
        field(9; Comment; Text[150])
        {
            Caption = 'Comment';
        }
        field(10; "Customer Entry No."; Integer)
        {
            Caption = 'Customer Entry No.';
            TableRelation = "Cust. Ledger Entry";
        }
        field(17; "Modified By"; Code[50])
        {
            Caption = 'Modified By';
            TableRelation = "A01 External User";
            DataClassification = CustomerContent;
        }
    }
    keys
    {
        key(PK; "Deadline No.")
        {
            Clustered = true;
        }
    }
}
