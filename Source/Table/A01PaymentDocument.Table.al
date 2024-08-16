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
                    NoSeriesManagement.TestManual(AddOnSetup."Customer Settlement Nos");
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
        // field(6; Status; Enum "A01 Approval Status")
        // {
        //     Caption = 'Status';
        //     Editable = false;
        // }
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
                    CreateDimFromDefaultDim(Rec.FieldNo("Responsibility Center"));
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
        // field(11; "Description"; Text[100])
        // {
        //     Caption = 'Description';
        // }
        field(12; "Due Date"; Date)
        {
            Caption = 'Due Date';
        }
        field(13; "Shortcut Dimension 1 Code"; Code[20])
        {
            CaptionClass = '1,2,1';
            Caption = 'Shortcut Dimension 1 Code';

            trigger OnLookup()
            begin
                LookupShortcutDimCode(1, "Shortcut Dimension 1 Code");
                Validate("Shortcut Dimension 1 Code");
            end;

            trigger OnValidate()
            begin
                ValidateShortcutDimCode(1, "Shortcut Dimension 1 Code");
                Modify();
            end;
        }
        field(14; "Shortcut Dimension 2 Code"; Code[20])
        {
            CaptionClass = '1,2,2';
            Caption = 'Shortcut Dimension 2 Code';

            trigger OnLookup()
            begin
                LookupShortcutDimCode(2, "Shortcut Dimension 2 Code");
                Validate("Shortcut Dimension 2 Code");
            end;

            trigger OnValidate()
            begin
                ValidateShortcutDimCode(2, "Shortcut Dimension 2 Code");
                Modify();
            end;
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
            CalcFormula = sum("A01 Payment Document Line".Amount where("Document No." = field("No.")));
        }
        field(20; "Validated Amount"; Decimal)
        {
            Caption = 'Validated Amount';
            Editable = false;
            FieldClass = FlowField;
            CalcFormula = sum("A01 Payment Document Line"."Validated Amount" where("Document No." = field("No.")));
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
            AddOnSetup.TestField("Customer Settlement Nos");
            NoSeriesManagement.InitSeries(AddOnSetup."Customer Settlement Nos", xRec."No. Series", 0D, "No.", "No. Series");
        end;
        InitHeader();
    end;

    trigger OnDelete()
    var
        DocLine: Record "A01 Payment Document Line";
    begin
        RequestMgt.CheckOnHoldRequestAlreadyExists(Rec);

        DocLine.SetRange(DocLine."Document No.", "No.");
        if (not DocLine.IsEmpty) then
            DocLine.DeleteAll();
    end;

    trigger OnModify()
    var

    begin
        RequestMgt.CheckOnHoldRequestAlreadyExists(Rec);
    end;

    var
        AddOnSetup: Record "A01 Afk Setup";
        Currency: Record Currency;
        NoSeriesManagement: Codeunit NoSeriesManagement;
        RequestMgt: Codeunit "A01 Document Request Mgt";
        DimensionManagement: Codeunit DimensionManagement;
        SecMgt: Codeunit "A01 Security Mgt";
        Text009: Label 'You may have changed a dimension.\\Do you want to update the lines?';
        LblQuestChangeRespCenter: Label 'The lines will be deleted. Do you want to continue ?';
    //DoYouWantToKeepExistingDimensionsQst: Label 'This will change the dimension specified on the document. Do you want to recalculate/update dimensions?';


    local procedure InitHeader()
    begin
        "Partner Type" := "Partner Type"::Customer;
        "Posting Date" := WorkDate();
        Rec.Validate("Responsibility Center", SecMgt.GetMainUserResponsibilityCenter());
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


    procedure LookupShortcutDimCode(FieldNo: Integer; var ShortcutDimCode: Code[20])
    begin
        DimensionManagement.LookupDimValueCode(FieldNo, ShortcutDimCode);
        DimensionManagement.ValidateShortcutDimValues(FieldNo, ShortcutDimCode, "Dimension Set ID");
    end;


    procedure ValidateShortcutDimCode(FieldNo: Integer; var ShortcutDimCode: Code[20])
    begin
        DimensionManagement.ValidateShortcutDimValues(FieldNo, ShortcutDimCode, "Dimension Set ID");
        if xRec."Dimension Set ID" <> "Dimension Set ID" then
            if PaymentLinesExist() then
                UpdateAllLineDim("Dimension Set ID", xRec."Dimension Set ID");
    end;

    procedure PaymentLinesExist(): Boolean
    var
        PaymentLine: Record "A01 Payment Document Line";
    begin
        PaymentLine.Reset();
        PaymentLine.SetRange("Document No.", "No.");
        exit(not PaymentLine.IsEmpty())
    end;

    local procedure UpdateAllLineDim(NewParentDimSetID: Integer; OldParentDimSetID: Integer)
    var
        PaymentLine: Record "A01 Payment Document Line";
        NewDimSetID: Integer;
    begin
        // Update all lines with changed dimensions.

        if NewParentDimSetID = OldParentDimSetID then
            exit;
        if not Confirm(Text009) then
            exit;

        PaymentLine.Reset();
        PaymentLine.SetRange("Document No.", "No.");
        PaymentLine.LockTable();
        if PaymentLine.Find('-') then
            repeat
                NewDimSetID := DimensionManagement.GetDeltaDimSetID(PaymentLine."Dimension Set ID", NewParentDimSetID, OldParentDimSetID);
                if PaymentLine."Dimension Set ID" <> NewDimSetID then begin
                    PaymentLine."Dimension Set ID" := NewDimSetID;
                    PaymentLine.Modify();
                end;
            until PaymentLine.Next() = 0;
    end;

    procedure CreateDimFromDefaultDim(FieldNo: Integer)
    var
        DefaultDimSource: List of [Dictionary of [Integer, Code[20]]];
    begin
        InitDefaultDimensionSources(DefaultDimSource, FieldNo);
        CreateDim(DefaultDimSource);
    end;

    local procedure InitDefaultDimensionSources(var DefaultDimSource: List of [Dictionary of [Integer, Code[20]]]; FieldNo: Integer)
    begin
        //OnBeforeInitDefaultDimensionSources(Rec, DefaultDimSource, FieldNo);

        // DimMgt.AddDimSource(DefaultDimSource, Database::Customer, Rec."Bill-to Customer No.", FieldNo = Rec.FieldNo("Bill-to Customer No."));
        // DimMgt.AddDimSource(DefaultDimSource, Database::"Salesperson/Purchaser", Rec."Salesperson Code", FieldNo = Rec.FieldNo("Salesperson Code"));
        // DimMgt.AddDimSource(DefaultDimSource, Database::Campaign, Rec."Campaign No.", FieldNo = Rec.FieldNo("Campaign No."));
        DimensionManagement.AddDimSource(DefaultDimSource, Database::"Responsibility Center", Rec."Responsibility Center", FieldNo = Rec.FieldNo("Responsibility Center"));
        // DimMgt.AddDimSource(DefaultDimSource, Database::"Customer Templ.", Rec."Bill-to Customer Templ. Code", FieldNo = Rec.FieldNo("Bill-to Customer Templ. Code"));
        // DimMgt.AddDimSource(DefaultDimSource, Database::Location, Rec."Location Code", FieldNo = Rec.FieldNo("Location Code"));

        //OnAfterInitDefaultDimensionSources(Rec, DefaultDimSource, FieldNo);
    end;

    procedure CreateDim(DefaultDimSource: List of [Dictionary of [Integer, Code[20]]])
    var
        SourceCodeSetup: Record "Source Code Setup";
        OldDimSetID: Integer;
        IsHandled: Boolean;
    begin
        IsHandled := false;
        //OnBeforeCreateDim(Rec, IsHandled, DefaultDimSource);
        if IsHandled then
            exit;

        SourceCodeSetup.Get();

        "Shortcut Dimension 1 Code" := '';
        "Shortcut Dimension 2 Code" := '';
        OldDimSetID := "Dimension Set ID";
        "Dimension Set ID" :=
          DimensionManagement.GetRecDefaultDimID(
            Rec, CurrFieldNo, DefaultDimSource, SourceCodeSetup.Sales, "Shortcut Dimension 1 Code", "Shortcut Dimension 2 Code", 0, 0);

        //OnCreateDimOnBeforeUpdateLines(Rec, xRec, CurrFieldNo, OldDimSetID, DefaultDimSource);

        if (OldDimSetID <> "Dimension Set ID") and (OldDimSetID <> 0) and GuiAllowed and not GetHideValidationDialog() then
            if CouldDimensionsBeKept() then
                if not ConfirmKeepExistingDimensions() then begin
                    "Dimension Set ID" := OldDimSetID;
                    DimensionManagement.UpdateGlobalDimFromDimSetID(Rec."Dimension Set ID", Rec."Shortcut Dimension 1 Code", Rec."Shortcut Dimension 2 Code");
                end;

        if (OldDimSetID <> "Dimension Set ID") and PaymentLinesExist() then begin
            //OnCreateDimOnBeforeModify(Rec, xRec, CurrFieldNo, OldDimSetID);
            Modify();
            UpdateAllLineDim("Dimension Set ID", OldDimSetID);
        end;
    end;

    local procedure ConfirmKeepExistingDimensions() Confirmed: Boolean
    var
    //IsHandled: Boolean;
    begin
        //Confirmed := Confirm(DoYouWantToKeepExistingDimensionsQst);
        Confirmed := true;
    end;

    local procedure CouldDimensionsBeKept(): Boolean;
    var
        IsHandled: Boolean;
    begin
        IsHandled := false;
        //OnBeforeCouldDimensionsBeKept(Rec, xRec, Result, IsHandled);
        if not IsHandled then begin
            // if (xRec."Sell-to Customer No." <> '') and (xRec."Sell-to Customer No." <> Rec."Sell-to Customer No.") then
            //     exit(false);
            // if (xRec."Bill-to Customer No." <> '') and (xRec."Bill-to Customer No." <> Rec."Bill-to Customer No.") then
            //     exit(false);

            // if (xRec."Location Code" <> Rec."Location Code") and (xRec."Bill-to Customer No." <> '') then
            //     exit(true);
            // if (xRec."Salesperson Code" <> '') and (xRec."Salesperson Code" <> Rec."Salesperson Code") then
            //     exit(true);
            if (xRec."Responsibility Center" <> '') and (xRec."Responsibility Center" <> Rec."Responsibility Center") then
                exit(true);
        end;
        //OnAfterCouldDimensionsBeKept(Rec, xRec, Result);
    end;

    procedure GetHideValidationDialog(): Boolean
    begin
        exit(false);
    end;

    procedure ShowDocDim()
    var
        OldDimSetID: Integer;
    begin
        OldDimSetID := "Dimension Set ID";
        "Dimension Set ID" :=
          DimensionManagement.EditDimensionSet(
            "Dimension Set ID", StrSubstNo('%1 %2', 'Payment: ', "No."),
            "Shortcut Dimension 1 Code", "Shortcut Dimension 2 Code");

        if OldDimSetID <> "Dimension Set ID" then begin
            Modify();
            if PaymentLinesExist() then
                UpdateAllLineDim("Dimension Set ID", OldDimSetID);
        end;
    end;

    procedure GetCurrency()
    begin
        if ("Currency Code" = '') then begin
            Clear(Currency);
            Currency.InitRoundingPrecision();
        end else
            Currency.Get("Currency Code");
    end;
}
