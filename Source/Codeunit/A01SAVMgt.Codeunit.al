codeunit 50022 A01SAVMgt
{
    var
        WS: codeunit "A01 Api Mgt";
        LblErrorQuoteNotExists: Label 'The Quote N° %1 does not exists', Comment = '%1 = QuoteNo';



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
            if (TransportOrder."Carrier No." <> WS.GetText('Carrier No_', input)) then
                TransportOrder.Validate("Carrier No.", WS.GetText('Carrier No_', input));

        jsonkey := 'Vehicle No_';
        if (WS.KeyExists(jsonkey, input)) then
            if (TransportOrder."Vehicle No." <> WS.GetText('Vehicle No_', input)) then
                TransportOrder.Validate("Vehicle No.", WS.GetText('Vehicle No_', input));

        jsonkey := 'Driver No_';
        if (WS.KeyExists(jsonkey, input)) then
            if (TransportOrder." Driver No." <> WS.GetText('Driver No_', input)) then
                TransportOrder.Validate(" Driver No.", WS.GetText('Driver No_', input));

        jsonkey := 'Route No_';
        if (WS.KeyExists(jsonkey, input)) then
            if (TransportOrder."Route No." <> WS.GetText('Route No_', input)) then
                TransportOrder.Validate("Route No.", WS.GetText('Route No_', input));

        jsonkey := 'Departure Date (Planned)';
        if (WS.KeyExists(jsonkey, input)) then
            if (TransportOrder."Departure Date (Planned)" <> WS.GetDateTime('Departure Date (Planned)', input)) then
                TransportOrder.Validate("Departure Date (Planned)", WS.GetDateTime('Departure Date (Planned)', input));

        jsonkey := 'Duration (Planned)';
        if (TransportOrder."Duration (Planned)" <> WS.GetInt('Duration (Planned)', input)) then
            TransportOrder.Validate("Duration (Planned)", WS.GetInt('Duration (Planned)', input));

        jsonkey := 'Return Date (Planned)';
        if (WS.KeyExists(jsonkey, input)) then
            if (TransportOrder."Return Date (Planned)" <> WS.GetDateTime('Return Date (Planned)', input)) then
                TransportOrder.Validate("Return Date (Planned)", WS.GetDateTime('Return Date (Planned)', input));

        jsonkey := 'Departure Date (Actual)';
        if (WS.KeyExists(jsonkey, input)) then
            if (TransportOrder."Departure Date (Actual)" <> WS.GetDateTime('Departure Date (Actual)', input)) then
                TransportOrder.Validate("Departure Date (Actual)", WS.GetDateTime('Departure Date (Actual)', input));

        jsonkey := 'Return Date (Actual)';
        if (WS.KeyExists(jsonkey, input)) then
            if (TransportOrder."Return Date (Actual)" <> WS.GetDateTime('Return Date (Actual)', input)) then
                TransportOrder.Validate("Return Date (Actual)", WS.GetDateTime('Return Date (Actual)', input));

        jsonkey := 'Duration (Actual)';
        if (WS.KeyExists(jsonkey, input)) then
            if (TransportOrder."Duration (Actual)" <> WS.GetInt('Duration (Actual)', input)) then
                TransportOrder.Validate("Duration (Actual)", WS.GetInt('Duration (Actual)', input));

        jsonkey := 'Useful volume (cbm)';
        if (WS.KeyExists(jsonkey, input)) then
            if (TransportOrder."Useful volume (cbm)" <> WS.GetDecimal('Useful volume (cbm)', input)) then
                TransportOrder.Validate("Useful volume (cbm)", WS.GetDecimal('Useful volume (cbm)', input));

        jsonkey := 'Payload (kg)';
        if (WS.KeyExists(jsonkey, input)) then
            if (TransportOrder."Payload (kg)" <> WS.GetDecimal('Payload (kg)', input)) then
                TransportOrder.Validate("Payload (kg)", WS.GetDecimal('Payload (kg)', input));

        jsonkey := 'Outbound Package Count';
        if (WS.KeyExists(jsonkey, input)) then
            if (TransportOrder."Outbound Package Count" <> WS.GetDecimal('Outbound Package Count', input)) then
                TransportOrder.Validate("Outbound Package Count", WS.GetDecimal('Outbound Package Count', input));

        jsonkey := 'Outbound Volume Loaded (cbm)';
        if (WS.KeyExists(jsonkey, input)) then
            if (TransportOrder."Outbound Volume Loaded (cbm)" <> WS.GetDecimal('Outbound Volume Loaded (cbm)', input)) then
                TransportOrder.Validate("Outbound Volume Loaded (cbm)", WS.GetDecimal('Outbound Volume Loaded (cbm)', input));

        jsonkey := 'Outbound Weight Load (Kg)';
        if (WS.KeyExists(jsonkey, input)) then
            if (TransportOrder."Outbound Weight Load (Kg)" <> WS.GetDecimal('Outbound Weight Load (Kg)', input)) then
                TransportOrder.Validate("Outbound Weight Load (Kg)", WS.GetDecimal('Outbound Weight Load (Kg)', input));

        jsonkey := 'Outbound Unloading Dura (Plan)';
        if (WS.KeyExists(jsonkey, input)) then
            if (TransportOrder."Outbound Unloading Dura (Plan)" <> WS.GetDecimal('Outbound Unloading Dura (Plan)', input)) then
                TransportOrder.Validate("Outbound Unloading Dura (Plan)", WS.GetDecimal('Outbound Unloading Dura (Plan)', input));

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

        jsonkey := 'Total Volume(cbm)';
        if (WS.KeyExists(jsonkey, input)) then
            if (TransportOrderDetail."Total Volume (cbm)" <> WS.GetDecimal(jsonkey, input)) then
                TransportOrderDetail.Validate("Total Volume (cbm)", WS.GetDecimal(jsonkey, input));

        jsonkey := 'Total Weight(Kg)';
        if (WS.KeyExists(jsonkey, input)) then
            if (TransportOrderDetail."Total Weight (Kg)" <> WS.GetDecimal(jsonkey, input)) then
                TransportOrderDetail.Validate("Total Weight (Kg)", WS.GetDecimal(jsonkey, input));

        jsonkey := 'Total Weight(Kg)';
        if (WS.KeyExists(jsonkey, input)) then
            if (TransportOrderDetail."Total Weight (Kg)" <> WS.GetDecimal(jsonkey, input)) then
                TransportOrderDetail.Validate("Total Weight (Kg)", WS.GetDecimal(jsonkey, input));

        jsonkey := 'Quantity(Actual)';
        if (WS.KeyExists(jsonkey, input)) then
            if (TransportOrderDetail."Quantity (Actual)" <> WS.GetDecimal('Quantity(Actual)', input)) then
                TransportOrderDetail.Validate("Quantity (Actual)", WS.GetDecimal('Quantity(Actual)', input));

        jsonkey := 'Quantity(Gap)';
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

    end;
}
