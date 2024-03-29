/// <summary>
/// Enum A01 Voucher Entry Type (ID 50041).
/// </summary>
enum 50041 "A01 Purch. Voucher Entry Type"
{
    Extensible = true;

    value(0; Emission)
    {
        Caption = 'Emission';
    }
    value(1; Consumption)
    {
        Caption = 'Consumption';
    }
}
