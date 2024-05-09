/// <summary>
/// Enum A01 Approval Status (ID 50037).
/// </summary>
enum 50037 "A01 Approval Status"
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
    value(6; "Waiting for validation")
    {
        Caption = 'Waiting for validation';
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
    value(12; AwaitingVerification)
    {
        Caption = 'Awaiting Verification';
    }
}
