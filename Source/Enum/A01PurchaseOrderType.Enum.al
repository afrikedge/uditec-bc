/// <summary>
/// Enum A01 Purchase Order Type (ID 50033).
/// </summary>
enum 50033 "A01 Purchase Order Type"
{
    Extensible = true;

    value(0; Goods)
    {
        Caption = 'Goods';
    }
    value(1; Others)
    {
        Caption = 'Others';
    }
}
