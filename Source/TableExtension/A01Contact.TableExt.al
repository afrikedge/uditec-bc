/// <summary>
/// TableExtension A01 Contact (ID 50005) extends Record Contact.
/// </summary>
tableextension 50005 "A01 Contact" extends Contact
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
        field(50017; "A01 Employee Number"; Code[30])
        {
            Caption = 'Employee Number';
            DataClassification = CustomerContent;
        }
        field(50018; "A01 Employee Function"; Code[50])
        {
            Caption = 'Employee Function';
            DataClassification = CustomerContent;
        }
        field(50019; "A01 Employee Salary"; Decimal)
        {
            Caption = 'Employee Salary';
            DataClassification = CustomerContent;
        }
        field(50020; "A01 Professional Category"; Enum "A01 Professional Category")
        {
            Caption = 'Professional Category';
            DataClassification = CustomerContent;
        }
        field(50021; "A01 Name of employer_Activity"; Text[100])
        {
            Caption = 'Name of employer / type of activity';
            DataClassification = CustomerContent;
        }
        field(50022; "A01 Employer address_Activity"; Text[100])
        {
            Caption = 'Employer address or activity';
            DataClassification = CustomerContent;
        }
        field(50023; "A01 General Comment"; Text[300])
        {
            Caption = 'General Comments';
            DataClassification = CustomerContent;
        }
        field(50024; "A01 Gender"; enum A01Gender)
        {
            Caption = 'Gender';
            DataClassification = CustomerContent;
        }







        //Only for contact not on Customer
        field(50100; "A01 VAT Regime"; Code[20])
        {
            Caption = 'VAT Regime';
            DataClassification = CustomerContent;
            TableRelation = "VAT Business Posting Group";
        }
        field(50101; "A01 Main Contact"; Code[20])
        {
            Caption = 'Main Contact';
            DataClassification = CustomerContent;
            TableRelation = Contact;
        }
        field(50102; "A01 Prepayment required"; Decimal)
        {
            Caption = 'Prepayment required (%)';
            DataClassification = CustomerContent;
            MinValue = 0;
            MaxValue = 0;
        }

        field(50103; "A01 Score"; Decimal)
        {
            Caption = 'Score';
            DataClassification = CustomerContent;
        }
        field(50104; "A01 Prospect Status"; Enum "A01 Propect Validation Status")
        {
            Caption = 'Prospect Status';
            DataClassification = CustomerContent;
        }
        field(50105; "A01 Payment Terms Code"; Code[10])
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
        field(50106; "A01 Payment Method"; Code[10])
        {
            Caption = 'Payment Method';
            DataClassification = CustomerContent;
            TableRelation = "Payment Method";
        }
        field(50107; "A01 Credit Limit"; Decimal)
        {
            Caption = 'Credit Limit';
            DataClassification = CustomerContent;
            InitValue = 1;
        }
        field(50108; "A01 Contact Type"; Enum "A01 Contact Type")
        {
            Caption = 'Contact Type';
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(50109; "A01 Customer Price Group"; Code[10])
        {
            Caption = 'Customer Price Group';
            TableRelation = "Customer Price Group";
            DataClassification = CustomerContent;
        }
        field(50110; "A01 Relationship"; Text[50])
        {
            Caption = 'Relationship';
            DataClassification = CustomerContent;
        }
    }
    trigger OnInsert()
    var
        ParamUser: Record "User Setup";
        RespCenter: Record "Responsibility Center";
    begin
        if (ParamUser.Get(UserId)) then
            if (RespCenter.Get(ParamUser."Sales Resp. Ctr. Filter")) then
                if (RespCenter."A01 Customer Price Group" <> '') then
                    if ("A01 Customer Price Group" = '') then
                        "A01 Customer Price Group" := RespCenter."A01 Customer Price Group";
    end;
}
