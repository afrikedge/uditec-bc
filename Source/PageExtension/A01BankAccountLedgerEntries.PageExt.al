pageextension 50048 "A01 Bank Account Ledger Entrie" extends "Bank Account Ledger Entries"
{
    //Credit Amount
    layout
    {
        addafter("Credit Amount")
        {
            field("A01 Payment Reference"; Rec."A01 Payment Reference")
            {
                ApplicationArea = Basic, Suite;
            }
        }
    }
}
