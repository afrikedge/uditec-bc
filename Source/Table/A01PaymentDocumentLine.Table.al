/// <summary>
/// Table A01 Payment Document Line (ID 50033).
/// </summary>
table 50033 "A01 Payment Document Line"
{
    Caption = 'Payment Document Line';
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
    }
    keys
    {
        key(PK; "Document No.", "Responsibility Center", "Payment Method")
        {
            Clustered = true;
        }
    }
}
