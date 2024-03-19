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
    value(2; Arbitration)
    {
        Caption = 'Arbitration';
    }
    value(3; "Waiting for committee")
    {
        Caption = 'Waiting for committee';
    }
    value(4; Valid)
    {
        Caption = 'Valid';
    }
    value(5; Canceled)
    {
        Caption = 'Canceled';
    }
    value(6; Rejected)
    {
        Caption = 'Rejected';
    }
}
