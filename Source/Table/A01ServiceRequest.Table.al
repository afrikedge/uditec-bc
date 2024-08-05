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
        field(14; "Web User Id"; Code[50])
        {
            Caption = 'Web User Id';
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(15; "Responsibility Center"; Code[10])
        {
            Caption = 'Point of sale';
            TableRelation = "Responsibility Center";
        }
        field(16; "Ship-to Code"; Code[10])
        {
            Caption = 'Delivery address';
            TableRelation = "Ship-to Address".Code where("Customer No." = field("Customer No."));
        }
        field(17; "Contact No."; Code[10])
        {
            Caption = 'Contact No.';
            TableRelation = "Contact"."No.";
        }
        field(18; "Serial No."; Code[50])
        {
            Caption = 'Serial No.';
        }
        field(19; "IMEI No."; Code[50])
        {
            Caption = 'IMEI number';
        }
        field(20; "Sales Doc. No."; Code[50])
        {
            Caption = 'Invoice/BL number';
        }
        field(21; "Description"; Text[300])
        {
            Caption = 'Description of the problem';
        }
        field(22; "Item Accessories"; Text[300])
        {
            Caption = 'Accessories item';
        }
        field(23; "Observations"; Text[300])
        {
            Caption = 'Observations';
        }
        field(24; "SR Type"; enum "A01 SR Type")
        {
            Caption = 'Place of intervention';
        }
        field(25; "SR Origin"; enum "A01 SR Origin")
        {
            Caption = 'Origin of request';
        }
        field(26; "Diagnostic Report"; Text[250])
        {
            Caption = 'Diagnostic Report';
        }
        field(27; "Repair Report"; Text[250])
        {
            Caption = 'Repair Report';
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
