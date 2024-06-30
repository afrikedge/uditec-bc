page 50113 "A01 Service Request"
{
    ApplicationArea = All;
    Caption = 'Service Request';
    PageType = Document;
    SourceTable = "A01 Service Request";

    layout
    {
        area(Content)
        {
            group(General)
            {
                Caption = 'General';

                field("No."; Rec."No.")
                {
                }
                field("Service Request Status"; Rec."Service Request Status")
                {
                }
                field("Customer No."; Rec."Customer No.")
                {
                }
                field("Warranty Status"; Rec."Warranty Status")
                {
                }
                field("Item No."; Rec."Item No.")
                {
                }
                field("Contrat No."; Rec."Contrat No.")
                {
                }
                field(Reference; Rec.Reference)
                {
                }
                field("Warranty End Date"; Rec."Warranty End Date")
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
            }
            part(Mouvement; "A01 SR Item Mouvement Subform")
            {
                Caption = 'Item Mouvements';
                ApplicationArea = Basic, Suite;
                SubPageLink = "Service Request No." = field("No.");
                UpdatePropagation = Both;
            }
            part(SparePart; "A01 SR SparePart Subform")
            {
                Caption = 'Spare Part';
                ApplicationArea = Basic, Suite;
                SubPageLink = "Service Request No." = field("No.");
                UpdatePropagation = Both;
            }
            part(SRDefectivePart; "A01 SR Defective Part Subform")
            {
                Caption = 'Defective Part';
                ApplicationArea = Basic, Suite;
                SubPageLink = "Service Request No." = field("No.");
                UpdatePropagation = Both;
            }
            part(SRSalesDocument; "A01 SR Sales Document Subform")
            {
                Caption = 'Valorisation';
                ApplicationArea = Basic, Suite;
                SubPageLink = "Service Request No." = field("No.");
                UpdatePropagation = Both;
            }
            part(SRAssignmentFlow; "A01 SR Assignment Flow Subform")
            {
                Caption = 'Affectation';
                ApplicationArea = Basic, Suite;
                SubPageLink = "Service Request No." = field("No.");
                UpdatePropagation = Both;
            }
        }
    }
}
