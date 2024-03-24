/// <summary>
/// Table A01 Afk Setup (ID 50017).
/// </summary>
table 50017 "A01 Afk Setup"
{
    Caption = 'Afk Setup';
    DataClassification = CustomerContent;


    fields
    {
        field(1; "MIR Maximum credit duration"; Integer)
        {
            Caption = 'Maximum credit duration';
        }
        field(2; "MIR Required Deposit %"; Decimal)
        {
            Caption = 'Required Deposit %';
            MinValue = 0;
            MaxValue = 100;
        }
        field(3; "MIR Monthly interest rate %"; Decimal)
        {
            Caption = 'Monthly interest rate %';
            MinValue = 0;
            MaxValue = 100;
        }
        field(4; "MIR No of cumulative credits"; Integer)
        {
            Caption = 'Number of cumulative credits';
        }
        field(5; "MIR No of products per file"; Integer)
        {
            Caption = 'Number of products per file';
        }
        field(6; "MIR Site visit required"; Enum "A01 MIR Site visit required")
        {
            Caption = 'Site visit required';
        }
        field(7; "MIR Eligibility area"; Decimal)
        {
            Caption = 'Eligibility area';
        }
        field(8; "MIR Sales minimum value"; Decimal)
        {
            Caption = 'Sales minimum value';
        }
        field(9; "MIR Application fees (%)"; Decimal)
        {
            Caption = 'Application fees (%)';
            MinValue = 0;
            MaxValue = 100;
        }
        field(10; "MIR Discounts allowed"; Boolean)
        {
            Caption = 'Discounts allowed';
        }
        field(11; "MIR Due rounding rule"; Enum "A01 MIR Due rounding rule")
        {
            Caption = 'Due rounding rule';
        }
        field(12; "MIR Item for interest"; Code[20])
        {
            Caption = 'Item for interest';
            TableRelation = Item where(Type = const(Service));
        }
        field(13; "MIR Sales Mode"; Code[20])
        {
            Caption = 'Sales Mode';
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(3));
        }
        field(14; "MIR Item for application fees"; Code[20])
        {
            Caption = 'Item for application fees';
            TableRelation = Item where(Type = const(Service));
        }
        field(15; "Minimum Delivery per trip"; Integer)
        {
            Caption = 'Minimum Delivery per trip';
        }
        field(16; "AGP credit duration"; Integer)
        {
            Caption = 'AGP credit duration';
        }
        field(17; "AGP Transferable part %"; Decimal)
        {
            Caption = 'AGP Transferable part %';
            MinValue = 0;
            MaxValue = 100;
        }
        field(18; "AGP Discounts allowed"; Boolean)
        {
            Caption = 'AGP Discounts allowed';
        }
        field(19; "AGP Sales minimum value"; Decimal)
        {
            Caption = 'AGP Sales minimum value';
        }
        field(20; "AGP Operation duration (Month)"; Integer)
        {
            Caption = 'AGP Operation duration (Month)';
        }
        field(21; "SAV diagnostic time"; Integer)
        {
            Caption = 'SAV diagnostic time';
        }
        field(22; "Code"; Code[10])
        {
            Caption = 'Code';
        }
        field(23; "MIR Eligible Products"; Enum "A01 MIR Eligible Product Mode")
        {
            Caption = 'Eligible Products';
        }
    }
    keys
    {
        key(PK; "Code")
        {
            Clustered = true;
        }
    }
    var
        RecordHasBeenRead: Boolean;
    /// <summary>
    /// 
    /// </summary>
    procedure GetRecordOnce()
    begin
        if RecordHasBeenRead then
            exit;
        Get();
        RecordHasBeenRead := true;
    end;
}
