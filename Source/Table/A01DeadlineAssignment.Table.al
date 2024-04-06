/// <summary>
/// Table A01 Deadline assignment (ID 50025).
/// </summary>
table 50025 "A01 Deadline Assignment"
{
    Caption = 'Deadline assignment';
    DataClassification = CustomerContent;

    fields
    {
        field(1; "Customer No."; Code[20])
        {
            Caption = 'Customer No.';
            TableRelation = Customer;
        }
        field(2; "Deadline No."; Integer)
        {
            Caption = 'Deadline No.';
            TableRelation = "Cust. Ledger Entry"."Entry No." where(Open = const(true), "Customer No." = field("Customer No."), Positive = const(true));
            trigger OnValidate()
            var
                CustLedgerEntry: Record "Cust. Ledger Entry";
            begin
                if (CustLedgerEntry.Get("Deadline No.")) then begin
                    "Document Date" := CustLedgerEntry."Document Date";
                    "Due Date" := CustLedgerEntry."Due Date";
                    "Due status" := CalcRiskLevel(CustLedgerEntry);
                    "Document No." := CustLedgerEntry."Document No.";
                end;

            end;
        }
        field(3; "Document Date"; Date)
        {
            Caption = 'Document Date';
            Editable = false;
        }
        field(4; "Assigned to"; Code[50])
        {
            Caption = 'Assigned to';
            TableRelation = "A01 External User";
        }
        field(12; "Document No."; Code[20])
        {
            Caption = 'Document No.';
            Editable = false;
        }
        field(5; "Customer Name"; Text[100])
        {
            Caption = 'Customer Name';
            Editable = false;
            FieldClass = FlowField;
            CalcFormula = lookup(Customer.Name where("No." = field("Customer No.")));
        }
        field(6; "Due Date"; Date)
        {
            Caption = 'Due Date';
            Editable = false;
        }
        field(7; "Assigned on"; Date)
        {
            Caption = 'Assigned on';
        }
        field(8; "Assigned by"; Code[50])
        {
            Caption = 'Assigned by';
            TableRelation = "A01 External User";
        }

        field(9; "Due status"; Code[20])
        {
            Caption = 'Due status';
            //Editable = false;
            TableRelation = "A01 Customer Debt Status";
        }
        field(10; "Required action"; Enum "A01 Activity Type")
        {
            Caption = 'Required action';
        }
        field(11; Comment; Text[150])
        {
            Caption = 'Comment';
        }
        // field(12; "Customer Entry No."; Integer)
        // {
        //     Caption = 'Customer Entry No.';
        //     TableRelation = "Cust. Ledger Entry";
        // }
        // field(13; "Modified By"; Code[50])
        // {
        //     Caption = 'Modified By';
        //     TableRelation = "A01 External User";
        //     DataClassification = CustomerContent;
        // }
        // field(14; "Created By"; Code[50])
        // {
        //     Caption = 'Created By';
        //     TableRelation = "A01 External User";
        //     DataClassification = CustomerContent;
        // }
    }
    keys
    {
        key(PK; "Customer No.", "Deadline No.", "Assigned to", "Assigned on")
        {
            Clustered = true;
        }
    }

    local procedure CalcRiskLevel(CustLedgerEntry: Record "Cust. Ledger Entry"): Code[20]
    var
        Cust: Record Customer;
        CustDebtStatus: Record "A01 Customer Debt Status";
        DueDays: Integer;
    begin
        if (Cust.Get(CustLedgerEntry."Customer No.")) then begin
            CustDebtStatus.SetRange("Risk Level", Cust."A01 Risk Level");
            if (not CustLedgerEntry.IsEmpty()) then
                exit(Cust."A01 Risk Level");
        end;

        DueDays := GetDueDays(CustLedgerEntry);
        CustDebtStatus.Reset();
        CustDebtStatus.SetFilter("Minimum (Days)", '<%1', DueDays);
        CustDebtStatus.SetFilter("Minimum (Days)", '>=%1', DueDays);
        if (CustDebtStatus.FindFirst()) then
            exit(CustDebtStatus."Risk Level");

    end;

    local procedure GetDueDays(CustLedgerEntry: Record "Cust. Ledger Entry"): Integer
    var
    begin
        if (CustLedgerEntry."Closed at Date" <> 0D) then
            exit(Days(CustLedgerEntry."Due Date", CustLedgerEntry."Closed at Date"))
        else
            exit(Days(CustLedgerEntry."Due Date", Today));
    end;

    local procedure Days(Day1: Date; Day2: Date): Integer
    var
    begin
        if Day1 > Day2 then
            exit(0);
        if Day1 = 0D then
            exit(0);
        if Day2 = 0D then
            exit(0);

        exit(Day2 - Day1 + 1);
    end;

}
