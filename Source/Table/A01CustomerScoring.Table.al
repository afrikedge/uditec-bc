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
        }
        field(2; Criteria; Code[20])
        {
            Caption = 'Criteria';
        }
        field(3; Requirement; Code[20])
        {
            Caption = 'Requirement';
        }
        field(4; "Type"; Enum "A01 Scoring Criteria Type")
        {
            Caption = 'Type';
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
        }
        field(9; "Validity Date"; Date)
        {
            Caption = 'Validity Date';
        }
        field(10; "Document Required"; Boolean)
        {
            Caption = 'Document Required';
        }
        field(11; Valid; Boolean)
        {
            Caption = 'Valid';
        }
    }
    keys
    {
        key(PK; "Customer No.")
        {
            Clustered = true;
        }
    }
}
