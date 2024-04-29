/// <summary>
/// Page A01 Posted Cust Settlement (ID 50063).
/// </summary>
page 50063 "A01 Posted Cust Settlement"
{
    ApplicationArea = All;
    Caption = 'Posted Cust Settlement';
    PageType = Card;
    SourceTable = "A01 Posted Payment Document";
    Editable = false;

    UsageCategory = Documents;

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
                field(Object; Rec.Object)
                {
                }
                field("Partner No."; Rec."Partner No.")
                {
                }
                field("Partner Name"; Rec."Partner Name")
                {
                }
                field("Posting Date"; Rec."Posting Date")
                {
                }
                field("Responsibility Center"; Rec."Responsibility Center")
                {
                }
                field(Amount; Rec.Amount)
                {
                }
                field("Validated Amount"; Rec."Validated Amount")
                {
                }
                field("Applies-to ID"; Rec."Applies-to ID")
                {
                }
                field(Status; Rec.Status)
                {
                }
                field("External Document No."; Rec."External Document No.")
                {
                }
                field("Modified By"; Rec."Modified By")
                {
                }

                field("Settlement Date"; Rec."Settlement Date")
                {
                }
                field("Settled By"; Rec."Settled By")
                {
                }

            }
            part(SalesLines; "A01 Post CustSettlementSubform")
            {
                ApplicationArea = Basic, Suite;
                // Editable = IsSalesLinesEditable;
                // Enabled = IsSalesLinesEditable;
                SubPageLink = "Document No." = field("No."), "Responsibility Center" = field("Responsibility Center");
                UpdatePropagation = Both;
            }
        }

    }
    actions
    {
        area(Processing)
        {
            action("&Navigate")
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Find entries...';
                Image = Navigate;
                ShortCutKey = 'Ctrl+Alt+Q';
                AboutTitle = 'Get detailed posting details';
                AboutText = 'Here, you can look up the ledger entries that were created when this invoice was posted, as well as any related documents.';
                ToolTip = 'Find entries and documents that exist for the document number and posting date on the selected document. (Formerly this action was named Navigate.)';
                //Visible = NOT IsOfficeAddin;

                trigger OnAction()
                begin
                    Rec.Navigate();
                end;
            }
            // action(Print)
            // {
            //     Image = PrintForm;
            //     ApplicationArea = Basic, Suite;
            //     Caption = '&Print';
            //     trigger OnAction()
            //     var
            //         CustomerSettlement: Record "A01 Posted Payment Document";

            //     begin
            //         CustomerSettlement.SetRange("No.", Rec."No.");
            //         Report.Run(50022, true, false, CustomerSettlement);
            //     end;

            // }
        }
        area(Reporting)
        {
            action("&Print")
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Print';
                Image = PrintForm;
                // ShortCutKey = 'Ctrl+Alt+Q';
                // AboutTitle = 'Get detailed posting details';
                // AboutText = 'Here, you can look up the ledger entries that were created when this invoice was posted, as well as any related documents.';
                // ToolTip = 'Find entries and documents that exist for the document number and posting date on the selected document. (Formerly this action was named Navigate.)';
                //Visible = NOT IsOfficeAddin;

                trigger OnAction()
                begin
                    Rec.PrintRecords(true);
                end;
            }
        }
    }
}
