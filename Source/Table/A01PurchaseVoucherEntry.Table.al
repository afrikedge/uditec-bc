/// <summary>
/// Table A01 Purchase Voucher Entry (ID 50029).
/// </summary>
table 50029 "A01 Purchase Voucher Entry"
{
    Caption = 'Purchase Voucher Entry';
    DataClassification = CustomerContent;
    LookupPageId = "A01 Purch Voucher Ledg Entries";
    DrillDownPageId = "A01 Purch Voucher Ledg Entries";

    fields
    {
        field(1; "Entry No."; Integer)
        {
            Caption = 'Entry No.';
        }
        field(2; "Voucher No."; Code[50])
        {
            Caption = 'Voucher No.';
        }
        field(3; "Posting Date"; Date)
        {
            Caption = 'Posting Date';
        }
        field(4; Amount; Decimal)
        {
            Caption = 'Amount';
        }
        field(5; "Document Type"; Enum "Item Ledger Document Type")
        {
            Caption = 'Document Type';
        }
        field(6; "Entry Type"; Enum "A01 Purch. Voucher Entry Type")
        {
            Caption = 'Entry Type';
        }
        field(7; "Document No."; Code[20])
        {
            Caption = 'Document No.';
        }
        field(8; "External User"; Code[20])
        {
            Caption = 'External User';
        }
        field(9; "Item Ledger Entry No."; Integer)
        {
            Caption = 'Item Ledger Entry No.';

        }
    }
    keys
    {
        key(PK; "Entry No.")
        {
            Clustered = true;
        }
        key(PK2; "Entry Type")
        {
            SumIndexFields = Amount;
        }
    }
}
