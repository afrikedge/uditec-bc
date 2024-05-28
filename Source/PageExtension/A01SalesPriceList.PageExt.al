pageextension 50045 "A01 Sales Price List" extends "Sales Price List"
{
    actions
    {
        addafter(SuggestLines)
        {
            action("A01 ImportLines")
            {
                ApplicationArea = All;
                Caption = 'Import lines';
                Image = ImportCodes;
                trigger OnAction()
                var
                    ImportSalesPrices: xmlport "A01 Import Sales Prices";
                begin
                    ImportSalesPrices.SetPriceListCode(Rec.Code);
                    ImportSalesPrices.Run();
                end;
            }
        }
    }
}
