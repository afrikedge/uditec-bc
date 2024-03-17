/// <summary>
/// Enum A01 Parameter Type (ID 50017).
/// </summary>
enum 50017 "A01 Parameter Record Type"
{
    Extensible = true;

    value(0; " ")
    {
        Caption = ' ';
    }
    value(1; RiskLevel)
    {
        Caption = 'RiskLevel';
    }
    value(2; TicketFormat)
    {
        Caption = 'TicketFormat';
    }
}
