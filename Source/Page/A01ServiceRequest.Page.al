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
                field("Responsibility Center"; Rec."Responsibility Center")
                {
                }


                field("Ship-to Code"; Rec."Ship-to Code")
                {
                }

                field("Contact No."; Rec."Contact No.")
                {
                }
                field("Serial No."; Rec."Serial No.")
                {
                }
                field("IMEI No."; Rec."IMEI No.")
                {
                }
                field("Sales Doc. No."; Rec."Sales Doc. No.")
                {
                }
                field("Item Accessories"; Rec."Item Accessories")
                {
                }
                field(Observations; Rec.Observations)
                {
                }
                field("SR Type"; Rec."SR Type")
                {
                }
                field("SR Origin"; Rec."SR Origin")
                {
                }
                field("Diagnostic Report"; Rec."Diagnostic Report")
                {
                }
                field("Repair Report"; Rec."Repair Report")
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
