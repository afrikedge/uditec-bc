/// <summary>
/// TableExtension A01 Contact (ID 50005) extends Record Contact.
/// </summary>
tableextension 50005 "A01 Contact" extends Contact
{
    fields
    {
        field(50001; "A01 Legal Status"; Enum "A01 Legal Status")
        {
            Caption = 'Legal Status';
            DataClassification = CustomerContent;
        }
        field(50002; "A01 Payment Terms Code"; Code[10])
        {
            Caption = 'Payment Terms Code';
            TableRelation = "Payment Terms";
            DataClassification = CustomerContent;

            trigger OnValidate()
            var
                PayTerms: record "Payment Terms";
            begin
                if PayTerms.get("A01 Payment Terms Code") then
                    Rec.TestField("A01 Sales Mode", PayTerms."A01 Sales Mode");
            end;
        }
        field(50003; "A01 Identification Mode"; Enum "A01 Cust Identification Mode")
        {
            Caption = 'Identification Mode';
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
