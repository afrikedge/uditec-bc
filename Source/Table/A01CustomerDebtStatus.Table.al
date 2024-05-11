/// <summary>
/// Table Customer Debt Status (ID 50009).
/// </summary>
table 50009 "A01 Customer Debt Status"
{
    Caption = 'Customer Debt Status';
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
        field(3; "Risk Level"; Code[20])
        {
            Caption = 'Risk Level';
            TableRelation = "A01 Parameter Record".Code where(Type = const(RiskLevel));
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
        field(6; "Company fees (%)"; Decimal)
        {
            Caption = 'Company fees (%)';
            MinValue = 0;
            MaxValue = 100;
        }
        field(7; "Agent fees partial (%)"; Decimal)
        {
            Caption = 'Agent fees partial (%)';
            MinValue = 0;
            MaxValue = 100;
        }
        field(8; "Agent fees full (%)"; Decimal)
        {
            Caption = 'Agent fees full (%)';
            MinValue = 0;
            MaxValue = 100;
        }
        field(9; "WSSA Point"; Decimal)
        {
            Caption = 'WSSA Point';
        }
        field(10; "WSCA Point"; Decimal)
        {
            Caption = 'WSCA Point';
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
