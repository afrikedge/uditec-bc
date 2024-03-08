/// <summary>
/// Codeunit AFK01 CodeEventsSubscribers (ID 50002).
/// </summary>
codeunit 50002 "AFK01 CodeEventsSubscribers"
{

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Item-Check Avail.", 'OnBeforeShowWarningForThisItem', '', true, true)]
    local procedure OnBeforeShowWarningForThisItem_ItemCheckAvail(Item: Record Item; var ShowWarning: Boolean; var IsHandled: Boolean)
    begin
        ShowWarning := true;
        IsHandled := true;
    end;

}
