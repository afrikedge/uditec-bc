page 50096 "A01 Disposable Rate List"
{
    ApplicationArea = All;
    Caption = 'Disposable Rate List';
    PageType = List;
    SourceTable = "A01 Disposable Rate";
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("Max Score"; Rec."Max Score")
                {
                    NotBlank = true;
                }
                field("Approved (%)"; Rec."Approved (%)")
                {
                }
                field("Referred (%)"; Rec."Referred (%)")
                {
                }
            }
        }
    }
}
