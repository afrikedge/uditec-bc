/// <summary>
/// Enum A01 Warranty Plan (ID 50011).
/// </summary>
enum 50011 "A01 Warranty Plan Type"
{
    Extensible = true;

    value(0; Manufacturer)
    {
        Caption = 'Manufacturer';
    }
    value(1; "Internal")
    {
        Caption = 'Internal';
    }
    value(2; Extension)
    {
        Caption = 'Extension';
    }
}
