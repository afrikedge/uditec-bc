/// <summary>
/// Codeunit AFK01 Security Mgt (ID 50004).
/// </summary>
codeunit 50004 "A01 Security Mgt"
{
    var
        UserSetup: record "User Setup";
        CryptoMgt: Codeunit "Cryptography Management";
        ErrNotAuthorizedAction: Label 'You are not authorized to use this feature.';

    /// <summary>
    /// CheckIfUserCanCloseSalesOrder.
    /// </summary>
    procedure CheckIfUserCanCloseSalesOrder()
    begin
        if UserSetup.Get(UserId) then
            if UserSetup."A01 Can Close Sales Order" then
                exit;
        Error(ErrNotAuthorizedAction);
    end;

    /// <summary>
    /// CheckIfUserCanCancelSalesOrder.
    /// </summary>
    procedure CheckIfUserCanCancelSalesOrder()
    begin
        if UserSetup.Get(UserId) then
            if UserSetup."A01 Can Cancel Sales Order" then
                exit;
        Error(ErrNotAuthorizedAction);
    end;

    /// <summary>
    /// 
    /// </summary>
    /// <returns></returns>
    procedure CheckIfUserCanUpdateOrderAfterValidation(): Boolean
    begin
        if UserSetup.Get(UserId) then
            exit(UserSetup."A01 CanUpdateSalesOrderVal");
    end;

    /// <summary>
    /// GetSalesRespCenterFilter.
    /// </summary>
    /// <returns>Return value of type Text[1024].</returns>
    procedure GetSalesRespCenterFilter(): Text[1024]
    var
        Rep: Text[1024];
    begin
        UserSetup.Get(UserId);

        if (UserSetup."A01 Disable Resp Center Filter") then
            exit('*');

        if UserSetup."Sales Resp. Ctr. Filter" <> '' then
            if Rep = '' then
                Rep := UserSetup."Sales Resp. Ctr. Filter"
            else
                Rep := CopyStr(Rep + '|' + UserSetup."Sales Resp. Ctr. Filter", 1, 1000);


        if UserSetup."A01 Sales Resp. Filter 2" <> '' then
            if Rep = '' then
                Rep := UserSetup."A01 Sales Resp. Filter 2"
            else
                Rep := CopyStr(Rep + '|' + UserSetup."A01 Sales Resp. Filter 2", 1, 1000);


        if UserSetup."A01 Sales Resp. Filter 3" <> '' then
            if Rep = '' THEN
                Rep := UserSetup."A01 Sales Resp. Filter 3"
            else
                Rep := CopyStr(Rep + '|' + UserSetup."A01 Sales Resp. Filter 3", 1, 1000);


        if UserSetup."A01 Sales Resp. Filter 4" <> '' then
            if Rep = '' then
                Rep := UserSetup."A01 Sales Resp. Filter 4"
            else
                Rep := CopyStr(Rep + '|' + UserSetup."A01 Sales Resp. Filter 4", 1, 1000);



        if UserSetup."A01 Sales Resp. Filter 5" <> '' then
            if Rep = '' then
                Rep := UserSetup."A01 Sales Resp. Filter 5"
            else
                Rep := CopyStr(Rep + '|' + UserSetup."A01 Sales Resp. Filter 5", 1, 1000);


        if Rep = '' then Rep := '#K##+';
        exit(Rep);
    end;

    /// <summary>
    /// 
    /// </summary>
    /// <param name="UserCode"></param>
    /// <param name="NewPassord"></param>
    procedure CreateNewPassword(UserCode: Code[50]; NewPassord: Text[50])
    var
        ExternalUser: Record "A01 External User";
        HashedPass: Text;
    begin
        ExternalUser.get(UserCode);
        HashedPass := CryptoMgt.GenerateHashAsBase64String(NewPassord, 2);
        ExternalUser.Password := CopyStr(HashedPass, 1, 255);
        ExternalUser.UserMustChangePassword := true;
        ExternalUser.PasswordIsSet := true;
        ExternalUser.Modify();
    end;

    procedure ChecksOnBeforePosting(GenJournalLine: Record "Gen. Journal Line")
    var
        BankAcc: Record "Bank Account";
        GLMgt: Codeunit "A01 General Legder Mgt";
    begin

        if (GenJournalLine."Account Type" = GenJournalLine."Account Type"::"Bank Account") then
            if (BankAcc.get(GenJournalLine."Account No.")) then begin
                CheckBankUserAccount(BankAcc."No.");
            end;

        if (GenJournalLine."Bal. Account Type" = GenJournalLine."Bal. Account Type"::"Bank Account") then
            if (BankAcc.get(GenJournalLine."Bal. Account No.")) then begin
                CheckBankUserAccount(BankAcc."No.");
            end;

        GLMgt.CheckCashboxClosingDateOnGenJnlLine(GenJournalLine);

        if (GenJournalLine."Journal Batch Name" <> '') then
            CheckJournalUser(GenJournalLine."Journal Template Name", GenJournalLine."Journal Batch Name")

    end;

    procedure CheckWharehouseUserOnJournal(ItemJournalLine: Record "Item Journal Line")
    var
    begin
        CheckWharehouseUser(ItemJournalLine."Location Code");
    end;

    procedure CheckWharehouseUser(LocationCode: Code[20])
    var
        Location: Record Location;
        WarehouseEmp: Record "Warehouse Employee";
        ErrLbl: Label 'You are not authorized to use this location : %1', Comment = '%1=bank';

    begin
        if (LocationCode <> '') then
            if (Location.get(LocationCode)) then begin
                WarehouseEmp.Reset();
                WarehouseEmp.SetRange("Location Code", Location.Code);
                WarehouseEmp.SetRange("User Id", UserId);
                if (WarehouseEmp.IsEmpty()) then
                    Error(ErrLbl, Location.Code);
            end;
    end;

    procedure CheckBankUserAccount(BankAccountNo: Code[20])
    var
        BankAccUser: Record "A01 User Access";
        ErrLbl: Label 'You are not authorized to use this bank account : %1', Comment = '%1=bank';

    begin
        BankAccUser.Reset();
        BankAccUser.SetRange("Access Type", BankAccUser."Access Type"::"Bank Account");
        BankAccUser.SetRange("User Id", UserId);
        BankAccUser.SetRange("Ressource Code 1", BankAccountNo);
        if (BankAccUser.IsEmpty()) then
            Error(ErrLbl, BankAccountNo);
    end;

    procedure CheckJournalUser(JournalTempl: Code[20]; JournalCode: Code[20])
    var
        JournalUser: Record "A01 User Access";
        ErrLbl: Label 'You are not authorized to use this journal : %1 - %2', Comment = '%1=tmpl , %2=journal';

    begin
        JournalUser.Reset();
        JournalUser.SetRange("Access Type", JournalUser."Access Type"::Journal);
        JournalUser.SetRange("User Id", UserId);
        JournalUser.SetRange("Ressource Code 1", JournalTempl);
        JournalUser.SetRange("Ressource Code 2", JournalCode);
        if (JournalUser.IsEmpty()) then
            Error(ErrLbl, JournalTempl, JournalCode);
    end;

    procedure GetMainUserResponsibilityCenter(): Code[20]
    var
    begin
        UserSetup.Get(UserId);
        UserSetup.TestField("Sales Resp. Ctr. Filter");
        exit(UserSetup."Sales Resp. Ctr. Filter");
    end;

    procedure GetMainUserResponsibilityCenterStore(): Code[20]
    var
        resposibilityCenter: Record "Responsibility Center";
    begin
        UserSetup.Get(UserId);
        UserSetup.TestField("Sales Resp. Ctr. Filter");
        resposibilityCenter.get(UserSetup."Sales Resp. Ctr. Filter");
        resposibilityCenter.TestField("Global Dimension 1 Code");
        exit(resposibilityCenter."Global Dimension 1 Code");
    end;
}
