/// <summary>
/// PageExtension A01 Sales Quote Subform (ID 50016) extends Record Sales Quote Subform.
/// </summary>
pageextension 50016 "A01 Sales Quote Subform" extends "Sales Quote Subform"
{
    layout
    {
        addafter("Line Amount")
        {
            field("A01 Shipment Method Code"; Rec."A01 Shipment Method Code")
            {
                ApplicationArea = Basic, Suite;
            }
            field("A01 Markup"; Rec."A01 Markup")
            {
                ApplicationArea = all;
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
    }
}
