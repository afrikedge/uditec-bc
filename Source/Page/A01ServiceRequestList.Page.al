page 50114 "A01 Service Request List"
{
    ApplicationArea = All;
    Caption = 'Service Request List';
    PageType = List;
    SourceTable = "A01 Service Request";
    CardPageId = "A01 Service Request";
    UsageCategory = Lists;
    Editable = false;

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field("No."; Rec."No.")
                {
                }
                field("Warranty Status"; Rec."Warranty Status")
                {
                }
                field("Customer No."; Rec."Customer No.")
                {
                }
                field("Service Request Status"; Rec."Service Request Status")
                {
                }
                field("Item No."; Rec."Item No.")
                {
                }
                field(Reference; Rec.Reference)
                {
                }
                field("Contrat No."; Rec."Contrat No.")
                {
                }
                field("Created On"; Rec."Created On")
                {
                }
                field("Created By"; Rec."Created By")
                {
                }
                field("Closed On"; Rec."Closed On")
                {
                }
                field("Closed By"; Rec."Closed By")
                {
                }
                field("Warranty End Date"; Rec."Warranty End Date")
                {
                }
            }
        }
    }
}
