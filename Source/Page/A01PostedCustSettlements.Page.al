/// <summary>
/// Page A01 Posted Cust Settlements (ID 50058).
/// </summary>
page 50062 "A01 Posted Cust Settlements"
{
    ApplicationArea = All;
    Caption = 'Posted Cust Settlements';
    PageType = List;
    SourceTable = "A01 Posted Payment Document";
    CardPageId = "A01 Posted Cust Settlement";
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
                field("Partner No."; Rec."Partner No.")
                {
                }
                field(Object; Rec.Object)
                {
                }
                field("Posting Date"; Rec."Posting Date")
                {
                }
                field("Responsibility Center"; Rec."Responsibility Center")
                {
                }
                field(Status; Rec.Status)
                {
                }
                field("Modified By"; Rec."Modified By")
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
            Rec.SETFILTER("Responsibility Center", FiltreCG);
            Rec.FILTERGROUP(0);
        end;
    end;
}
