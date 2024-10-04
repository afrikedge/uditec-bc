/// <summary>
/// PageExtension A01 Payment Slip (ID 50009) extends Record Payment Slip.
/// </summary>
pageextension 50009 "A01 Payment Slip" extends "Payment Slip"
{
    layout
    {
        addafter("Partner Type")
        {
            field("A01 Description"; Rec."A01 Description")
            {
                ApplicationArea = Basic, Suite;
            }
            field("A01 Customer No."; Rec."A01 Customer No.")
            {
                ApplicationArea = Basic, Suite;
            }
            field("A01 Origin Document No."; Rec."A01 Origin Document No.")
            {
                ApplicationArea = Basic, Suite;
            }
            field("A01 Payment Method"; Rec."A01 Payment Method")
            {
                ApplicationArea = Basic, Suite;
            }

        }
        addafter("Shortcut Dimension 2 Code")
        {
            field(A01ShortcutDimCode3; ShortcutDimCode[3])
            {
                ApplicationArea = Dimensions;
                CaptionClass = '1,2,3';
                TableRelation = "Dimension Value".Code where("Global Dimension No." = const(3),
                                                                  "Dimension Value Type" = const(Standard),
                                                                  Blocked = const(false));
                Visible = DimVisible3;

                trigger OnValidate()
                begin
                    A01ValidateShortcutDimCode(3, ShortcutDimCode[3]);
                end;
            }
        }
    }
    actions
    {
        // addafter("P&osting")
        // {
        //     action("A01 Cash Receipt")
        //     {
        //         ApplicationArea = All;
        //         Image = PrintForm;
        //         Caption = 'Print Cash Receipt';
        //         trigger OnAction()
        //         var
        //             PaymentRec: Record "Payment Header";
        //         begin
        //             PaymentRec.SetRange("No.", Rec."No.");
        //             Report.Run(50004, true, false, PaymentRec);
        //         end;
        //     }
        // }

        modify(Print)
        {
            trigger OnBeforeAction()
            var
                PaymentRec: Record "Payment Header";
            begin
                PaymentRec.SetRange("No.", Rec."No.");
                Report.Run(50004, true, false, PaymentRec);
            end;
        }
    }
    trigger OnAfterGetRecord()
    var
    begin
        ShowShortcutDimCode(ShortcutDimCode);
    end;

    trigger OnNewRecord(BelowxRec: Boolean)
    var
    begin
        Clear(ShortcutDimCode);
    end;

    trigger OnOpenPage()
    var
    begin
        SetDimensionsVisibility();
    end;

    var
        DimMgt: Codeunit DimensionManagement;
        ShortcutDimCode: array[8] of Code[20];
        DimVisible1: Boolean;
        DimVisible2: Boolean;
        DimVisible3: Boolean;
        DimVisible4: Boolean;
        DimVisible5: Boolean;
        DimVisible6: Boolean;
        DimVisible7: Boolean;
        DimVisible8: Boolean;

    procedure A01ValidateShortcutDimCode(FieldNumber: Integer; var ShortcutDimCode: Code[20])
    begin
        DimMgt.ValidateShortcutDimValues(FieldNumber, ShortcutDimCode, Rec."Dimension Set ID");
    end;

    // procedure ItemNoOnAfterValidate();
    // begin
    //     ShowShortcutDimCode(ShortcutDimCode);
    // end;

    local procedure SetDimensionsVisibility()
    var
    //DimMgt: Codeunit DimensionManagement;
    begin
        DimVisible1 := false;
        DimVisible2 := false;
        DimVisible3 := false;
        DimVisible4 := false;
        DimVisible5 := false;
        DimVisible6 := false;
        DimVisible7 := false;
        DimVisible8 := false;

        DimMgt.UseShortcutDims(
          DimVisible1, DimVisible2, DimVisible3, DimVisible4, DimVisible5, DimVisible6, DimVisible7, DimVisible8);

        Clear(DimMgt);
    end;

    procedure ShowShortcutDimCode(var ShortcutDimCode: array[8] of Code[20])
    begin
        DimMgt.GetShortcutDimensions(Rec."Dimension Set ID", ShortcutDimCode);
    end;
}
