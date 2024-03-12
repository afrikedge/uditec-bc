/// <summary>
/// Enum A01 Payment Doc Type (ID 50016).
/// </summary>
enum 50016 "A01 Payment Doc Type"
{
    Extensible = true;

    value(0; " ")
    {
        Caption = ' ';
    }
    value(1; Cash)
    {
        Caption = 'Cash';
    }
    value(2; "Direct Check")
    {
        Caption = 'Direct Check';
    }
    value(3; "Deferred Check")
    {
        Caption = 'Deferred Check';
    }
    value(4; "Bank Card")
    {
        Caption = 'Bank Card';
    }
    value(5; "Bank Transfer")
    {
        Caption = 'Bank Transfer';
    }
    value(6; "Deposit Slip")
    {
        Caption = 'Deposit Slip';
    }
    value(7; Mvola)
    {
        Caption = 'Mvola';
    }
    value(8; Orange)
    {
        Caption = 'Orange';
    }
    value(9; "Bank Draft")
    {
        Caption = 'Bank Draft';
    }
    value(10; Voucher)
    {
        Caption = 'Purchase Voucher';
    }
}
