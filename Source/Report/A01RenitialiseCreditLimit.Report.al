report 50026 "A01 Renitialise Credit Limit"
{
    ApplicationArea = All;
    Caption = 'Renitialise Credit Limit';
    UsageCategory = Tasks;
    ProcessingOnly = true;

    dataset
    {
        dataitem(Customer; Customer)
        {
            //DataItemTableView=where(cust)
            RequestFilterFields = "No.";

            trigger OnPreDataItem()
            var
            begin
                BesoinNo := 0;
                Window.OPEN(Text008);
                NbreTotalLignes := COUNT;
            end;

            trigger OnAfterGetRecord()
            var
                Contract: record "A01 AGP Contrat";
            begin
                BesoinNo := BesoinNo + 1;
                Window.UPDATE(1,
                ROUND(BesoinNo / NbreTotalLignes * 10000, 1));

                if (Customer."Credit Limit (LCY)" = 1) then
                    CurrReport.Skip();

                if (Contract.Get(Customer."A01 Contract No.")) then begin
                    if (Contract."OP Ending Date" < Today) then begin
                        Customer."Credit Limit (LCY)" := 1;
                        Customer.Modify();
                    end;
                end;
            end;

            trigger OnPostDataItem()
            var
            begin
                Window.CLOSE();
                MESSAGE(TxtTraitementTermine);
            end;
        }
    }
    requestpage
    {
        layout
        {
            area(content)
            {
                group(GroupName)
                {
                }
            }
        }
        actions
        {
            area(processing)
            {
            }
        }
    }
    var
        BesoinNo: Integer;
        NbreTotalLignes: Integer;
        Window: Dialog;
        Text008: Label 'Traitement @1@@@@@@@@@@@@@@@@@@@@@@@@@@@@\';
        TxtTraitementTermine: Label 'Traitement términé !';
}
