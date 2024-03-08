/// <summary>
/// Enum A01 SO Processing Status (ID 50000).
/// </summary>
enum 50000 "A01 SO Processing Status"
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
    value(7; "Totally shipped")
    {
        Caption = 'Totally shipped';
    }
    value(8; "Partially shipped")
    {
        Caption = 'Partially shipped';
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
