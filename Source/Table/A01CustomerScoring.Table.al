/// <summary>
/// Table A01 Customer Scoring (ID 50015).
/// </summary>
table 50015 "A01 Customer Scoring"
{
    Caption = 'Customer Scoring';
    DataClassification = CustomerContent;

    fields
    {
        field(1; "Customer No."; Code[20])
        {
            Caption = 'Customer No.';
            TableRelation = "Customer";
        }
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
        // field(9; Precision; Code)
        // {
        //     Caption = 'Point';
        // }
    }
    keys
    {
        key(PK; "Customer No.", Criteria)
        {
            Clustered = true;
        }
    }
}
