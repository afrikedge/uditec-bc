/// <summary>
/// Table Web Link Document (ID 50043).
/// </summary>
table 50043 "A01 Web Link Document"
{
    Caption = 'Web Link Document';
    DataClassification = CustomerContent;

    fields
    {
        field(1; "Record Id"; Guid)
        {
            Caption = 'Record Id';
        }
        field(2; "Document Name"; Text[50])
        {
            Caption = 'Document Name';
        }
        field(3; Link; Text[200])
        {
            Caption = 'Link';
        }
    }
    keys
    {
        key(PK; "Record Id", "Document Name")
        {
            Clustered = true;
        }
    }
}
