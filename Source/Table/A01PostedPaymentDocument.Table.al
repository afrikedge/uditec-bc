/// <summary>
/// Table A01 Posted Payment Document (ID 50026).
/// </summary>
table 50026 "A01 Posted Payment Document"
{
    Caption = 'Posted Payment Document';
    DataClassification = CustomerContent;

    fields
    {
        field(1; "No."; Code[20])
        {
            Caption = 'No.';
            Editable = false;
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
        field(15; "External Document No."; Code[35])
        {
            Caption = 'External Document No.';
        }

        field(16; "Applies-to ID"; Code[50])
        {
            Caption = 'Applies-to ID';
            Editable = false;
        }
        field(17; "Applies-to Doc. Type"; Enum "Gen. Journal Document Type")
        {
            Caption = 'Applies-to Doc. Type';
            Editable = false;
        }
        field(18; "Applies-to Doc. No."; Code[20])
        {
            Caption = 'Applies-to Doc. No.';
            Editable = false;
        }
        field(19; "Amount"; Decimal)
        {
            Caption = 'Amount';
            Editable = false;
            FieldClass = FlowField;
            CalcFormula = sum("A01 Posted Payment Doc Line".Amount where("Document No." = field("No.")));
        }
        field(20; "Validated Amount"; Decimal)
        {
            Caption = 'Validated Amount';
            Editable = false;
            FieldClass = FlowField;
            CalcFormula = sum("A01 Posted Payment Doc Line"."Validated Amount" where("Document No." = field("No.")));
        }
        field(21; "Posting No."; Code[20])
        {
            Caption = 'Posting No.';
            Editable = false;
        }
        field(22; "Approval Status"; Enum "A01 Approval Status")
        {
            Caption = 'ApprovalStatus';
            Editable = false;
        }
        field(23; "Abandon Interets"; decimal)
        {
            Caption = 'Abandon Interets';
            Editable = false;
        }
        field(24; "Rebate Balance"; decimal)
        {
            Caption = 'Rebate Balance';
            Editable = false;
        }



        field(480; "Dimension Set ID"; Integer)
        {
            Caption = 'Dimension Set ID';
            Editable = false;
            TableRelation = "Dimension Set Entry";

            // trigger OnLookup()
            // begin
            //     Rec.ShowDimensions();
            // end;
        }
        field(50000; "Currency Code"; Code[10])
        {
            Caption = 'Currency Code';
            TableRelation = Currency;
            Editable = false;
        }

        field(50100; "Settlement Date"; Date)
        {
            Caption = 'Settlement Date';
        }
        field(50101; "Settled By"; Code[50])
        {
            Caption = 'Settled By';
        }
        field(50102; "Source Code"; Code[20])
        {
            Caption = 'Source Code';
        }
        field(50103; "Original No."; Code[20])
        {
            Caption = 'Original No.';
        }

    }
    keys
    {
        key(PK; "No.")
        {
            Clustered = true;
        }
    }
    procedure Navigate()
    var
        NavigatePage: Page Navigate;
    begin
        NavigatePage.SetDoc("Posting Date", "No.");
        NavigatePage.SetRec(Rec);
        NavigatePage.Run();
    end;

    /// <summary>
    /// PrintRecords.
    /// </summary>
    /// <param name="ShowRequestPage">Boolean.</param>
    procedure PrintRecords(ShowRequestPage: Boolean)
    var
        //DocumentSendingProfile: Record "Document Sending Profile";
        //DummyReportSelections: Record "Report Selections";
        //IsHandled: Boolean;
        PostedPayment: Record "A01 Posted Payment Document";
    begin
        // IsHandled := false;
        // OnBeforePrintRecords(DummyReportSelections, Rec, ShowRequestPage, IsHandled);
        // if not IsHandled then
        PostedPayment."No." := Rec."No.";
        PostedPayment.SetRecFilter();
        //PostedPayment.PrintRecords(false);
        REPORT.RunModal(50024, ShowRequestPage, false, PostedPayment);
        // DocumentSendingProfile.TrySendToPrinter(
        //   DummyReportSelections.Usage::"S.Invoice".AsInteger(), Rec, FieldNo("Partner No."), ShowRequestPage);
    end;
}
