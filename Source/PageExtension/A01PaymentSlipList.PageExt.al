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
            field("A01 Due Date"; Rec."A01 Due Date")
            {
                ApplicationArea = Basic, Suite;
            }
            field("A01 Drawee Reference"; Rec."A01 Drawee Reference")
            {
                ApplicationArea = Basic, Suite;
            }
            field(A01SystemCreatedBy; SecMgt.A01GetUserNameFromSecurityId(Rec.SystemCreatedBy))
            {
                ApplicationArea = Basic, Suite;
                Caption = 'User Name';
            }
            field(A01ShortcutDimCode3; ShortcutDimCode[3])
            {
                ApplicationArea = Dimensions;
                CaptionClass = '1,2,3';
                //Visible = DimVisible3;

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
        FiltreCG: Text[1024];
    begin
        FiltreCG := SecMgt.GetSalesRespCenterFilter();
        if FiltreCG <> '' then begin
            Rec.FILTERGROUP(2);
            Rec.SETFILTER("A01 Responsibility Center", FiltreCG);
            Rec.FILTERGROUP(0);
        end;
    end;

    trigger OnAfterGetRecord()
    var
    begin
        ShowShortcutDimCode(ShortcutDimCode);
    end;

    procedure ShowShortcutDimCode(var ShortcutDimCode: array[8] of Code[20])
    begin
        DimMgt.GetShortcutDimensions(Rec."Dimension Set ID", ShortcutDimCode);
    end;

    var
        DimMgt: Codeunit DimensionManagement;
        SecMgt: Codeunit "A01 Security Mgt";
        ShortcutDimCode: array[8] of Code[20];
}
