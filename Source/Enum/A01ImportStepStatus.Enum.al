/// <summary>
/// Enum A01 Import Step Status (ID 50031).
/// </summary>
enum 50031 "A01 Import Step Status"
{
    Extensible = true;

    value(0; Waiting)
    {
        Caption = 'Waiting';
    }
    value(1; "In Progress")
    {
        Caption = 'In Progress';
    }
    value(2; Late)
    {
        Caption = 'Late';
    }
    value(3; Closed)
    {
        Caption = 'Closed';
    }
}
