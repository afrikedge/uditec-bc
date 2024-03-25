/// <summary>
/// PageExtension A01 Payment Slip List Archive (ID 50014) extends Record Payment Slip List Archive.
/// </summary>
pageextension 50014 "A01 Payment Slip List Archive" extends "Payment Slip List Archive"
{
    trigger OnOpenPage()
    var
    begin
        //SetFiltreCentreGestion();
    end;

    // local procedure SetFiltreCentreGestion()
    // var
    //     //UserMgt: codeunit "User Setup Management";
    //     SecMgt: codeunit "A01 Security Mgt";
    //     FiltreCG: Text[1024];
    // begin

    //     //if UserMgt.GetSalesFilter() <> '' then begin

    //     FiltreCG := SecMgt.GetSalesRespCenterFilter();
    //     if FiltreCG <> '' then begin
    //         Rec.FILTERGROUP(2);
    //         Rec.SETFILTER("A01 Responsibility Center", FiltreCG);
    //         Rec.FILTERGROUP(0);
    //     end;
    //     //end;
    // end;
}
