/// <summary>
/// PageExtension A01 Item Category Card (ID 50018) extends Record Item Category Card.
/// </summary>
pageextension 50018 "A01 Item Category Card" extends "Item Category Card"
{
    layout
    {
        addafter("Parent Category")
        {
            field("A01 MIR Max credit duration"; Rec."A01 MIR Max credit duration")
            {
                ApplicationArea = Basic, Suite;
            }

            field("A01 MIR Monthly interest %"; Rec."A01 MIR Monthly interest %")
            {
                ApplicationArea = Basic, Suite;
            }
            field("A01 MIR Required Prepayment %"; Rec."A01 MIR Required Prepayment %")
            {
                ApplicationArea = Basic, Suite;
            }
            field("A01 Non Eligible credit sales"; Rec."A01 Non Eligible credit sales")
            {
                ApplicationArea = Basic, Suite;
            }
            field("A01 Point"; Rec."A01 Point")
            {
                ApplicationArea = Basic, Suite;
            }
        }
    }
}
