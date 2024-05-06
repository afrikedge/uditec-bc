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
    value(3; Object)
    {
        Caption = 'Object';
    }
    value(4; ImportStep)
    {
        Caption = 'ImportStep';
    }
    value(5; Brand)
    {
        Caption = 'Brand';
    }
    value(6; BankNote)
    {
        Caption = 'BankNote';
    }
    value(7; WebFunction)
    {
        Caption = 'Web Function';
    }
}
