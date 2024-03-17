/// <summary>
/// Table A01 Customer Criteria (ID 50013).
/// </summary>
table 50013 "A01 Cust Scoring Criteria"
{
    Caption = 'Customer Criteria';
    DataClassification = CustomerContent;

    fields
    {
        field(1; "Customer No."; Code[20])
        {
            Caption = 'Customer No.';
            TableRelation = Customer;
            Editable = false;
        }
        field(2; Criteria; Code[20])
        {
            Caption = 'Criteria';
            TableRelation = "A01 Scoring Criteria";
            Editable = false;
        }
        field(3; Requirement; Enum "A01 Scoring Criteria Req")
        {
            Caption = 'Requirement';
            FieldClass = FlowField;
            CalcFormula = lookup("A01 Scoring Criteria".Requirement where(Code = field("Criteria")));
            Editable = false;
        }
        field(4; "Type"; Enum "A01 Scoring Criteria Type")
        {
            Caption = 'Type';
            FieldClass = FlowField;
            CalcFormula = lookup("A01 Scoring Criteria".Type where(Code = field("Criteria")));
            Editable = false;
        }
        field(5; "Numeric Value"; Decimal)
        {
            Caption = 'Numeric Value';
        }
        field(6; "Aplhanumeric Value"; Code[20])
        {
            Caption = 'Aplhanumeric Value';
        }
        field(7; "List Value"; Code[20])
        {
            Caption = 'List Value';
            TableRelation = "A01 Scoring Criteria";
        }
        field(8; Validity; Enum "A01 Scoring Criteria Validity")
        {
            Caption = 'Validity';
            FieldClass = FlowField;
            CalcFormula = lookup("A01 Scoring Criteria".Validity where(Code = field("Criteria")));
            Editable = false;
        }
        field(9; "Validity Date"; Date)
        {
            Caption = 'Validity Date';
        }
        field(10; "Document Required"; Boolean)
        {
            Caption = 'Document Required';
            FieldClass = FlowField;
            CalcFormula = lookup("A01 Scoring Criteria"."Document required" where(Code = field("Criteria")));
            Editable = false;
        }
        field(11; Valid; Boolean)
        {
            Caption = 'Valid';
        }
    }
    keys
    {
        key(PK; "Customer No.", Criteria)
        {
            Clustered = true;
        }
    }
}
