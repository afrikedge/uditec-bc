pageextension 50044 "A01 Customer Ledger Entries" extends "Customer Ledger Entries"
{
    actions
    {
        addafter(Dimensions)
        {
            action("A01AGPDueLine")
            {
                ApplicationArea = All;
                Image = AllLines;
                Caption = 'Credit Amortisation Lines';
                RunObject = page "A01 Posted Credit Amort Lines";
                RunPageLink = "Document Type" = const("Posted Sales invoice"), "Document No." = field("Document No.");
            }
        }
    }
}
