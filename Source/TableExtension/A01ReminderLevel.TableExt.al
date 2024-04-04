/// <summary>
/// TableExtension A01 Reminder Level (ID 50020) extends Record Reminder Level.
/// </summary>
tableextension 50020 "A01 Reminder Level" extends "Reminder Level"
{
    fields
    {
        field(50000; "A01 Report Usage"; Enum "Report Selection Usage")
        {
            Caption = 'Report Usage';
            DataClassification = CustomerContent;
        }
        // field(50001; "A01 Reminder Report ID"; Integer)
        // {
        //     Caption = 'Reminder Report ID';
        //     DataClassification = CustomerContent;
        //     TableRelation = AllObj."Object ID" where("Object Type" = const(Report));
        // }
        // field(50002; "A01 Reminder Report Name"; Text[250])
        // {
        //     Caption = 'Reminder Report Name';
        //     FieldClass = FlowField;
        //     CalcFormula = lookup(AllObjWithCaption."Object Name" where("Object Type" = const(Report), "Object ID" = field("A01 Reminder Report ID")));
        //     Editable = false;
        // }
    }
}
