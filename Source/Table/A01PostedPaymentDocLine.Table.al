/// <summary>
/// Table A01 Posted Payment Doc Line (ID 50034).
/// </summary>
table 50034 "A01 Posted Payment Doc Line"
{
    Caption = 'Posted Payment Doc Line';
    DataClassification = CustomerContent;

    fields
    {
        field(1; "Document No."; Code[20])
        {
            Caption = 'Document No.';
        }
        field(2; "Payment Method"; Code[20])
        {
            Caption = 'Payment Method';
            TableRelation = "A01 RC Payment Method"."Payment Method" where("Responsability Center" = field("Responsibility Center"));
        }
        field(3; Reference; Text[30])
        {
            Caption = 'Reference';
        }
        field(4; Amount; Decimal)
        {
            Caption = 'Amount';
        }
        field(5; "Validated Amount"; Decimal)
        {
            Caption = 'Validated Amount';
        }
        field(6; "Responsibility Center"; Code[20])
        {
            Caption = 'Responsibility Center';
            TableRelation = "Responsibility Center";
        }
        field(7; "Applies-to ID"; Code[50])
        {
            Caption = 'Applies-to ID';
            Editable = false;
        }
        field(8; "Applies-to Doc. Type"; Enum "Gen. Journal Document Type")
        {
            Caption = 'Applies-to Doc. Type';
            Editable = false;
        }
        field(9; "Applies-to Doc. No."; Code[20])
        {
            Caption = 'Applies-to Doc. No.';
            Editable = false;
        }





        field(50000; "Account Type"; enum "Gen. Journal Account Type")
        {
            Caption = 'Account Type';
            Editable = false;
        }
        field(50001; "Account No."; Code[20])
        {
            Caption = 'Account No.';
            Editable = false;
        }
        field(50002; "Amount (LCY)"; Decimal)
        {
            Caption = 'Amount (LCY)';
            Editable = false;
        }
        field(50003; "Currency Code"; Code[10])
        {
            Caption = 'Currency Code';
            TableRelation = Currency;
            Editable = false;
        }
        field(50004; "Due Date"; Date)
        {
            Caption = 'Due Date';
            Editable = false;
        }





    }
    keys
    {
        key(PK; "Document No.", "Responsibility Center", "Payment Method")
        {
            Clustered = true;
        }
    }
}
