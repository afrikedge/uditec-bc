tableextension 50032 "A01 Posted Whse. Shipment Head" extends "Posted Whse. Shipment Header"
{
    fields
    {
        field(50000; "A01 No. Printed"; Integer)
        {
            Caption = 'No. Printed';
            DataClassification = CustomerContent;
            Editable = false;
        }
    }
}
