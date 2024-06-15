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
        field(4; "Calculation factor"; Decimal)
        {
            Caption = 'Calculation factor';
            MinValue = 0;
            MaxValue = 100;
            DecimalPlaces = 0 : 8;
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
        field(10; "Interest"; Decimal)
        {
            Caption = 'Interest';
        }
        field(11; "Quote No."; Code[20])
        {
            Caption = 'Quote No.';
            Editable = false;
        }
        field(12; "Order No."; Code[20])
        {
            Caption = 'Order No.';
            Editable = false;
        }
        field(13; "Interest Excl VAT"; Decimal)
        {
            Caption = 'Interest Excl VAT';
            //Editable = false;
        }
        field(14; "VAT on interest"; Decimal)
        {
            Caption = 'VAT on interest';
            //Editable = false;
        }
        field(15; "Paid Amount"; Decimal)
        {
            Caption = 'Paid Amount';
            Editable = false;
        }
        field(408; "Dimension Set ID"; integer)
        {
            Caption = 'Dimension Set ID';
        }

        // field(100; "Archived"; Boolean)
        // {
        //     Caption = 'Archived';
        //     Editable = false;
        // }
        field(101; "Cust Ledger Entry No."; Integer)
        {
            Caption = 'Cust Ledger Entry No.';
            Editable = false;
        }
        field(102; "Due Date"; Date)
        {
            Caption = 'Due Date';
            Editable = false;
        }
        field(103; "Interest Posted"; Boolean)
        {
            Caption = 'Interest Posted';
            Editable = false;
        }
        field(104; "Old Reference"; Text[30])
        {
            Caption = 'Old Reference';
            Editable = false;
        }
        field(105; "Payment Date"; Date)
        {
            Caption = 'Payment Date';
            Editable = false;
        }
        field(106; "Closed"; Boolean)
        {
            Caption = 'Closed';
            Editable = false;
        }
        field(107; "Customer No."; Code[20])
        {
            Caption = 'Customer No.';
            Editable = false;
            TableRelation = Customer;
        }
    }
    keys
    {
        key(PK; "Document Type", "Document No.", "Line No.")
        {
            Clustered = true;
        }
        key(PK2; "Customer No.", Closed)
        {

        }
    }

    procedure GetDueDays(): integer
    var
        tresoMgt: codeunit "A01 Treso Mgt";
    begin
        exit(tresoMgt.NosDays(rec."Due Date", Today));
    end;
}
