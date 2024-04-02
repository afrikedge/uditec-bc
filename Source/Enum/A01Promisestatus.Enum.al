/// <summary>
/// Enum A01 Promise status (ID 50038).
/// </summary>
enum 50038 "A01 Promise status"
{
    Extensible = true;

    value(0; Active)
    {
        Caption = 'Active';
    }
    value(1; Honored)
    {
        Caption = 'Honored';
    }
    value(2; "Partially honored")
    {
        Caption = 'Partially honored';
    }
    value(3; Canceled)
    {
        Caption = 'Canceled';
    }
}
