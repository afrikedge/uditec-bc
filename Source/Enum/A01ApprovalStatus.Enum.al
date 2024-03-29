/// <summary>
/// Enum A01 Approval Status (ID 50037).
/// </summary>
enum 50037 "A01 Approval Status"
{
    Extensible = true;

    value(0; Open)
    {
        Caption = 'Open';
    }
    value(1; "Waiting for approval")
    {
        Caption = 'Waiting for approval';
    }
    value(2; Approved)
    {
        Caption = 'Approved';
    }
    value(3; Rejected)
    {
        Caption = 'Rejected';
    }
    value(4; Canceled)
    {
        Caption = 'Canceled';
    }
}
