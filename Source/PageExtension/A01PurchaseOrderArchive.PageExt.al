/// <summary>
/// PageExtension A01 Purchase Order Archive (ID 50021) extends Record Purchase Order Archive.
/// </summary>
pageextension 50021 "A01 Purchase Order Archive" extends "Purchase Order Archive"
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
        addafter(PurchLinesArchive)
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
