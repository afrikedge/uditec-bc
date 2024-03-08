/// <summary>
/// TableExtension AFK01 Sales Header (ID 50000) extends Record Sales Header.
/// </summary>
tableextension 50000 "A01 Sales Header" extends "Sales Header"
{
    fields
    {
        field(50000; "A01 Processing Status"; Enum "A01 SO Processing Status")
        {
            Caption = 'Processing Status';
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(50001; "A01 Return Reason"; Text[250])
        {
            Caption = 'Return Reason';
            DataClassification = CustomerContent;
        }
        field(50002; "A01 Observations"; Text[250])
        {
            Caption = 'Observations';
            DataClassification = CustomerContent;
        }
        field(50003; "A01 User Id"; Code[50])
        {
            Caption = 'User Id';
            DataClassification = CustomerContent;
            TableRelation = User."User Name";
            Editable = false;
        }
        field(50004; "A01 Delivery Autorised by"; Code[50])
        {
            Caption = 'Delivery Autorised by';
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(50005; "A01 Delivery Autorised On"; DateTime)
        {
            Caption = 'Delivery Autorised On';
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(50006; "A01 Allow Deletion"; Boolean)
        {
            DataClassification = CustomerContent;
            Editable = false;
        }
    }
}
