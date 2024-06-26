report 50020 "A01 Create Document Request"
{
    ApplicationArea = All;
    Caption = 'Create Document Request';
    UsageCategory = Tasks;
    ProcessingOnly = true;
    dataset
    {
        dataitem(Integer; "Integer")
        {
            DataItemTableView = sorting(Number) where(Number = const(1));
            trigger OnAfterGetRecord()
            begin
                if ((CreatedDocType = "A01 Request On Document Type"::"Discount on quote")
                        or (CreatedDocType = "A01 Request On Document Type"::"Discount on order")) then begin
                    if ((RequestedDiscount > 100) or (RequestedDiscount = 0)) then
                        Error(LblRequestedDiscountError);
                    RequestDocMgt.AddDiscountRequest(SalesHeader, RequestedDiscount, '', SalesHeader."A01 Request Status"::"Waiting for validation");
                    Message(LblDocCreated);
                    exit;
                end;

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
                    Caption = 'Options';
                    field(RequestedDicsount; RequestedDiscount)
                    {
                        Caption = 'Requested Discount %';
                        ApplicationArea = Basic, Suite;
                    }
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
        SalesHeader: Record "Sales Header";
        RequestDocMgt: Codeunit "A01 Document Request Mgt";
        RequestedDiscount: Decimal;
        CreatedDocType: Enum "A01 Request On Document Type";

        LblRequestedDiscountError: Label 'The percentage must be positive and less than 100';
        LblDocCreated: Label 'The request was created successfully';

    procedure SetRequestType(CreatedDocType1: Enum "A01 Request On Document Type")
    var
    begin
        CreatedDocType := CreatedDocType1;
    end;

    procedure SetDoc(SalesHeader1: Record "Sales Header")
    var
    begin
        SalesHeader := SalesHeader1;
    end;
}
