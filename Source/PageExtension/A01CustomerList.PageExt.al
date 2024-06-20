pageextension 50042 "A01 Customer List" extends "Customer List"
{
    layout
    {
        addafter("Responsibility Center")
        {
            field("A01 Calc Risk Level"; Rec."A01 Calc Risk Level")
            {
                ApplicationArea = Basic, Suite;
            }
        }
    }
    actions
    {
        addafter("Cash Receipt Journal")
        {
            action(A01ImportAGPCustomers)
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Import AGP Customers';
                Image = ImportCodes;
                RunObject = xmlport "A01 Import AGP Customers";
                // trigger OnAction()
                // var
                //     ReportProcess: report "A01 Generate Interest Entries";
                // begin
                //     ReportProcess.SetJournal(Rec."Journal Template Name", Rec."Journal Batch Name");
                //     ReportProcess.RunModal();
                // end;
            }
        }
    }
}
