/// <summary>
/// Enum A01 Item Status (ID 50004).
/// </summary>
enum 50004 "A01 Item Status"
{
    Extensible = true;

    value(0; "Non applied")
    {
        Caption = 'Non applied';
    }
    value(1; New)
    {
        Caption = 'New';
    }
    value(2; Current)
    {
        Caption = 'Current';
    }
    value(3; Discontinuous)
    {
        Caption = 'Discontinuous';
    }
    value(4; "Slow Moving")
    {
        Caption = 'Slow Moving';
    }
    value(5; "Phase-out")
    {
        Caption = 'Phase-out';
    }
}
