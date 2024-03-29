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
    }
}
