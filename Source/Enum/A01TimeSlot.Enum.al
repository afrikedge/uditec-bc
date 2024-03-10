/// <summary>
/// Enum A01 Time Slot (ID 50005).
/// </summary>
enum 50005 "A01 Time Slot"
{
    Extensible = true;

    value(0; "Before noon")
    {
        Caption = 'Before noon';
    }
    value(1; Afternoon)
    {
        Caption = 'Afternoon';
    }
    value(2; After5PM)
    {
        Caption = 'After 5 p.m.';
    }
}
