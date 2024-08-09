/// <summary>
/// Table A01 Afk Setup (ID 50017).
/// </summary>
table 50017 "A01 Afk Setup"
{
    Caption = 'Afk Setup';
    DataClassification = CustomerContent;


    fields
    {
        field(1; "MIR Maximum credit duration"; Integer)
        {
            Caption = 'Maximum credit duration';
        }
        field(2; "MIR Required Deposit %"; Decimal)
        {
            Caption = 'Required Deposit %';
            MinValue = 0;
            MaxValue = 100;
        }
        field(3; "MIR Monthly interest rate %"; Decimal)
        {
            Caption = 'Monthly interest rate %';
            MinValue = 0;
            MaxValue = 100;
        }
        field(4; "MIR No of cumulative credits"; Integer)
        {
            Caption = 'Number of cumulative credits';
        }
        field(5; "MIR No of products per file"; Integer)
        {
            Caption = 'Number of products per file';
        }
        field(6; "MIR Site visit required"; Enum "A01 MIR Site Visit Required")
        {
            Caption = 'Site visit required';
        }
        field(7; "MIR Eligibility area"; Decimal)
        {
            Caption = 'Eligibility area';
        }
        field(8; "MIR Sales minimum value"; Decimal)
        {
            Caption = 'Sales minimum value';
        }
        field(9; "MIR Application fees (%)"; Decimal)
        {
            Caption = 'Application fees (%)';
            MinValue = 0;
            MaxValue = 100;
        }
        field(10; "MIR Discounts allowed"; Boolean)
        {
            Caption = 'Discounts allowed';
        }
        field(11; "MIR Due rounding rule"; Enum "A01 MIR Due rounding rule")
        {
            Caption = 'Due rounding rule';
        }
        field(12; "MIR Item for interest"; Code[20])
        {
            Caption = 'Item for interest';
            TableRelation = Item where(Type = const(Service));
        }
        field(13; "MIR Sales Mode"; Code[20])
        {
            Caption = 'Sales Mode';
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(3));
        }
        field(14; "MIR Item for application fees"; Code[20])
        {
            Caption = 'Item for application fees';
            TableRelation = Item where(Type = const(Service));
        }
        field(15; "Minimum Delivery per trip"; Integer)
        {
            Caption = 'Minimum Delivery per trip';
        }
        field(16; "AGP credit duration"; Integer)
        {
            Caption = 'AGP credit duration';
        }
        field(17; "AGP Transferable part %"; Decimal)
        {
            Caption = 'AGP Transferable part %';
            MinValue = 0;
            MaxValue = 100;
        }
        field(18; "AGP Discounts allowed"; Boolean)
        {
            Caption = 'AGP Discounts allowed';
        }
        field(19; "AGP Sales minimum value"; Decimal)
        {
            Caption = 'AGP Sales minimum value';
        }
        field(20; "AGP Operation duration (Month)"; Integer)
        {
            Caption = 'AGP Operation duration (Month)';
        }
        field(21; "SAV diagnostic time"; Integer)
        {
            Caption = 'SAV diagnostic time';
        }
        field(22; "Code"; Code[10])
        {
            Caption = 'Code';
        }
        field(23; "MIR Eligible Products"; Enum "A01 MIR Eligible Product Mode")
        {
            Caption = 'Eligible Products';
        }

        field(24; "Purchase Voucher Nos"; Code[20])
        {
            Caption = 'Purchase Voucher Nos';
            TableRelation = "No. Series";
        }
        field(25; "Warranty Contract Nos"; Code[20])
        {
            Caption = 'Warranty Contract Nos';
            TableRelation = "No. Series";
        }
        field(26; "Deadline Assignment Nos"; Code[20])
        {
            Caption = 'Deadline Assignment Nos';
            TableRelation = "No. Series";
        }
        field(27; "Payment Promise Nos"; Code[20])
        {
            Caption = 'Payment Promise Nos';
            TableRelation = "No. Series";
        }
        field(28; "Customer Settlement Nos"; Code[20])
        {
            Caption = 'Customer Settlement Nos';
            TableRelation = "No. Series";
        }
        field(29; "Discount Request Nos"; Code[20])
        {
            Caption = 'Discount Request Nos';
            TableRelation = "No. Series";
        }
        field(30; "Unblocking Request Nos"; Code[20])
        {
            Caption = 'Unblocking Request Nos';
            TableRelation = "No. Series";
        }
        field(31; "Revision Request Nos"; Code[20])
        {
            Caption = 'Revision Request Nos';
            TableRelation = "No. Series";
        }
        field(32; "Reposession request Nos"; Code[20])
        {
            Caption = 'Reposession request Nos';
            TableRelation = "No. Series";
        }
        field(33; "Service Request Nos"; Code[20])
        {
            Caption = 'Service Request Nos';
            TableRelation = "No. Series";
        }
        field(34; "Transport Voucher Nos"; Code[20])
        {
            Caption = 'Transport Voucher Nos';
            TableRelation = "No. Series";
        }
        field(35; "Reposession Location"; Code[20])
        {
            Caption = 'Reposession Location';
            TableRelation = "Location";
        }
        field(36; "AGP Sales Mode"; Code[20])
        {
            Caption = 'AGP Sales Mode';
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(3));
        }
        field(37; "AGP Min number of participants"; Integer)
        {
            Caption = 'AGP Minimum number of participants';
        }
        field(38; "AGP Site visit"; Enum "A01 MIR Site Visit Required")
        {
            Caption = 'AGP Site visit';
        }
        field(39; "AGP Type of employee contract"; Enum "A01 AGP Type of emp contr")
        {
            Caption = 'AGP Type of employee contract';
        }
        field(40; "AGP Minimum salary"; Decimal)
        {
            Caption = 'AGP Minimum salary';
        }
        field(41; "AGP Conditions of appl fees"; Enum "A01 Agp Application Fees Type")
        {
            Caption = 'Conditions of application fees';
        }
        field(42; "AGP Administrative fees (%)"; Decimal)
        {
            Caption = 'AGP Administrative fees (%)"';
        }
        field(43; "AGP Banked Employee"; Boolean)
        {
            Caption = 'AGP Banked Employee';
        }
        field(45; "AGP Item AGP application fees"; Code[20])
        {
            Caption = 'AGP Item for AGP application fees';
            TableRelation = Item where(Type = const(Service));
        }
        field(46; "AGP Contract Nos"; Code[20])
        {
            Caption = 'AGP Contract Nos';
            TableRelation = "No. Series";
        }
        field(47; "Posted Cust Settlement Nos"; Code[20])
        {
            Caption = 'Posted Customer Settlement Nos';
            TableRelation = "No. Series";
        }
        field(48; "MIR Realised Interest Account"; Code[20])
        {
            Caption = 'MIR Realised Interest Account';
            TableRelation = "G/L Account"."No." where("Direct Posting" = const(true));
        }
        field(49; "MIR Planned Interest Account"; Code[20])
        {
            Caption = 'MIR Planned Interest Account';
            TableRelation = "G/L Account"."No." where("Direct Posting" = const(true));
        }
        field(50; "ShipToAddress Code Nos"; Code[20])
        {
            Caption = 'ShipToAddress Code Nos';
            TableRelation = "No. Series";
        }
        field(51; "Lead Nos"; Code[20])
        {
            Caption = 'Lead Nos';
            TableRelation = "No. Series";
        }
        field(52; "Item Category Code (Voucher)"; Code[20])
        {
            Caption = 'Item Category Code (Voucher)';
            TableRelation = "Item Category";
        }
        field(53; "Charge Account (Voucher)"; Code[20])
        {
            Caption = 'Charge Account (Voucher)';
            TableRelation = "G/L Account"."No." where("Direct Posting" = const(true));
        }
        field(54; "Payment Method (Voucher)"; Code[20])
        {
            Caption = 'Payment Method (Voucher)';
            TableRelation = "Payment Method";
        }
        field(55; "Reposession Risk Level"; Code[20])
        {
            Caption = 'Reposession Risk Level';
            TableRelation = "A01 Parameter Record".Code where(Type = const(RiskLevel));
        }
        field(56; "Suspense Account (Voucher)"; Code[20])
        {
            Caption = 'Suspense Account (Voucher)';
            TableRelation = "G/L Account"."No." where("Direct Posting" = const(true));
        }
        field(57; "Transfer Acc (Bank-CashBox)"; Code[20])
        {
            Caption = 'Transfer Acc (Bank-CashBox)';
            TableRelation = "G/L Account"."No." where("Direct Posting" = const(true));
        }
        field(58; "Transfer Acc (Inter-cash)"; Code[20])
        {
            Caption = 'Transfer Acc (Inter-cash)';
            TableRelation = "G/L Account"."No." where("Direct Posting" = const(true));
        }
        field(59; "Exempt Post Invoices Nos"; Code[20])
        {
            Caption = 'Exempt Post Invoices Nos';
            TableRelation = "No. Series";
        }
        field(60; "Exempt Post Shipment Nos"; Code[20])
        {
            Caption = 'Exempt Post Shipment Nos';
            TableRelation = "No. Series";
        }
        field(61; "Petty Cash Pay Mode"; Code[10])
        {
            Caption = 'Petty Cash Payment Method';
            TableRelation = "Payment Method";
        }
        field(62; "Exempt VAT Bus. Posting Group"; Code[20])
        {
            Caption = 'Exempt VAT Business Posting Group';
            TableRelation = "VAT Business Posting Group";
        }
        field(63; "AGP Payment Terms Code"; Code[20])
        {
            Caption = 'AGP Payment Terms Code';
            TableRelation = "Payment terms";
        }
        field(64; "Template for AGP Customer"; Code[20])
        {
            Caption = 'Template for AGP Customer';
            TableRelation = "Config. Template Header";
        }
        field(65; "Allow Partial Invoice MIR"; Boolean)
        {
            Caption = 'Allow partial invoice on Mirindra';
        }
        field(66; "Transport Order Nos"; Code[20])
        {
            Caption = 'Transport Order Nos';
            TableRelation = "No. Series";
        }
        field(67; "Sales channel for Interest"; Code[20])
        {
            Caption = 'Sales channel for Interest';
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(2));
        }
        field(68; "SR Default Bin Code"; Code[20])
        {
            Caption = 'Default bin for after sales service';
        }

        field(69; "Delivery Agent"; Code[20])
        {
            Caption = 'Delivery Agent';
            TableRelation = "A01 External Profile";
        }
        field(70; "SR Agent Profile"; Code[20])
        {
            Caption = 'Delivery Agent';
            TableRelation = "A01 External Profile";
        }
        field(71; "SR SWAP Bin Code"; Text[50])
        {
            Caption = 'SR SWAP Bin Code';
        }
        field(72; "SR Defect Bin Code"; Text[50])
        {
            Caption = 'SR Defect Bin Code';
        }
        field(73; "SR Workshop Bin Code"; Text[50])
        {
            Caption = 'SR Workshop Bin Code';
        }
        field(74; "Service Request Adj Nos"; Code[20])
        {
            Caption = 'Service Request Item Adjust Nos';
            TableRelation = "No. Series";
        }
        field(75; "SR Item Source Code"; Code[10])
        {
            Caption = 'SR Item Source Code';
            TableRelation = "Source Code";
        }
        field(76; "Deferred month"; Integer)
        {
            Caption = 'MIR Credit deferred (Months)';
        }


        //Config. Template Header
        //Banked or unbanked employee
        //Administrative fees (%)
        //Conditions of application application fees
    }
    keys
    {
        key(PK; "Code")
        {
            Clustered = true;
        }
    }
    var
        RecordHasBeenRead: Boolean;
    /// <summary>
    /// GetRecordOnce()
    /// </summary>
    procedure GetRecordOnce()
    begin
        if RecordHasBeenRead then
            exit;
        Get();
        RecordHasBeenRead := true;
    end;
}
