/// <summary>
/// Table A01 Warranty contract (ID 50026).
/// </summary>
table 50027 "A01 Warranty contract"
{
    Caption = 'Warranty contract';
    DataClassification = CustomerContent;

    fields
    {
        field(11; "No."; Code[20])
        {
            Caption = 'No.';
        }
        field(1; "Item No."; Code[20])
        {
            Caption = 'Item No.';
        }
        field(2; "Serie No."; Code[20])
        {
            Caption = 'Serie No.';
        }
        field(3; "Customer No."; Code[20])
        {
            Caption = 'Customer No.';
        }
        field(4; "Document Type"; Enum "Item Ledger Document Type")
        {
            Caption = 'Document Type';
        }
        field(5; "Document No."; Code[20])
        {
            Caption = 'Document No.';
        }
        field(6; "Starting Date"; Date)
        {
            Caption = 'Starting Date';
        }
        field(7; "Standard Warranty"; Code[20])
        {
            Caption = 'Standard Warranty';
            TableRelation = "A01 Warranty Plan";
        }
        field(8; "Standard Warranty Ending Date"; Date)
        {
            Caption = 'Standard Warranty Ending Date';
        }
        field(9; "Extended Warranty"; Code[20])
        {
            Caption = 'Extended Warranty';
            TableRelation = "A01 Warranty Plan";
        }
        field(10; "Extended Warranty Ending Date"; Date)
        {
            Caption = 'Extended Warranty Ending Date';
        }
        field(12; "Line No."; integer)
        {
            Caption = 'Line No.';
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
