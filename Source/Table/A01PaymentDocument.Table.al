/// <summary>
/// Table A01 Payment Document (ID 50032).
/// </summary>
table 50032 "A01 Payment Document"
{
    Caption = 'Payment Document';
    DataClassification = CustomerContent;

    fields
    {
        field(1; "No."; Code[20])
        {
            Caption = 'No.';
            Editable = false;

            trigger OnValidate()
            begin
                if "No." <> xRec."No." then begin
                    AddOnSetup.Get();
                    NoSeriesManagement.TestManual(AddOnSetup."Payment Document Nos");
                    "No. Series" := '';
                end;
            end;
        }
        field(2; "Partner Type"; Enum "A01 Payment Doc Partner Type")
        {
            Caption = 'Partner Type';
        }
        field(3; "Partner No."; Code[20])
        {
            Caption = 'Partner No.';
            TableRelation = if ("Partner Type" = const(Customer)) Customer
            else if ("Partner Type" = const(Vendor)) Vendor;
            trigger OnValidate()
            var
                Cust1: Record Customer;
                Vend1: Record Vendor;
            begin


                if (Rec."Partner No." <> xRec."Partner No.") then begin
                    DeleteLinesIfTheyExists();
                end;

                if ("Partner Type" = "Partner Type"::Customer) then begin
                    if (Cust1.Get("Partner No.")) then
                        "Partner Name" := Cust1.Name;
                end;
                if ("Partner Type" = "Partner Type"::Vendor) then begin
                    if (Vend1.Get("Partner No.")) then
                        "Partner Name" := Vend1.Name;
                end;
            end;
        }

        field(4; Object; Text[100])
        {
            Caption = 'Object';
        }
        field(5; "Posting Date"; Date)
        {
            Caption = 'Posting Date';
        }
        field(6; Status; Enum "A01 Approval Status")
        {
            Caption = 'Status';
            Editable = false;
        }
        field(7; "Modified By"; Code[50])
        {
            Caption = 'Modified By';
            TableRelation = "A01 External User";
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(8; "Responsibility Center"; Code[10])
        {
            Caption = 'Responsibility Center';
            TableRelation = "Responsibility Center";
            trigger OnValidate()
            begin

                if (Rec."Responsibility Center" <> xRec."Responsibility Center") then begin
                    DeleteLinesIfTheyExists();
                end;
            end;
        }
        field(9; "No. Series"; Code[20])
        {
            Caption = 'No. Series';
            TableRelation = "No. Series";
        }
        field(10; "Partner Name"; Text[100])
        {
            Caption = 'Partner Name';
            Editable = false;
        }
        field(50000; "Currency Code"; Code[10])
        {
            Caption = 'Currency Code';
            TableRelation = Currency;
            Editable = false;

            trigger OnValidate()
            begin
            end;
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
            AddOnSetup.TestField("Payment Document Nos");
            NoSeriesManagement.InitSeries(AddOnSetup."Payment Document Nos", xRec."No. Series", 0D, "No.", "No. Series");
        end;
        InitHeader();
    end;

    var
        AddOnSetup: Record "A01 Afk Setup";
        NoSeriesManagement: Codeunit NoSeriesManagement;
        LblQuestChangeRespCenter: Label 'The lines will be deleted. Do you want to continue ?';

    local procedure InitHeader()
    begin
    end;

    local procedure DeleteLinesIfTheyExists()
    var
        DocLine: Record "A01 Payment Document Line";
    begin
        DocLine.SetRange(DocLine."Document No.", "No.");
        if (not DocLine.IsEmpty) then
            if (Confirm(LblQuestChangeRespCenter)) then begin
                DocLine.DeleteAll();
            end;
    end;
}
