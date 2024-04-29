/// <summary>
/// Page A01 AGP Contracts (ID 50058).
/// </summary>
page 50060 "A01 AGP Contracts"
{
    ApplicationArea = All;
    Caption = 'AGP Contracts';
    PageType = List;
    SourceTable = "A01 AGP Contrat";
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("No."; Rec."No.")
                {
                }
                field("Account Type"; Rec."Account Type")
                {
                }
                field("Customer No."; Rec."Customer No.")
                {
                }
                field("Commitment Type"; Rec."Commitment Type")
                {
                }
                field("Duration (Month)"; Rec."Duration (Month)")
                {
                }
                field("Approval Status"; Rec."Approval Status")
                {
                }
                field("First Terms Date"; Rec."First Terms Date")
                {
                }
                field("OP Duration (Month)"; Rec."OP Duration (Month)")
                {
                }
                field("OP Ending Date"; Rec."OP Ending Date")
                {
                }
                field("OP Starting Date"; Rec."OP Starting Date")
                {
                }
                field("Payment Method Code"; Rec."Payment Method Code")
                {
                }
                field("Payment Terms Code"; Rec."Payment Terms Code")
                {
                }

                field("Transferable part %"; Rec."Transferable part %")
                {
                }
                field("Credit Limit Mode"; Rec."Credit Limit Mode")
                {
                }
                field("Standard Credit Limit"; Rec."Standard Credit Limit")
                {
                }
                field("Application fees %"; Rec."Application fees %")
                {
                }

                field("Created By"; Rec."Created By")
                {
                }
                field("Modified By"; Rec."Modified By")
                {
                }
            }
        }
    }
}
