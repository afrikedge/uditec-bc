/// <summary>
/// Table A01 Request On Sales Document (ID 50031).
/// </summary>
table 50031 "A01 Request On Sales Document"
{
    Caption = 'Request On Sales Document';
    DataClassification = CustomerContent;

    fields
    {
        field(1; "Request Type"; Enum "A01 Request Sales Doc Type")
        {
            Caption = 'Request Type';
        }
        field(2; "Request No."; Code[20])
        {
            Caption = 'Request No.';
        }
        field(3; Object; Text[100])
        {
            Caption = 'Object';
        }
        field(4; Status; Enum "A01 Approval Status")
        {
            Caption = 'Status';
        }
        field(5; "Document Type"; Enum "Sales Document Type")
        {
            Caption = 'Document Type';
        }
        field(6; "Document No."; Code[20])
        {
            Caption = 'Document No.';
        }
        field(7; Creator; Code[50])
        {
            Caption = 'Creator';
            Editable = false;
        }
        field(8; "Requested Discount (%)"; Decimal)
        {
            Caption = 'Requested Discount (%)';
        }
        field(9; "Validated Discount (%)"; Decimal)
        {
            Caption = 'Validated Discount (%)';
        }
        field(10; "Customer No."; Code[20])
        {
            Caption = 'Customer No.';
            TableRelation = Customer;
        }
        field(11; "Sales Person"; Code[20])
        {
            Caption = 'Sales Person';
            TableRelation = "Salesperson/Purchaser";
        }
        field(12; "Credit Limit"; Decimal)
        {
            Caption = 'Credit Limit';
        }
        field(13; "In progress Balance"; Decimal)
        {
            Caption = 'In progress Balance';
        }
        field(14; "Due Balance"; Decimal)
        {
            Caption = 'Due Balance';
        }
        field(15; "Worst Current Status"; Code[10])
        {
            Caption = 'Worst Current Status';
            TableRelation = "A01 Customer Debt Status";
        }
        field(16; "Gross exposure"; Decimal)
        {
            Caption = 'Gross exposure';
        }
        field(17; "Risk level"; Code[20])
        {
            Caption = 'Risk level';
            TableRelation = "A01 Parameter Record".Code where(Type = const(RiskLevel));
        }
        field(18; Exceeding; Decimal)
        {
            Caption = 'Exceeding';
        }
        field(19; "Item No."; Code[20])
        {
            Caption = 'Item No.';
            TableRelation = Item;
        }
        field(20; "Serial Number"; Text[30])
        {
            Caption = 'Serial Number';
        }
        field(21; Origin; Enum "A01 Repossession Origin")
        {
            Caption = 'Origin';
        }
        field(22; "Acceptance Status"; Enum "A01 Reposession Accept Status")
        {
            Caption = 'Acceptance Status';
        }
        field(23; Reason; Text[100])
        {
            Caption = 'Reason';
        }
        field(24; "Reposession Type"; Enum "A01 Reposession Type")
        {
            Caption = 'Reposession Type';
        }
        field(25; "Reposession Item Status"; Enum "A01 Reposession Item Status")
        {
            Caption = 'Reposession Item Status';
        }
    }
    keys
    {
        key(PK; "Request Type", "Request No.")
        {
            Clustered = true;
        }
    }
}
