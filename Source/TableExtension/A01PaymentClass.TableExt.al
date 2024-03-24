/// <summary>
/// TableExtension A01 Payment Class (ID 50011) extends Record Payment Class.
/// </summary>
tableextension 50011 "A01 Payment Class" extends "Payment Class"
{
    fields
    {
        field(50000; "A01 Responsibility Center"; Code[20])
        {
            Caption = 'Responsibility Center';
            DataClassification = CustomerContent;
            TableRelation = "Responsibility Center";
        }
        field(50001; "A01 Payment Method"; Code[20])
        {
            Caption = 'Payment Method';
            DataClassification = CustomerContent;
            TableRelation = "Payment Method";
        }
    }
}
