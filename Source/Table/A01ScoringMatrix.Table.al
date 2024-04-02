/// <summary>
/// Table A01 Scoring Matrix (ID 50014).
/// </summary>
table 50014 "A01 Scoring Matrix"
{
    Caption = 'Scoring Matrix';
    DataClassification = CustomerContent;

    fields
    {
        field(1; "Sales Mode"; Code[20])
        {
            Caption = 'Sales Mode';
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(3));
        }
        field(2; "Criteria"; Code[20])
        {
            Caption = 'Criteria';
            TableRelation = "A01 Scoring Criteria";
        }
        field(3; Coefficient; Decimal)
        {
            Caption = 'Coefficient';
            FieldClass = FlowField;
            CalcFormula = lookup("A01 Scoring Criteria".Coefficient where(Code = field("Criteria")));
            Editable = false;
        }
        field(4; "Criteria Value"; Code[20])
        {
            Caption = 'Criteria Value';
            TableRelation = "A01 Scoring Criteria Value" where(Criteria = field(Criteria));
        }
        field(5; "Point"; Decimal)
        {
            Caption = 'Point';
            trigger OnValidate()
            begin
                Rec.CalcFields(Coefficient);
                Rec."Weighted Point" := Rec.Point * Rec.Coefficient;
            end;
        }
        field(6; "Weighted Point"; Decimal)
        {
            Caption = 'Weighted Point';
            Editable = false;
        }
    }
    keys
    {
        key(PK; "Sales Mode", Criteria, "Criteria Value")
        {
            Clustered = true;
        }
    }
}
