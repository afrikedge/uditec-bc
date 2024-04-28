tableextension 50027 "A01 Sales Invoice Line" extends "Sales Invoice Line"
{
    fields
    {
        field(50000; "A01 Shipment Method Code"; Code[10])
        {
            Caption = 'Shipment Method Code';
            TableRelation = "Shipment Method";
            DataClassification = CustomerContent;
        }
        field(50001; "A01 Promotion Line No."; integer)
        {
            Caption = 'Promotion Line No.';
            Editable = false;
            DataClassification = CustomerContent;
        }
    }
}
