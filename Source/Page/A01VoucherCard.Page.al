page 50074 "A01 Voucher Card"
{
    ApplicationArea = All;
    Caption = 'Voucher Card';
    PageType = Card;
    DeleteAllowed = false;
    InsertAllowed = false;
    SourceTable = "A01 Purchase Voucher";
    UsageCategory = Administration;

    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General';

                field("No."; Rec."No.")
                {
                }
                field("Initial Amount"; Rec."Initial Amount")
                {
                }
                field("Emission By"; Rec."Emission By")
                {
                }
                field("Emission Date"; Rec."Emission Date")
                {
                }
                field(Balance; Rec.Balance)
                {
                }
                field(Observation; Rec.Observation)
                {
                }
                field(Reference; Rec.Reference)
                {
                }
                field("Validity Date"; Rec."Validity Date")
                {
                }
            }
        }
    }
}
