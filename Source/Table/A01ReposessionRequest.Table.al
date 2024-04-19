/// <summary>
/// Table A01 Reposession Request (ID 50024).
/// </summary>
table 50024 "A01 Reposession Request"
{
    Caption = 'Reposession Request';
    DataClassification = CustomerContent;


    fields
    {
        field(2; "No."; Code[20])
        {
            Caption = 'No.';
            Editable = false;

            trigger OnValidate()
            begin
                if "No." <> xRec."No." then begin
                    AddOnSetup.Get();
                    NoSeriesManagement.TestManual(AddOnSetup."Reposession request Nos");
                    "No. Series" := '';
                end;
            end;
        }
        field(3; Object; Text[100])
        {
            Caption = 'Object';
        }
        // field(4; Status; Enum "A01 Approval Status")
        // {
        //     Caption = 'Status';
        // }
        field(5; "Document Type"; Enum "Item Ledger Document Type")
        {
            Caption = 'Document Type';

        }
        field(6; "Document No."; Code[20])
        {
            Caption = 'Document No.';
            TableRelation = if ("Document Type" = const("Sales Shipment")) "Sales Shipment Header"
            else if ("Document Type" = const("Sales Invoice")) "Sales Invoice Header";
        }
        field(7; "Modified By"; Code[50])
        {
            Caption = 'Modified By';
            TableRelation = "A01 External User";
            DataClassification = CustomerContent;
        }
        field(19; "Item No."; Code[20])
        {
            Caption = 'Item No.';
            TableRelation = Item;
            // TableRelation = if ("Document Type" = const("Sales Shipment")) "Sales Shipment Line"."No." where(Type = const(Item), "Document No." = field("Document No."))
            // else if ("Document Type" = const("Sales Invoice")) "Sales Invoice line"."No." where(Type = const(Item), "Document No." = field("Document No."));
        }
        field(20; "Serial Number"; Text[30])
        {
            Caption = 'Serial Number';
        }
        field(21; Origin; Enum "A01 Repossession Origin")
        {
            Caption = 'Origin';
        }
        field(22; "Acceptance Status"; Enum "A01 Reposession Accept Status")
        {
            Caption = 'Acceptance Status';
        }
        field(23; Reason; Text[100])
        {
            Caption = 'Reason';
        }
        field(24; "Reposession Type"; Enum "A01 Reposession Type")
        {
            Caption = 'Reposession Type';
        }
        field(25; "Reposession Item Status"; Enum "A01 Reposession Item Status")
        {
            Caption = 'Reposession Item Status';
        }
        field(26; "No. Series"; Code[20])
        {
            Caption = 'No. Series';
            TableRelation = "No. Series";
        }
        field(27; "Created By"; Code[50])
        {
            Caption = 'Created By';
            TableRelation = "A01 External User";
            DataClassification = CustomerContent;
            Editable = false;
        }

        field(28; "Document Ref."; Code[20])
        {
            Caption = 'Document Ref.';
        }
        field(29; "Value"; Decimal)
        {
            Caption = 'Value';
        }

    }
    keys
    {
        key(PK; "No.")
        {
            Clustered = true;
        }
    }
    trigger OnInsert()
    begin
        if "No." = '' then begin
            AddOnSetup.Get();
            AddOnSetup.TestField("Reposession request Nos");
            NoSeriesManagement.InitSeries(AddOnSetup."Reposession request Nos", xRec."No. Series", 0D, "No.", "No. Series");
        end;
        InitHeader();
    end;

    var
        AddOnSetup: Record "A01 Afk Setup";
        SourceCodeSetup: Record "Source Code Setup";
        NoSeriesManagement: Codeunit NoSeriesManagement;

    local procedure InitHeader()
    begin
    end;

    procedure AcceptAction()
    var
        LblQst: Label 'Do you want to change the status to "accepted"?';
    begin
        TestField("Acceptance Status", "Acceptance Status"::Waiting);
        if (not confirm(LblQst)) then
            exit;
        "Acceptance Status" := "Acceptance Status"::Accepted;
        Modify(true);
    end;

    procedure ReturnAction()
    var
        LblQst: Label 'Do you want to return this product?';
    begin
        TestField("Acceptance Status", "Acceptance Status"::Cancelled);
        TestField("Reposession Item Status", "Reposession Item Status"::"To be returned");
        if (not confirm(LblQst)) then
            exit;
        //"Acceptance Status" := "Acceptance Status"::
        "Reposession Item Status" := "Reposession Item Status"::Returned;
        PostItemJournalLine(Rec, false);
        Modify(true);
    end;

    procedure ReceiveAction()
    var
        LblQst: Label 'Do you want to receive this product?';
    begin
        TestField("Acceptance Status", "Acceptance Status"::Accepted);
        TestField("Reposession Item Status", "Reposession Item Status"::"To be received");
        if (not confirm(LblQst)) then
            exit;
        //"Acceptance Status" := "Acceptance Status"::
        "Reposession Item Status" := "Reposession Item Status"::Received;
        PostItemJournalLine(Rec, true);
        Modify(true);
    end;

    procedure CancelAction()
    var
        LblQst: Label 'Do you want to change the status to "Cancelled"?';
    begin
        TestField("Acceptance Status", "Acceptance Status"::Waiting);
        if (not confirm(LblQst)) then
            exit;
        "Acceptance Status" := "Acceptance Status"::Cancelled;
        Modify(true);
    end;

    procedure ConfirmAction()
    var
        LblQst: Label 'Do you want to change the status to "Confirmed"?';
    begin
        TestField("Reposession Type", "Reposession Type"::Provisional);
        if (not Confirm(LblQst)) then
            exit;
        "Reposession Type" := "Reposession Type"::Definitive;
        Modify(true);
    end;

    procedure RejectAction()
    var
        LblQst: Label 'Do you want to change the status to "Rejected"?';
    begin
        TestField("Acceptance Status", "Acceptance Status"::Accepted);
        TestField("Reposession Item Status", "Reposession Item Status"::Received);
        if (not Confirm(LblQst)) then
            exit;
        "Reposession Item Status" := "Reposession Item Status"::"To be returned";
        Modify(true);
    end;

    procedure CloseAction()
    var
        Cust: Record Customer;
        SalesShipment: Record "Sales Shipment Header";
        SalesInvoice: Record "Sales Invoice Header";
        LblQst: Label 'Do you want to change the status to "Closed"?';
    begin
        TestField(Value);
        TestField("Reposession Type", "Reposession Type"::Definitive);
        TestField("Acceptance Status", "Acceptance Status"::Accepted);
        TestField("Reposession Item Status", "Reposession Item Status"::Received);
        if (not Confirm(LblQst)) then
            exit;

        if ("Document Type" = "Document Type"::"Sales Shipment") then
            if (SalesShipment.Get("Document No.")) then begin
                Cust.get(SalesShipment."Sell-to Customer No.");
            end;

        if ("Document Type" = "Document Type"::"Sales Invoice") then
            if (SalesInvoice.Get("Document No.")) then begin
                Cust.get(SalesInvoice."Sell-to Customer No.");
            end;

        AddOnSetup.GetRecordOnce();
        AddOnSetup.TestField("Reposession Risk Level");
        Cust.TestField("No.");
        Cust."A01 Risk Level" := AddOnSetup."Reposession Risk Level";
        Cust.Blocked := Cust.Blocked::All;
        Cust.Modify(true);

        "Acceptance Status" := "Acceptance Status"::Accepted;
        Modify(true);
    end;

    local procedure PostItemJournalLine(DocRequest: Record "A01 Reposession Request"; isPositiveAdj: Boolean)
    var
        ItemJnlLine: Record "Item Journal Line";
        ItemJnlPostLine: Codeunit "Item Jnl.-Post Line";
        TxtDecr: Label 'Reposession %1', Comment = '%1=No';
    begin
        AddOnSetup.GetRecordOnce();
        AddOnSetup.TestField("Reposession Location");
        SourceCodeSetup.Get();

        ItemJnlLine.Init();
        ItemJnlLine."Posting Date" := WorkDate();
        ItemJnlLine."Document Date" := WorkDate();
        ItemJnlLine."Document No." := DocRequest."No.";
        //ItemJnlLine."External Document No." := ItemAdj."External Document No.";
        ItemJnlLine."External Document No." := "No.";//231117******
        if (isPositiveAdj) then
            ItemJnlLine."Entry Type" := ItemJnlLine."Entry Type"::"Positive Adjmt."
        else
            ItemJnlLine."Entry Type" := ItemJnlLine."Entry Type"::"Negative Adjmt.";

        ItemJnlLine.VALIDATE("Item No.", DocRequest."Item No.");
        ItemJnlLine.Description := STRSUBSTNO(TxtDecr, DocRequest."No.");
        ;

        ItemJnlLine.VALIDATE("Location Code", AddOnSetup."Reposession Location");
        ItemJnlLine.VALIDATE(Quantity, 1);

        //ItemJnlLine.VALIDATE("Unit of Measure Code", AdjustLine."Unit of Measure Code");
        ItemJnlLine."Invoiced Quantity" := 1;
        ItemJnlLine."Source Code" := SourceCodeSetup."Item Journal";
        //ItemJnlLine."Gen. Prod. Posting Group" := Item1."Gen. Prod. Posting Group";

        ItemJnlLine.Validate("Serial No.", DocRequest."Serial Number");

        //ItemJnlLine."Shortcut Dimension 1 Code" := AdjustLine."Shortcut Dimension 1 Code";
        //ItemJnlLine."Shortcut Dimension 2 Code" := AdjustLine."Shortcut Dimension 2 Code";
        //ItemJnlLine."Dimension Set ID" := AdjustLine."Dimension Set ID";

        //AmountToInvoice := ItemJnlLine.Amount;

        ItemJnlPostLine.RunWithCheck(ItemJnlLine);
    end;
}
