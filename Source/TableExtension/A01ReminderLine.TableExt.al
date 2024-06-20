/// <summary>
/// TableExtension A01 Reminder Line (ID 50021) extends Record Reminder Line.
/// </summary>
tableextension 50021 "A01 Reminder Line" extends "Reminder Line"
{
    fields
    {
        field(50000; "A01 Debt Status"; Code[20])
        {
            Caption = 'Debt Status';
            DataClassification = CustomerContent;
            TableRelation = "A01 Customer Debt Status";
            Editable = false;
        }
        field(50001; "A01 Installment"; Decimal)
        {
            Caption = 'Installment';
            DataClassification = CustomerContent;
        }
        field(50002; "A01 Amount Due"; Decimal)
        {
            Caption = 'Amount Due';
            DataClassification = CustomerContent;
        }
        field(50003; "A01 Sales Store"; Code[20])
        {
            Caption = 'Sales Store';
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(1));
            DataClassification = CustomerContent;
        }
        field(50004; "A01 Sales Mode"; Code[20])
        {
            Caption = 'Sales Mode';
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(3));
            DataClassification = CustomerContent;
        }
    }
}
