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
        field(50003; "A01 Ticket Format"; Code[10])
        {
            Caption = 'Ticket Format';
            TableRelation = "A01 Parameter Record".Code where(Type = const(TicketFormat));
            DataClassification = CustomerContent;
        }
        // field(50004; "A01 Maximum credit duration"; Integer)
        // {
        //     Caption = 'Maximum credit duration (Months)';
        //     DataClassification = CustomerContent;
        // }
        // field(50005; "A01 MIR Max credit duration"; Integer)
        // {
        //     Caption = 'Maximum credit duration (Mirindra)';
        //     DataClassification = CustomerContent;
        // }
        // field(50006; "A01 MIR Required Prepayment %"; Decimal)
        // {
        //     Caption = 'Required Prepayment % (Mirindra)';
        //     DataClassification = CustomerContent;
        // }
        // field(50007; "A01 MIR Monthly interest %"; Decimal)
        // {
        //     Caption = 'Monthly interest rate % (Mirindra)';
        //     DataClassification = CustomerContent;
        // }
        // field(50008; "A01 MIR Eligible Product"; Boolean)
        // {
        //     Caption = 'Eligible Product (Mirindra)';
        //     DataClassification = CustomerContent;
        // }
        field(50009; "A01 Prep required for credit"; Decimal)
        {
            Caption = 'Prepayment required for credit (%)';
            DataClassification = CustomerContent;
        }
        field(50010; "A01 Non Eligible credit sales"; Boolean)
        {
            Caption = 'Non Eligible for credit sales';
            DataClassification = CustomerContent;
        }
        field(50011; "A01 Assembly service"; Boolean)
        {
            Caption = 'Assembly service';
            DataClassification = CustomerContent;

        }
        field(50012; "A01 Brand"; Code[20])
        {
            Caption = 'Brand';
            TableRelation = "A01 Parameter Record".Code where(Type = const(Brand));
            DataClassification = CustomerContent;
        }



    }
}
