/// <summary>
/// Table A01 Payment Type Configuration (ID 50007).
/// </summary>
Table 50007 "A01 Payment Type Configuration"
{
    Caption = 'Payment Type Configuration';
    DataClassification = CustomerContent;

    fields
    {
        field(1; "Journal Template Name"; Code[10])
        {
            Caption = 'Journal Template Name';
            TableRelation = "Gen. Journal Template";

        }
        field(2; "Journal Batch Name"; Code[10])
        {
            Caption = 'Journal Batch Name';
            TableRelation = "Gen. Journal Batch".Name where("Journal Template Name" = field("Journal Template Name"));
        }
        field(3; "Payment Type"; Enum "A01 Payment Doc Type")
        {
            Caption = 'Payment Type';
        }
        field(4; "Payment Class"; Text[30])
        {
            Caption = 'Payment Class';
            TableRelation = "Payment Class";
        }
    }
    keys
    {
        key(PK; "Journal Template Name")
        {
            Clustered = true;
        }
    }
}
