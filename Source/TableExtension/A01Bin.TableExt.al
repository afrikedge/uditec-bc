tableextension 50028 "A01 Bin" extends Bin
{
    fields
    {
        field(50000; "A01 Unit of Measure Code"; Code[10])
        {
            Caption = 'Unit of Measure Code';
            TableRelation = "Unit of Measure";
            DataClassification = CustomerContent;
        }
        field(50001; "A01 Capacity"; Decimal)
        {
            Caption = 'Unit of Measure Code';
            DataClassification = CustomerContent;
        }
    }
}
