xmlport 50001 "A01 Import AGP Customers"
{
    Caption = 'Import AGP Customers';
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
                fieldattribute(CustomerName; ImportDocument."Account Name") { }
                fieldattribute(Matricule; ImportDocument."Reference30_4") { }
                fieldattribute(Mode; ImportDocument."Code10_1") { }
                fieldattribute(Identification; ImportDocument.Reference30_1) { }
                fieldattribute(Adresse; ImportDocument."Texte100_1") { }
                fieldattribute(Telephone; ImportDocument.Reference30_2) { }
                fieldattribute(Telephone2; ImportDocument."Reference30_3") { }
                fieldattribute(Fonction; ImportDocument.Reference50_1) { }
                fieldattribute(Salaire; ImportDocument.Amount) { }
                fieldattribute(MontantPlafond; ImportDocument.Amount2) { }
                fieldattribute(Contrat; ImportDocument.Code20_1) { }
                fieldattribute(ClientFacture; ImportDocument.Code20_2) { }
                fieldattribute(CentreDeGestion; ImportDocument.Code20_3) { }

                trigger OnBeforeInsertRecord()
                var
                    Cust: Record "Customer";
                    RespCenter: Record "Responsibility Center";
                    ContratAGP: Record "A01 AGP Contrat";
                    CustomerNo: Code[20];
                    CustomerName: Text[100];
                    Matricule: Code[30];
                    Mode: Integer;
                    Identification: Code[30];
                    Adresse: Text[100];
                    Telephone: Code[30];
                    Telephone2: Code[30];
                    Fonction: Code[50];
                    Salaire: Decimal;
                    MontantPlafond: Decimal;
                    Contrat: Code[20];
                    ClientFacture: Code[20];
                    CentreDeGestion: Code[20];
                    ErrorLabel1: Label 'The value of %1 is required on line %2', Comment = '%1=column %2=lineNo';
                    ErrorLabel2: Label 'The contract %1 is already validated on line %2', Comment = '%1=contract no %2=lineNo';
                begin

                    LineNo := LineNo + 1;

                    CustomerNo := ImportDocument."Account No.";

                    CustomerName := ImportDocument."Account Name";
                    if (CustomerName = '') then
                        Error(ErrorLabel1, 'Customer Name', LineNo);

                    Matricule := ImportDocument.Reference30_4;
                    if (Matricule = '') then
                        Error(ErrorLabel1, 'Matricule', LineNo);

                    if (ImportDocument.Code10_1 = '') then
                        Mode := 1
                    else
                        if (not Evaluate(Mode, ImportDocument.Code10_1)) then
                            Error(ErrorLabel1, 'Mode', LineNo)
                        else
                            if (Mode > 3) then
                                Error(ErrorLabel1, 'Mode', LineNo);

                    if (Mode = 0) then
                        Mode := 1;

                    Identification := ImportDocument.Reference30_1;
                    if (Identification = '') then
                        Error(ErrorLabel1, 'Identification', LineNo);

                    Adresse := ImportDocument.Texte100_1;
                    if (Adresse = '') then
                        Error(ErrorLabel1, 'Adresse', LineNo);

                    Telephone := ImportDocument.Reference30_2;
                    if (Telephone = '') then
                        Error(ErrorLabel1, 'Telephone', LineNo);

                    Telephone2 := ImportDocument.Reference30_3;
                    if (Telephone2 = '') then
                        Error(ErrorLabel1, 'Telephone2', LineNo);

                    Fonction := ImportDocument."Reference50_1";
                    if (Fonction = '') then
                        Error(ErrorLabel1, 'Fonction', LineNo);

                    Salaire := ImportDocument."Amount";


                    MontantPlafond := ImportDocument."Amount2";

                    Contrat := ImportDocument."Code20_1";
                    if (Contrat = '') then
                        Error(ErrorLabel1, 'Contrat', LineNo)
                    else begin
                        if (not ContratAGP.Get(Contrat)) then
                            Error(ErrorLabel1, 'Contrat AGP', LineNo);

                        if (ContratAGP."Approval Status" = ContratAGP."Approval Status"::Validated) then
                            Error(ErrorLabel2, Contrat, LineNo);
                    end;

                    ClientFacture := ImportDocument."Code20_2";

                    CentreDeGestion := ImportDocument."Code20_3";
                    if (CentreDeGestion = '') then
                        Error(ErrorLabel1, 'Centre de gestion', LineNo);

                    if (CustomerNo = '') then begin
                        Cust.Init();
                        Cust."No." := '';
                        Cust.Insert(true);
                    end else begin
                        Cust.Get(CustomerNo);
                    end;

                    Cust.Name := CustomerName;
                    Cust."A01 Employee Number" := Matricule;
                    Cust.Validate("A01 Identification Mode", Mode);
                    Cust."A01 ID Number" := Identification;
                    Cust.Address := Adresse;
                    Cust."Phone No." := Telephone;
                    Cust."Mobile Phone No." := Telephone2;
                    Cust."A01 Employee Function" := Fonction;
                    Cust."A01 Employee Salary" := Salaire;
                    Cust."A01 Proposed Credit Limit" := MontantPlafond;
                    Cust."A01 Contract No." := Contrat;
                    Cust."Bill-to Customer No." := ClientFacture;
                    Cust."Responsibility Center" := CopyStr(CentreDeGestion, 1, 10);
                    Cust.Modify();


                    if (Salaire > 0) then
                        AddSalaryCriteria(Cust."No.", Salaire);
                    if (Cust."A01 Identification Mode" = Cust."A01 Identification Mode"::NIC) then
                        AddIdentificationCriteria(Cust."No.", Identification, 'CIN');
                    if (Cust."A01 Identification Mode" = Cust."A01 Identification Mode"::Passport) then
                        AddIdentificationCriteria(Cust."No.", Identification, 'PSP');
                    if (Cust."A01 Identification Mode" = Cust."A01 Identification Mode"::"Residency card") then
                        AddIdentificationCriteria(Cust."No.", Identification, 'CDR');


                    RespCenter.get(Cust."Responsibility Center");
                    Cust."Location Code" := RespCenter."Location Code";
                    Cust."Customer Price Group" := RespCenter."A01 Customer Price Group";
                    Cust."Global Dimension 1 Code" := RespCenter."Global Dimension 1 Code";

                    FillTemplateValues(Cust);

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

    trigger OnPreXmlPort()
    var
    begin
        AfkSetup.Get();
        AfkSetup.TestField("Template for AGP Customer");
    end;

    trigger OnPostXmlPort()
    begin
        Message(LblEndOfProcess);
    end;

    var
        AfkSetup: Record "A01 Afk Setup";
        LblEndOfProcess: Label 'End of importation';
        LineNo: integer;

    local procedure AddSalaryCriteria(CustNo: Code[20]; Salary: decimal)
    var
        CustScoringCriteria: Record "A01 Cust Scoring Criteria";
    begin
        if (CustScoringCriteria.Get(CustScoringCriteria."Account Type"::Customer, CustNo, 'SALAIRE')) then begin
            CustScoringCriteria."Numeric Value" := Salary;
            CustScoringCriteria.Modify();
        end else begin
            CustScoringCriteria.Init();
            CustScoringCriteria."Account Type" := CustScoringCriteria."Account Type"::Customer;
            CustScoringCriteria."Customer No." := CustNo;
            CustScoringCriteria.Criteria := 'SALAIRE';
            CustScoringCriteria."Numeric Value" := Salary;
            CustScoringCriteria.insert(true);
        end;
    end;

    local procedure AddIdentificationCriteria(CustNo: Code[20]; CriteriaValue: Code[30]; CriteriaCode: Code[20])
    var
        CustScoringCriteria: Record "A01 Cust Scoring Criteria";
    begin
        if (CustScoringCriteria.Get(CustScoringCriteria."Account Type"::Customer, CustNo, CriteriaCode)) then begin
            CustScoringCriteria."Aplhanumeric Value" := CriteriaValue;
            CustScoringCriteria.Modify();
        end else begin
            CustScoringCriteria.Init();
            CustScoringCriteria."Account Type" := CustScoringCriteria."Account Type"::Customer;
            CustScoringCriteria."Customer No." := CustNo;
            CustScoringCriteria.Criteria := CriteriaCode;
            CustScoringCriteria."Aplhanumeric Value" := CriteriaValue;
            CustScoringCriteria.insert(true);
        end;
    end;

    local procedure FillTemplateValues(var Cust: Record Customer)
    var
        ConfigHeader: Record "Config. Template Header";
        ConfigTemplMgt: Codeunit "Config. Template Management";
        CustRef: RecordRef;
    begin
        ConfigHeader.Get(AfkSetup."Template for AGP Customer");
        CustRef.GetTable(Cust);
        ConfigTemplMgt.SetUpdatingRelatedTable(true);
        ConfigTemplMgt.UpdateRecord(ConfigHeader, CustRef);
    end;
}
