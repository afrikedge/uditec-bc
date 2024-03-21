/// <summary>
/// TableExtension AFK01 Sales Header (ID 50000) extends Record Sales Header.
/// </summary>
tableextension 50000 "A01 Sales Header" extends "Sales Header"
{
    fields
    {
        field(50000; "A01 Processing Status"; Enum "A01 SO Processing Status")
        {
            Caption = 'Processing Status';
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(50001; "A01 Return Reason"; Text[250])
        {
            Caption = 'Return Reason';
            DataClassification = CustomerContent;
        }
        field(50002; "A01 Observations"; Text[250])
        {
            Caption = 'Observations';
            DataClassification = CustomerContent;
        }
        field(50003; "A01 User Id"; Code[50])
        {
            Caption = 'User Id';
            DataClassification = CustomerContent;
            TableRelation = User."User Name";
            Editable = false;
        }
        field(50004; "A01 Delivery Autorised by"; Code[50])
        {
            Caption = 'Delivery Autorised by';
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(50005; "A01 Delivery Autorised On"; DateTime)
        {
            Caption = 'Delivery Autorised On';
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(50006; "A01 Allow Deletion"; Boolean)
        {
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(50007; "A01 Credit Validation Status"; Enum "A01 Credit Validation Status")
        {
            Caption = 'Validation Status';
            DataClassification = CustomerContent;
        }
        field(50008; "A01 Credit Duration (Month)"; Integer)
        {
            Caption = 'Credit Duration (Month)';
            DataClassification = CustomerContent;
        }
        field(50009; "A01 Sales Mode"; Code[20])
        {
            Caption = 'Sales Mode';
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(3));
            DataClassification = CustomerContent;
            trigger OnValidate()
            begin
                Rec.ValidateShortcutDimCode(3, "A01 Sales Mode");
            end;
        }
        field(50010; "A01 Interest rate"; Decimal)
        {
            Caption = 'Interest rate %';
            DataClassification = CustomerContent;
            MinValue = 0;
            MaxValue = 100;
        }
        field(50011; "A01 Analyst comments"; Text[200])
        {
            Caption = 'Analyst comments';
            DataClassification = CustomerContent;
        }
        field(50012; "A01 System Decision"; Enum "A01 System Decision")
        {
            Caption = 'System Decision';
            DataClassification = CustomerContent;
        }
        field(50013; "A01 Analyst Opinion"; Enum "A01 Eligibility Opinion")
        {
            Caption = 'Analyst Opinion';
            DataClassification = CustomerContent;
        }
        field(50014; "A01 Investigator Opinion"; Enum "A01 Eligibility Opinion")
        {
            Caption = 'Investigator Opinion';
            DataClassification = CustomerContent;
        }
        modify("Sell-to Customer No.")
        {
            trigger OnAfterValidate()
            var
                Cust1: Record Customer;
            begin
                if (Cust1.get("Sell-to Customer No.")) then
                    Rec.validate("A01 Sales Mode", Cust1."A01 Sales Mode");
            end;
        }

    }
}
