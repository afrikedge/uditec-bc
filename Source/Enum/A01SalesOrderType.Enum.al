/// <summary>
/// Enum A01 Sales Order Type (ID 50056).
/// </summary>
enum 50056 "A01 Sales Order Type"
{
    Extensible = true;

    value(0; Normal)
    {
        Caption = 'Normal';
    }
    value(1; Exempt)
    {
        Caption = 'Exempt';
    }
    value(2; Consignation)
    {
        Caption = 'Consignation';
    }
}
