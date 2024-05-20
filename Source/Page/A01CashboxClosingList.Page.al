/// <summary>
/// Page A01 Cashbox Closing List (ID 50077).
/// </summary>
page 50077 "A01 Cashbox Closing List"
{
    ApplicationArea = All;
    Caption = 'Cashbox Closing List';
    PageType = List;
    SourceTable = "A01 Cashbox Closing";
    SourceTableView = where(Status = const(Open));
    CardPageId = "A01 Cashbox Closing";
    UsageCategory = Lists;
    Editable = false;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("Store Code"; Rec."Store Code")
                {
                }
                field("Closing Balance"; Rec."Closing Balance")
                {
                }
                field("Closing Date"; Rec."Closing Date")
                {
                }
                field(Status; Rec.Status)
                {
                }
            }
        }
    }
    trigger OnOpenPage()
    var
    begin
        SetFiltreCentreGestion();
    end;

    local procedure SetFiltreCentreGestion()
    var
        SecMgt: codeunit "A01 Security Mgt";
        FiltreCG: Text[1024];
    begin
        FiltreCG := SecMgt.GetSalesRespCenterFilter();
        if FiltreCG <> '' then begin
            Rec.FILTERGROUP(2);
            Rec.SETFILTER("Store Code", FiltreCG);
            Rec.FILTERGROUP(0);
        end;
    end;
}
