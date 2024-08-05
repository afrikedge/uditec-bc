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

    procedure CalcSalesFirstDueDate(PostingDate: Date): Date
    var
        DueDate: Date;
    begin
        DueDate := "First Terms Date";
        while (DueDate < "OP Ending Date") do begin
            if (PostingDate <= DueDate) then
                exit(DueDate);
            DueDate := CalcDate('<1M>', DueDate);
        end;
        exit(DueDate);
    end;

    procedure CalcSalesCreditDuration(PostingDate: Date): Integer
    var
        StartingDate1: Date;
        EndingDate1: Date;
        NumMonths: Integer;
    begin
        StartingDate1 := "OP Starting Date";
        NumMonths := "Duration (Month)";
        EndingDate1 := CalcDate('<1M>', StartingDate1);

        if (Rec."OP Duration (Month)" >= NumMonths) then
            exit(NumMonths);

        if (PostingDate > "OP Ending Date") then
            exit(0);

        //if (EndingDate1 >= "OP Ending Date") then
        //    exit(0);

        while (EndingDate1 < "OP Ending Date") do begin
            if (PostingDate <= EndingDate1) then
                exit(NumMonths);
            NumMonths := NumMonths - 1;
            EndingDate1 := CalcDate('<1M>', EndingDate1);
        end;

        if (NumMonths < 0) then
            exit(0);
        exit(NumMonths);
    end;
}
