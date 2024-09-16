table 50051 "A01 Route"
{
    Caption = 'Route';
    DataClassification = CustomerContent;

    fields
    {
        field(1; "Code"; Code[20])
        {
            Caption = 'Code';
        }
        field(2; Description; Text[100])
        {
            Caption = 'Description';
        }
        field(3; "Route Type"; Enum "A01 Route Type")
        {
            Caption = 'Route Type';
        }
        field(4; "Route Status"; Enum "Routing Status")
        {
            Caption = 'Route Status';
        }
        field(5; "Departure Zone"; Code[20])
        {
            Caption = 'Departure Zone';
            TableRelation = "Service Zone";
        }
        field(6; "Arrival Zone"; Code[20])
        {
            Caption = 'Arrival Zone';
            TableRelation = "Service Zone";
        }
        field(7; "Total Distance(Km)"; Decimal)
        {
            Caption = 'Total Distance(Km)';
        }
        field(8; "Average Duration"; decimal)
        {
            Caption = 'Average Duration';
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
