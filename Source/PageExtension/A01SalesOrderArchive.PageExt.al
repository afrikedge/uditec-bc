/// <summary>
/// PageExtension A01 Sales Order Archive (ID 50022) extends Record Sales Order Archive.
/// </summary>

pageextension 50022 "A01 Sales Order Archive" extends "Sales Order Archive"
{
    layout
    {
        addafter(SalesLinesArchive)
        {
            part(A01PaymentMethods; "A01 Sales Payment Methods")
            {
                ApplicationArea = All;
                // Editable = IsSalesLinesEditable;
                // Enabled = IsSalesLinesEditable;
                SubPageLink = "Document Type" = const(Order), "Document No." = field("No.");
                UpdatePropagation = Both;
            }
        }
    }
}
