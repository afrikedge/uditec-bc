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
        NoSeriesManagement: Codeunit NoSeriesManagement;

    local procedure InitHeader()
    begin
    end;
}
