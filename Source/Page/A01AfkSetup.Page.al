/// <summary>
/// Page A01 Afk Setup (ID 50040).
/// </summary>
page 50040 "A01 Afk Setup"
{
    ApplicationArea = All;
    Caption = 'Afk Setup';
    AdditionalSearchTerms = 'addons setup,afk setup,params setup';
    PageType = Card;
    SourceTable = "A01 Afk Setup";
    DeleteAllowed = false;
    InsertAllowed = false;
    UsageCategory = Administration;

    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General';
                field("Item Category Code (Voucher)"; Rec."Item Category Code (Voucher)")
                {
                }
                field("Charge Account (Voucher)"; Rec."Charge Account (Voucher)")
                {
                }
                field("Suspense Account (Voucher)"; Rec."Suspense Account (Voucher)")
                {
                }
                field("Payment Method (Voucher)"; Rec."Payment Method (Voucher)")
                {
                }
                field("Transfer Acc (Bank-CashBox)"; Rec."Transfer Acc (Bank-CashBox)")
                {
                }
                field("Transfer Acc (Inter-cash)"; Rec."Transfer Acc (Inter-cash)")
                {
                }
                field("Petty Cash Pay Mode"; Rec."Petty Cash Pay Mode")
                {
                }
                field("Exempt VAT Bus. Posting Group"; Rec."Exempt VAT Bus. Posting Group")
                {
                }


            }
            group(Mirindra)
            {
                Caption = 'Mirindra';

                field("MIR Eligible Products"; Rec."MIR Eligible Products")
                {
                    ToolTip = 'Indicates items allowed for Mirindra credit sales';
                }
                field("MIR Application fees (%)"; Rec."MIR Application fees (%)")
                {
                    ToolTip = 'Percentage of Application fees to be included in the calculation of the debt';
                }
                field("MIR Discounts allowed"; Rec."MIR Discounts allowed")
                {
                    ToolTip = 'Indicates whether discounts are allowed for credit sales by Mirindra';
                }
                field("MIR Due rounding rule"; Rec."MIR Due rounding rule")
                {
                    ToolTip = 'Indicates the level of rounding on monthly payments';
                }
                field("MIR Eligibility area"; Rec."MIR Eligibility area")
                {
                    ToolTip = 'Indicates the distance (in kilometers) tolerable between the point of sale and the customer''s place of residence';
                }
                field("MIR Item for application fees"; Rec."MIR Item for application fees")
                {
                    ToolTip = 'Item code used for invoicing Mirindra application fees';
                }
                field("MIR Item for interest"; Rec."MIR Item for interest")
                {
                    ToolTip = 'Item code used for Mirindra interest billing';
                }
                field("MIR Maximum credit duration"; Rec."MIR Maximum credit duration")
                {
                    ToolTip = 'Indicates the maximum number of months allowed for depreciation';
                }
                field("MIR Monthly interest rate %"; Rec."MIR Monthly interest rate %")
                {
                    ToolTip = 'Indicates the monthly interest rate';
                }
                field("MIR No of cumulative credits"; Rec."MIR No of cumulative credits")
                {
                    ToolTip = 'Indicates the number of credits that a customer can accumulate';
                }
                field("MIR No of products per file"; Rec."MIR No of products per file")
                {
                    ToolTip = 'Indicates the maximum number of items that a credit file can contain';
                }
                field("MIR Required Deposit %"; Rec."MIR Required Deposit %")
                {
                    ToolTip = 'Indicates the percentage of deposit required';
                }
                field("MIR Sales Mode"; Rec."MIR Sales Mode")
                {
                    ToolTip = 'Sales mode corresponding to Mirindra';
                }
                field("MIR Sales minimum value"; Rec."MIR Sales minimum value")
                {
                    ToolTip = 'Minimum amount of a sale by Mirindra';
                }
                field("MIR Site visit required"; Rec."MIR Site visit required")
                {
                    ToolTip = 'Indicates whether the site visit is mandatory or not';
                }
                field("MIR Planned Interest Account"; Rec."MIR Planned Interest Account")
                {
                }
                field("MIR Realised Interest Account"; Rec."MIR Realised Interest Account")
                {
                }
                field("Allow Partial Invoice MIR"; Rec."Allow Partial Invoice MIR")
                {
                }
                field("Sales channel for Interest"; Rec."Sales channel for Interest")
                {
                }
                field("MIR Credit delay (Months)"; Rec."Deferred month")
                {
                }
                field("Rebate Payment Method"; Rec."Rebate Payment Method")
                {
                }
            }
            group(Logistics)
            {
                Caption = 'Logistics';

                field("Minimum Delivery per trip"; Rec."Minimum Delivery per trip")
                {
                    ToolTip = 'Minimum number of deliveries per trip';
                }
                field("Delivery Agent"; Rec."Delivery Agent")
                {
                }
            }
            group("Grouped purchase")
            {
                Caption = 'Grouped purchase';
                field("AGP Payment Terms Code"; Rec."AGP Payment Terms Code")
                {

                }
                field("AGP Discounts allowed"; Rec."AGP Discounts allowed")
                {
                    ToolTip = 'Indicates whether discounts are allowed for credit sales by AGP';
                }
                field("AGP Operation duration (Month)"; Rec."AGP Operation duration (Month)")
                {
                    ToolTip = 'Default number of months during which purchases can be made for an AGP contract';
                }
                field("AGP Sales minimum value"; Rec."AGP Sales minimum value")
                {
                    ToolTip = 'Minimum amount of a sale per AGP';
                }
                field("AGP Transferable part %"; Rec."AGP Transferable part %")
                {
                    ToolTip = 'Maximum percentage of income that can be used for the monthly loan payment';
                }
                field("AGP credit duration"; Rec."AGP credit duration")
                {
                    ToolTip = 'Maximum number of months for group purchase credit';
                }
                field("AGP Sales Mode"; Rec."AGP Sales Mode")
                {
                    ToolTip = 'Indicates the sales method used for AGP contracts';
                }

                field("AGP Min number of participants"; Rec."AGP Min number of participants")
                {
                    ToolTip = 'Indicates the minimum number of employees required for an AGP contract';
                }
                field("AGP Site visit"; Rec."AGP Site visit")
                {
                    ToolTip = 'Indicates whether the site visit is mandatory or not';
                }
                field("AGP Type of employee contract"; Rec."AGP Type of employee contract")
                {
                    ToolTip = 'Indicates the type of contract of employees eligible for the credit';
                }
                field("AGP Minimum salary"; Rec."AGP Minimum salary")
                {
                    ToolTip = 'Minimum salary for an employee eligible for AGP';
                }
                field("AGP Conditions of appl fees"; Rec."AGP Conditions of appl fees")
                {
                    ToolTip = 'Indicates under what conditions the application fees are applied';
                }
                field("AGP Administrative fees (%)"; Rec."AGP Administrative fees (%)")
                {
                    ToolTip = 'MPercentage of the AGP application fee';
                }
                field("AGP Banked Employee"; Rec."AGP Banked Employee")
                {
                    ToolTip = 'Indicates whether banked or unbanked employees can benefit from the credit';
                }
                field("AGP Item AGP application fees"; Rec."AGP Item AGP application fees")
                {

                }
                field("Template for AGP Cudtomer"; Rec."Template for AGP Customer")
                {

                }
            }
            group("After sales service")
            {
                Caption = 'After sales service';

                field("SAV diagnostic time"; Rec."SAV diagnostic time")
                {
                    ToolTip = 'Default duration in number of hours between the entry date and the end date of diagnosis';
                }
                field("Reposession Location"; Rec."Reposession Location")
                {
                    ToolTip = 'Location code to use for returning repossessed items';
                }
                field("Reposession Risk Level"; Rec."Reposession Risk Level")
                {
                }
                field("SR Default Bin Code"; Rec."SR Default Bin Code")
                {
                }

                field("SR Agent Profile"; Rec."SR Agent Profile")
                {
                }
                field("SR SWAP Bin Code"; Rec."SR SWAP Bin Code")
                {
                }
                field("SR Defect Bin Code"; Rec."SR Defect Bin Code")
                {
                }
                field("SR Workshop Bin Code"; Rec."SR Workshop Bin Code")
                {
                }
                field("Service Request Adj Nos"; Rec."Service Request Adj Nos")
                {
                }
                field("SR Item Source Code"; Rec."SR Item Source Code")
                {
                }


            }
            group("Numbering")
            {
                Caption = 'Numbering';

                field("Payment Promise Nos"; Rec."Payment Promise Nos")
                {
                }
                field("Service Request Nos"; Rec."Service Request Nos")
                {
                }
                field("Purchase Voucher Nos"; Rec."Purchase Voucher Nos")
                {
                }
                field("Discount Request Nos"; Rec."Discount Request Nos")
                {
                }
                field("Revision Request Nos"; Rec."Revision Request Nos")
                {
                }
                field("Transport Voucher Nos"; Rec."Transport Voucher Nos")
                {
                }
                field("Warranty Contract Nos"; Rec."Warranty Contract Nos")
                {
                }
                field("Unblocking Request Nos"; Rec."Unblocking Request Nos")
                {
                }
                field("Deadline Assignment Nos"; Rec."Deadline Assignment Nos")
                {
                }
                field("Reposession request Nos"; Rec."Reposession request Nos")
                {
                }
                field("Customer Settlement Nos"; Rec."Customer Settlement Nos")
                {
                }
                field("Posted Cust Settlement Nos"; Rec."Posted Cust Settlement Nos")
                {
                }
                field("AGP Contract Nos"; Rec."AGP Contract Nos")
                {
                }
                field("ShipToAddress Code Nos"; Rec."ShipToAddress Code Nos")
                {
                }
                field("Lead Nos"; Rec."Lead Nos")
                {
                }
                field("Exempt Post Invoices Nos"; Rec."Exempt Post Invoices Nos")
                {
                }
                field("Exempt Post Shipment Nos"; Rec."Exempt Post Shipment Nos")
                {
                }

                field("Transport Order Nos"; Rec."Transport Order Nos")
                {
                }

            }
            group("TestApi")
            {
                Caption = 'Test Api';

                field(TestApiJsonInput; TestApiJsonInput)
                {
                    Caption = 'JsonInput';
                    MultiLine = true;
                }
                field(TestApiJsonResponse; TestApiJsonResponse)
                {
                    Caption = 'JsonResponse';
                    MultiLine = true;
                }
            }
        }
    }
    actions
    {
        area(processing)
        {
            action(Process)
            {
                ApplicationArea = All;
                Caption = 'TestAPI';
                Image = TestFile;
                Ellipsis = true;

                trigger OnAction()
                var
                    ApiInterface: Codeunit "A01 Api Interface Mgt";
                begin
                    if (TestApiJsonInput <> '') then
                        TestApiJsonResponse := ApiInterface.Run(TestApiJsonInput);
                end;
            }
            action(ProcessCustom)
            {
                ApplicationArea = All;
                Caption = 'TestCustom';
                Image = TestFile;
                Ellipsis = true;

                trigger OnAction()
                var
                    SRRequest: record "A01 Service Request";
                    InvtMgt: Codeunit "A01 Inventory Mgt";
                    dateT: DateTime;
                begin
                    SRRequest.Get('SVQ24-0000008');
                    InvtMgt.CreateItemAdjustmentEntry_ServiceRequest(SRRequest);
                    // Evaluate(dateT, '1753-01-01T00:00:00.000Z');
                    // Message(format(dateT));
                end;
            }
            action(ImportLettrage)
            {
                ApplicationArea = All;
                Caption = 'Import entries for application';
                Image = ImportLog;
                Ellipsis = true;
                RunObject = xmlport "A01 Import Lettrage";
            }
            action(UpdateCreditAmortLines)
            {
                ApplicationArea = All;
                Caption = 'Update credit amort Lines';
                Image = UpdateDescription;
                Ellipsis = true;
                RunObject = report "A01 Update Credit Amort Line";
            }
            action(CustomProcess)
            {
                ApplicationArea = All;
                Caption = 'Run custom process';
                Image = UpdateUnitCost;
                Ellipsis = true;
                RunObject = report A01CustomProcess;
            }
            action(UpdateCreditAmortLinesTest)
            {
                ApplicationArea = All;
                Caption = 'Update credit amort Lines - TEST';
                Image = UpdateDescription;
                Ellipsis = true;
                RunObject = report "A01 Update Credit Line Test";
            }
        }
    }
    trigger OnOpenPage()
    begin
        Rec.Reset();
        if not Rec.Get() then begin
            Rec.Init();
            Rec.Insert();
        end;
    end;

    var
        TestApiJsonInput: Text;
        TestApiJsonResponse: Text;
}
