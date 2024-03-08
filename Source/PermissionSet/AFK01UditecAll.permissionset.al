permissionset 50000 "AFK01 Uditec_All"
{
    Assignable = true;
    Permissions = tabledata "AFK01 Document Step History"=RIMD,
        table "AFK01 Document Step History"=X,
        codeunit "AFK01 CodeEventsSubscribers"=X,
        codeunit "AFK01 PageEventsSubscribers"=X,
        codeunit "AFK01 Sales Order Processing"=X,
        codeunit "AFK01 TableEventsSubscribers"=X;
}