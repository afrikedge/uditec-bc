/// <summary>
/// TableExtension A01 Ship-to Address (ID 50007) extends Record Ship-to Address.
/// </summary>
tableextension 50007 "A01 Ship-to Address" extends "Ship-to Address"
{
    fields
    {
        field(50000; "A01 Time preference"; Enum "A01 Time Slot")
        {
            Caption = 'Time preference';
            DataClassification = CustomerContent;
        }
        field(50001; "A01 Place"; Text[100])
        {
            Caption = 'Place';
            DataClassification = CustomerContent;
        }
        field(50002; "A01 Neighborhood"; Text[50])
        {
            Caption = 'Neighborhood';
            DataClassification = CustomerContent;
        }
        field(50003; "A01 Area"; Text[50])
        {
            Caption = 'Area';
            DataClassification = CustomerContent;
        }
        field(50004; "A01 Road Type"; Enum "A01 Road Conditions")
        {
            Caption = 'Road Type';
            DataClassification = CustomerContent;
        }
        field(50005; "A01 Road Type (Others)"; Text[50])
        {
            Caption = 'Road Type (Others)';
            DataClassification = CustomerContent;
        }
        field(50006; "A01 Walking distance"; Enum "A01 Walking distance")
        {
            Caption = 'Walking distance';
            DataClassification = CustomerContent;
        }
        field(50007; "A01 Walking distance (Others)"; Text[50])
        {
            Caption = 'Walking distance (Others)';
            DataClassification = CustomerContent;
        }
        field(50008; "A01 Delivery Location"; Enum "A01 Delivery Location Type")
        {
            Caption = 'Delivery Location';
            DataClassification = CustomerContent;
        }
        field(50009; "A01 Motorcycle Access"; Boolean)
        {
            Caption = 'Motorcycle Access';
            DataClassification = CustomerContent;
        }
        field(50010; "A01 Access Plan"; Enum "A01 Access Plan Type")
        {
            Caption = 'Access Plan';
            DataClassification = CustomerContent;
        }
        field(50011; "A01 Access Type"; Enum "A01 Access Type")
        {
            Caption = 'Access Type';
            DataClassification = CustomerContent;
        }
        field(50012; "A01 Truck Type"; Enum "A01 Delivery Truck Type")
        {
            Caption = 'Truck Type';
            DataClassification = CustomerContent;
        }
        field(50013; "A01 Public parking presence"; Boolean)
        {
            Caption = 'Public parking presence';
            DataClassification = CustomerContent;
        }
        field(50014; "A01 Remarks"; Text[100])
        {
            Caption = 'Remarks';
            DataClassification = CustomerContent;
        }
        field(50015; "A01 Ground plan"; Media)
        {
            Caption = 'Ground plan';
            DataClassification = CustomerContent;
        }
    }
}
