/// <summary>
/// Table A01 RC Payment Method (ID 50018).
/// </summary>
table 50018 "A01 RC Payment Method"
{
    Caption = 'RC Payment Method';
    DataClassification = CustomerContent;

    fields
    {
        field(1; "Responsability Center"; Code[20])
        {
            Caption = 'Responsability Center';
            TableRelation = "Responsibility Center";
        }
        field(2; "Payment Method"; Code[20])
        {
            Caption = 'Payment Method';
            TableRelation = "Payment Method";
        }
        field(3; "Bal. Account Type"; Enum "Payment Balance Account Type")
        {
            Caption = 'Bal. Account Type';

            trigger OnValidate()
            begin
                "Bal. Account No." := '';
            end;
        }
        field(4; "Bal. Account No."; Code[20])
        {
            Caption = 'Bal. Account No.';
            TableRelation = if ("Bal. Account Type" = const("G/L Account")) "G/L Account"
            else
            if ("Bal. Account Type" = const("Bank Account")) "Bank Account";

            trigger OnValidate()
            begin
                //if "Bal. Account No." <> '' then
                //    TestField("Direct Debit", false);
                if "Bal. Account Type" = "Bal. Account Type"::"G/L Account" then
                    CheckGLAcc("Bal. Account No.");
            end;
        }
        field(5; "Payment Class"; Code[20])
        {
            Caption = 'Payment Class';
            TableRelation = "Payment Class" where("A01 Responsibility Center" = field("Responsability Center"));
        }
    }
    keys
    {
        key(PK; "Responsability Center", "Payment Class")
        {
            Clustered = true;
        }
    }

    local procedure CheckGLAcc(AccNo: Code[20])
    var
        GLAcc: Record "G/L Account";
        IsHandled: Boolean;
    begin
        IsHandled := false;
        //OnBeforeCheckGLAcc(Rec, CurrFieldNo, AccNo, IsHandled);
        if IsHandled then
            exit;

        if AccNo <> '' then begin
            GLAcc.Get(AccNo);
            GLAcc.CheckGLAcc();
            GLAcc.TestField("Direct Posting", true);
        end;
    end;
}
