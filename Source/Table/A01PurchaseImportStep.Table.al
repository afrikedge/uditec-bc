/// <summary>
/// Table A01 Purchase Import Step (ID 50021).
/// </summary>
table 50021 "A01 Purchase Import Step"
{
    Caption = 'Purchase Import Step';
    DataClassification = CustomerContent;

    fields
    {
        field(1; "Document Type"; Enum "Purchase Document Type")
        {
            Caption = 'Document Type';
        }
        field(2; "Document No."; Code[20])
        {
            Caption = 'Document No.';
        }
        field(3; "Step Type"; Enum "A01 Import Step Type")
        {
            Caption = 'Step Type';
        }
        field(4; "Step Code"; Code[20])
        {
            Caption = 'Step Code';
            TableRelation = if ("Step Type" = const(Step)) "A01 Parameter Record" where(Type = const(ImportStep));
        }
        field(6; Notes; Text[100])
        {
            Caption = 'Notes';
        }
        field(5; "Step Description"; Text[100])
        {
            Caption = 'Step Description';
            FieldClass = FlowField;
            Editable = false;
            CalcFormula = lookup("A01 Parameter Record".Description
                where(Type = const(ImportStep), Code = field("Step Code")));
        }
        field(7; "Step Status"; Enum "A01 Import Step Status")
        {
            Caption = 'Step Status';
        }
        field(8; "Starting Date"; Date)
        {
            Caption = 'Starting Date';
        }
        field(9; "Due Date"; Date)
        {
            Caption = 'Due Date';
        }
        field(10; Notify; Boolean)
        {
            Caption = 'Notify';
        }
        field(11; "Notify Date"; Date)
        {
            Caption = 'Notify Date';
        }
        field(12; "Line No."; Integer)
        {
            Caption = 'Line No.';
        }
        field(13; "Notified"; Boolean)
        {
            Caption = 'Notified';
            Editable = false;
        }
        field(14; "Archived"; Boolean)
        {
            Caption = 'Archived';
            Editable = false;
        }

    }
    keys
    {
        key(PK; "Document Type", "Document No.", "Line No.")
        {
            Clustered = true;
        }
    }
}
