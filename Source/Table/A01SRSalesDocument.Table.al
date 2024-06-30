table 50060 "A01 SR Sales Document"
{
    Caption = 'SR Sales Document';
    DataClassification = CustomerContent;

    fields
    {
        field(1; "Service Request No."; Code[20])
        {
            Caption = 'Service Request No.';
        }
        field(2; "Line No."; Integer)
        {
            Caption = 'Line No.';
        }
        field(3; "Document Type"; enum "Sales Document Type")
        {
            Caption = 'Document Type';
        }
        field(4; "Document Date"; Date)
        {
            Caption = 'Document Date';
        }
        field(5; "Document Amount"; Decimal)
        {
            Caption = 'Document Amount';
        }
        field(6; "Processing Status"; Enum "A01 Approval Status")
        {
            Caption = 'Processing Status';
        }
    }
    keys
    {
        key(PK; "Service Request No.")
        {
            Clustered = true;
        }
    }
}
