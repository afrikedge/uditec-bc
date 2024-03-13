tableextension 50008 "A01 Payment Terms" extends "Payment Terms"
{
    fields
    {
        field(50000; "A01 Sales Mode"; Code[20])
        {
            Caption = 'Sales Mode';
            DataClassification = CustomerContent;
            TableRelation = "Dimension Value" where("Global Dimension No." = const(3));
        }
        field(50001; "A01 Multi-deadlines"; Boolean)
        {
            Caption = 'Multi-deadlines';
            DataClassification = CustomerContent;
        }
        field(50002; "A01 Prepayment (%)"; Decimal)
        {
            Caption = 'Prepayment (%)';
            DataClassification = CustomerContent;
            MinValue = 0;
            MaxValue = 100;
        }
    }
}
