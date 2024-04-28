/// <summary>
/// Page A01 Item Promotion List (ID 50085).
/// </summary>
page 50085 "A01 Item Promotion List"
{
    ApplicationArea = All;
    Caption = 'Item Promotion List';
    PageType = List;
    SourceTable = "A01 Item Promotion";
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("Promoted Item No."; Rec."Promoted Item No.")
                {
                }
                field("Item Name"; Rec."Item Name")
                {
                }
                field("Starting Date"; Rec."Starting Date")
                {
                }
                field("Ending Date"; Rec."Ending Date")
                {
                }
                field("Deactivated"; Rec."Deactivated")
                {
                }
                field("Additional Items Nomber"; Rec."Additional Items Nomber")
                {
                }
                field("Responsilibity Center Filter"; Rec."Responsilibity Center Filter")
                {
                }
            }
        }
    }
    actions
    {
        area(Navigation)
        {
            // group(Process)
            // {
            action(A01AdditionalItems)
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Additional Items';
                Image = ViewDetails;
                RunObject = Page "A01 Promotion Add Items";
                RunPageLink = "Promoted Item No." = field("Promoted Item No.");
            }
            //}
        }
    }
}

