/// <summary>
/// Table A01 Scoring Criteria (ID 50010).
/// </summary>
table 50010 "A01 Scoring Criteria"
{
    Caption = 'Scoring Criteria';
    DataClassification = CustomerContent;

    fields
    {
        field(1; "Code"; Code[20])
        {
            Caption = 'Code';
        }
        field(2; Description; Text[50])
        {
            Caption = 'Description';
        }
        field(3; Requirement; Enum "A01 Scoring Criteria Req")
        {
            Caption = 'Requirement';
        }
        field(4; Validity; Enum "A01 Scoring Criteria Validity")
        {
            Caption = 'Validity';
        }
        field(5; Coefficient; Decimal)
        {
            Caption = 'Coefficient';
            InitValue = 1;
        }
        field(6; "Point Maximal"; Decimal)
        {
            Caption = 'Point Maximal';
        }
        field(7; "Document required"; Boolean)
        {
            Caption = 'Document required';
        }
        field(8; "Type"; Enum "A01 Scoring Criteria Type")
        {
            Caption = 'Type';
        }
        field(9; Size; Integer)
        {
            Caption = 'Size';
        }
    }
    keys
    {
        key(PK; "Code")
        {
            Clustered = true;
        }
    }
}
