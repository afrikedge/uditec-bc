/// <summary>
/// TableExtension A01 Sales Invoice Header (ID 50025) extends Record Sales Invoice Header.
/// </summary>
tableextension 50025 "A01 Sales Invoice Header" extends "Sales Invoice Header"
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
        field(50015; "A01 Web User Id"; Code[50])
        {
            Caption = 'Web User Id';
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(50016; "A01 Order Web User Id"; Code[50])
        {
            Caption = 'Web user order creator';
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(50017; "A01 AGP Contract No."; Code[50])
        {
            Caption = 'AGP Contract No.';
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(50018; "A01 Request Status"; Enum "A01 Approval Status")
        {
            Caption = 'Approval Status';
            Editable = false;
            DataClassification = CustomerContent;
        }
        field(50019; "A01 Sales Order Type"; Enum "A01 Sales Order Type")
        {
            Caption = 'Sales Order Type';
            Editable = false;
            DataClassification = CustomerContent;
        }
    }

}
