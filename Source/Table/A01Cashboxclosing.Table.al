/// <summary>
/// Table A01 Cashbox closing (ID 50038).
/// </summary>
table 50038 "A01 Cashbox Closing"
{
    Caption = 'Cashbox closing';
    DataClassification = CustomerContent;

    fields
    {
        field(1; "Store Code"; Code[20])
        {
            Caption = 'Store Code';
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(1));
            trigger OnValidate()
            var
            begin
                if (xRec."Store Code" <> "Store Code") then
                    DeleteLinesIfTheyExists();
            end;
        }
        field(2; "Closing Date"; Date)
        {
            Caption = 'Closing Date';
            trigger OnValidate()
            var
            begin
                if (xRec."Closing Date" <> "Closing Date") then
                    DeleteLinesIfTheyExists();
            end;
        }
        field(3; Status; Enum "A01 Cashbox closing Status")
        {
            Caption = 'Status';
            Editable = false;
        }
        field(4; "Closing Balance"; Decimal)
        {
            Caption = 'Closing Balance';
            Editable = false;
            FieldClass = FlowField;
            CalcFormula = sum("A01 Cashbox Closing Line"."Line Value" where("Store Code" = field("Store Code"),
                                                                            "Closing Date" = field("Closing Date")));
        }
    }
    keys
    {
        key(PK; "Store Code", "Closing Date")
        {
            Clustered = true;
        }
    }


    trigger OnInsert()
    begin
        InitHeader();
    end;

    var
        SecMgt: Codeunit "A01 Security Mgt";
        LblQuestChangeRespCenter: Label 'The lines will be deleted. Do you want to continue ?';
        LblQuestValidate: Label 'Do you want to validate the closing of cashbox for the date of %1 ?', Comment = '%1)';



    local procedure InitHeader()
    begin

        //Validate("Store Code", SecMgt.GetMainUserResponsibilityCenterStore());
    end;

    local procedure DeleteLinesIfTheyExists()
    var
        DocLine: Record "A01 Cashbox Closing Line";
    begin
        DocLine.SetRange("Store Code", "Store Code");
        DocLine.SetRange("Closing Date", "Closing Date");
        if (not DocLine.IsEmpty) then
            if (Confirm(LblQuestChangeRespCenter)) then begin
                DocLine.DeleteAll();
            end;
    end;

    procedure PostCashboxClosing()
    var
        DocLine: Record "A01 Cashbox Closing Line";
    begin
        if (not Confirm(StrSubstNo(LblQuestValidate, "Closing Date"))) then
            exit;

        DocLine.Reset();
        DocLine.SetRange("Store Code", "Store Code");
        DocLine.SetRange("Closing Date", "Closing Date");
        if DocLine.FindSet() then
            repeat
                SecMgt.CheckBankUserAccount(DocLine."Bank Account");
            until DocLine.Next() < 1;

        Rec.Status := rec.Status::Posted;
        Modify();

        DocLine.Reset();
        DocLine.SetRange("Store Code", "Store Code");
        DocLine.SetRange("Closing Date", "Closing Date");
        DocLine.ModifyAll(Status, rec.Status::Posted);
    end;
}
