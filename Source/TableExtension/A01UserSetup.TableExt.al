/// <summary>
/// TableExtension AFK01 User Setup (ID 50001) extends Record User Setup.
/// </summary>
tableextension 50001 "A01 User Setup" extends "User Setup"
{
    fields
    {
        field(50000; "A01 Can Cancel Sales Order"; Boolean)
        {
            Caption = 'Can Cancel Sales Order';
            DataClassification = CustomerContent;
        }
        field(50001; "A01 CanUpdateSalesOrderVal"; Boolean)
        {
            Caption = 'Can update Sales Order after validation';
            DataClassification = CustomerContent;
        }
        field(50003; "A01 Can Close Sales Order"; Boolean)
        {
            Caption = 'Can Close Sales Order';
            DataClassification = CustomerContent;
        }
        field(50004; "A01 Sales Resp. Filter 2"; Code[10])
        {
            Caption = 'Sales Resp. Ctr. Filter 2';
            TableRelation = "Responsibility Center".Code;
            DataClassification = CustomerContent;
        }
        field(50005; "A01 Sales Resp. Filter 3"; Code[10])
        {
            Caption = 'Sales Resp. Ctr. Filter 3';
            TableRelation = "Responsibility Center".Code;
            DataClassification = CustomerContent;
        }
        field(50006; "A01 Sales Resp. Filter 4"; Code[10])
        {
            Caption = 'Sales Resp. Ctr. Filter 4';
            TableRelation = "Responsibility Center".Code;
            DataClassification = CustomerContent;
        }
        field(50007; "A01 Sales Resp. Filter 5"; Code[10])
        {
            Caption = 'Sales Resp. Ctr. Filter 5';
            TableRelation = "Responsibility Center".Code;
            DataClassification = CustomerContent;
        }
        field(50008; "A01 Disable Resp Center Filter"; Boolean)
        {
            Caption = 'Disable Resp Center filter';
            DataClassification = CustomerContent;
        }
        field(50009; "A01 GL Period Group"; Code[20])
        {
            Caption = 'GL Period Group';
            TableRelation = "A01 GL Period User Group";
            DataClassification = CustomerContent;
        }
    }
}
