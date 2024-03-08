/// <summary>
/// Page AFK01 Document Step Lines (ID 50000).
/// </summary>
page 50000 "A01 Document Step Lines"
{
    ApplicationArea = All;
    Caption = 'Document Step Lines';
    PageType = List;
    SourceTable = "A01 Document Step History";
    UsageCategory = Lists;
    Editable = false;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("Step ID"; Rec."Step ID")
                {
                }
                field("Action"; Rec."Action")
                {
                }
                field("New Status"; Rec."New Status")
                {
                }
                field("User ID"; Rec."User ID")
                {
                }
                field("Action Date"; Rec."Action Date")
                {
                }
                field("Created Document"; Rec."Created Document")
                {
                }
                field("Document Type"; Rec."Document Type")
                {
                }
                field("Document No."; Rec."Document No.")
                {
                }
                field("User Name"; Rec."User Name")
                {
                }
            }
        }
    }
}
