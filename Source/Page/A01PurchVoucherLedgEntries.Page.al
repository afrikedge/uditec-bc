page 50075 "A01 Purch Voucher Ledg Entries"
{
    ApplicationArea = All;
    Caption = 'Purch Voucher Ledg Entries';
    PageType = List;
    SourceTable = "A01 Purchase Voucher Entry";
    Editable = false;
    UsageCategory = Lists;


    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("Entry No."; Rec."Entry No.")
                {
                }
                field("Voucher No."; Rec."Voucher No.")
                {
                }
                field("Posting Date"; Rec."Posting Date")
                {
                }
                field("Entry Type"; Rec."Entry Type")
                {
                }
                field("Document Type"; Rec."Document Type")
                {
                }
                field("Document No."; Rec."Document No.")
                {
                }
                field(Amount; Rec.Amount)
                {
                }
                field("External User"; Rec."External User")
                {
                }
                field("Item Ledger Entry No."; Rec."Item Ledger Entry No.")
                {
                }
            }
        }
    }
}
