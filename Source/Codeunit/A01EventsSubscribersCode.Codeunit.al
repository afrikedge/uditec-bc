/// <summary>
/// Codeunit AFK01 CodeEventsSubscribers (ID 50002).
/// </summary>
codeunit 50002 "A01 EventsSubscribers_Code"
{

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Item-Check Avail.", 'OnBeforeShowWarningForThisItem', '', true, true)]
    local procedure OnBeforeShowWarningForThisItem_ItemCheckAvail(Item: Record Item; var ShowWarning: Boolean; var IsHandled: Boolean)
    begin
        ShowWarning := true;
        IsHandled := true;
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Sales-Post", 'OnAfterUpdateAfterPosting', '', true, true)]
    local procedure OnAfterUpdateAfterPosting_SalesPost(var SalesHeader: Record "Sales Header"; var TempSalesLine: Record "Sales Line" temporary)
    var
        SalesOrderProcess: Codeunit "A01 Sales Order Processing";
    begin
        //Set invoice or ship status
        SalesOrderProcess.ChangeStatusOnSalesPosting(SalesHeader)
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Sales-Post", 'OnDeleteAfterPostingOnBeforeDeleteSalesHeader', '', true, true)]
    local procedure OnDeleteAfterPostingOnBeforeDeleteSalesHeader_SalesPost(var SalesHeader: Record "Sales Header")
    var
        SalesOrderProcess: Codeunit "A01 Sales Order Processing";
        ArchiveMgt: Codeunit ArchiveManagement;
    begin
        //Set Totally invoiced status and archive
        SalesOrderProcess.SetStatusToCompletelyInvoiced(SalesHeader);
        ArchiveMgt.ArchSalesDocumentNoConfirm(SalesHeader);
    end;


    [EventSubscriber(ObjectType::Codeunit, Codeunit::"ArchiveManagement", 'OnBeforeAutoArchiveSalesDocument', '', true, true)]
    local procedure OnBeforeAutoArchiveSalesDocument_ArchiveManagement(var SalesHeader: Record "Sales Header"; var IsHandled: Boolean)
    begin
        //Desactivate Auto-archive on Sales Order
        if (SalesHeader."Document Type" = SalesHeader."Document Type"::Order) then
            IsHandled := true;
    end;







}
