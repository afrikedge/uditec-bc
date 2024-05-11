/// <summary>
/// Enum A01 System Decision (ID 50028).
/// </summary>
enum 50028 "A01 System Decision"
{
    Extensible = true;

    value(0; " ")
    {
        Caption = ' ';
    }
    value(1; Eligible)
    {
        Caption = 'Eligible';
    }
    value(2; "Not eligible")
    {
        Caption = 'Not eligible';
    }

    value(3; Arbitration)
    {
        Caption = 'Arbitration';
    }
}
