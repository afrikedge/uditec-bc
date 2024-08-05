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








        //Specific on customer
        field(50200; "A01 Prospect No."; Code[20])
        {
            Caption = 'Prospect No.';
            DataClassification = CustomerContent;
            TableRelation = Contact;
        }
        field(50201; "A01 Proposed Credit Limit"; Decimal)
        {
            Caption = 'Proposed Credit Limit';
            DataClassification = CustomerContent;
            //TableRelation = Contact;
        }
        field(50202; "A01 Calc Risk Level"; Code[20])
        {
            Caption = 'Calculated Risk Level';
            DataClassification = CustomerContent;
            Editable = false;
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
        modify("Responsibility Center")
        {
            trigger OnAfterValidate()
            var
                RespCenter: Record "Responsibility Center";
            begin
                if (RespCenter.Get("Responsibility Center")) then begin
                    if (RespCenter."A01 Customer Price Group" <> '') then
                        if ("Customer Price Group" = '') then
                            Rec.Validate("Customer Price Group", RespCenter."A01 Customer Price Group");
                end;
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

    trigger OnInsert()
    var
    begin
        if ("Credit Limit (LCY)" = 0) then
            "Credit Limit (LCY)" := 1;
    end;

    procedure CalcCustStatus(): Code[20]
    var
        //Cust: Record Customer;
        CustDebtStatus: Record "A01 Customer Debt Status";
        CustLedgerEntry: Record "Cust. Ledger Entry";

        TresoMgt: Codeunit "A01 Treso Mgt";
        DueDays: Integer;
        MaxDueDays: Integer;
        RiskOfMaxDueDate: Code[20];
        foundInCreditLine: Boolean;
    begin
        //if (Cust.Get(CustNo)) then begin
        if ("A01 Risk Level" <> '') then begin
            CustDebtStatus.Reset();
            CustDebtStatus.SetRange("Risk Level", "A01 Risk Level");
            if (CustDebtStatus.FindFirst()) then
                exit(CustDebtStatus.Code);
        end;

        //end;


        MaxDueDays := 0;
        RiskOfMaxDueDate := '';

        CustLedgerEntry.Reset();
        CustLedgerEntry.SetCurrentKey("Customer No.", Open, Positive, "Due Date", "Currency Code");
        CustLedgerEntry.SetRange("Customer No.", Rec."No.");
        CustLedgerEntry.SetRange(Open, true);
        CustLedgerEntry.SetRange(Positive, true);
        if CustLedgerEntry.FindSet() then
            repeat
                foundInCreditLine := DocumentFountInCreditDueLine(MaxDueDays, RiskOfMaxDueDate);
                if (not foundInCreditLine) then begin
                    DueDays := TresoMgt.GetDueDays(CustLedgerEntry);
                    if (DueDays >= MaxDueDays) then begin
                        RiskOfMaxDueDate := GetRiskLevel(DueDays);
                        MaxDueDays := DueDays;
                    end;
                end;
            until CustLedgerEntry.Next() < 1;

        exit(RiskOfMaxDueDate);

    end;

    local procedure GetRiskLevel(DueDays: Integer): Code[20]
    var
        CustDebtStatus: Record "A01 Customer Debt Status";
    begin
        CustDebtStatus.Reset();
        //CustDebtStatus.SetFilter("Minimum (Days)", '>=%1', DueDays);
        CustDebtStatus.SetFilter("Maximum (Days)", '>=%1', DueDays);
        CustDebtStatus.SetRange("Risk Level", '');
        if (CustDebtStatus.FindFirst()) then
            exit(CustDebtStatus.Code);
    end;

    procedure UpdateDueDateOnAmortisationLines(NewCustEntryDueDate: Date; DocumentNo: Code[20])
    var
        CreditAmortLine: Record "A01 Credit Depreciation Table";
        LineDueDate: Date;
    begin
        LineDueDate := NewCustEntryDueDate;

        CreditAmortLine.Reset();
        CreditAmortLine.SetRange("Document Type", CreditAmortLine."Document Type"::"Posted Sales invoice");
        CreditAmortLine.SetRange("Document No.", DocumentNo);
        if CreditAmortLine.FindSet(true) then
            repeat
                CreditAmortLine."Due Date" := LineDueDate;
                CreditAmortLine.Modify();
                LineDueDate := CalcDate('<1M>', LineDueDate);
            until CreditAmortLine.Next() < 1;
    end;

    local procedure DocumentFountInCreditDueLine(var MaxDueDays: integer; var RiskOfMaxDueDate: Code[20]): Boolean
    var
        CreditDueLine: Record "A01 Credit Depreciation Table";
        //TresoMgt: Codeunit "A01 Treso Mgt";
        DueDays: Integer;
        Found: Boolean;
    begin
        //Table des echeancier de dettes
        //Recherche du plus grand retarc aussi dans les lignes du tableau d'amortissement
        CreditDueLine.Reset();
        CreditDueLine.SetCurrentKey("Customer No.", Closed);
        CreditDueLine.SetRange("Customer No.", Rec."No.");
        CreditDueLine.SetRange(Closed, false);
        if CreditDueLine.FindSet() then
            repeat
                Found := true;
                DueDays := CreditDueLine.GetDueDays();
                if (DueDays >= MaxDueDays) then begin
                    RiskOfMaxDueDate := GetRiskLevel(DueDays);
                    MaxDueDays := DueDays;
                end;
            until CreditDueLine.Next() < 1;
        exit(Found);
    end;
}
