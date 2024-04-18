/// <summary>
/// Table A01 GL Period User Group (ID 50037).
/// </summary>
table 50037 "A01 GL Period User Group"
{
    Caption = 'GL Period User Group';
    DataClassification = CustomerContent;

    fields
    {
        field(1; "Code"; Code[20])
        {
            Caption = 'Code';
        }
        field(2; Name; Text[100])
        {
            Caption = 'Name';
        }
        field(3; "Allow Posting From"; Date)
        {
            Caption = 'Allow Posting From';

            trigger OnValidate()
            begin
                CheckAllowedPostingDates(0);
                //CheckPostingDateRange("Allow Posting From", FieldCaption("Allow Posting From"));
            end;
        }
        field(4; "Allow Posting To"; Date)
        {
            Caption = 'Allow Posting To';

            trigger OnValidate()
            begin
                CheckAllowedPostingDates(0);
            end;
        }
    }
    keys
    {
        key(PK; "Code")
        {
            Clustered = true;
        }
    }
    procedure CheckAllowedPostingDates(NotificationType: Option Error,Notification)
    var
        UserSetupManagement: codeunit "User Setup Management";
    begin
        UserSetupManagement.CheckAllowedPostingDatesRange(
          "Allow Posting From", "Allow Posting To", NotificationType, DATABASE::"A01 GL Period User Group");
    end;

    // local procedure CheckAllowedPostingDatesRange(AllowPostingFrom: Date; AllowPostingTo: Date)
    // var
    //     AllowedDateErr: Label 'Please enter a valid period!';
    // begin
    //     if AllowPostingFrom <= AllowPostingTo then
    //         exit;

    //     if (AllowPostingFrom = 0D) or (AllowPostingTo = 0D) then
    //         exit;

    //     Error(AllowedDateErr);

    // end;
}
