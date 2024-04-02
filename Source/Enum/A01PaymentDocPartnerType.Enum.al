/// <summary>
/// Enum A01 Payment Doc Partner Type (ID 50047).
/// </summary>
enum 50047 "A01 Payment Doc Partner Type"
{
    Extensible = true;

    value(0; Customer)
    {
        Caption = 'Customer';
    }
    value(1; Vendor)
    {
        Caption = 'Vendor';
    }
}
