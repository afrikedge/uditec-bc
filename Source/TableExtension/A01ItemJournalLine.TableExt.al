tableextension 50034 "A01 Item Journal Line" extends "Item Journal Line"
{
    fields
    {
        field(50000; A01Difference; Decimal)
        {
            Caption = 'Difference';
            DataClassification = CustomerContent;
            Editable = false;
        }
        modify("Qty. (Calculated)")
        {
            trigger OnAfterValidate()
            var
            begin
                A01Difference := "Qty. (Phys. Inventory)" - "Qty. (Calculated)";
            end;
        }
        modify("Qty. (Phys. Inventory)")
        {
            trigger OnAfterValidate()
            var
            begin
                A01Difference := "Qty. (Phys. Inventory)" - "Qty. (Calculated)";
            end;
        }
    }

}
