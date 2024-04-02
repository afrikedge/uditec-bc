
/// <summary>
/// Enum A01 MIR Due rounding rule (ID 50027).
/// </summary>
enum 50027 "A01 MIR Due rounding rule"
{
    Extensible = true;

    value(0; None)
    {
        Caption = 'None';
    }
    value(1; Hundred)
    {
        Caption = 'Hundred';
    }
    value(2; Thousand)
    {
        Caption = 'Thousand';
    }
}
