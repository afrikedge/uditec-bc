/// <summary>
/// Codeunit AFK01 Security Mgt (ID 50004).
/// </summary>
codeunit 50004 "AFK01 Security Mgt"
{
    var
        ErrNotAuthorizedAction: Label 'You are not authorized to use this feature.';

    /// <summary>
    /// CheckIfUserCanCancelSalesOrder.
    /// </summary>
    procedure CheckIfUserCanCancelSalesOrder()
    var
        UserSetup: record "User Setup";
    begin
        if UserSetup.Get(UserId) then
            if UserSetup."AFK01 Can Cancel Sales Order" then
                exit;
        Error(ErrNotAuthorizedAction);
    end;

    local procedure MyProcedure()
    // var
    //     myInt: Integer;
    begin

    end;
    /// <summary>
    /// 
    /// </summary>
    /// <returns></returns>
    procedure CheckIfUserCanUpdateOrderAfterValidation(): Boolean
    var
        UserSetup: record "User Setup";
    begin
        if UserSetup.Get(UserId) then
            exit(UserSetup."AFK01 CanUpdateSalesOrderVal");
    end;
}
