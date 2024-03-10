/// <summary>
/// Enum A01 Legal Status (ID 50003).
/// </summary>
enum 50003 "A01 Legal Status"
{
    Extensible = true;

    value(0; " ")
    {
        Caption = ' ';
    }
    value(1; "Limited Company")
    {
        Caption = 'Limited Company';
    }
    value(2; SARL)
    {
        Caption = 'SARL';
    }
    value(3; SAS)
    {
        Caption = 'SAS';
    }
    value(4; Admin)
    {
        Caption = 'Administration';
    }
    value(5; "Individual Company")
    {
        Caption = 'Individual Company';
    }
    value(6; NGO)
    {
        Caption = 'Non Gouv Organisation';
    }
    value(7; Diplomatic)
    {
        Caption = 'Diplomatic representation';
    }
    value(8; Association)
    {
        Caption = 'Association';
    }
    value(9; Person)
    {
        Caption = 'Individual Person';
    }
}
