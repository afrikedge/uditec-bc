/// <summary>
/// Enum A01 Warranty Plan Status (ID 50012).
/// </summary>
enum 50012 "A01 Warranty Plan Status"
{
    Extensible = true;

    value(0; Active)
    {
        Caption = 'Actif';
    }
    value(1; Inactive)
    {
        Caption = 'Inactif';
    }
}
