enum 50065 "A01 ServiceRequest Status"
{
    Extensible = true;
    
    value(0; Draft)
    {
        Caption = 'Draft';
    }
    value(1; Confirmed)
    {
        Caption = 'Confirmed';
    }
    value(2; Canceled)
    {
        Caption = 'Canceled';
    }
    value(3; Closed)
    {
        Caption = 'Closed';
    }
    value(4; "To Diagnose")
    {
        Caption = 'To Diagnose';
    }
    value(5; "To Treat")
    {
        Caption = 'To Treat';
    }
    value(6; "To qualify")
    {
        Caption = 'To qualify';
    }
    value(7; "To be invoiced")
    {
        Caption = 'To be invoiced';
    }
    value(8; "To deliver")
    {
        Caption = 'To deliver';
    }
    value(9; "To replace")
    {
        Caption = 'To replace';
    }
    value(10; "To repay")
    {
        Caption = 'To repay';
    }
}
