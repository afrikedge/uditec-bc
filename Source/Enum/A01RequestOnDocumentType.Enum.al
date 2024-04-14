/// <summary>
/// Enum A01 Request Sales Doc Type (ID 50042).
/// </summary>
enum 50042 "A01 Request On Document Type"
{
    Extensible = true;

    value(0; Discount)
    {
        Caption = 'Discount';
    }
    value(1; Unblocking)
    {
        Caption = 'Unblocking';
    }
    value(3; "POS Payment")
    {
        Caption = 'POS Payment';
    }
    value(4; "Payment Document")
    {
        Caption = 'Payment Document';
    }
}
