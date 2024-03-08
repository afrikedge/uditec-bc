/// <summary>
/// TableExtension AFK01 Sales Header (ID 50000) extends Record Sales Header.
/// </summary>
tableextension 50000 "AFK01 Sales Header" extends "Sales Header"
{
    fields
    {
        field(50000; "AFK01 Processing Status"; Enum "AFK01 SO Processing Status")
        {
            Caption = 'Processing Status';
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(50001; "AFK01 Return Reason"; Text[250])
        {
            Caption = 'Return Reason';
            DataClassification = CustomerContent;
        }
        field(50002; "AFK01 Observations"; Text[250])
        {
            Caption = 'Observations';
            DataClassification = CustomerContent;
        }
        field(50003; "AFK01 User Id"; Code[50])
        {
            Caption = 'User Id';
            DataClassification = CustomerContent;
            TableRelation = User."User Name";
            Editable = false;
        }
        field(50004; "AFK01 Delivery Autorised by"; Code[50])
        {
            Caption = 'Delivery Autorised by';
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(50005; "AFK01 Delivery Autorised On"; DateTime)
        {
            Caption = 'Delivery Autorised On';
            DataClassification = CustomerContent;
            Editable = false;
        }
    }
}
