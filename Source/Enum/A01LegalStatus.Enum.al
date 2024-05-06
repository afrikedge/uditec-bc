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
    value(1; "SA")
    {
        Caption = 'SA';
    }
    value(2; SARL)
    {
        Caption = 'SARL';
    }
    value(3; SARLU)
    {
        Caption = 'SARLU';
    }
    value(4; Administration)
    {
        Caption = 'Administration';
    }
    value(5; Diplomatic)
    {
        Caption = 'Diplomatic representation';
    }
    value(6; NGO)
    {
        Caption = 'Non Gouv Organisation/Association';
    }
    value(7; "Individual Company")
    {
        Caption = 'Individual Company';
    }
    value(8; "Informal Entrepreneur")
    {
        Caption = 'Informal Entrepreneur';
    }
    value(9; "Individual Person")
    {
        Caption = 'Individual Person';
    }
}
