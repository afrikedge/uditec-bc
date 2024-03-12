/// <summary>
/// TableExtension A01 Item (ID 50004) extends Record Item.
/// </summary>
tableextension 50004 "A01 Item" extends Item
{
    fields
    {
        field(50000; "A01 Item Status"; Enum "A01 Item Status")
        {
            Caption = 'Item Status';
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(50002; "A01 Shipment Method Code"; Code[10])
        {
            Caption = 'Shipment Method Code';
            TableRelation = "Shipment Method";
            DataClassification = CustomerContent;
        }
    }
}
