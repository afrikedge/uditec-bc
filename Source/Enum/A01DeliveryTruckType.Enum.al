/// <summary>
/// Enum A01 Delivery Truck Type (ID 50010).
/// </summary>
enum 50010 "A01 Delivery Truck Type"
{
    Extensible = true;

    value(0; Large)
    {
        Caption = 'Large truck';
    }
    value(1; Small)
    {
        Caption = 'Small truck';
    }
    value(2; "Access less than 3.5T")
    {
        Caption = 'Access less than 3.5T';
    }
}
