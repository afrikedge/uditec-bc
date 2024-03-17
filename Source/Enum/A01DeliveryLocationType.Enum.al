/// <summary>
/// Enum A01 Delivery Location Type (ID 50008).
/// </summary>
enum 50008 "A01 Delivery Location Type"
{
    Extensible = true;

    value(0; "Ground floor")
    {
        Caption = 'Ground floor';
    }
    value(1; "1st floor")
    {
        Caption = '1st floor';
    }
    value(2; "2nd Floor")
    {
        Caption = '2nd Floor';
    }
    value(3; "3rd floor")
    {
        Caption = '3rd floor';
    }
    value(4; Others)
    {
        Caption = 'Others';
    }
}
