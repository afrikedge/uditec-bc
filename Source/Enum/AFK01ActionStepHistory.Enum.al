/// <summary>
/// Enum AFK01 ActionStepHistory (ID 50002).
/// </summary>
enum 50002 "AFK01 ActionStepHistory"
{
    Extensible = true;
    
    value(0; Creation)
    {
        Caption = 'Creation';
    }
    value(1; "Change Status")
    {
        Caption = 'Change Status';
    }
    value(2; Ship)
    {
        Caption = 'Ship';
    }
    value(3; Invoice)
    {
        Caption = 'Invoice';
    }
    value(4; Deletion)
    {
        Caption = 'Deletion';
    }
}
