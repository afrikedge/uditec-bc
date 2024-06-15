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
        field(50007; "A01 Credit Validation Status"; Enum "A01 Approval Status")
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
        field(50011; "A01 Analyst comments"; Text[300])
        {
            Caption = 'Analyst comments';
            DataClassification = CustomerContent;

        }
        field(50012; "A01 System Decision"; Enum "A01 System Decision")
        {
            Caption = 'System Decision';
            DataClassification = CustomerContent;
        }
        field(50013; "A01 Analyst Opinion"; Enum "A01 Credit Request Opinion")
        {
            Caption = 'Analyst Opinion';
            DataClassification = CustomerContent;
        }
        field(50014; "A01 Investigator Opinion"; Enum "A01 Credit Request Opinion")
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
            trigger OnValidate()
            var
                AGPContract: Record "A01 AGP Contrat";
            begin
                if (AGPContract.Get("A01 AGP Contract No.")) then begin
                    Rec.Validate("A01 Credit Duration (Month)", AGPContract.CalcSalesCreditDuration("Posting Date"));
                    Rec.Validate("Due Date", AGPContract.CalcSalesFirstDueDate("Posting Date"));
                end;

            end;
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
            DataClassification = CustomerContent;
            trigger OnValidate()
            var
            begin
                SOMgt.ChangePostingNosSeries(Rec);
                AfkSetup.GetRecordOnce();
                if ("A01 Sales Order Type" = "A01 Sales Order Type"::Exempt) then
                    Rec.Validate("VAT Bus. Posting Group", AfkSetup."Exempt VAT Bus. Posting Group");
            end;
        }
        field(50020; "A01 Monthly Capacity"; Decimal)
        {
            Caption = 'Monthly Capacity';
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(50021; "A01 Miscellaneous Contact"; Code[20])
        {
            Caption = 'Miscellaneous Contact';
            DataClassification = CustomerContent;
            TableRelation = Contact;
            //Editable = false;
            trigger OnValidate()
            var
                Contact1: Record Contact;
                Cust: Record Customer;
            begin
                if (Cust.Get("Sell-to Customer No.")) then begin
                    if (Cust."A01 Customer Type" = Cust."A01 Customer Type"::Miscellaneous) then
                        if (Contact1.Get("A01 Miscellaneous Contact")) then begin
                            "Sell-to Customer Name" := Contact1.Name;
                            "Sell-to Address" := Contact1.Address;
                            "Sell-to Address 2" := Contact1."Address 2";
                            "Sell-to City" := Contact1.City;
                            "Sell-to Country/Region Code" := Contact1."Country/Region Code";
                            "Sell-to E-Mail" := Contact1."E-Mail";
                            "Sell-to Phone No." := Contact1."Phone No.";
                            "Sell-to Post Code" := Contact1."Post Code";
                            "Sell-to County" := Contact1.County;
                        end;
                end;
            end;
        }
        field(50022; "A01 Joint Type"; Enum "A01 Credit Joint Type")
        {
            Caption = 'Joint Type';
            DataClassification = CustomerContent;
        }
        field(50023; "A01 Joint Code"; Code[20])
        {
            Caption = 'Joint Code';
            DataClassification = CustomerContent;
            TableRelation = if ("A01 Joint Type" = const(Contact)) Contact else if ("A01 Joint Type" = const(Customer)) Customer;
        }
        field(50024; "A01 Collection Opinion"; Enum "A01 Credit Request Opinion")
        {
            Caption = 'Collection Opinion';
            DataClassification = CustomerContent;
        }
        field(50025; "A01 Manager Opinion"; Enum "A01 Credit Request Opinion")
        {
            Caption = 'Manager Opinion';
            DataClassification = CustomerContent;
        }
        field(50026; "A01 Manager Comments"; Text[300])
        {
            Caption = 'Manager Comments';
            DataClassification = CustomerContent;
        }
        field(50027; "A01 Collection Comments"; Text[300])
        {
            Caption = 'Collection Comments';
            DataClassification = CustomerContent;
        }
        field(50028; "A01 Investigator Comments"; Text[300])
        {
            Caption = 'Collection Comments';
            DataClassification = CustomerContent;
        }
        field(50029; "A01 Max Approved Rate (%)"; Decimal)
        {
            Caption = 'Max Approved Rate (%)';
            DataClassification = CustomerContent;
        }
        field(50030; "A01 Max Referred Rate (%)"; Decimal)
        {
            Caption = 'Max Referred Rate (%)';
            DataClassification = CustomerContent;
        }
        field(50031; "A01 Joint Required"; Boolean)
        {
            Caption = 'Joint Required';
            DataClassification = CustomerContent;
        }
        field(50032; "A01 Rec. Amount"; Decimal)
        {
            Caption = 'Recommended Amount';
            DataClassification = CustomerContent;
        }
        field(50033; "A01 Rec. Duration"; Integer)
        {
            Caption = 'Recommended Duration';
            DataClassification = CustomerContent;
        }
        field(50034; "A01 Rec. Deposit (%)"; Decimal)
        {
            Caption = 'Recommended Deposit (%)';
            DataClassification = CustomerContent;
        }
        field(50035; "A01 General Comment"; Text[300])
        {
            Caption = 'General Comment';
            DataClassification = CustomerContent;
        }






        modify("Sell-to Customer No.")
        {
            trigger OnAfterValidate()
            var
                Cust1: Record Customer;
            begin
                if (Cust1.Get("Sell-to Customer No.")) then begin
                    Rec.validate("A01 Sales Mode", Cust1."A01 Sales Mode");
                    Rec.Validate("A01 AGP Contract No.", Cust1."A01 Contract No.");

                end;
            end;
        }
    }

    trigger OnDelete()
    var
        CreditDueLine: Record "A01 Credit Depreciation Table";
    begin
        if ("Document Type" = Rec."Document Type"::Order) then begin
            CreditDueLine.SetRange("Document Type", CreditDueLine."Document Type"::"Sales order");
            CreditDueLine.SetRange("Document No.", Rec."No.");
            if (not CreditDueLine.IsEmpty) then
                CreditDueLine.DeleteAll();
        end;
        if ("Document Type" = Rec."Document Type"::Quote) then begin
            CreditDueLine.SetRange("Document Type", CreditDueLine."Document Type"::"Sales Quote");
            CreditDueLine.SetRange("Document No.", Rec."No.");
            if (not CreditDueLine.IsEmpty) then
                CreditDueLine.DeleteAll();
        end;
    end;

    var
        AfkSetup: Record "A01 Afk Setup";
        SOMgt: codeunit "A01 Sales Order Processing";
}
