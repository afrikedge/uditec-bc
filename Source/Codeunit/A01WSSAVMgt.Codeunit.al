codeunit 50022 A01WSSAVMgt
{
    var
        WS: codeunit "A01 Api Mgt";
        LblErrorQuoteNotExists: Label 'The Quote N° %1 does not exists', Comment = '%1 = QuoteNo';


    procedure RunOrderTransport(input: JsonObject; IsDeletion: Boolean): Text
    var
        NoDocument: text;
    begin
        NoDocument := ws.GetText('No_', input);
        if (NoDocument <> '') then begin

            if (IsDeletion) then
                exit(DeleteOrderTransport(NoDocument))
            else
                exit(ModifyOrderTransport(NoDocument, input))

        end else
            exit(AddOrderTransport(input));
    end;

    procedure RunServiceRequest(input: JsonObject; IsDeletion: Boolean): Text
    var
        NoDocument: text;
    begin
        NoDocument := ws.GetText('No_', input);
        if (NoDocument <> '') then begin

            if (IsDeletion) then
                exit(DeleteServiceRequest(NoDocument))
            else
                exit(ModifyServiceRequest(NoDocument, input))

        end else
            exit(AddServiceRequest(input));
    end;

    local procedure AddOrderTransport(input: JsonObject): Text
    var
        TransportOrder: Record "A01 Transport Order";
        TransportOrderDetail: Record "A01 Transport Order Detail";
    begin

        TransportOrder.Init();
        TransportOrder."No." := '';

        TransportOrderDetail.LockTable();
        TransportOrder.Insert(true);

        ProcessOrderTransport(TransportOrder, input);

        processOrderTransportLines(TransportOrder, input);

        TransportOrder.Modify(true);

        exit(Ws.CreateResponseSuccess(TransportOrder."No."));

    end;

    local procedure DeleteOrderTransport(NoDocument: Text): Text
    var
        TransportOrder: Record "A01 Transport Order";
    begin

        TransportOrder.Get(NoDocument);

        TransportOrder.Delete(true);

        exit(Ws.CreateResponseSuccess(TransportOrder."No."));

    end;

    local procedure ModifyOrderTransport(NoDocument: Text; input: JsonObject): Text
    var
        TransportOrder: Record "A01 Transport Order";
    begin

        TransportOrder.Get(NoDocument);

        ProcessOrderTransport(TransportOrder, input);

        TransportOrder.Modify(true);

        processOrderTransportLines(TransportOrder, input);

        exit(Ws.CreateResponseSuccess(TransportOrder."No."));

    end;

    local procedure processOrderTransportLines(TransportOrder: Record "A01 Transport Order"; input: JsonObject)
    var
        TransportOrderDetail: Record "A01 Transport Order Detail";
        c: JsonToken;
        LinesArray: JsonArray;
        LineInput: JsonObject;
    begin

        TransportOrderDetail.Reset();
        TransportOrderDetail.SetRange("Transport Order No.", TransportOrder."No.");
        if (not TransportOrderDetail.IsEmpty) then
            TransportOrderDetail.DeleteAll();

        input.Get('TransportOrderDetails', c);
        LinesArray := c.AsArray();
        foreach c in LinesArray do begin
            LineInput := c.AsObject();
            TransportOrderDetail.Init();
            ProcessOrderTransportLine(TransportOrder, TransportOrderDetail, LineInput);
            TransportOrderDetail.Insert(true);
        end;
    end;

    local procedure AddServiceRequest(input: JsonObject): Text
    var
        ServiceRequest: Record "A01 Service Request";
    begin

        ServiceRequest.Init();
        ServiceRequest."No." := '';

        //TransportOrderDetail.LockTable();
        ServiceRequest.Insert(true);

        ProcessServiceRequest(ServiceRequest, input);

        Process_SRSparePart_Lines(ServiceRequest, input);
        Process_SRDefectivePart_Lines(ServiceRequest, input);
        Process_SRItemMovement_Lines(ServiceRequest, input);
        Process_SRSalesDocument_Lines(ServiceRequest, input);
        Process_SRAssignmentFlow_Lines(ServiceRequest, input);

        ServiceRequest.Modify(true);

        exit(Ws.CreateResponseSuccess(ServiceRequest."No."));

    end;

    local procedure ModifyServiceRequest(NoDocument: Text; input: JsonObject): Text
    var
        ServiceRequest: Record "A01 Service Request";
    begin

        ServiceRequest.Get(NoDocument);

        ProcessServiceRequest(ServiceRequest, input);

        ServiceRequest.Modify(true);

        Process_SRSparePart_Lines(ServiceRequest, input);
        Process_SRDefectivePart_Lines(ServiceRequest, input);
        Process_SRItemMovement_Lines(ServiceRequest, input);
        Process_SRSalesDocument_Lines(ServiceRequest, input);
        Process_SRAssignmentFlow_Lines(ServiceRequest, input);

        exit(Ws.CreateResponseSuccess(ServiceRequest."No."));

    end;

    local procedure DeleteServiceRequest(NoDocument: Text): Text
    var
        ServiceRequest: Record "A01 Service Request";
    begin

        ServiceRequest.Get(NoDocument);

        ServiceRequest.Delete(true);

        exit(Ws.CreateResponseSuccess(ServiceRequest."No."));

    end;


    local procedure Process_SRSparePart_Lines(ServiceRequest: Record "A01 Service Request"; input: JsonObject)
    var
        SRSparePart: Record "A01 SR Spare Part";
        c: JsonToken;
        LinesArray: JsonArray;
        LineInput: JsonObject;
    begin
        SRSparePart.Reset();
        SRSparePart.SetRange("Service Request No.", ServiceRequest."No.");
        SRSparePart.SetRange("Spare Status", SRSparePart."Spare Status"::" ");
        if (not SRSparePart.IsEmpty) then
            SRSparePart.DeleteAll();

        input.Get('SRSparePart', c);
        LinesArray := c.AsArray();
        foreach c in LinesArray do begin
            LineInput := c.AsObject();
            SRSparePart.Init();
            Process_SRSparePart(ServiceRequest, SRSparePart, LineInput);
            SRSparePart.Insert();
        end;
    end;

    local procedure Process_SRDefectivePart_Lines(ServiceRequest: Record "A01 Service Request"; input: JsonObject)
    var
        SRSparePart: Record "A01 SR Spare Part";
        c: JsonToken;
        LinesArray: JsonArray;
        LineInput: JsonObject;
    begin
        SRSparePart.Reset();
        SRSparePart.SetRange("Service Request No.", ServiceRequest."No.");
        SRSparePart.SetRange("Spare Status", SRSparePart."Spare Status"::Defective);
        if (not SRSparePart.IsEmpty) then
            SRSparePart.DeleteAll();

        input.Get('SRDefectivePart', c);
        LinesArray := c.AsArray();
        foreach c in LinesArray do begin
            LineInput := c.AsObject();
            SRSparePart.Init();
            Process_SRDefectivePart(ServiceRequest, SRSparePart, LineInput);
            SRSparePart.Insert();
        end;
    end;

    local procedure Process_SRItemMovement_Lines(ServiceRequest: Record "A01 Service Request"; input: JsonObject)
    var
        SRItemMvt: Record "A01 SR Item Movement";
        c: JsonToken;
        LinesArray: JsonArray;
        LineInput: JsonObject;
    begin
        SRItemMvt.Reset();
        SRItemMvt.SetRange("Service Request No.", ServiceRequest."No.");
        if (not SRItemMvt.IsEmpty) then
            SRItemMvt.DeleteAll();

        input.Get('SRItemMovement', c);
        LinesArray := c.AsArray();
        foreach c in LinesArray do begin
            LineInput := c.AsObject();
            SRItemMvt.Init();
            Process_SRItemMovement(ServiceRequest, SRItemMvt, LineInput);
            SRItemMvt.Insert();
        end;
    end;

    local procedure Process_SRSalesDocument_Lines(ServiceRequest: Record "A01 Service Request"; input: JsonObject)
    var
        SRSalesDocument: Record "A01 SR Sales Document";
        c: JsonToken;
        LinesArray: JsonArray;
        LineInput: JsonObject;
    begin
        SRSalesDocument.Reset();
        SRSalesDocument.SetRange("Service Request No.", ServiceRequest."No.");
        if (not SRSalesDocument.IsEmpty) then
            SRSalesDocument.DeleteAll();

        input.Get('SRSalesDocument', c);
        LinesArray := c.AsArray();
        foreach c in LinesArray do begin
            LineInput := c.AsObject();
            SRSalesDocument.Init();
            Process_SRSalesDocument(ServiceRequest, SRSalesDocument, LineInput);
            SRSalesDocument.Insert();
        end;
    end;

    local procedure Process_SRAssignmentFlow_Lines(ServiceRequest: Record "A01 Service Request"; input: JsonObject)
    var
        SRAssignmentFlow: Record "A01 SR Assignment Flow";
        c: JsonToken;
        LinesArray: JsonArray;
        LineInput: JsonObject;
    begin
        SRAssignmentFlow.Reset();
        SRAssignmentFlow.SetRange("Service Request No.", ServiceRequest."No.");
        if (not SRAssignmentFlow.IsEmpty) then
            SRAssignmentFlow.DeleteAll();

        input.Get('SRAssignmentFlow', c);
        LinesArray := c.AsArray();
        foreach c in LinesArray do begin
            LineInput := c.AsObject();
            SRAssignmentFlow.Init();
            Process_SRAssignmentFlow(ServiceRequest, SRAssignmentFlow, LineInput);
            SRAssignmentFlow.Insert();
        end;
    end;

















    local procedure ProcessOrderTransport(var TransportOrder: Record "A01 Transport Order"; input: JsonObject)
    var
        jsonkey: text;
    begin

        jsonkey := 'webUserName';
        if (WS.KeyExists(jsonkey, input)) then
            if (TransportOrder."Web User Id" <> WS.GetText(jsonkey, input)) then
                TransportOrder.Validate("Web User Id", WS.GetText(jsonkey, input));

        jsonkey := 'TransportOrder Status';
        if (WS.KeyExists(jsonkey, input)) then
            if (TransportOrder."TransportOrder Status".AsInteger() <> WS.GetInt(jsonkey, input)) then
                TransportOrder.Validate("TransportOrder Status", WS.GetInt(jsonkey, input));

        jsonkey := 'Carrier No_';
        if (WS.KeyExists(jsonkey, input)) then
            if (TransportOrder."Carrier No." <> WS.GetText(jsonkey, input)) then
                TransportOrder.Validate("Carrier No.", WS.GetText(jsonkey, input));

        jsonkey := 'Vehicle No_';
        if (WS.KeyExists(jsonkey, input)) then
            if (TransportOrder."Vehicle No." <> WS.GetText(jsonkey, input)) then
                TransportOrder.Validate("Vehicle No.", WS.GetText(jsonkey, input));

        jsonkey := 'Driver No_';
        if (WS.KeyExists(jsonkey, input)) then
            if (TransportOrder." Driver No." <> WS.GetText(jsonkey, input)) then
                TransportOrder.Validate(" Driver No.", WS.GetText(jsonkey, input));

        jsonkey := 'Route No_';
        if (WS.KeyExists(jsonkey, input)) then
            if (TransportOrder."Route No." <> WS.GetText(jsonkey, input)) then
                TransportOrder.Validate("Route No.", WS.GetText(jsonkey, input));

        jsonkey := 'Departure Date (Planned)';
        if (WS.KeyExists(jsonkey, input)) then
            if (TransportOrder."Departure Date (Planned)" <> WS.GetDateTime(jsonkey, input)) then
                TransportOrder.Validate("Departure Date (Planned)", WS.GetDateTime(jsonkey, input));

        jsonkey := 'Duration (Planned)';
        if (TransportOrder."Duration (Planned)" <> WS.GetInt(jsonkey, input)) then
            TransportOrder.Validate("Duration (Planned)", WS.GetInt(jsonkey, input));

        jsonkey := 'Return Date (Planned)';
        if (WS.KeyExists(jsonkey, input)) then
            if (TransportOrder."Return Date (Planned)" <> WS.GetDateTime(jsonkey, input)) then
                TransportOrder.Validate("Return Date (Planned)", WS.GetDateTime(jsonkey, input));

        jsonkey := 'Departure Date (Actual)';
        if (WS.KeyExists(jsonkey, input)) then
            if (TransportOrder."Departure Date (Actual)" <> WS.GetDateTime(jsonkey, input)) then
                TransportOrder.Validate("Departure Date (Actual)", WS.GetDateTime(jsonkey, input));

        jsonkey := 'Return Date (Actual)';
        if (WS.KeyExists(jsonkey, input)) then
            if (TransportOrder."Return Date (Actual)" <> WS.GetDateTime(jsonkey, input)) then
                TransportOrder.Validate("Return Date (Actual)", WS.GetDateTime(jsonkey, input));

        jsonkey := 'Duration (Actual)';
        if (WS.KeyExists(jsonkey, input)) then
            if (TransportOrder."Duration (Actual)" <> WS.GetInt(jsonkey, input)) then
                TransportOrder.Validate("Duration (Actual)", WS.GetInt(jsonkey, input));

        jsonkey := 'Useful volume (cbm)';
        if (WS.KeyExists(jsonkey, input)) then
            if (TransportOrder."Useful volume (cbm)" <> WS.GetDecimal(jsonkey, input)) then
                TransportOrder.Validate("Useful volume (cbm)", WS.GetDecimal(jsonkey, input));

        jsonkey := 'Payload (kg)';
        if (WS.KeyExists(jsonkey, input)) then
            if (TransportOrder."Payload (kg)" <> WS.GetDecimal(jsonkey, input)) then
                TransportOrder.Validate("Payload (kg)", WS.GetDecimal(jsonkey, input));

        jsonkey := 'Outbound Package Count';
        if (WS.KeyExists(jsonkey, input)) then
            if (TransportOrder."Outbound Package Count" <> WS.GetDecimal(jsonkey, input)) then
                TransportOrder.Validate("Outbound Package Count", WS.GetDecimal(jsonkey, input));

        jsonkey := 'Outbound Volume Loaded (cbm)';
        if (WS.KeyExists(jsonkey, input)) then
            if (TransportOrder."Outbound Volume Loaded (cbm)" <> WS.GetDecimal(jsonkey, input)) then
                TransportOrder.Validate("Outbound Volume Loaded (cbm)", WS.GetDecimal(jsonkey, input));

        jsonkey := 'Outbound Weight Load (Kg)';
        if (WS.KeyExists(jsonkey, input)) then
            if (TransportOrder."Outbound Weight Load (Kg)" <> WS.GetDecimal(jsonkey, input)) then
                TransportOrder.Validate("Outbound Weight Load (Kg)", WS.GetDecimal(jsonkey, input));

        jsonkey := 'Outbound Unloading Dura (Plan)';
        if (WS.KeyExists(jsonkey, input)) then
            if (TransportOrder."Outbound Unloading Dura (Plan)" <> WS.GetDecimal(jsonkey, input)) then
                TransportOrder.Validate("Outbound Unloading Dura (Plan)", WS.GetDecimal(jsonkey, input));

        jsonkey := 'Inbound Package Count';
        if (WS.KeyExists(jsonkey, input)) then
            if (TransportOrder."Inbound Package Count" <> WS.GetDecimal(jsonkey, input)) then
                TransportOrder.Validate("Inbound Package Count", WS.GetDecimal(jsonkey, input));

        jsonkey := 'Inbound Weight Load (Kg)';
        if (WS.KeyExists(jsonkey, input)) then
            if (TransportOrder."Inbound Weight Load (Kg)" <> WS.GetDecimal(jsonkey, input)) then
                TransportOrder.Validate("Inbound Weight Load (Kg)", WS.GetDecimal(jsonkey, input));

        jsonkey := 'Inbound Unloading Dura (Plan)';
        if (WS.KeyExists(jsonkey, input)) then
            if (TransportOrder."Inbound Unloading Dura (Plan)" <> WS.GetDecimal(jsonkey, input)) then
                TransportOrder.Validate("Inbound Unloading Dura (Plan)", WS.GetDecimal(jsonkey, input));


        jsonkey := 'Delivery Agent';
        if (WS.KeyExists(jsonkey, input)) then
            if (TransportOrder."Delivery Agent" <> WS.GetText(jsonkey, input)) then
                TransportOrder.Validate("Delivery Agent", WS.GetText(jsonkey, input));

        jsonkey := 'Initial Location';
        if (WS.KeyExists(jsonkey, input)) then
            if (TransportOrder."Initial Location" <> WS.GetText(jsonkey, input)) then
                TransportOrder.Validate("Initial Location", WS.GetText(jsonkey, input));

    end;

    local procedure ProcessOrderTransportLine(TransportOrder: Record "A01 Transport Order"; var TransportOrderDetail: Record "A01 Transport Order Detail"; input: JsonObject)
    var
        jsonkey: text;
    begin

        if (TransportOrderDetail."Transport Order No." <> TransportOrder."No.") then
            TransportOrderDetail."Transport Order No." := TransportOrder."No.";

        jsonkey := 'Line No_';
        if (WS.KeyExists(jsonkey, input)) then
            if (TransportOrderDetail."Line No." <> WS.GetInt(jsonkey, input)) then
                TransportOrderDetail."Line No." := WS.GetInt(jsonkey, input);

        jsonkey := 'Order Line No_';
        if (WS.KeyExists(jsonkey, input)) then
            if (TransportOrderDetail."Order Line No." <> WS.GetInt(jsonkey, input)) then
                TransportOrderDetail."Order Line No." := WS.GetInt(jsonkey, input);

        jsonkey := 'Order No_';
        if (WS.KeyExists(jsonkey, input)) then
            if (TransportOrderDetail."Order No." <> WS.GetText(jsonkey, input)) then
                TransportOrderDetail.Validate("Order No.", WS.GetText(jsonkey, input));

        jsonkey := 'Customer No_';
        if (WS.KeyExists(jsonkey, input)) then
            if (TransportOrderDetail."Customer No." <> WS.GetText(jsonkey, input)) then
                TransportOrderDetail.Validate("Customer No.", WS.GetText(jsonkey, input));

        jsonkey := 'Address Code';
        if (WS.KeyExists(jsonkey, input)) then
            if (TransportOrderDetail."Address Code" <> WS.GetText(jsonkey, input)) then
                TransportOrderDetail.Validate("Address Code", WS.GetText(jsonkey, input));

        jsonkey := 'Time preference';
        if (WS.KeyExists(jsonkey, input)) then
            if (TransportOrderDetail."Time preference".AsInteger() <> WS.GetInt(jsonkey, input)) then
                TransportOrderDetail.Validate("Time preference", WS.GetInt(jsonkey, input));

        jsonkey := 'Transport Direction';
        if (WS.KeyExists(jsonkey, input)) then
            if (TransportOrderDetail."Transport Direction".AsInteger() <> WS.GetInt(jsonkey, input)) then
                TransportOrderDetail.Validate("Transport Direction", WS.GetInt(jsonkey, input));

        jsonkey := 'Item No_';
        if (WS.KeyExists(jsonkey, input)) then
            if (TransportOrderDetail."Item No." <> WS.GetText(jsonkey, input)) then
                TransportOrderDetail.Validate("Item No.", WS.GetText(jsonkey, input));

        jsonkey := 'Unit of Mesure Code';
        if (WS.KeyExists(jsonkey, input)) then
            if (TransportOrderDetail."Unit of Mesure Code" <> WS.GetText(jsonkey, input)) then
                TransportOrderDetail.Validate("Unit of Mesure Code", WS.GetText(jsonkey, input));

        jsonkey := 'Quantity (Planned)';
        if (WS.KeyExists(jsonkey, input)) then
            if (TransportOrderDetail."Quantity (Planned)" <> WS.GetDecimal(jsonkey, input)) then
                TransportOrderDetail.Validate("Quantity (Planned)", WS.GetDecimal(jsonkey, input));

        jsonkey := 'Unloading Duration';
        if (WS.KeyExists(jsonkey, input)) then
            if (TransportOrderDetail."Unloading Duration" <> WS.GetDecimal(jsonkey, input)) then
                TransportOrderDetail.Validate("Unloading Duration", WS.GetDecimal(jsonkey, input));

        jsonkey := 'Total Volume (cbm)';
        if (WS.KeyExists(jsonkey, input)) then
            if (TransportOrderDetail."Total Volume (cbm)" <> WS.GetDecimal(jsonkey, input)) then
                TransportOrderDetail.Validate("Total Volume (cbm)", WS.GetDecimal(jsonkey, input));

        jsonkey := 'Total Weight (Kg)';
        if (WS.KeyExists(jsonkey, input)) then
            if (TransportOrderDetail."Total Weight (Kg)" <> WS.GetDecimal(jsonkey, input)) then
                TransportOrderDetail.Validate("Total Weight (Kg)", WS.GetDecimal(jsonkey, input));

        jsonkey := 'Total Weight (Kg)';
        if (WS.KeyExists(jsonkey, input)) then
            if (TransportOrderDetail."Total Weight (Kg)" <> WS.GetDecimal(jsonkey, input)) then
                TransportOrderDetail.Validate("Total Weight (Kg)", WS.GetDecimal(jsonkey, input));

        jsonkey := 'Quantity (Actual)';
        if (WS.KeyExists(jsonkey, input)) then
            if (TransportOrderDetail."Quantity (Actual)" <> WS.GetDecimal(jsonkey, input)) then
                TransportOrderDetail.Validate("Quantity (Actual)", WS.GetDecimal(jsonkey, input));

        jsonkey := 'Quantity (Gap)';
        if (WS.KeyExists(jsonkey, input)) then
            if (TransportOrderDetail."Quantity (Gap)" <> WS.GetDecimal(jsonkey, input)) then
                TransportOrderDetail.Validate("Quantity (Gap)", WS.GetDecimal(jsonkey, input));

        jsonkey := 'Gap Reason Code';
        if (WS.KeyExists(jsonkey, input)) then
            if (TransportOrderDetail."Gap Reason Code" <> WS.GetText(jsonkey, input)) then
                TransportOrderDetail.Validate("Gap Reason Code", WS.GetText(jsonkey, input));

        jsonkey := 'Anomaly Type';
        if (WS.KeyExists(jsonkey, input)) then
            if (TransportOrderDetail."Anomaly Type".AsInteger() <> WS.GetInt(jsonkey, input)) then
                TransportOrderDetail.Validate("Anomaly Type", WS.GetInt(jsonkey, input));

        jsonkey := 'Anomaly Description';
        if (WS.KeyExists(jsonkey, input)) then
            if (TransportOrderDetail."Anomaly Description" <> WS.GetText(jsonkey, input)) then
                TransportOrderDetail.Validate("Anomaly Description", WS.GetText(jsonkey, input));

        jsonkey := 'Location Code';
        if (WS.KeyExists(jsonkey, input)) then
            if (TransportOrderDetail."Location Code" <> WS.GetText(jsonkey, input)) then
                TransportOrderDetail.Validate("Location Code", WS.GetText(jsonkey, input));

        jsonkey := 'Return Status';
        if (WS.KeyExists(jsonkey, input)) then
            if (TransportOrderDetail."Return Status".AsInteger() <> WS.GetInt(jsonkey, input)) then
                TransportOrderDetail.Validate("Return Status", WS.GetInt(jsonkey, input));

        jsonkey := 'Order Type';
        if (WS.KeyExists(jsonkey, input)) then
            if (TransportOrderDetail."Order Type".AsInteger() <> WS.GetInt(jsonkey, input)) then
                TransportOrderDetail.Validate("Order Type", WS.GetInt(jsonkey, input));

        jsonkey := 'Service Zone';
        if (WS.KeyExists(jsonkey, input)) then
            if (TransportOrderDetail."Service Zone" <> WS.GetText(jsonkey, input)) then
                TransportOrderDetail.Validate("Service Zone", WS.GetText(jsonkey, input));

    end;

    local procedure ProcessServiceRequest(var ServiceRequest: Record "A01 Service Request"; input: JsonObject)
    var
        jsonkey: text;
    begin

        jsonkey := 'webUserName';
        if (WS.KeyExists(jsonkey, input)) then
            if (ServiceRequest."Web User Id" <> WS.GetText(jsonkey, input)) then
                ServiceRequest.Validate("Web User Id", WS.GetText(jsonkey, input));

        jsonkey := 'Service Request Status';
        if (WS.KeyExists(jsonkey, input)) then
            if (ServiceRequest."Service Request Status".AsInteger() <> WS.GetInt(jsonkey, input)) then
                ServiceRequest.Validate("Service Request Status", WS.GetInt(jsonkey, input));

        jsonkey := 'Customer No_';
        if (WS.KeyExists(jsonkey, input)) then
            if (ServiceRequest."Customer No." <> WS.GetText(jsonkey, input)) then
                ServiceRequest.Validate("Customer No.", WS.GetText(jsonkey, input));

        jsonkey := 'Warranty Status';
        if (WS.KeyExists(jsonkey, input)) then
            if (ServiceRequest."Warranty Status" <> WS.GetBool(jsonkey, input)) then
                ServiceRequest.Validate("Warranty Status", WS.GetBool(jsonkey, input));

        jsonkey := 'Contrat No_';
        if (WS.KeyExists(jsonkey, input)) then
            if (ServiceRequest."Contrat No." <> WS.GetText(jsonkey, input)) then
                ServiceRequest.Validate("Contrat No.", WS.GetText(jsonkey, input));

        jsonkey := 'Item No_';
        if (WS.KeyExists(jsonkey, input)) then
            if (ServiceRequest."Item No." <> WS.GetText(jsonkey, input)) then
                ServiceRequest.Validate("Item No.", WS.GetText(jsonkey, input));

        jsonkey := 'Reference';
        if (WS.KeyExists(jsonkey, input)) then
            if (ServiceRequest.Reference <> WS.GetText(jsonkey, input)) then
                ServiceRequest.Validate("Reference", WS.GetText(jsonkey, input));

        jsonkey := 'Warranty End Date';
        if (ServiceRequest."Warranty End Date" <> WS.GetDate(jsonkey, input)) then
            ServiceRequest.Validate("Warranty End Date", WS.GetDate(jsonkey, input));

        jsonkey := 'Created On';
        if (WS.KeyExists(jsonkey, input)) then
            if (ServiceRequest."Created On" <> WS.GetDate(jsonkey, input)) then
                ServiceRequest.Validate("Created On", WS.GetDate(jsonkey, input));

        jsonkey := 'Created By';
        if (WS.KeyExists(jsonkey, input)) then
            if (ServiceRequest."Created By" <> WS.GetText(jsonkey, input)) then
                ServiceRequest.Validate("Created By", WS.GetText(jsonkey, input));

        jsonkey := 'Closed On';
        if (WS.KeyExists(jsonkey, input)) then
            if (ServiceRequest."Closed On" <> WS.GetDatetime(jsonkey, input)) then
                ServiceRequest.Validate("Closed On", WS.GetDatetime(jsonkey, input));

        jsonkey := 'Closed By';
        if (WS.KeyExists(jsonkey, input)) then
            if (ServiceRequest."Closed By" <> WS.GetText(jsonkey, input)) then
                ServiceRequest.Validate("Closed By", WS.GetText(jsonkey, input));




        //******************
        jsonkey := 'Responsibility Center';
        if (WS.KeyExists(jsonkey, input)) then
            if (ServiceRequest."Responsibility Center" <> WS.GetText(jsonkey, input)) then
                ServiceRequest.Validate("Responsibility Center", WS.GetText(jsonkey, input));

        jsonkey := 'Ship-to Code';
        if (WS.KeyExists(jsonkey, input)) then
            if (ServiceRequest."Ship-to Code" <> WS.GetText(jsonkey, input)) then
                ServiceRequest.Validate("Ship-to Code", WS.GetText(jsonkey, input));

        jsonkey := 'Contact No_';
        if (WS.KeyExists(jsonkey, input)) then
            if (ServiceRequest."Contact No." <> WS.GetText(jsonkey, input)) then
                ServiceRequest.Validate("Contact No.", WS.GetText(jsonkey, input));

        jsonkey := 'Serial No_';
        if (WS.KeyExists(jsonkey, input)) then
            if (ServiceRequest."Serial No." <> WS.GetText(jsonkey, input)) then
                ServiceRequest.Validate("Serial No.", WS.GetText(jsonkey, input));

        jsonkey := 'IMEI No_';
        if (WS.KeyExists(jsonkey, input)) then
            if (ServiceRequest."IMEI No." <> WS.GetText(jsonkey, input)) then
                ServiceRequest.Validate("IMEI No.", WS.GetText(jsonkey, input));

        jsonkey := 'Sales Doc. No_';
        if (WS.KeyExists(jsonkey, input)) then
            if (ServiceRequest."Sales Doc. No." <> WS.GetText(jsonkey, input)) then
                ServiceRequest.Validate("Sales Doc. No.", WS.GetText(jsonkey, input));

        jsonkey := 'Description';
        if (WS.KeyExists(jsonkey, input)) then
            if (ServiceRequest."Description" <> WS.GetText(jsonkey, input)) then
                ServiceRequest.Validate("Description", WS.GetText(jsonkey, input));

        jsonkey := 'Item Accessories';
        if (WS.KeyExists(jsonkey, input)) then
            if (ServiceRequest."Item Accessories" <> WS.GetText(jsonkey, input)) then
                ServiceRequest.Validate("Item Accessories", WS.GetText(jsonkey, input));

        jsonkey := 'Observations';
        if (WS.KeyExists(jsonkey, input)) then
            if (ServiceRequest."Observations" <> WS.GetText(jsonkey, input)) then
                ServiceRequest.Validate("Observations", WS.GetText(jsonkey, input));

        jsonkey := 'SR Type';
        if (WS.KeyExists(jsonkey, input)) then
            if (ServiceRequest."SR Type".AsInteger() <> WS.GetInt(jsonkey, input)) then
                ServiceRequest.Validate("SR Type", WS.GetInt(jsonkey, input));

        jsonkey := 'SR Origin';
        if (WS.KeyExists(jsonkey, input)) then
            if (ServiceRequest."SR Origin".AsInteger() <> WS.GetInt(jsonkey, input)) then
                ServiceRequest.Validate("SR Origin", WS.GetInt(jsonkey, input));


        jsonkey := 'Diagnostic Report';
        if (WS.KeyExists(jsonkey, input)) then
            if (ServiceRequest."Diagnostic Report" <> WS.GetText(jsonkey, input)) then
                ServiceRequest.Validate("Diagnostic Report", WS.GetText(jsonkey, input));

        jsonkey := 'Repair Report';
        if (WS.KeyExists(jsonkey, input)) then
            if (ServiceRequest."Repair Report" <> WS.GetText(jsonkey, input)) then
                ServiceRequest.Validate("Repair Report", WS.GetText(jsonkey, input));

        jsonkey := 'Sales Doc. Date';
        if (WS.KeyExists(jsonkey, input)) then
            if (ServiceRequest."Sales Doc. Date" <> WS.GetDate(jsonkey, input)) then
                ServiceRequest.Validate("Sales Doc. Date", WS.GetDate(jsonkey, input));

    end;

    local procedure Process_SRItemMovement(ServiceRequest: Record "A01 Service Request"; var SRItemMvt: Record "A01 SR Item Movement"; input: JsonObject)
    var
        jsonkey: text;
    begin

        if (SRItemMvt."Service Request No." <> ServiceRequest."No.") then
            SRItemMvt."Service Request No." := ServiceRequest."No.";

        jsonkey := 'Movement Date';
        if (WS.KeyExists(jsonkey, input)) then
            if (SRItemMvt."Movement Date" <> WS.GetDate(jsonkey, input)) then
                SRItemMvt.Validate("Movement Date", WS.GetDate(jsonkey, input));

        jsonkey := 'Line No_';
        if (WS.KeyExists(jsonkey, input)) then
            if (SRItemMvt."Line No." <> WS.GetInt(jsonkey, input)) then
                SRItemMvt.Validate("Line No.", WS.GetInt(jsonkey, input));

        jsonkey := 'Movement Type';
        if (WS.KeyExists(jsonkey, input)) then
            if (SRItemMvt."Movement Type".AsInteger() <> WS.GetInt(jsonkey, input)) then
                SRItemMvt.Validate("Movement Type", WS.GetInt(jsonkey, input));


        jsonkey := 'From Location Code';
        if (WS.KeyExists(jsonkey, input)) then
            if (SRItemMvt."From Location Code" <> WS.GetText(jsonkey, input)) then
                SRItemMvt.Validate("From Location Code", WS.GetText(jsonkey, input));

        jsonkey := 'From Bin Code';
        if (WS.KeyExists(jsonkey, input)) then
            if (SRItemMvt."From Bin Code" <> WS.GetText(jsonkey, input)) then
                SRItemMvt.Validate("From Bin Code", WS.GetText(jsonkey, input));

        jsonkey := 'To Location Code';
        if (WS.KeyExists(jsonkey, input)) then
            if (SRItemMvt."To Location Code" <> WS.GetText(jsonkey, input)) then
                SRItemMvt.Validate("To Location Code", WS.GetText(jsonkey, input));

        jsonkey := 'To Bin Code';
        if (WS.KeyExists(jsonkey, input)) then
            if (SRItemMvt."To Bin Code" <> WS.GetText(jsonkey, input)) then
                SRItemMvt.Validate("To Bin Code", WS.GetText(jsonkey, input));

        jsonkey := 'Movement Description';
        if (WS.KeyExists(jsonkey, input)) then
            if (SRItemMvt."Movement Description" <> WS.GetText(jsonkey, input)) then
                SRItemMvt.Validate("Movement Description", WS.GetText(jsonkey, input));
    end;

    local procedure Process_SRSparePart(ServiceRequest: Record "A01 Service Request"; var SRSparePart: Record "A01 SR Spare Part"; input: JsonObject)
    var
        jsonkey: text;
    begin

        SRSparePart."Spare Status" := SRSparePart."Spare Status"::" ";

        if (SRSparePart."Service Request No." <> ServiceRequest."No.") then
            SRSparePart."Service Request No." := ServiceRequest."No.";

        jsonkey := 'Line No_';
        if (WS.KeyExists(jsonkey, input)) then
            if (SRSparePart."Line No." <> WS.GetInt(jsonkey, input)) then
                SRSparePart.Validate("Line No.", WS.GetInt(jsonkey, input));

        jsonkey := 'Item No_';
        if (WS.KeyExists(jsonkey, input)) then
            if (SRSparePart."Item No." <> WS.GetText(jsonkey, input)) then
                SRSparePart.Validate("Item No.", WS.GetText(jsonkey, input));

        jsonkey := 'Unit of Measure Code';
        if (WS.KeyExists(jsonkey, input)) then
            if (SRSparePart."Unit of Measure Code" <> WS.GetText(jsonkey, input)) then
                SRSparePart.Validate("Unit of Measure Code", WS.GetText(jsonkey, input));

        jsonkey := 'Description';
        if (WS.KeyExists(jsonkey, input)) then
            if (SRSparePart."Description" <> WS.GetText(jsonkey, input)) then
                SRSparePart.Validate("Description", WS.GetText(jsonkey, input));

        jsonkey := 'Quantity';
        if (WS.KeyExists(jsonkey, input)) then
            if (SRSparePart."Quantity" <> WS.GetDecimal(jsonkey, input)) then
                SRSparePart.Validate("Quantity", WS.GetDecimal(jsonkey, input));

        jsonkey := 'Usage Status';
        if (WS.KeyExists(jsonkey, input)) then
            if (SRSparePart."Usage Status".AsInteger() <> WS.GetInt(jsonkey, input)) then
                SRSparePart.Validate("Usage Status", WS.GetInt(jsonkey, input));

        jsonkey := 'Usage';
        if (WS.KeyExists(jsonkey, input)) then
            if (SRSparePart."Usage" <> WS.GetText(jsonkey, input)) then
                SRSparePart.Validate("Usage", WS.GetText(jsonkey, input));

    end;

    local procedure Process_SRDefectivePart(ServiceRequest: Record "A01 Service Request"; var SRSparePart: Record "A01 SR Spare Part"; input: JsonObject)
    var
        jsonkey: text;
    begin

        SRSparePart."Spare Status" := SRSparePart."Spare Status"::Defective;

        if (SRSparePart."Service Request No." <> ServiceRequest."No.") then
            SRSparePart."Service Request No." := ServiceRequest."No.";

        jsonkey := 'Line No_';
        if (WS.KeyExists(jsonkey, input)) then
            if (SRSparePart."Line No." <> WS.GetInt(jsonkey, input)) then
                SRSparePart.Validate("Line No.", WS.GetInt(jsonkey, input));

        jsonkey := 'Item No_';
        if (WS.KeyExists(jsonkey, input)) then
            if (SRSparePart."Item No." <> WS.GetText(jsonkey, input)) then
                SRSparePart.Validate("Item No.", WS.GetText(jsonkey, input));

        jsonkey := 'Unit of Measure Code';
        if (WS.KeyExists(jsonkey, input)) then
            if (SRSparePart."Unit of Measure Code" <> WS.GetText(jsonkey, input)) then
                SRSparePart.Validate("Unit of Measure Code", WS.GetText(jsonkey, input));

        jsonkey := 'Description';
        if (WS.KeyExists(jsonkey, input)) then
            if (SRSparePart."Description" <> WS.GetText(jsonkey, input)) then
                SRSparePart.Validate("Description", WS.GetText(jsonkey, input));

        jsonkey := 'Quantity';
        if (WS.KeyExists(jsonkey, input)) then
            if (SRSparePart."Quantity" <> WS.GetDecimal(jsonkey, input)) then
                SRSparePart.Validate("Quantity", WS.GetDecimal(jsonkey, input));

        jsonkey := 'Observation';
        if (WS.KeyExists(jsonkey, input)) then
            if (SRSparePart."Observations" <> WS.GetText(jsonkey, input)) then
                SRSparePart.Validate("Observations", WS.GetText(jsonkey, input));


        // jsonkey := 'Usage Status';
        // if (WS.KeyExists(jsonkey, input)) then
        //     if (SRSparePart."Usage Status".AsInteger() <> WS.GetInt(jsonkey, input)) then
        //         SRSparePart.Validate("Usage Status", WS.GetInt(jsonkey, input));

        // jsonkey := 'Usage';
        // if (WS.KeyExists(jsonkey, input)) then
        //     if (SRSparePart."Usage" <> WS.GetText(jsonkey, input)) then
        //         SRSparePart.Validate("Usage", WS.GetText(jsonkey, input));

    end;

    local procedure Process_SRSalesDocument(ServiceRequest: Record "A01 Service Request"; var SRSalesDocument: Record "A01 SR Sales Document"; input: JsonObject)
    var
        jsonkey: text;
    begin

        if (SRSalesDocument."Service Request No." <> ServiceRequest."No.") then
            SRSalesDocument."Service Request No." := ServiceRequest."No.";

        jsonkey := 'Line No_';
        if (WS.KeyExists(jsonkey, input)) then
            if (SRSalesDocument."Line No." <> WS.GetInt(jsonkey, input)) then
                SRSalesDocument.Validate("Line No.", WS.GetInt(jsonkey, input));

        jsonkey := 'Document Type';
        if (WS.KeyExists(jsonkey, input)) then
            if (SRSalesDocument."Document Type".AsInteger() <> WS.GetInt(jsonkey, input)) then
                SRSalesDocument.Validate("Document Type", WS.GetInt(jsonkey, input));

        jsonkey := 'Document Date';
        if (WS.KeyExists(jsonkey, input)) then
            if (SRSalesDocument."Document Date" <> WS.GetDate(jsonkey, input)) then
                SRSalesDocument.Validate("Document Date", WS.GetDate(jsonkey, input));

        jsonkey := 'Document Amount';
        if (WS.KeyExists(jsonkey, input)) then
            if (SRSalesDocument."Document Amount" <> WS.GetDecimal(jsonkey, input)) then
                SRSalesDocument.Validate("Document Amount", WS.GetDecimal(jsonkey, input));

        jsonkey := 'Processing Status';
        if (WS.KeyExists(jsonkey, input)) then
            if (SRSalesDocument."Processing Status".AsInteger() <> WS.GetInt(jsonkey, input)) then
                SRSalesDocument.Validate("Processing Status", WS.GetInt(jsonkey, input));

    end;

    local procedure Process_SRAssignmentFlow(ServiceRequest: Record "A01 Service Request"; var SRAssignmentFlow: Record "A01 SR Assignment Flow"; input: JsonObject)
    var
        jsonkey: text;
    begin

        if (SRAssignmentFlow."Service Request No." <> ServiceRequest."No.") then
            SRAssignmentFlow."Service Request No." := ServiceRequest."No.";

        jsonkey := 'Line No_';
        if (WS.KeyExists(jsonkey, input)) then
            if (SRAssignmentFlow."Line No." <> WS.GetInt(jsonkey, input)) then
                SRAssignmentFlow.Validate("Line No.", WS.GetInt(jsonkey, input));

        jsonkey := 'Assigned On';
        if (WS.KeyExists(jsonkey, input)) then
            if (SRAssignmentFlow."Assigned On" <> WS.GetDate(jsonkey, input)) then
                SRAssignmentFlow.Validate("Assigned On", WS.GetDate(jsonkey, input));

        jsonkey := 'Assigned By';
        if (WS.KeyExists(jsonkey, input)) then
            if (SRAssignmentFlow."Assigned By" <> WS.GetText(jsonkey, input)) then
                SRAssignmentFlow.Validate("Assigned By", WS.GetText(jsonkey, input));

        jsonkey := 'Current Status';
        if (WS.KeyExists(jsonkey, input)) then
            if (SRAssignmentFlow."Current Status".AsInteger() <> WS.GetInt(jsonkey, input)) then
                SRAssignmentFlow.Validate("Current Status", WS.GetInt(jsonkey, input));

        jsonkey := 'Assigned To';
        if (WS.KeyExists(jsonkey, input)) then
            if (SRAssignmentFlow."Assigned To" <> WS.GetText(jsonkey, input)) then
                SRAssignmentFlow.Validate("Assigned To", WS.GetText(jsonkey, input));

        jsonkey := 'Next Status';
        if (WS.KeyExists(jsonkey, input)) then
            if (SRAssignmentFlow."Next Status".AsInteger() <> WS.GetInt(jsonkey, input)) then
                SRAssignmentFlow.Validate("Next Status", WS.GetInt(jsonkey, input));

        jsonkey := 'Notes';
        if (WS.KeyExists(jsonkey, input)) then
            if (SRAssignmentFlow."Notes" <> WS.GetText(jsonkey, input)) then
                SRAssignmentFlow.Validate("Notes", WS.GetText(jsonkey, input));

        jsonkey := 'Starting Date';
        if (WS.KeyExists(jsonkey, input)) then
            if (SRAssignmentFlow."Starting Date" <> WS.GetDatetime(jsonkey, input)) then
                SRAssignmentFlow.Validate("Starting Date", WS.GetDatetime(jsonkey, input));

        jsonkey := 'Deadline';
        if (WS.KeyExists(jsonkey, input)) then
            if (SRAssignmentFlow."Deadline" <> WS.GetDatetime(jsonkey, input)) then
                SRAssignmentFlow.Validate("Deadline", WS.GetDatetime(jsonkey, input));

    end;

}
