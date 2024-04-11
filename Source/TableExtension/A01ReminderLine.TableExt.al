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
        }
    }
}
