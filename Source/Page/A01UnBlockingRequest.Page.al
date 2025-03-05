page 50066 "A01 UnBlocking Request"
{
    ApplicationArea = All;
    Caption = 'UnBlocking Request';
    PageType = Card;
    SourceTable = "A01 Request On Document";
    SourceTableView = where("Request Type" = const(Unblocking));
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General';

                field("Request No."; Rec."Request No.")
                {
                }
                field(Object; Rec.Object)
                {
                }
                field("Customer No."; Rec."Customer No.")
                {
                }
                field(Status; Rec.Status)
                {
                }
                field("Credit Limit"; Rec."Credit Limit")
                {
                }
                field("Due Balance"; Rec."Due Balance")
                {
                }
                field(Exceeding; Rec.Exceeding)
                {
                }
                field("Gross exposure"; Rec."Gross exposure")
                {
                }
                field("In progress Balance"; Rec."In progress Balance")
                {
                }
                field("Risk level"; Rec."Risk level")
                {
                }
                field("Sales Person"; Rec."Sales Person")
                {
                }
                field("Created By"; Rec."Created By")
                {
                }
                field("Modified By"; Rec."Modified By")
                {
                }
                field("Worst Current Status"; Rec."Worst Current Status")
                {
                }
                field("Current Credit Limit"; Rec."Current Credit Limit")
                {
                }
                field("Current In progress Balance"; Rec."Current In progress Balance")
                {
                }
                field(CalcOverdueBalance; Rec.CalcOverdueBalance())
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Current Due Balance';
                    //CaptionClass = Format(StrSubstNo(Text000, Format(CurrentDate)));

                    trigger OnDrillDown()
                    var
                        DtldCustLedgEntry: Record "Detailed Cust. Ledg. Entry";
                        CustLedgEntry: Record "Cust. Ledger Entry";
                    begin
                        DtldCustLedgEntry.SetFilter("Customer No.", Rec."Customer No.");
                        // Rec.CopyFilter("Global Dimension 1 Filter", DtldCustLedgEntry."Initial Entry Global Dim. 1");
                        // Rec.CopyFilter("Global Dimension 2 Filter", DtldCustLedgEntry."Initial Entry Global Dim. 2");
                        // Rec.CopyFilter("Currency Filter", DtldCustLedgEntry."Currency Code");
                        CustLedgEntry.DrillDownOnOverdueEntries(DtldCustLedgEntry);
                    end;
                }
                field("Total Order Amount"; Rec."Total Order Amount")
                {
                }
            }
        }
    }
    actions
    {
        area(navigation)
        {
            action(Validate)
            {
                ApplicationArea = All;
                Image = Create;
                Caption = 'Validate';
                trigger OnAction()
                var
                    DocRequestMgt: Codeunit "A01 Document Request Mgt";
                    LabConfirmation: label 'Do you want to validate this request?';
                begin
                    if (not confirm(LabConfirmation)) then
                        exit;
                    DocRequestMgt.ModifyStatus(Rec, '', Rec.Status::Validated);
                    //Message('Modification terminée');
                end;
            }
        }
    }
}
