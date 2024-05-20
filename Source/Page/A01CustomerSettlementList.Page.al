
/// <summary>
/// Page A01 Customer Settlements (ID 50056).
/// </summary>
page 50059 "A01 Customer Settlement List"
{
    ApplicationArea = All;
    Caption = 'Customer Settlement List';
    PageType = List;
    SourceTable = "A01 Payment Document";
    UsageCategory = Lists;
    Editable = false;
    CardPageId = "A01 Customer Settlement";

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
                field(Status; Rec."Approval Status")
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
