table 50061 "A01 Neighborhood"
{
    Caption = 'Neighborhood';
    DataClassification = CustomerContent;
    LookupPageId = "A01 Neighborhood List";

    fields
    {
        field(1; City; Code[30])
        {
            Caption = 'City';
            TableRelation = "Post Code".City;
        }
        field(2; Municipality; Text[50])
        {
            Caption = 'Municipality';
        }
        field(3; Neighborhood; Text[50])
        {
            Caption = 'Neighborhood';
        }
        field(4; "Delivery Axis"; Code[10])
        {
            Caption = 'Delivery Axis';
            TableRelation = "Service Zone";
        }
    }
    keys
    {
        key(PK; City, Municipality, Neighborhood)
        {
            Clustered = true;
        }
    }
}
