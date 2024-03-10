/// <summary>
/// Enum A01 Access Type (ID 50009).
/// </summary>
enum 50009 "A01 Access Type"
{
    Extensible = true;

    value(0; "Direct access")
    {
        Caption = 'Direct access';
    }
    value(1; Corridor)
    {
        Caption = 'Corridor';
    }
    value(2; "Narrow path")
    {
        Caption = 'Narrow path';
    }
    value(3; Stairs)
    {
        Caption = 'Stairs';
    }
}
