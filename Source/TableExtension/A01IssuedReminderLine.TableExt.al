/// <summary>
/// TableExtension A01 Issued Reminder Line (ID 50022) extends Record Issued Reminder Line.
/// </summary>
tableextension 50022 "A01 Issued Reminder Line" extends "Issued Reminder Line"
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
