pageextension 50041 "A01 Transfer Orders" extends "Transfer Orders"
{
    layout
    {
        addafter("Receipt Date")
        {
            field("A01 Approval Status"; Rec."A01 Approval Status")
            {
                ApplicationArea = all;
            }
        }
    }
    trigger OnOpenPage()
    var
    begin
        SetLocationFilters();
    end;

    local procedure SetLocationFilters()
    var
        SecMgt: codeunit "A01 Security Mgt";
        FiltreCG: Text[1024];
    begin
        FiltreCG := SecMgt.GetUserLocationFilter();
        if FiltreCG <> '' then begin
            Rec.FILTERGROUP(2);
            Rec.SETFILTER(Rec."Transfer-from Code", FiltreCG);
            Rec.FILTERGROUP(0);
        end;
    end;
}