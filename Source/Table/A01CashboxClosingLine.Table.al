/// <summary>
/// Table A01 Cashbox Closing Line (ID 50039).
/// </summary>
table 50039 "A01 Cashbox Closing Line"
{
    Caption = 'Cashbox Closing Line';
    DataClassification = CustomerContent;

    fields
    {
        field(1; "Store Code"; Code[20])
        {
            Caption = 'Store Code';
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(1));
            Editable = false;
        }
        field(2; "Closing Date"; Date)
        {
            Caption = 'Closing Date';
            Editable = false;
        }
        field(3; "Bank Account"; Code[20])
        {
            Caption = 'Bank Account';
            TableRelation = "Bank Account" where("Global Dimension 1 Code" = field("Store Code"), "A01 Bank Account Type" = const(CashBox));
        }
        field(4; "Bank Note"; Code[20])
        {
            Caption = 'Bank Note';
            TableRelation = "A01 Parameter Record".Code where(Type = const(BankNote));
            trigger OnValidate()
            var
                DecVal: Decimal;
            begin
                if (Evaluate(DecVal, "Bank Note")) then begin
                    "Bank Note Value" := DecVal;
                    Validate("Quantity");
                end;
            end;
        }
        field(5; Quantity; Integer)
        {
            Caption = 'Quantity';
            trigger OnValidate()
            var
            begin
                "Line Value" := Quantity * "Bank Note Value";
            end;
        }
        field(6; "Bank Note Value"; Decimal)
        {
            Caption = 'Bank Note Value';
            Editable = false;

        }
        field(7; "Line Value"; Decimal)
        {
            Caption = 'Line Value';
            Editable = false;
        }

    }
    keys
    {
        key(PK; "Store Code", "Closing Date", "Bank Account", "Bank Note")
        {
            Clustered = true;
        }
    }
}
