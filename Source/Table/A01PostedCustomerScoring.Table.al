table 50045 "A01 Posted Customer Scoring"
{
    Caption = 'Posted Customer Scoring';
    DataClassification = CustomerContent;

    fields
    {
        field(1; "Account Type"; Enum "A01 Customer Account Type")
        {
            Caption = 'Account Type';
            DataClassification = CustomerContent;
        }
        field(18; "Customer No."; Code[20])
        {
            Caption = 'Customer No.';
            DataClassification = CustomerContent;
            TableRelation = if ("Account Type" = const("Customer")) Customer
            else if ("Account Type" = const("Prospect")) Contact;
        }
        // field(1; "Customer No."; Code[20])
        // {
        //     Caption = 'Customer No.';
        //     TableRelation = "Customer";
        // }
        // field(10; "Lead No."; Code[20])
        // {
        //     Caption = 'Lead No.';
        //     TableRelation = "Contact";
        // }
        field(2; Criteria; Code[20])
        {
            Caption = 'Criteria';
            TableRelation = "A01 Scoring Criteria";
        }
        field(3; Type; Enum "A01 Scoring Criteria Type")
        {
            Caption = 'Type';
            FieldClass = FlowField;
            CalcFormula = lookup("A01 Scoring Criteria".Type where(Code = field("Criteria")));
            Editable = false;
        }
        field(4; "Criteria Value"; Code[20])
        {
            Caption = 'Criteria Value';
            TableRelation = "A01 Scoring Criteria Value" where(Criteria = field(Criteria));
        }
        field(5; Validity; Enum "A01 Scoring Criteria Validity")
        {
            Caption = 'Validity';
            FieldClass = FlowField;
            CalcFormula = lookup("A01 Scoring Criteria".Validity where(Code = field("Criteria")));
            Editable = false;
        }
        field(6; "Validity Date"; Date)
        {
            Caption = 'Validity Date';
        }
        field(7; "Document Required"; Boolean)
        {
            Caption = 'Document Required';
            FieldClass = FlowField;
            CalcFormula = lookup("A01 Scoring Criteria"."Document required" where(Code = field("Criteria")));
            Editable = false;
        }
        field(8; Valid; Boolean)
        {
            Caption = 'Valid';
        }
        field(9; Score; Decimal)
        {
            Caption = 'Score';
        }
        field(12; DocumentLink; Text[200])
        {
            Caption = 'Document link';
        }
        field(13; "Sales Mode"; Code[20])
        {
            Caption = 'Sales Mode';
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(3));
            DataClassification = CustomerContent;
        }
        field(14; Precision; Text[50])
        {
            Caption = 'Precision';
        }
        field(15; Coefficient; Decimal)
        {
            Caption = 'Coefficient';
        }
        field(16; "Weighted Score"; Decimal)
        {
            Caption = 'Weighted Score';
        }
        field(17; "Modified By"; Code[50])
        {
            Caption = 'Modified By';
            TableRelation = "A01 External User";
            DataClassification = CustomerContent;
        }

        field(50000; "Document No."; Code[20])
        {
            Caption = 'Document No.';
            DataClassification = CustomerContent;
        }

    }
    keys
    {
        key(PK; "Document No.", "Account Type", "Customer No.", Criteria)
        {
            Clustered = true;
        }
    }
}
