/// <summary>
/// Enum A01 AGP Credit Limit Mode (ID 50057).
/// </summary>
enum 50057 "A01 AGP Credit Limit Mode"
{
    Extensible = true;

    value(0; "Salary")
    {
        Caption = 'Salary';
    }
    value(1; "Standard")
    {
        Caption = 'Standard';
    }
    value(2; "Manual")
    {
        Caption = 'Manual';
    }
}
