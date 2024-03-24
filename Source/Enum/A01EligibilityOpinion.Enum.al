/// <summary>
/// Enum A01 Eligibility Notice (ID 50029).
/// </summary>
enum 50029 "A01 Eligibility Opinion"
{
    Extensible = true;

    value(0; Favorable)
    {
        Caption = 'Favorable';
    }
    value(1; "Not favorable")
    {
        Caption = 'Not favorable';
    }
    value(2; Doubtful)
    {
        Caption = 'Doubtful';
    }
}
