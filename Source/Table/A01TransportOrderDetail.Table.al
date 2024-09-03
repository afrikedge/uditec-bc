table 50055 "A01 Transport Order Detail"
{
    Caption = 'Transport Order Detail';
    DataClassification = CustomerContent;

    fields
    {
        field(1; "Transport Order No."; Code[20])
        {
            Caption = 'Transport Order No.';
        }
        field(2; "Order No."; Code[20])
        {
            Caption = 'Order No.';
        }
        field(3; "Line No."; Integer)
        {
            Caption = 'Line No.';
        }
        field(4; "Customer No."; Code[20])
        {
            Caption = 'Customer No.';
            TableRelation = Customer;
            Editable = false;
        }
        field(5; "Address Code"; Code[20])
        {
            Caption = 'Address Code';
            Editable = false;
        }
        field(6; "Time preference"; Enum "A01 Time Slot")
        {
            Caption = 'Time preference';
            Editable = false;
        }
        field(7; "Transport Direction"; Enum "A01 Transport Direction")
        {
            Caption = 'Transport Direction';
            Editable = false;
        }
        field(8; "Item No."; Code[20])
        {
            Caption = 'Item No.';
            Editable = false;
        }
        field(9; "Unit of Mesure Code"; Code[20])
        {
            Caption = 'Unit of Mesure Code';
            Editable = false;
        }
        field(10; "Quantity (Planned)"; Decimal)
        {
            Caption = 'Quantity (Planned)';
        }
        field(11; "Unloading Duration"; Decimal)
        {
            Caption = 'Unloading Duration';
        }
        field(12; "Total Volume (cbm)"; Decimal)
        {
            Caption = 'Total Volume (cbm)';
            Editable = false;
        }
        field(13; "Total Weight (Kg)"; Decimal)
        {
            Caption = 'Total Weight (Kg)';
            Editable = false;
        }
        field(14; "Quantity (Actual)"; Decimal)
        {
            Caption = 'Quantity (Actual)';
        }
        field(15; "Quantity (Gap)"; Decimal)
        {
            Caption = 'Quantity (Gap)';
            Editable = false;
        }
        field(16; "Gap Reason Code"; Code[20])
        {
            Caption = 'Gap Reason Code';
        }
        field(17; "Anomaly Type"; Enum "A01 Anomaly Type")
        {
            Caption = 'Anomaly Type';
        }
        field(18; "Anomaly Description"; Text[200])
        {
            Caption = 'Anomaly Description';
        }
        field(19; "Location Code"; Code[10])
        {
            Caption = 'Location Code';
            TableRelation = Location;
        }
        field(20; "Return Status"; enum "A01 Transport Return Status")
        {
            Caption = 'Return Status';
        }
        field(21; "Order Line No."; Integer)
        {
            Caption = 'Order Line No.';
        }
        field(22; "Order Type"; enum "A01 Transport Order Type")
        {
            Caption = 'Order Type';
        }
        field(23; "Service Zone"; Code[10])
        {
            Caption = 'Order Type';
            TableRelation = "Service Zone";
        }
    }
    keys
    {
        key(PK; "Transport Order No.", "Order No.", "Line No.")
        {
            Clustered = true;
        }
        key(PK2; "Transport Order No.", "Order Type", "Location Code")
        {
        }
        key(PK3; "Transport Order No.", "Customer No.")
        {
        }
    }
    trigger OnInsert()
    var
        TOLine: record "A01 Transport Order Detail";
        ErrorLbl: label 'This order line (%1 - %2) is already present in document %3', Comment = '%1 %2 %3';
    begin
        TOLine.SetRange("Order No.", Rec."Order No.");
        TOLine.SetRange("Order Line No.", Rec."Order Line No.");
        if TOLine.FindSet() then
            repeat
                if (TOLine."Transport Order No." <> Rec."Transport Order No.") then
                    Error(ErrorLbl, Rec."Order Line No.", Rec."Order No.", TOLine."Transport Order No.");
            until TOLine.Next() < 1;
    end;
}
