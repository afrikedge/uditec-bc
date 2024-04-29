/// <summary>
/// Table A01 AGP Contrat (ID 50035).
/// </summary>
table 50035 "A01 AGP Contrat"
{
    Caption = 'AGP Contrat';
    DataClassification = CustomerContent;

    fields
    {
        field(1; "No."; Code[20])
        {
            Caption = 'No.';
            Editable = false;
        }
        field(2; "Account Type"; Enum "A01 Customer Account Type")
        {
            Caption = 'Account Type';
        }
        field(3; "Customer No."; Code[20])
        {
            Caption = 'Customer No.';
        }
        field(4; "OP Starting Date"; Date)
        {
            Caption = 'OP Starting Date';
        }
        field(5; "OP Duration (Month)"; Integer)
        {
            Caption = 'OP Duration (Month)';
        }
        field(6; "OP Ending Date"; Date)
        {
            Caption = 'OP Ending Date';
        }
        field(7; "Duration (Month)"; Integer)
        {
            Caption = 'Duration (Month)';
        }
        field(8; "Commitment Type"; Enum "A01 Commitment Type")
        {
            Caption = 'Commitment Type';
        }
        field(9; "Payment Terms Code"; Code[20])
        {
            Caption = 'Payment Terms Code';
        }
        field(10; "First Terms Date"; Date)
        {
            Caption = 'First Terms Date';
        }
        field(11; "Payment Method Code"; Code[10])
        {
            Caption = 'Payment Method Code';
        }
        field(12; "Approval Status"; Enum "A01 Approval Status")
        {
            Caption = 'Approval Status';
        }
        field(13; "Created By"; Code[50])
        {
            Caption = 'Created By';
            Editable = false;
        }
        field(14; "Modified By"; Code[50])
        {
            Caption = 'Modified By';
            Editable = false;
        }
        field(15; "No. Series"; Code[20])
        {
            Caption = 'No. Series';
            TableRelation = "No. Series";
        }
        field(16; "Transferable part %"; Decimal)
        {
            Caption = 'Transferable part %';
        }
        field(17; "Credit Limit Mode"; Enum "A01 AGP Credit Limit Mode")
        {
            Caption = 'Credit Limit Mode';
        }
        field(18; "Standard Credit Limit"; Decimal)
        {
            Caption = 'Standard Credit Limit';
        }
        field(19; "Application fees %"; Decimal)
        {
            Caption = 'Application fees %';
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
        //Currency: Record Currency;
        NoSeriesManagement: Codeunit NoSeriesManagement;

    trigger OnInsert()
    begin
        if "No." = '' then begin
            AddOnSetup.Get();
            AddOnSetup.TestField("AGP Contract Nos");
            NoSeriesManagement.InitSeries(AddOnSetup."AGP Contract Nos", xRec."No. Series", 0D, "No.", "No. Series");
        end;
        InitHeader();
    end;

    local procedure InitHeader()
    begin
        // "Partner Type" := "Partner Type"::Customer;
        // "Posting Date" := WorkDate();
    end;
}
