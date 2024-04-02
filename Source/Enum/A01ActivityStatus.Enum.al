/// <summary>
/// Enum A01 Activity Status (ID 50039).
/// </summary>
enum 50039 "A01 Activity Status"
{
    Extensible = true;

    value(0; Open)
    {
        Caption = 'Open';
    }
    value(1; Planned)
    {
        Caption = 'Planned';
    }
    value(2; "In progress")
    {
        Caption = 'In progress';
    }
    value(3; Closed)
    {
        Caption = 'Closed';
    }
    value(4; Canceled)
    {
        Caption = 'Canceled';
    }
}
