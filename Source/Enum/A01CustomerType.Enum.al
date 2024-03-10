/// <summary>
/// Enum A01 Customer Type (ID 50014).
/// </summary>
enum 50014 "A01 Customer Type"
{
    Extensible = true;

    value(0; Organization)
    {
        Caption = 'Organization';
    }
    value(1; Person)
    {
        Caption = 'Person';
    }
    value(2; Miscellaneous)
    {
        Caption = 'Miscellaneous';
    }
}
