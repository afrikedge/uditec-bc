enum 50035 "A01 Propect Validation Status"
{
    Extensible = true;

    value(0; Initialization)
    {
        Caption = 'Initialization';
    }
    value(1; "File under processing")
    {
        Caption = 'File under processing';
    }
    value(2; "Waiting for analyst")
    {
        Caption = 'Waiting for analyst';
    }
    value(3; "Waiting for committee")
    {
        Caption = 'Waiting for committee';
    }
    value(4; "Validated under conditions")
    {
        Caption = 'Validated under conditions';
    }
    value(5; Converted)
    {
        Caption = 'Converted';
    }
    value(6; Lost)
    {
        Caption = 'Lost';
    }
    value(7; Rejected)
    {
        Caption = 'Rejected';
    }
}
