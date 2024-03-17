/// <summary>
/// PageExtension A01 Payment Class List (ID 50010) extends Record Payment Class List.
/// </summary>
pageextension 50010 "A01 Payment Class List" extends "Payment Class List"
{
    // layout
    // {
    //     addafter(Name)
    //     {
    //         field("A01 Responsibility Center"; Rec."A01 Responsibility Center")
    //         {
    //             ApplicationArea = Basic, Suite;
    //         }
    //     }
    // }
    trigger OnOpenPage()
    var
    begin
        SetFiltreCentreGestion();
    end;

    local procedure SetFiltreCentreGestion()
    var
        //UserMgt: codeunit "User Setup Management";
        SecMgt: codeunit "A01 Security Mgt";
        FiltreCG: Text[1024];
    begin

        //if UserMgt.GetSalesFilter() <> '' then begin

        FiltreCG := SecMgt.GetSalesRespCenterFilter();
        if FiltreCG <> '' then begin
            Rec.FILTERGROUP(2);
            Rec.SETFILTER("A01 Responsibility Center", FiltreCG);
            Rec.FILTERGROUP(0);
        end;
        //end;
    end;
}
