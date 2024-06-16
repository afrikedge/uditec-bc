/// <summary>
/// Table A01 Deadline assignment (ID 50025).
/// </summary>
table 50025 "A01 Deadline Assignment"
{
    Caption = 'Customer assignment';
    DataClassification = CustomerContent;

    fields
    {
        field(100; "No."; Code[20])
        {
            Caption = 'No.';
            Editable = false;

            trigger OnValidate()
            begin
                if "No." <> xRec."No." then begin
                    AddOnSetup.Get();
                    NoSeriesManagement.TestManual(AddOnSetup."Customer Settlement Nos");
                    "No. Series" := '';
                end;
            end;
        }
        field(1; "Customer No."; Code[20])
        {
            Caption = 'Customer No.';
            TableRelation = Customer;
            trigger OnValidate()
            var
                Cust: Record "Customer";
            begin
                if (Cust.Get("Customer No.")) then begin
                    "Due status" := Cust.CalcCustStatus();
                    CheckAndModifyCustExistingAssigments();
                end;

            end;
        }
        // field(2; "Deadline No."; Integer)
        // {
        //     Caption = 'Deadline No.';
        //     TableRelation = "Cust. Ledger Entry"."Entry No." where(Open = const(true), "Customer No." = field("Customer No."), Positive = const(true));
        //     trigger OnValidate()
        //     var
        //         CustLedgerEntry: Record "Cust. Ledger Entry";
        //     begin
        //         if (CustLedgerEntry.Get("Deadline No.")) then begin
        //             "Document Date" := CustLedgerEntry."Document Date";
        //             "Due Date" := CustLedgerEntry."Due Date";
        //             "Due status" := CalcRiskLevel(CustLedgerEntry);
        //             "Document No." := CustLedgerEntry."Document No.";
        //         end;

        //     end;
        // }
        // field(3; "Document Date"; Date)
        // {
        //     Caption = 'Document Date';
        //     Editable = false;
        // }
        field(4; "Assigned to"; Code[50])
        {
            Caption = 'Assigned to';
            TableRelation = "A01 External User";
        }
        // field(12; "Document No."; Code[20])
        // {
        //     Caption = 'Document No.';
        //     Editable = false;
        // }
        field(5; "Customer Name"; Text[100])
        {
            Caption = 'Customer Name';
            Editable = false;
            FieldClass = FlowField;
            CalcFormula = lookup(Customer.Name where("No." = field("Customer No.")));
        }
        // field(6; "Due Date"; Date)
        // {
        //     Caption = 'Due Date';
        //     Editable = false;
        // }
        field(7; "Assigned on"; Date)
        {
            Caption = 'Assigned on';
            Editable = false;
        }
        field(8; "Assigned by"; Code[50])
        {
            Caption = 'Assigned by';
            //TableRelation = "A01 External User";
            FieldClass = FlowField;
            CalcFormula = lookup("A01 External User".Code where(BCUserId = field("Created By")));
            Editable = false;
        }

        field(9; "Due status"; Code[20])
        {
            Caption = 'Due status';
            Editable = false;
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
        field(12; "No. Series"; Code[20])
        {
            Caption = 'No. Series';
            TableRelation = "No. Series";
        }
        field(13; "Assigment Status"; Enum "A01 Deadline Assigment Status")
        {
            Caption = 'Assigment Status';
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
        field(14; "Created By"; Code[50])
        {
            Caption = 'Created By';
            TableRelation = User;
            DataClassification = CustomerContent;
            Editable = false;
        }
    }
    keys
    {
        key(PK; "No.")
        {
            Clustered = true;
        }
    }


    var
        AddOnSetup: Record "A01 Afk Setup";
        NoSeriesManagement: Codeunit NoSeriesManagement;



    trigger OnInsert()
    begin
        if "No." = '' then begin
            AddOnSetup.Get();
            AddOnSetup.TestField("Deadline Assignment Nos");
            NoSeriesManagement.InitSeries(AddOnSetup."Deadline Assignment Nos", xRec."No. Series", 0D, "No.", "No. Series");
        end;
        InitHeader();
    end;

    trigger OnDelete()
    var
    begin

    end;

    local procedure InitHeader()
    begin
        "Created By" := CopyStr(UserId, 1, 50);
        "Assigned on" := Today;
    end;



    local procedure CheckAndModifyCustExistingAssigments()
    var
        Assigment: Record "A01 Deadline Assignment";
        QstLbl: Label 'Existing active assignments for this customer will be closed. Do you want to continue?';
    begin
        Assigment.Reset();
        Assigment.SetFilter("No.", '<>%1', Rec."No.");
        Assigment.SetRange("Customer No.", Rec."Customer No.");
        Assigment.SetRange("Assigment Status", "Assigment Status"::Active);
        if (Assigment.FindFirst()) then begin
            if (not confirm(QstLbl)) then
                Error('');
            Assigment.ModifyAll("Assigment Status", "Assigment Status"::InActive);
        end;

    end;



    // local procedure CalcRiskLevel(CustLedgerEntry: Record "Cust. Ledger Entry"): Code[20]
    // var
    //     Cust: Record Customer;
    //     CustDebtStatus: Record "A01 Customer Debt Status";
    //     DueDays: Integer;
    // begin
    //     if (Cust.Get(CustLedgerEntry."Customer No.")) then begin
    //         CustDebtStatus.SetRange("Risk Level", Cust."A01 Risk Level");
    //         if (not CustDebtStatus.IsEmpty()) then
    //             exit(Cust."A01 Risk Level");
    //     end;

    //     DueDays := GetDueDays(CustLedgerEntry);
    //     CustDebtStatus.Reset();
    //     CustDebtStatus.SetFilter("Minimum (Days)", '<%1', DueDays);
    //     CustDebtStatus.SetFilter("Minimum (Days)", '>=%1', DueDays);
    //     if (CustDebtStatus.FindFirst()) then
    //         exit(CustDebtStatus."Risk Level");

    // end;



}
