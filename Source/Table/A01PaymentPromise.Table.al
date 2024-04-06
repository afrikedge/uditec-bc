/// <summary>
/// Table A01 Payment Promise (ID 50030).
/// </summary>
table 50030 "A01 Payment Promise"
{
    Caption = 'Payment Promise';
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
                    NoSeriesManagement.TestManual(AddOnSetup."Reposession request Nos");
                    "No. Series" := '';
                end;
            end;
        }
        field(2; Object; Text[30])
        {
            Caption = 'Object';
        }
        // field(3; "Customer Account Type"; Enum "A01 Customer Account Type")
        // {
        //     Caption = 'Customer Account Type';
        // }
        field(3; "Customer No."; Code[20])
        {
            Caption = 'Customer No.';
            TableRelation = Customer;
        }
        field(4; "Contact No."; Code[20])
        {
            Caption = 'Contact No.';
            TableRelation = Contact;
        }
        field(5; Description; Text[50])
        {
            Caption = 'Description';
        }
        field(6; "Created By"; Code[50])
        {
            Caption = 'Created By';
            TableRelation = "A01 External User";
        }
        field(7; "Promise Date"; Date)
        {
            Caption = 'Promise Date';
        }
        field(8; "Amount promised"; Decimal)
        {
            Caption = 'Amount promised';
        }
        field(9; "Amount honored"; Decimal)
        {
            Caption = 'Amount honored';
        }
        field(10; "Followed by"; Code[50])
        {
            Caption = 'Followed by';
            TableRelation = "A01 External User";
        }
        field(11; Origin; Code[20])
        {
            Caption = 'Origin';
            TableRelation = "Reminder Header";
        }
        field(12; Reminder; Enum "A01 Activity Type")
        {
            Caption = 'Reminder';
        }
        field(13; "Reminder deadline"; Date)
        {
            Caption = 'Reminder deadline';
        }
        field(14; Status; Enum "A01 Promise status")
        {
            Caption = 'Status';
        }
        field(15; "Reminder date"; Date)
        {
            Caption = 'Reminder date';
        }
        field(17; "Modified By"; Code[50])
        {
            Caption = 'Modified By';
            TableRelation = "A01 External User";
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(18; "No. Series"; Code[20])
        {
            Caption = 'No. Series';
            TableRelation = "No. Series";
        }
        //Reminder date
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
            AddOnSetup.TestField("Payment Promise Nos");
            NoSeriesManagement.InitSeries(AddOnSetup."Payment Promise Nos", xRec."No. Series", 0D, "No.", "No. Series");
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
