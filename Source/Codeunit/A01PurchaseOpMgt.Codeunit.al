codeunit 50019 "A01 Purchase Op Mgt"
{
    procedure FillImportationSteps(PurchHeader: Record "Purchase Header")
    var
        ImportStep: Record "A01 Parameter Record";
        PurchaseImportStep: Record "A01 Purchase Import Step";
        LineNo: Integer;
        LblErrorEmptyList: Label 'The list must be empty to perform this operation';
    begin

        PurchaseImportStep.Reset();
        PurchaseImportStep.SetRange("Document Type", PurchHeader."Document Type");
        PurchaseImportStep.SetRange("Document No.", PurchHeader."No.");
        if (not PurchaseImportStep.IsEmpty) then
            Error(LblErrorEmptyList);

        LineNo := 0;
        if ((PurchHeader."Document Type" = PurchHeader."Document Type"::Order)
                and (PurchHeader."A01 Purchase Order Type" = PurchHeader."A01 Purchase Order Type"::Goods)) then begin
            ImportStep.Reset();
            ImportStep.SetCurrentKey("Line Order");
            ImportStep.SetRange(Type, ImportStep.Type::ImportStep);
            if ImportStep.FindSet() then
                repeat
                    LineNo := LineNo + 1;
                    PurchaseImportStep.Init();
                    PurchaseImportStep."Document Type" := PurchHeader."Document Type";
                    PurchaseImportStep."Document No." := PurchHeader."No.";
                    PurchaseImportStep."Line No." := LineNo;
                    PurchaseImportStep.Validate("Step Code", ImportStep.Code);
                    PurchaseImportStep.Insert(true);
                until ImportStep.Next() < 1;
        end;

    end;
}
