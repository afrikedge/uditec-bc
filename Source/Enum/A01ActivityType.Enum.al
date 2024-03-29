/// <summary>
/// Enum A01 Activity Type (ID 50040).
/// </summary>
enum 50040 "A01 Activity Type"
{
    Extensible = true;

    value(0; "E-mail")
    {
        Caption = 'E-mail';
    }
    value(1; SMS)
    {
        Caption = 'SMS';
    }
    value(2; Call)
    {
        Caption = 'Call';
    }
    value(3; Chat)
    {
        Caption = 'Chat';
    }
    value(4; Appointment)
    {
        Caption = 'Appointment';
    }
    value(5; Letter)
    {
        Caption = 'Letter';
    }
    value(6; Task)
    {
        Caption = 'Task';
    }
}
