/// <summary>
/// PageExtension A01 Purchase Order (ID 50020) extends Record Purchase Order.
/// </summary>
pageextension 50020 "A01 Purchase Order" extends "Purchase Order"
{
    layout
    {
        addafter("Vendor Order No.")
        {
            field("A01 Purchase Order Type"; Rec."A01 Purchase Order Type")
            {
                ApplicationArea = All;
            }
        }
        addafter(PurchLines)
        {
            part(A01ImportSteps; "A01 Purchase Import Steps")
            {
                ApplicationArea = All;
                //Editable = IsPurchaseLinesEditable;
                //Enabled = IsPurchaseLinesEditable;
                SubPageLink = "Document Type" = const(Order), "Document No." = field("No.");
                UpdatePropagation = Both;
            }
        }
    }
}
