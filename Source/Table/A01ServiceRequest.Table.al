table 50056 "A01 Service Request"
{
    Caption = 'Service Request';
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
                    NoSeriesManagement.TestManual(AddOnSetup."Service Request Nos");
                    "No. Series" := '';
                end;
            end;
        }
        field(2; "Service Request Status"; Enum "A01 ServiceRequest Status")
        {
            Caption = 'Service Request Status';
        }
        field(3; "Customer No."; Code[20])
        {
            Caption = 'Customer No.';
            TableRelation = Customer;
        }
        field(4; "Warranty Status"; Boolean)
        {
            Caption = 'Warranty Status';
        }
        field(5; "Contrat No."; Code[20])
        {
            Caption = 'Contrat No.';
            TableRelation = "A01 Warranty contract";
        }
        field(6; "Item No."; Code[20])
        {
            Caption = 'Item No.';
            TableRelation = Item;
        }
        field(7; Reference; Code[30])
        {
            Caption = 'Reference';
        }
        field(8; "Warranty End Date"; Date)
        {
            Caption = 'Warranty End Date';
        }
        field(9; "Created On"; Date)
        {
            Caption = 'Created On';
        }
        field(10; "Created By"; Code[50])
        {
            Caption = 'Created By';
            TableRelation = "A01 External User";
        }
        field(11; "Closed On"; Date)
        {
            Caption = 'Closed On';
        }
        field(12; "Closed By"; Code[50])
        {
            Caption = 'Closed By';
            TableRelation = "A01 External User";
        }
        field(13; "No. Series"; Code[20])
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
            AddOnSetup.TestField("Service Request Nos");
            NoSeriesManagement.InitSeries(AddOnSetup."Service Request Nos", xRec."No. Series", 0D, "No.", "No. Series");
        end;
        InitHeader();
    end;

    var
        AddOnSetup: Record "A01 Afk Setup";
        Currency: Record Currency;
        NoSeriesManagement: Codeunit NoSeriesManagement;
        RequestMgt: Codeunit "A01 Document Request Mgt";
        DimensionManagement: Codeunit DimensionManagement;

    local procedure InitHeader()
    begin
    end;
}
