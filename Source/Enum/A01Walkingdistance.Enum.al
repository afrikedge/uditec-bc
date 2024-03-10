/// <summary>
/// Enum A01 Walking distance (ID 50007).
/// </summary>
enum 50007 "A01 Walking distance"
{
    Extensible = true;

    value(0; Less100)
    {
        Caption = 'Less than 100 meters';
    }
    value(1; Less200)
    {
        Caption = 'Less than 200 meters';
    }
    value(2; More200)
    {
        Caption = 'More than 200 meters';
    }
    value(3; Other)
    {
        Caption = 'Other specify';
    }
}
