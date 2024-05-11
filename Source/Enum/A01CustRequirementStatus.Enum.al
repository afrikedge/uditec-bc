enum 50022 "A01 Cust Requirement Status"
{
    Extensible = true;

    value(0; Mandatory)
    {
        Caption = 'Mandatory';
    }
    value(1; Recommended)
    {
        Caption = 'Recommended';
    }
    value(2; Conditional)
    {
        Caption = 'Conditional';
    }
    value(3; Income)
    {
        Caption = 'Income';
    }
    value(4; Joint)
    {
        Caption = 'Joint';
    }
}
