enum 50078 "A01 Transport Order Type"
{
    Extensible = true;
    
    value(0; "Sales Order")
    {
        Caption = 'Sales Order';
    }
    value(1; "Sales Order return")
    {
        Caption = 'Sales Order return';
    }
    value(2; Transfer)
    {
        Caption = 'Transfer';
    }
}
