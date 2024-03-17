/// <summary>
/// TableExtension A01 Gen. Journal Line (ID 50009) extends Record Gen. Journal Line.
/// </summary>
tableextension 50009 "A01 Gen. Journal Line" extends "Gen. Journal Line"
{
    fields
    {
        field(50000; "A01 Payment Doc Type"; Enum "A01 Payment Doc Type")
        {
            Caption = 'Payment Doc Type';
            DataClassification = CustomerContent;
        }
        field(50001; "A01 Check No."; Code[20])
        {
            Caption = 'Check No.';
            DataClassification = CustomerContent;
        }
        field(50002; "A01 Check Date"; Date)
        {
            Caption = 'Check Date';
            DataClassification = CustomerContent;
        }
        field(50003; "A01 Customer Name"; Text[100])
        {
            Caption = 'Customer Name';
            DataClassification = CustomerContent;
            Editable = false;
        }
    }
}
