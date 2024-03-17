/// <summary>
/// TableExtension A01 Payment Header Archive (ID 50012) extends Record Payment Header Archive.
/// </summary>
tableextension 50012 "A01 Payment Header Archive" extends "Payment Header Archive"
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
    }
}
