/// <summary>
/// TableExtension A01 Sales Line (ID 50013) extends Record Sales Line.
/// </summary>
tableextension 50013 "A01 Sales Line" extends "Sales Line"
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
        field(50002; "A01 Markup"; Decimal)
        {
            Caption = 'Markup';
            //Editable = false;
            DataClassification = CustomerContent;
        }

        modify("No.")
        {
            trigger OnAfterValidate()
            var
                Item1: Record Item;
            begin
                if (Item1.get("No.")) then
                    Rec."A01 Shipment Method Code" := Item1."A01 Shipment Method Code";
            end;
        }
        // modify("Prepayment %")
        // {
        //     trigger OnAfterValidate()
        //     var
        //         Item1: Record Item;
        //     begin
        //         if (Item1.get("No.")) then
        //             if (Item1."A01 Cancel Prepayment") then
        //                 rec.Validate("Prepayment %", 0);
        //         //Rec."A01 Shipment Method Code" := Item1."A01 Shipment Method Code";
        //     end;
        // }
    }
}
