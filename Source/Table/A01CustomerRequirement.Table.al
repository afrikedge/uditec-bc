/// <summary>
/// Table A01 Customer Requirement (ID 50012).
/// </summary>
table 50012 "A01 Customer Requirement"
{
    Caption = 'Customer Requirement';
    DataClassification = CustomerContent;

    fields
    {
        field(1; "Type"; Enum "A01 Customer Type")
        {
            Caption = 'Type';
        }
        field(2; "Legal Form"; Enum "A01 Legal Status")
        {
            Caption = 'Legal Form';
        }
        field(3; "Identification Mode"; Enum "Tax Identification Type")
        {
            Caption = 'Identification Mode';
        }
        field(4; "Scoring Criteria"; Code[20])
        {
            Caption = 'Scoring Criteria';
        }
        field(5; Status; Enum "A01 Cust Requirement Status")
        {
            Caption = 'Status';
        }
    }
    keys
    {
        key(PK; "Type")
        {
            Clustered = true;
        }
    }
}
