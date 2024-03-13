/// <summary>
/// TableExtension A01 Customer (ID 50006) extends Record Customer.
/// </summary>
tableextension 50006 "A01 Customer" extends Customer
{
    fields
    {
        field(50000; "A01 Customer Type"; Enum "A01 Customer Type")
        {
            Caption = 'Customer Type';
            DataClassification = CustomerContent;
        }
        field(50001; "A01 Legal Status"; enum "A01 Legal Status")
        {
            Caption = 'Legal Status';
            DataClassification = CustomerContent;
        }
        field(50002; "A01 Risk Level"; Code[20])
        {
            Caption = 'Risk Level';
            DataClassification = CustomerContent;
            TableRelation = "A01 Parameter Record" where(Type = const(RiskLevel));
        }
    }
}
