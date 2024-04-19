/// <summary>
/// Enum A01 Reposession Acceptance Status (ID 50044).
/// </summary>
enum 50044 "A01 Reposession Accept Status"
{
    Extensible = true;

    value(0; Waiting)
    {
        Caption = 'Waiting';
    }
    value(1; Accepted)
    {
        Caption = 'Accepted';
    }
    value(2; Cancelled)
    {
        Caption = 'Cancelled';
    }
    value(3; Closed)
    {
        Caption = 'Closed';
    }
}
