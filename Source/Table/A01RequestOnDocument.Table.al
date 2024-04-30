/// <summary>
/// Table A01 Request On Sales Document (ID 50031).
/// </summary>
table 50031 "A01 Request On Document"
{
    Caption = 'Request On Document';
    DataClassification = CustomerContent;

    fields
    {
        field(1; "Request Type"; Enum "A01 Request On Document Type")
        {
            Caption = 'Request Type';
        }
        field(2; "Request No."; Code[20])
        {
            Caption = 'Request No.';
            Editable = false;
        }
        field(3; Object; Text[100])
        {
            Caption = 'Object';
        }
        field(4; Status; Enum "A01 Approval Status")
        {
            Caption = 'Status';
            Editable = false;
        }
        // field(5; "Document Type"; Enum "Sales Document Type")
        // {
        //     Caption = 'Document Type';
        // }
        // field(6; "Document No."; Code[20])
        // {
        //     Caption = 'Document No.';
        // }
        field(7; "Modified By"; Code[50])
        {
            Caption = 'Modified By';
            TableRelation = "A01 External User";
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(8; "Requested Discount (%)"; Decimal)
        {
            Caption = 'Requested Discount (%)';
        }
        field(9; "Validated Discount (%)"; Decimal)
        {
            Caption = 'Validated Discount (%)';
        }
        field(10; "Customer No."; Code[20])
        {
            Caption = 'Customer No.';
            TableRelation = Customer;
            Editable = false;
            trigger OnValidate()
            var
                Cust: Record Customer;
            begin
                if (Cust.get("Customer No.")) then begin
                    "Credit Limit" := Cust."Credit Limit (LCY)";
                    "Due Balance" := Cust.CalcOverdueBalance();
                    "In progress Balance" := Cust."Balance (LCY)";
                    "Risk level" := Cust."A01 Risk Level";
                end;
            end;
        }
        field(11; "Sales Person"; Code[20])
        {
            Caption = 'Sales Person';
            TableRelation = "Salesperson/Purchaser";
            Editable = false;
        }
        field(12; "Credit Limit"; Decimal)
        {
            Caption = 'Credit Limit';
            Editable = false;
        }
        field(13; "In progress Balance"; Decimal)
        {
            Caption = 'In progress Balance';
            Editable = false;
        }
        field(14; "Due Balance"; Decimal)
        {
            Caption = 'Due Balance';
            Editable = false;
        }
        field(15; "Worst Current Status"; Code[10])
        {
            Caption = 'Worst Current Status';
            TableRelation = "A01 Customer Debt Status";
            Editable = false;
        }
        field(16; "Gross exposure"; Decimal)
        {
            Caption = 'Gross exposure';
        }
        field(17; "Risk level"; Code[20])
        {
            Caption = 'Risk level';
            TableRelation = "A01 Parameter Record".Code where(Type = const(RiskLevel));
            Editable = false;
        }
        field(18; Exceeding; Decimal)
        {
            Caption = 'Exceeding';
        }
        // field(19; "Sequence No."; Integer)
        // {
        //     Caption = 'Sequence No.';
        //     Editable = false;
        // }
        field(20; "Created By"; Code[50])
        {
            Caption = 'Modified By';
            TableRelation = "A01 External User";
            DataClassification = CustomerContent;
            Editable = false;
        }

    }
    keys
    {
        key(PK; "Request Type", "Request No.")
        {
            Clustered = true;
        }
    }
    var
        RequestMgt: codeunit "A01 Document Request Mgt";


    trigger OnInsert()
    var

    begin
        RequestMgt.CheckSameRequestAlreadyExists(Rec);

        // if "Sequence No." = 0 then
        //     "Sequence No." := GetNextSequenceNo();

        InitHeader();
    end;

    local procedure InitHeader()
    begin

    end;

    // value(0; Initialization)
    // value(1; "File on hold")
    // value(2; "Waiting for Analyst")
    // value(3; "Waiting for investigation")
    // value(4; "Waiting for collection")
    // value(5; "Waiting for manager")
    // value(6; "Waiting for committee")
    // value(7; "Validated under conditions")
    // value(8; Validated)
    // value(9; Canceled)
    // value(10; Rejected)
    // value(11; Closed)


    // local procedure GetNextSequenceNo(): Integer
    // var
    //     Request: Record "A01 Request On Document";
    // begin
    //     Request.SetRange("Request Type", Rec."Request Type");
    //     Request.SetRange("Request No.", Rec."Request No.");
    //     if Request.FindLast() then
    //         exit(Request."Sequence No." + 1)
    //     else
    //         exit(1);
    // end;



    procedure IsOnHold(): Boolean
    begin
        if (Status = Status::Initialization) then exit(true);
        if (Status = Status::"File on hold") then exit(true);
        if (Status = Status::"Waiting for Analyst") then exit(true);
        if (Status = Status::"Waiting for investigation") then exit(true);
        if (Status = Status::"Waiting for collection") then exit(true);
        if (Status = Status::"Waiting for manager") then exit(true);
        if (Status = Status::"Waiting for committee") then exit(true);
        if (Status = Status::"Validated") then exit(true);
    end;


}
