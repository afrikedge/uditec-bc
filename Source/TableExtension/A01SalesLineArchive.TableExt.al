/// <summary>
/// TableExtension A01 Sales Line Archive (ID 50014) extends Record Sales Line Archive.
/// </summary>
tableextension 50014 "A01 Sales Line Archive" extends "Sales Line Archive"
{
    fields
    {
        field(50000; "A01 Shipment Method Code"; Code[10])
        {
            Caption = 'Shipment Method Code';
            TableRelation = "Shipment Method";
            DataClassification = CustomerContent;
        }
    }
}
