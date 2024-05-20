/// <summary>
/// PageExtension A01 Payment Slip List (ID 50013) extends Record Payment Slip List.
/// </summary>
pageextension 50013 "A01 Payment Slip List" extends "Payment Slip List"
{

    layout
    {
        addafter("Status Name")
        {
            field("A01 Origin Document No."; Rec."A01 Origin Document No.")
            {
                ApplicationArea = Basic, Suite;
            }
            field("A01 Customer No."; Rec."A01 Customer No.")
            {
                ApplicationArea = Basic, Suite;
            }
            field("A01Shortcut Dimension 1 Code"; Rec."Shortcut Dimension 1 Code")
            {
                ApplicationArea = Basic, Suite;
            }
            field("A01 Customer Name"; Rec."A01 Customer Name")
            {
                ApplicationArea = Basic, Suite;
            }
            field("A01 Description"; Rec."A01 Description")
            {
                ApplicationArea = Basic, Suite;
            }
            field(A01Amount; Rec.Amount)
            {
                ApplicationArea = Basic, Suite;
            }
            field("A01 Payment Method"; Rec."A01 Payment Method")
            {
                ApplicationArea = Basic, Suite;
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
            Rec.SETFILTER("A01 Responsibility Center", FiltreCG);
            Rec.FILTERGROUP(0);
        end;
    end;
}
