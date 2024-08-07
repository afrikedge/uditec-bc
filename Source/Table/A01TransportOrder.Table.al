table 50054 "A01 Transport Order"
{
    Caption = 'Transport Order';
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
                    NoSeriesManagement.TestManual(AddOnSetup."Transport Order Nos");
                    "No. Series" := '';
                end;
            end;
        }
        field(2; "TransportOrder Status"; Enum "A01 TransportOrder Status")
        {
            Caption = 'TransportOrder Status';
        }
        field(3; "Carrier No."; Code[20])
        {
            Caption = 'Carrier No.';
            TableRelation = Vendor;
        }
        field(4; "Vehicle No."; Code[20])
        {
            Caption = 'Vehicle No.';
            TableRelation = "A01 Vehicule";
        }
        field(5; " Driver No."; Code[20])
        {
            Caption = ' Driver No.';
            TableRelation = "A01 Driver";
        }
        field(6; "Route No."; Code[20])
        {
            Caption = 'Route No.';
            TableRelation = "A01 Route";
        }
        field(7; "Departure Date (Planned)"; DateTime)
        {
            Caption = 'Departure Date (Planned)';
        }
        field(8; "Departure Time (Planned)"; Time)
        {
            Caption = 'Departure Time (Planned)';
        }
        field(9; "Return Date (Planned)"; DateTime)
        {
            Caption = 'Return Date (Planned)';
        }
        field(10; "Return Time (Planned)"; Time)
        {
            Caption = 'Return Time (Planned)';
        }
        field(11; "Departure Date (Actual)"; DateTime)
        {
            Caption = 'Departure Date (Actual)';
        }
        field(12; "Departure Time (Actual)"; Time)
        {
            Caption = 'Departure Time (Actual)';
        }
        field(13; "Return Date (Actual)"; DateTime)
        {
            Caption = 'Return Date (Actual)';
        }
        field(14; "Return Time (Actual)"; Time)
        {
            Caption = 'Return Time (Actual)';
        }
        field(15; "Duration (Actual)"; Integer)
        {
            Caption = 'Duration (Actual)';
        }
        field(16; "Duration (Planned)"; Integer)
        {
            Caption = 'Duration (Planned)';
        }
        field(17; "Useful volume (cbm)"; Decimal)
        {
            Caption = 'Useful volume (cbm)';
            Editable = false;
        }
        field(18; "Payload (kg)"; Decimal)
        {
            Caption = 'Payload (kg)';
            Editable = false;
        }

        field(19; "Outbound Package Count"; Decimal)
        {
            Caption = 'Outbound Package Count';
            Editable = false;
        }
        field(20; "Outbound Volume Loaded (cbm)"; Decimal)
        {
            Caption = 'Outbound Volume Loaded (cbm)';
            Editable = false;
        }

        field(21; "Outbound Weight Load (Kg)"; Decimal)
        {
            Caption = 'Outbound Weight Load (Kg)';
            Editable = false;
        }

        field(22; "Outbound Unloading Dura (Plan)"; Decimal)
        {
            Caption = 'Outbound Unloading Duration (Planned)';
            Editable = false;
        }
        field(23; "Inbound Package Count"; Decimal)
        {
            Caption = 'Inbound Package Count';
            Editable = false;
        }
        field(24; "Inbound Volume Loaded (cbm)"; Decimal)
        {
            Caption = 'Inbound Volume Loaded (cbm)';
            Editable = false;
        }
        field(25; "Inbound Weight Load (Kg)"; Decimal)
        {
            Caption = 'Inbound Weight Load (Kg)';
            Editable = false;
        }
        field(26; "Inbound Unloading Dura (Plan)"; Decimal)
        {
            Caption = 'Inbound Unloading Duration (Planned)';
            Editable = false;
        }
        field(27; "No. Series"; Code[20])
        {
            Caption = 'No. Series';
            TableRelation = "No. Series";
        }
        field(28; "Web User Id"; Code[50])
        {
            Caption = 'Web User Id';
            DataClassification = CustomerContent;
            Editable = false;
        }

        field(29; "Delivery Agent"; Code[50])
        {
            Caption = 'Delivery Agent';
            DataClassification = CustomerContent;
            Editable = false;
            TableRelation = "A01 External User";
        }
        field(30; "Initial Location"; Code[50])
        {
            Caption = 'Delivery Agent';
            DataClassification = CustomerContent;
            Editable = false;
            TableRelation = Location;
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
            AddOnSetup.TestField("Transport Order Nos");
            NoSeriesManagement.InitSeries(AddOnSetup."Transport Order Nos", xRec."No. Series", 0D, "No.", "No. Series");
        end;
        InitHeader();
    end;

    trigger OnDelete()
    var
        TransportOrderDetail: Record "A01 Transport Order Detail";
    begin
        TransportOrderDetail.Reset();
        TransportOrderDetail.SetRange("Transport Order No.", Rec."No.");
        if (not TransportOrderDetail.IsEmpty) then
            TransportOrderDetail.DeleteAll();
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
