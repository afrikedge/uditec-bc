/// <summary>
/// 
/// </summary>
xmlport 50000 "A01 Import Affectations"
{
    Caption = 'Import Affectations';
    Direction = Import;
    Format = VariableText;
    TextEncoding = UTF8;
    FieldDelimiter = '<None>';
    FieldSeparator = '<TAB>';
    UseRequestPage = false;

    schema
    {
        textelement(RootNodeName)
        {
            tableelement("ImportDocument"; "A01 Import Document")
            {
                SourceTableView = sorting("Entry No.") order(ascending);
                AutoSave = false;

                fieldattribute(CustomerNo; ImportDocument."Account No.") { }

                fieldattribute(AssignTo; ImportDocument.UserId) { }

                fieldattribute(RequiredAction; ImportDocument."IntValue") { }

                //fieldattribute(CustomerNo; ImportDocument."Account No."){}
                //fieldattribute(CustomerNo; ImportDocument."Account No."){}

                trigger OnBeforeInsertRecord()
                var
                    Affectation: Record "A01 Deadline Assignment";
                begin
                    Affectation.Init();
                    Affectation.Validate("Customer No.", ImportDocument."Account No.");
                    Affectation.Validate("Assigned to", ImportDocument."UserId");
                    Affectation.Validate("Required action", ImportDocument."IntValue");
                    Affectation.Insert(true);
                end;
            }
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
    trigger OnPostXmlPort()
    begin
        Message(LblEndOfProcess);
    end;

    var
        LblEndOfProcess: Label 'End of importation';
}
