/// <summary>
/// Enum A01 Credit Validation Status (ID 50024).
/// </summary>
enum 50024 "A01 Credit Validation Status"
{
    Extensible = true;

    value(0; Initialization)
    {
        Caption = 'Initialization';
    }
    value(1; "File on hold")
    {
        Caption = 'File on hold';
    }
    value(2; "Waiting for Analyst")
    {
        Caption = 'Waiting for Analyst';
    }
    value(3; "Waiting for investigation")
    {
        Caption = 'Waiting for investigation';
    }
    value(4; "Waiting for collection")
    {
        Caption = 'Waiting for collection';
    }
    value(5; "Waiting for manager")
    {
        Caption = 'Waiting for manager';
    }
    value(6; "Waiting for committee")
    {
        Caption = 'Waiting for committee';
    }
    value(7; "Validated under conditions")
    {
        Caption = 'Validated under conditions';
    }
    value(8; Validated)
    {
        Caption = 'Validated';
    }
    value(9; Canceled)
    {
        Caption = 'Canceled';
    }
    value(10; Rejected)
    {
        Caption = 'Rejected';
    }
    value(11; Closed)
    {
        Caption = 'Closed';
    }
}
