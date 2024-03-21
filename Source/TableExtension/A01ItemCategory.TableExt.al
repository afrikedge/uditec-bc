/// <summary>
/// TableExtension A01 Item Category (ID 50015) extends Record Item Category.
/// </summary>
tableextension 50015 "A01 Item Category" extends "Item Category"
{
    fields
    {
        field(50005; "A01 Maximum credit duration"; Integer)
        {
            Caption = 'Maximum credit duration (Months)';
            DataClassification = CustomerContent;
        }
        field(50006; "A01 MIR Max credit duration"; Integer)
        {
            Caption = 'Maximum credit duration (Mirindra)';
            DataClassification = CustomerContent;
        }
        field(50007; "A01 MIR Required Prepayment %"; Decimal)
        {
            Caption = 'Required Prepayment % (Mirindra)';
            DataClassification = CustomerContent;
        }
        field(50008; "A01 MIR Monthly interest %"; Decimal)
        {
            Caption = 'Monthly interest rate % (Mirindra)';
            DataClassification = CustomerContent;
        }
        field(50009; "A01 MIR Eligible Products"; Enum "A01 MIR Eligible Product Mode")
        {
            Caption = 'Eligible Products (Mirindra)';
            DataClassification = CustomerContent;
        }
    }
}
