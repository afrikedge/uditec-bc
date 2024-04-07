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
        field(50000; "Currency Code"; Code[10])
        {
            Caption = 'Currency Code';
            TableRelation = Currency;
            Editable = false;

            trigger OnValidate()
            begin
            end;
        }

        field(50100; "Settlement Date"; Date)
        {
            Caption = 'Settlement Date';
        }
        field(50101; "User Id"; Code[50])
        {
            Caption = 'User Id';
        }
        field(50102; "Source Code"; Code[20])
        {
            Caption = 'Source Code';
        }

    }
    keys
    {
        key(PK; "No.")
        {
            Clustered = true;
        }
    }

}
