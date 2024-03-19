/// <summary>
/// Table A01 Credit Depreciation Table (ID 50016).
/// </summary>
table 50016 "A01 Credit Depreciation Table"
{
    Caption = 'Credit Depreciation Table';
    DataClassification = CustomerContent;

    fields
    {
        field(1; "Document Type"; Enum "A01 Depreciation Document Type")
        {
            Caption = 'Document Type';
        }
        field(2; "Document No."; Code[20])
        {
            Caption = 'Document No.';
        }
        field(3; "Line No."; Integer)
        {
            Caption = 'Line No.';
        }
        field(4; "Calculation factor"; Integer)
        {
            Caption = 'Calculation factor';
            MinValue = 0;
            MaxValue = 100;
        }
        field(5; "Monthly payment"; Decimal)
        {
            Caption = 'Monthly payment';
        }
        field(6; Depreciation; Decimal)
        {
            Caption = 'Depreciation';
        }
        field(7; "Remaining debt"; Decimal)
        {
            Caption = 'Remaining debt';
        }
        field(8; "Abandoned interests"; Decimal)
        {
            Caption = 'Abandoned interests';
        }
        field(9; "Payment balance"; Decimal)
        {
            Caption = 'Payment balance';
        }
        field(10; "Amount paid"; Decimal)
        {
            Caption = 'Amount paid';
        }
    }
    keys
    {
        key(PK; "Document Type", "Document No.", "Line No.")
        {
            Clustered = true;
        }
    }
}
