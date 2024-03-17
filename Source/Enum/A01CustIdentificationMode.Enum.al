/// <summary>
/// Enum A01 Cust Identification Mode (ID 50023).
/// </summary>
enum 50023 "A01 Cust Identification Mode"
{
    Extensible = true;

    value(0; NIC)
    {
        Caption = 'NIC';
    }
    value(1; Passport)
    {
        Caption = 'Passport';
    }
    value(2; "Residency card")
    {
        Caption = 'Residency card';
    }
}
