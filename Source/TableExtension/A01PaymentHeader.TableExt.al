/// <summary>
/// TableExtension A01 Payment Header (ID 50010) extends Record Payment Header.
/// </summary>
tableextension 50010 "A01 Payment Header" extends "Payment Header"
{
    fields
    {
        field(50000; "A01 Check No."; Code[20])
        {
            Caption = 'Check No.';
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(50001; "A01 Customer No."; Code[20])
        {
            Caption = 'Customer No.';
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(50002; "A01 Customer Name"; Text[100])
        {
            Caption = 'Customer Name';
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(50003; "A01 Description"; Text[100])
        {
            Caption = 'Description';
            DataClassification = CustomerContent;
        }
        field(50004; "A01 Origin Document No."; Code[20])
        {
            Caption = 'Origin Document No.';
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(50005; "A01 Responsibility Center"; Code[20])
        {
            Caption = 'Responsibility Center';
            DataClassification = CustomerContent;
            TableRelation = "Responsibility Center";
            Editable = false;
        }
        field(50006; "A01 Payment Method"; Code[20])
        {
            Caption = 'Payment Method';
            TableRelation = "Payment Method";
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(50007; "A01 Due Date"; Date)
        {
            Caption = 'Due Date';
            FieldClass = FlowField;
            CalcFormula = max("Payment Line"."Due Date" where("No." = field("No.")));
            Editable = false;
        }
        field(50008; "A01 Drawee Reference"; Text[10])
        {
            Caption = 'Drawee Reference';
            FieldClass = FlowField;
            CalcFormula = max("Payment Line"."Drawee Reference" where("No." = field("No.")));
            Editable = false;
        }
        // field(50006; "A01 Posted Document No."; Code[20])
        // {
        //     Caption = 'Posted Document No.';
        //     DataClassification = CustomerContent;
        //     Editable = false;
        // }
    }
}
