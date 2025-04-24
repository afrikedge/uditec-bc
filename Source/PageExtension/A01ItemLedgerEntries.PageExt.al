pageextension 50055 "A01 Item Ledger Entries" extends "Item Ledger Entries"
{
    layout
    {
        addafter("Source No.")
        {
            field(A01SystemCreatedBy; SecMgt.A01GetUserNameFromSecurityId(Rec.SystemCreatedBy))
            {
                Caption = 'User Name';
                ApplicationArea = All;
            }
        }
    }
    var
        SecMgt: Codeunit "A01 Security Mgt";
}
