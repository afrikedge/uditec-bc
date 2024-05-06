/// <summary>
/// Table A01 Web Profile Permission (ID 50042).
/// </summary>
table 50042 "A01 Web Profile Permission"
{
    Caption = 'Web Profile Permission';
    DataClassification = CustomerContent;

    fields
    {
        field(1; "Web Profile"; Code[20])
        {
            Caption = 'Web Profile';
            TableRelation = "A01 External Profile";
        }
        field(2; "Web Function"; Code[20])
        {
            Caption = 'Web Function';
            TableRelation = "A01 Parameter Record".Code where(Type = const(WebFunction));
        }
        field(3; Insertion; Boolean)
        {
            Caption = 'Insertion';
        }
        field(4; Modification; Boolean)
        {
            Caption = 'Modification';
        }
        field(5; Deletion; Boolean)
        {
            Caption = 'Deletion';
        }
        field(6; Read; Boolean)
        {
            Caption = 'Read';
        }
        field(7; Execution; Boolean)
        {
            Caption = 'Execution';
        }
    }
    keys
    {
        key(PK; "Web Profile", "Web Function")
        {
            Clustered = true;
        }
    }
}
