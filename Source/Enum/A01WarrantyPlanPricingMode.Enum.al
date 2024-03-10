/// <summary>
/// Enum A01 Warranty Plan Pricing Mode (ID 50013).
/// </summary>
enum 50013 "A01 Warranty Plan Pricing Mode"
{
    Extensible = true;

    value(0; "Depending on price list")
    {
        Caption = 'Depending on price list';
    }
    value(1; "Percentage of sale price")
    {
        Caption = 'Percentage of sale price';
    }
    value(2; "Fixed price")
    {
        Caption = 'Fixed price';
    }
}
