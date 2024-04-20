/// <summary>
/// Page A01 Reposession Request (ID 50053).
/// </summary>
page 50053 "A01 Reposession Request"
{
    ApplicationArea = All;
    Caption = 'Reposession Request';
    PageType = Card;
    SourceTable = "A01 Reposession Request";
    UsageCategory = Documents;
    //Editable = false;

    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General';

                field("No."; Rec."No.")
                {
                }
                field("Customer No."; Rec."Customer No.")
                {
                }
                field("Customer Name"; Rec."Customer Name")
                {
                }
                field(Object; Rec.Object)
                {
                }
                field("Document Type"; Rec."Document Type")
                {
                }
                field("Document No."; Rec."Document No.")
                {
                }
                field("Item No."; Rec."Item No.")
                {
                }
                field("Reposession Item Status"; Rec."Reposession Item Status")
                {
                }
                field("Reposession Type"; Rec."Reposession Type")
                {
                }
                field("Serial Number"; Rec."Serial Number")
                {
                }
                // field(Status; Rec.Status)
                // {
                // }
                field(Origin; Rec.Origin)
                {
                }
                field("Acceptance Status"; Rec."Acceptance Status")
                {
                }
                field(Reason; Rec.Reason)
                {
                }
                field("Modified By"; Rec."Modified By")
                {
                }
                field("Document Ref."; Rec."Document Ref.")
                {
                }
                field(Value; Rec.Value)
                {
                }
            }
        }
    }
    actions
    {
        area(Processing)
        {
            action(AcceptAction)
            {
                ApplicationArea = All;
                Image = Process;
                Caption = 'Accept';
                trigger OnAction()
                var
                begin
                    Rec.AcceptAction();
                end;
            }
            action(CancelAction)
            {
                ApplicationArea = All;
                Image = Process;
                Caption = 'Cancel';
                trigger OnAction()
                var
                begin
                    Rec.CancelAction();
                end;
            }
            action(ReceiveAction)
            {
                ApplicationArea = All;
                Image = Process;
                Caption = 'Receive';
                trigger OnAction()
                var
                begin
                    Rec.ReceiveAction();
                end;
            }
            action(ConfirmAction)
            {
                ApplicationArea = All;
                Image = Process;
                Caption = 'Confirm';
                trigger OnAction()
                var
                begin
                    Rec.ConfirmAction();
                end;
            }
            action(RejectAction)
            {
                ApplicationArea = All;
                Image = Process;
                Caption = 'Reject';
                trigger OnAction()
                var
                begin
                    Rec.RejectAction();
                end;
            }
            action(ReturnAction)
            {
                ApplicationArea = All;
                Image = Process;
                Caption = 'Return';
                trigger OnAction()
                var
                begin
                    Rec.ReturnAction();
                end;
            }
            action(CloseAction)
            {
                ApplicationArea = All;
                Image = Process;
                Caption = 'Close';
                trigger OnAction()
                var
                begin
                    Rec.CloseAction();
                end;
            }
        }
        area(Navigation)
        {
            action(ItemEntries)
            {
                ApplicationArea = All;
                Image = CostEntries;
                Caption = 'Item Entries';
                RunObject = page "Item Ledger Entries";
                RunPageLink = "Document No." = field("No.");
                // trigger OnAction()
                // var
                //     ItemLedgEntry: Record "Item Ledger Entry";
                //     ItemLedgEntries: page "Item Ledger Entries";
                // begin
                //     ItemLedgEntry.Reset();
                //     ItemLedgEntry.SetRange("Document No.", Rec."No.");
                //     ItemLedgEntries.SetRecord(ItemLedgEntry);
                //     ItemLedgEntries.Run();
                // end;
            }
        }
    }
    var

}
