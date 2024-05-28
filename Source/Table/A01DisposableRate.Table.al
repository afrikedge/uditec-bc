table 50048 "A01 Disposable Rate"
{
    Caption = 'Disposable Rate';
    DataClassification = CustomerContent;

    fields
    {
        field(1; "Max Score"; Integer)
        {
            Caption = 'Max Score (Before)';
        }
        field(2; "Approved (%)"; Decimal)
        {
            Caption = 'Approved Max (%)';
        }
        field(3; "Referred (%)"; Decimal)
        {
            Caption = 'Referred Max (%)';
        }
    }
    keys
    {
        key(PK; "Max Score")
        {
            Clustered = true;
        }
    }
}
