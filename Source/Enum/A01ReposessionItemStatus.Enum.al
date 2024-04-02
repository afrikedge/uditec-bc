/// <summary>
/// Enum A01 Reposession Item Status (ID 50046).
/// </summary>
enum 50046 "A01 Reposession Item Status"
{
    Extensible = true;

    value(0; "To be received")
    {
        Caption = 'To be received';
    }
    value(1; Received)
    {
        Caption = 'Received';
    }
    value(2; "To be returned")
    {
        Caption = 'To be returned';
    }
    value(3; Returned)
    {
        Caption = 'Returned';
    }
}
