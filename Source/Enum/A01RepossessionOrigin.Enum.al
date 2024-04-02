/// <summary>
/// Enum A01 Repossession Origin (ID 50043).
/// </summary>
enum 50043 "A01 Repossession Origin"
{
    Extensible = true;

    value(0; Voluntary)
    {
        Caption = 'Voluntary';
    }
    value(1; Forced)
    {
        Caption = 'Forced';
    }
}
