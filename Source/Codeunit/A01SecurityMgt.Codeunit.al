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
}
