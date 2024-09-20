/// <summary>
/// PageExtension A01 Sales Order Subform (ID 50015) extends Record Sales Order Subform.
/// </summary>
pageextension 50015 "A01 Sales Order Subform" extends "Sales Order Subform"
{
    layout
    {
        addafter("Line Amount")
        {
            field("A01 Shipment Method Code"; Rec."A01 Shipment Method Code")
            {
                ApplicationArea = Basic, Suite;
            }
        }
        modify("Unit Price")
        {
            trigger OnAfterValidate()
            var
                SecMgt: Codeunit "A01 Security Mgt";
            begin
                SecMgt.CheckIfUserCanSetSalesPrice();
            end;
        }
        modify("Line Amount")
        {
            trigger OnAfterValidate()
            var
                SecMgt: Codeunit "A01 Security Mgt";
            begin
                SecMgt.CheckIfUserCanSetSalesPrice();
            end;
        }
        modify("Line Discount %")
        {
            trigger OnAfterValidate()
            var
                SecMgt: Codeunit "A01 Security Mgt";
            begin
                SecMgt.CheckIfUserCanSetSalesDiscounts();
            end;
        }
        modify("Line Discount Amount")
        {
            trigger OnAfterValidate()
            var
                SecMgt: Codeunit "A01 Security Mgt";
            begin
                SecMgt.CheckIfUserCanSetSalesDiscounts();
            end;
        }
        addafter("Promised Delivery Date")
        {
            field("A01 Promotion Line No."; Rec."A01 Promotion Line No.")
            {
                ApplicationArea = Basic, Suite;
            }
            field("A01Quantity (Base)"; Rec."Quantity (Base)")
            {
                ApplicationArea = all;
            }
            field("A01 Markup"; Rec."A01 Markup")
            {
                ApplicationArea = all;
            }
        }
    }
}
