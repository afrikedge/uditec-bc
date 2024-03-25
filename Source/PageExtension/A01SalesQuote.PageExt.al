pageextension 50017 "A01 Sales Quote" extends "Sales Quote"
{
    layout
    {
        addafter("Foreign Trade")
        {
            group(A01Credit)
            {
                Caption = 'Credit';
                field("A01 Credit Validation Status"; Rec."A01 Credit Validation Status")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("A01 Credit Duration (Month)"; Rec."A01 Credit Duration (Month)")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("A01 Interest rate"; Rec."A01 Interest rate")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("A01 Sales Mode"; Rec."A01 Sales Mode")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("A01 Analyst comments"; Rec."A01 Analyst comments")
                {
                    ApplicationArea = Basic, Suite;
                    MultiLine = true;
                }
                field("A01 System Decision"; Rec."A01 System Decision")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("A01 Analyst Opinion"; Rec."A01 Analyst Opinion")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("A01 Investigator Opinion"; Rec."A01 Investigator Opinion")
                {
                    ApplicationArea = Basic, Suite;
                }
            }
        }
    }
    actions
    {
        modify(Print)
        {
            trigger OnBeforeAction()
            var
            // ApprovalsMgmt: Codeunit "Approvals Mgmt.";
            // Msg: Label 'Le document est au statut ouvert';
            begin
                // if Rec.Status = Rec.Status::Open then begin
                //     if not ApprovalsMgmt.PrePostApprovalCheckSales(Rec) then begin
                //         Codeunit.Run(Codeunit::"Sales-Quote to Order (Yes/No)", Rec);
                //         Error(Msg);
                //     end;
                // end;
            end;

        }
    }
}
