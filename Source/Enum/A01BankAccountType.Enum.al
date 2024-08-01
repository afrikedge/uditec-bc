enum 50054 "A01 Bank Account Type"
{
    Extensible = true;

    value(0; "Bank Account")
    {
        Caption = 'Bank Account';
    }
    value(1; CashBox)
    {
        Caption = 'Income CashBox';
    }
    value(2; PettyCash)
    {
        Caption = 'Petty Cash';
    }
    value(3; MobileMoney)
    {
        Caption = 'Mobile Money';
    }
}
