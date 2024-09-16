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
    value(2; "Waiting for Diagnosis")
    {
        Caption = 'Waiting for Diagnosis';
    }
    value(3; "Diagnosis In Progress")
    {
        Caption = 'Diagnosis In Progress';
    }
    value(4; "Diagnosis to be confirmed")
    {
        Caption = 'Diagnosis to be confirmed';
    }
    value(5; "Waiting for quote")
    {
        Caption = 'Waiting for quote';
    }
    value(6; "Waiting for Processing")
    {
        Caption = 'Waiting for Processing';
    }
    value(7; "Processing In Progress")
    {
        Caption = 'Processing In Progress';
    }
    value(8; "Processing to be confirmed")
    {
        Caption = 'Processing to be confirmed';
    }
    value(9; "Waiting for invoicing")
    {
        Caption = 'Waiting for invoicing';
    }
    value(10; "Waiting for delivery")
    {
        Caption = 'Waiting for delivery';
    }

    value(11; "Waiting for replacement")
    {
        Caption = 'Waiting for replacement';
    }
    value(12; "Waiting for refund")
    {
        Caption = 'Waiting for refund';
    }
    value(13; "Closed")
    {
        Caption = 'Closed';
    }
    value(14; "Cancelled")
    {
        Caption = 'Cancelled';
    }
}
