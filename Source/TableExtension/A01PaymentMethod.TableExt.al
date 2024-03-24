/// <summary>
/// TableExtension A01 Payment Method (ID 50016) extends Record Payment Method.
/// </summary>
tableextension 50016 "A01 Payment Method" extends "Payment Method"
{
    fields
    {
        field(50000; "A01 Approval required"; Boolean)
        {
            Caption = 'Approval required';
            DataClassification = CustomerContent;
        }
        field(50001; "A01 Reference required"; Boolean)
        {
            Caption = 'Reference required';
            DataClassification = CustomerContent;
        }
    }
}
