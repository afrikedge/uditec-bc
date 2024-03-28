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
            TableRelation = "A01 Parameter Record".Code where(Type = const(RiskLevel));
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
            trigger OnValidate()
            begin
                Rec.ValidateShortcutDimCode(3, "A01 Sales Mode");
            end;
        }
        field(50005; "A01 Account Type"; Enum "A01 Customer Account Type")
        {
            Caption = 'Account Type';
            DataClassification = CustomerContent;
        }
        field(50006; "A01 Prospect No."; Code[20])
        {
            Caption = 'Prospect No.';
            DataClassification = CustomerContent;
            TableRelation = Contact;
        }
        field(50007; "A01 Modified By"; Code[50])
        {
            Caption = 'Modified By';
            DataClassification = CustomerContent;
            TableRelation = "A01 External User";
        }
        field(50008; "A01 Parent Customer"; Code[20])
        {
            Caption = 'Parent Customer';
            DataClassification = CustomerContent;
            TableRelation = Customer;
        }
        field(50009; "A01 Allowed Item Category"; Code[20])
        {
            Caption = 'Allowed Item Category';
            DataClassification = CustomerContent;
            TableRelation = "Item Category";
        }
        modify("Payment Terms Code")
        {
            trigger OnAfterValidate()
            var
                PayTerms: record "Payment Terms";
            begin
                if PayTerms.get("Payment Terms Code") then
                    Rec.TestField("A01 Sales Mode", PayTerms."A01 Sales Mode");
            end;
        }
    }
}
