/// <summary>
/// PageExtension A01 General Journal (ID 50029) extends Record General Journal.
/// </summary>
pageextension 50029 "A01 General Journal" extends "General Journal"
{
    actions
    {
        addafter("Renumber Document Numbers")
        {
            action(A01GenerateInterestLines)
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Generate interest lines';
                Image = GeneralLedger;
                trigger OnAction()
                var
                    ReportProcess: report "A01 Generate Interest Entries";
                begin
                    ReportProcess.SetJournal(Rec."Journal Template Name", Rec."Journal Batch Name");
                    ReportProcess.RunModal();
                end;
            }
        }
    }
}
