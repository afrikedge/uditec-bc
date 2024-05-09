tableextension 50031 "A01 Transfer Line" extends "Transfer Line"
{
    fields
    {
        modify("Item No.")
        {
            trigger OnBeforeValidate()
            var
                itemMgt: Codeunit "A01 Inventory Mgt";
            begin
                itemMgt.CheckLineModification(Rec);
            end;
        }
        modify(Quantity)
        {
            trigger OnBeforeValidate()
            var
                itemMgt: Codeunit "A01 Inventory Mgt";
            begin
                itemMgt.CheckLineModification(Rec);
            end;
        }
    }
}
