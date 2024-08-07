enum 50077 "A01 Transport Return Status"
{
    Extensible = true;
    
    value(0; Waiting)
    {
        Caption = 'Waiting';
    }
    value(1; Shipped)
    {
        Caption = 'Shipped';
    }
    value(2; Postponed)
    {
        Caption = 'Postponed';
    }
    value(3; Return)
    {
        Caption = 'Return';
    }
}
