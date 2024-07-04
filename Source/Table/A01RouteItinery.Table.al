table 50052 "A01 Route Itinery"
{
    Caption = 'Route Itinery';
    DataClassification = CustomerContent;

    fields
    {
        field(1; "Route Code"; Code[20])
        {
            Caption = 'Route Code';
        }
        field(2; "Departure Zone"; Code[20])
        {
            Caption = 'Departure Zone';
            TableRelation = Zone;
        }
        field(3; "Arrival Zone"; Code[20])
        {
            Caption = 'Arrival Zone';
            TableRelation = Zone;
        }
        field(4; "Route Type"; Enum "A01 Route Type")
        {
            Caption = 'Route Type';
        }
        field(5; "Time preference"; Enum "A01 Time Slot")
        {
            Caption = 'Time preference';
        }
        field(6; "Total Distance(Km)"; Decimal)
        {
            Caption = 'Total Distance(Km)';
        }
        field(7; "Average Duration"; decimal)
        {
            Caption = 'Average Duration';
        }
    }
    keys
    {
        key(PK; "Route Code", "Departure Zone", "Arrival Zone")
        {
            Clustered = true;
        }
    }
}
