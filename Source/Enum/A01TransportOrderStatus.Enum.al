enum 50064 "A01 TransportOrder Status"
{
    Extensible = true;
    
    value(0; Waiting)
    {
        Caption = 'Waiting';
    }
    value(1; Planned)
    {
        Caption = 'Planned';
    }
    value(2; Shipped)
    {
        Caption = 'Shipped';
    }
    value(3; Closed)
    {
        Caption = 'Closed';
    }
    value(4; Canceled)
    {
        Caption = 'Canceled';
    }
}
