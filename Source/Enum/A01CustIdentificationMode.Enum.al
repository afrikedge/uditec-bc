/// <summary>
/// Enum A01 Cust Identification Mode (ID 50023).
/// </summary>
enum 50023 "A01 Cust Identification Mode"
{
    Extensible = true;

    value(0; " ")
    {
        Caption = 'Not applied';
    }
    value(1; NIC)
    {
        Caption = 'NIC';
    }
    value(2; Passport)
    {
        Caption = 'Passport';
    }
    value(3; "Residency card")
    {
        Caption = 'Residency card';
    }
}
