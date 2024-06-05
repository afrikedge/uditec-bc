pageextension 50046 "A01 Item Tracking Lines" extends "Item Tracking Lines"
{
    actions
    {
        addafter("Assign Lot No.")
        {
            action(A01ImportSerialNos)
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Import serial Nos';
                Image = ImportCodes;
                trigger OnAction()
                var
                    xmlPort: XmlPort "A01 Import Serial Numbers";
                begin
                    xmlPort.SetTempImportDoc(TempImportDoc);
                    xmlPort.Run();

                    if TempImportDoc.FindSet() then
                        repeat
                            Rec.Validate("Quantity Handled (Base)", 0);
                            Rec.Validate("Quantity Invoiced (Base)", 0);
                            Rec.Validate("Serial No.", TempImportDoc."Document No.");
                            Rec.Validate("Quantity (Base)", QtySignFactor());
                            Rec."Entry No." := NextEntryNo();
                            Rec.Insert();
                        until TempImportDoc.Next() < 1;

                end;
            }
        }
    }
    var
        TempImportDoc: Record "A01 Import Document" temporary;
}
