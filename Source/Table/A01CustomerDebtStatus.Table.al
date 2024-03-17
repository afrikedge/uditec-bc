/// <summary>
/// Table Customer Debt Status (ID 50009).
/// </summary>
table 50009 "A01 Customer Debt Status"
{
    Caption = 'Customer Debt Status';
    DataClassification = CustomerContent;

    fields
    {
        field(1; "Code"; Code[10])
        {
            Caption = 'Code';
        }
        field(2; Description; Text[50])
        {
            Caption = 'Description';
        }
        field(3; "Risk Level"; Code[20])
        {
            Caption = 'Risk Level';
            TableRelation = "A01 Parameter Record" where(Type = const(RiskLevel));

        }
        field(4; "Minimum (Days)"; Integer)
        {
            Caption = 'Minimum (Days)';
            MinValue = 0;
        }
        field(5; "Maximum (Days)"; Integer)
        {
            Caption = 'Maximum (Days)';
            MinValue = 0;
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
