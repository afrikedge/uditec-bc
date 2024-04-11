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
        field(50006; "A01 Parent Customer"; Code[20])
        {
            Caption = 'Parent Customer';
            DataClassification = CustomerContent;
            TableRelation = Customer;
        }
        field(50007; "A01 Allowed Item Category"; Code[20])
        {
            Caption = 'Allowed Item Category';
            DataClassification = CustomerContent;
            TableRelation = "Item Category";
        }
        field(50008; "A01 Preferred Reminder Mode"; Enum "A01 Activity Type")
        {
            Caption = 'Preferred Reminder Mode';
            DataClassification = CustomerContent;
        }
        field(50009; "A01 Contract No."; Code[20])
        {
            Caption = 'Contract No.';
            TableRelation = "A01 AGP Contrat";
            DataClassification = CustomerContent;
        }
        field(50010; "A01 NIF"; Code[30])
        {
            Caption = 'NIF';
            DataClassification = CustomerContent;
        }
        field(50011; "A01 STAT"; Code[30])
        {
            Caption = 'STAT';
            DataClassification = CustomerContent;
        }
        field(50012; "A01 RCS"; Code[30])
        {
            Caption = 'RCS';
            DataClassification = CustomerContent;
        }
        field(50013; "A01 CIF"; Code[30])
        {
            Caption = 'CIF';
            DataClassification = CustomerContent;
        }
        field(50014; "A01 ID Number"; Code[30])
        {
            Caption = 'ID Number';
            DataClassification = CustomerContent;
        }
        field(50015; "A01 Created By"; Code[50])
        {
            Caption = 'Created By';
            DataClassification = CustomerContent;
        }
        field(50016; "A01 Modified By"; Code[50])
        {
            Caption = 'Modified By';
            DataClassification = CustomerContent;
        }








        //Specific on customer
        field(50100; "A01 Prospect No."; Code[20])
        {
            Caption = 'Prospect No.';
            DataClassification = CustomerContent;
            TableRelation = Contact;
        }
        // field(50101; "A01 Modified By"; Code[50])
        // {
        //     Caption = 'Modified By';
        //     DataClassification = CustomerContent;
        //     TableRelation = "A01 External User";
        // }


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
    trigger OnDelete()
    var
        CustRequirement: Record "A01 Cust Scoring Criteria";
        CustScoring: Record "A01 Customer Scoring";
    begin
        CustRequirement.Reset();
        CustRequirement.SetRange("Account Type", CustRequirement."Account Type"::Customer);
        CustRequirement.SetRange("Customer No.", Rec."No.");
        if (not CustRequirement.IsEmpty) then
            CustRequirement.DeleteAll();

        CustScoring.Reset();
        CustScoring.SetRange("Account Type", CustScoring."Account Type"::Customer);
        CustScoring.SetRange("Customer No.", Rec."No.");
        if (not CustScoring.IsEmpty) then
            CustScoring.DeleteAll();
    end;
}
