page 50073 "A01 Purchase Vouchers"
{
    ApplicationArea = All;
    Caption = 'Purchase Vouchers';
    PageType = List;
    CardPageId = "A01 Voucher Card";
    SourceTable = "A01 Purchase Voucher";
    UsageCategory = Lists;
    Editable = false;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("No."; Rec."No.")
                {
                }
                field("Initial Amount"; Rec."Initial Amount")
                {
                }
                field("Emission Date"; Rec."Emission Date")
                {
                }
                field("Emission By"; Rec."Emission By")
                {
                }
                field(Balance; Rec.Balance)
                {
                }
                field("Validity Date"; Rec."Validity Date")
                {
                }
                field(Reference; Rec.Reference)
                {
                }
                field(Observation; Rec.Observation)
                {
                }
                field("Item Ledger Entry Id"; Rec."Item Ledger Entry Id")
                {
                }
            }
        }
    }
}
