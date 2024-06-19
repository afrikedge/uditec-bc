/// <summary>
/// TableExtension A01 Reminder Header (ID 50019) extends Record Reminder Header.
/// </summary>
tableextension 50019 "A01 Reminder Header" extends "Reminder Header"
{
    fields
    {
        field(50001; "A01 Activity Type"; Enum "A01 Activity Type")
        {
            Caption = 'Type';
            DataClassification = CustomerContent;
        }
        field(50002; "A01 Description"; Text[50])
        {
            Caption = 'Description';
            DataClassification = CustomerContent;
        }
        field(50003; "A01 Created By"; Code[50])
        {
            Caption = 'Created By';
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(50004; "A01 Expected Start Datetime"; DateTime)
        {
            Caption = 'Expected start date and time';
            DataClassification = CustomerContent;
        }
        field(50005; "A01 Expected End Datetime"; DateTime)
        {
            Caption = 'Expected end date and time';
            DataClassification = CustomerContent;
        }
        field(50006; "A01 Actual Start Datetime"; DateTime)
        {
            Caption = 'Actual start date and time';
            DataClassification = CustomerContent;
        }
        field(50007; "A01 Actual End Datetime"; DateTime)
        {
            Caption = 'Actual end date and time';
            DataClassification = CustomerContent;
        }
        field(50008; "A01 Reminder Datetime"; DateTime)
        {
            Caption = 'Reminder date and time';
            DataClassification = CustomerContent;
        }
        field(50009; "A01 Related activity"; Code[20])
        {
            Caption = 'Related activity';
            DataClassification = CustomerContent;
            TableRelation = "Reminder Header";
        }
        field(50010; "A01 Activity Status"; Enum "A01 Activity Status")
        {
            Caption = 'Status';
            DataClassification = CustomerContent;
        }
        field(50011; "A01 Observations"; Text[150])
        {
            Caption = 'Observations';
            DataClassification = CustomerContent;
        }
        field(50012; "A01 Web User Id"; Code[50])
        {
            Caption = 'Web User Id';
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(50013; "A01 Subject"; Text[50])
        {
            Caption = 'Subject';
            DataClassification = CustomerContent;
        }
        field(50014; "A01 Assignment No."; Code[20])
        {
            Caption = 'Assignment No.';
            DataClassification = CustomerContent;
            TableRelation = "A01 Deadline Assignment";
        }
        field(50015; "A01 Activity Feedback"; Code[20])
        {
            Caption = 'Activity Feedback';
            DataClassification = CustomerContent;
            TableRelation = "A01 Parameter Record".Code where(Type = const(ActivityFeedback));
        }

    }
}
