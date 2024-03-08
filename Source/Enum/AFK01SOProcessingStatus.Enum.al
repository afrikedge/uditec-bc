enum 50000 "AFK01 SO Processing Status"
{
    Extensible = true;

    value(0; Draft)
    {
        Caption = 'Draft';
    }
    value(1; "Waiting for prepayment")
    {
        Caption = 'Waiting for prepayment';
    }
    value(2; "Blocked")
    {
        Caption = 'Blocked';
    }
    value(3; "Stock out")
    {
        Caption = 'Stock out';
    }
    value(4; "Partially out of stock")
    {
        Caption = 'Partially out of stock';
    }
    value(5; "Waiting for discount")
    {
        Caption = 'Waiting for discount';
    }
    value(6; "Waiting for delivery")
    {
        Caption = 'Waiting for delivery';
    }
    value(7; "Totally delivered")
    {
        Caption = 'Totally delivered';
    }
    value(8; "Partially delivered")
    {
        Caption = 'Partially delivered';
    }
    value(9; "Partially invoiced")
    {
        Caption = 'Partially invoiced';
    }
    value(10; "Consigned")
    {
        Caption = 'Consigned';
    }
    value(12; "Partially Consigned")
    {
        Caption = 'Partially Consigned';
    }
    value(13; "Closed")
    {
        Caption = 'Closed';//Soldée
    }
    value(14; "Totally invoiced")
    {
        Caption = 'Totally invoiced';
    }
    value(15; "Cancelled")
    {
        Caption = 'Cancelled';
    }
}
