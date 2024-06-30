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
        }
        field(4; "Vehicle No."; Code[20])
        {
            Caption = 'Vehicle No.';
        }
        field(5; " Driver No."; Code[20])
        {
            Caption = ' Driver No.';
        }
        field(6; "Route No."; Code[20])
        {
            Caption = 'Route No.';
        }
        field(7; "Departure Date (Planned)"; Date)
        {
            Caption = 'Departure Date (Planned)';
        }
        field(8; "Departure Time (Planned)"; Time)
        {
            Caption = 'Departure Time (Planned)';
        }
        field(9; "Return Date (Planned)"; Date)
        {
            Caption = 'Return Date (Planned)';
        }
        field(10; "Return Time (Planned)"; Time)
        {
            Caption = 'Return Time (Planned)';
        }
        field(11; "Departure Date (Actual)"; Date)
        {
            Caption = 'Departure Date (Actual)';
        }
        field(12; "Departure Time (Actual)"; Time)
        {
            Caption = 'Departure Time (Actual)';
        }
        field(13; "Return Date (Actual)"; Date)
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
        }
        field(18; "Payload (kg)"; Decimal)
        {
            Caption = 'Payload (kg)';
        }

        field(19; "Outbound Package Count"; Decimal)
        {
            Caption = 'Outbound Package Count';
        }
        field(20; "Outbound Volume Loaded (cbm)"; Decimal)
        {
            Caption = 'Outbound Volume Loaded (cbm)';
        }

        field(21; "Outbound Weight Load (Kg)"; Decimal)
        {
            Caption = 'Outbound Weight Load (Kg)';
        }

        field(22; "Outbound Unloading Dura (Plan)"; Decimal)
        {
            Caption = 'Outbound Unloading Duration (Planned)';
        }
        field(23; "Inbound Package Count"; Decimal)
        {
            Caption = 'Inbound Package Count';
        }
        field(24; "Inbound Volume Loaded (cbm)"; Decimal)
        {
            Caption = 'Inbound Volume Loaded (cbm)';
        }
        field(25; "Inbound Weight Load (Kg)"; Decimal)
        {
            Caption = 'Inbound Weight Load (Kg)';
        }
        field(26; "Inbound Unloading Dura (Plan)"; Decimal)
        {
            Caption = 'Inbound Unloading Duration (Planned)';
        }
        field(27; "No. Series"; Code[20])
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
            AddOnSetup.TestField("Transport Order Nos");
            NoSeriesManagement.InitSeries(AddOnSetup."Transport Order Nos", xRec."No. Series", 0D, "No.", "No. Series");
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
