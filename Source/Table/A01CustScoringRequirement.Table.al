/// <summary>
/// Table A01 Customer Requirement (ID 50012).
/// </summary>
table 50012 "A01 Cust Scoring Requirement"
{
    Caption = 'Customer Requirement';
    DataClassification = CustomerContent;

    fields
    {
        field(1; "Customer Type"; Enum "A01 Customer Type")
        {
            Caption = 'Customer Type';
        }
        field(2; "Legal Form"; Enum "A01 Legal Status")
        {
            Caption = 'Legal Form';
        }
        field(3; "Identification Mode"; Enum "A01 Cust Identification Mode")
        {
            Caption = 'Identification Mode';
        }
        field(4; "Scoring Criteria"; Code[20])
        {
            Caption = 'Scoring Criteria';
            TableRelation = "A01 Scoring Criteria";
        }
        field(5; "Requirement Status"; Enum "A01 Cust Requirement Status")
        {
            Caption = 'Requirement Status';
        }
    }
    keys
    {
        key(PK; "Customer Type")
        {
            Clustered = true;
        }
    }
}
