/// <summary>
/// TableExtension A01 Responsibility Center (ID 50003) extends Record Responsibility Center.
/// </summary>
tableextension 50003 "A01 Responsibility Center" extends "Responsibility Center"
{
    fields
    {
        field(50000; "A01 Default Customer"; Code[20])
        {
            Caption = 'Default Customer';
            DataClassification = CustomerContent;
            TableRelation = Customer;
        }
        field(50001; "A01 Theme Color 1"; Text[30])
        {
            Caption = 'Theme Color 1';
            DataClassification = CustomerContent;
        }
        field(50002; "A01 Theme Color 2"; Text[30])
        {
            Caption = 'Theme Color 2';
            DataClassification = CustomerContent;
        }
        field(50003; "A01 Theme Color 3"; Text[30])
        {
            Caption = 'Theme Color 3';
            DataClassification = CustomerContent;
        }
        field(50004; "A01 Logo"; Media)
        {
            Caption = 'Picture';
            //SubType = Bitmap;
            DataClassification = CustomerContent;
        }
        field(50005; "A01 Nos of categories"; Integer)
        {
            Caption = 'Item Categories';
            FieldClass = FlowField;
            CalcFormula = count("A01 Resp Center Item Category" where("Responsability Center Code" = field(Code)));
        }
        field(50006; "A01 Customer Price Group"; Code[10])
        {
            Caption = 'Customer Price Group';
            TableRelation = "Customer Price Group";
            DataClassification = CustomerContent;
        }
        field(50007; "A01 Current Promotion"; Code[10])
        {
            Caption = 'Current Promotion';
            TableRelation = Campaign;
            DataClassification = CustomerContent;
        }
        field(50008; "A01 Control Payment on Invoice"; Boolean)
        {
            Caption = 'Control Payment on Invoices';
            DataClassification = CustomerContent;
        }
        field(50009; "A01 Price list change"; Boolean)
        {
            Caption = 'Price list change';
            DataClassification = CustomerContent;
        }

    }
}
