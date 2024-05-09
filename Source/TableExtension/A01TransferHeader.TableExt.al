tableextension 50030 "A01 Transfer Header" extends "Transfer Header"
{
    fields
    {
        field(50000; "A01 Approval Status"; Enum "A01 Transfer Approval Status")
        {
            Caption = 'Approval Status';
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(50001; "A01 Approval User"; Code[50])
        {
            Caption = 'Approval User';
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(50002; "A01 Approval Date"; Date)
        {
            Caption = 'Approval Date';
            DataClassification = CustomerContent;
            Editable = false;
        }
        modify("Transfer-from Code")
        {
            trigger OnBeforeValidate()
            var
                itemMgt: Codeunit "A01 Inventory Mgt";
            begin
                itemMgt.CheckModification(Rec);
            end;
        }
        modify("Transfer-to Code")
        {
            trigger OnBeforeValidate()
            var
                itemMgt: Codeunit "A01 Inventory Mgt";
            begin
                itemMgt.CheckModification(Rec);
            end;
        }
    }
}
