/// <summary>
/// Codeunit A01 Treso Mgt (ID 50007).
/// </summary>
codeunit 50007 "A01 Treso Mgt"
{
    var
        //CurrExchRate: Record "Currency Exchange Rate";
        GenJnlPostLine: Codeunit "Gen. Jnl.-Post Line";
        NoSeriesManagement: Codeunit NoSeriesManagement;
        ErrText01: Label 'The payment document has not been configured for \template %1\sheet %2\type %3', comment = '%1=model,%2=journal,%3=type';

    /// <summary>
    /// A01_ProcessFeuilleReglementCCL.
    /// </summary>
    /// <param name="GenJnlLine3">Record "Gen. Journal Line".</param>
    procedure A01_ProcessFeuilleReglementCCL(GenJnlLine3: Record "Gen. Journal Line")
    var
    //GenJnlLine3: record "Gen. Journal Line";
    //GenJournalLine2: record "Gen. Journal Line";
    begin

        if GenJnlLine3."A01 Payment Doc Type" = GenJnlLine3."A01 Payment Doc Type"::"Direct Check" then
            CreateNewPaymentDoc(GenJnlLine3);

        if GenJnlLine3."A01 Payment Doc Type" = GenJnlLine3."A01 Payment Doc Type"::"Bank Draft" then
            CreateNewPaymentDoc(GenJnlLine3);

        if GenJnlLine3."A01 Payment Doc Type" = GenJnlLine3."A01 Payment Doc Type"::"Bank Transfer" then begin
            if GenJnlLine3."Account Type" = GenJnlLine3."Account Type"::Customer then
                CreateNewPaymentDoc(GenJnlLine3);
            //if GenJnlLine3."Account Type" = GenJnlLine3."Account Type"::"Bank Account" then //JN231019 Vir from Treso
            //    CreateNewPaymentDoc_VirementFromTreso(GenJnlLine3);//***
        end;

        if GenJnlLine3."A01 Payment Doc Type" = GenJnlLine3."A01 Payment Doc Type"::Cash then
            CreateNewPaymentDoc(GenJnlLine3);

        //Traite fournisseur
        // IF (GenJnlLine3."Account Type" = GenJnlLine3."Account Type"::Vendor) AND (GenJnlLine3."Payment Method Code" <> '') THEN BEGIN
        //         CreateNewPaymentDocVendor(GenJnlLine3);

        //     END;

    end;

    [Obsolete('Not used')]
    local procedure A01_ProcessFeuilleReglementCCL_old(var TempGenJnlLine: Record "Gen. Journal Line" temporary)
    var
        GenJnlLine3: record "Gen. Journal Line";
        GenJournalLine2: record "Gen. Journal Line";
    begin
        if TempGenJnlLine.FindSet() then
            repeat


                GenJnlLine3 := TempGenJnlLine;
                GenJournalLine2.COPY(GenJnlLine3);


                if GenJnlLine3."A01 Payment Doc Type" = GenJnlLine3."A01 Payment Doc Type"::"Direct Check" then
                    CreateNewPaymentDoc(GenJnlLine3);

                if GenJnlLine3."A01 Payment Doc Type" = GenJnlLine3."A01 Payment Doc Type"::"Bank Draft" then
                    CreateNewPaymentDoc(GenJnlLine3);

                if GenJnlLine3."A01 Payment Doc Type" = GenJnlLine3."A01 Payment Doc Type"::"Bank Transfer" then begin
                    if GenJnlLine3."Account Type" = GenJnlLine3."Account Type"::Customer then
                        CreateNewPaymentDoc(GenJnlLine3);
                    //if GenJnlLine3."Account Type" = GenJnlLine3."Account Type"::"Bank Account" then //JN231019 Vir from Treso
                    //    CreateNewPaymentDoc_VirementFromTreso(GenJnlLine3);//***
                end;

                if GenJnlLine3."A01 Payment Doc Type" = GenJnlLine3."A01 Payment Doc Type"::Cash then
                    CreateNewPaymentDoc(GenJnlLine3);


            //Traite fournisseur
            // IF (GenJnlLine3."Account Type" = GenJnlLine3."Account Type"::Vendor) AND (GenJnlLine3."Payment Method Code" <> '') THEN BEGIN
            //         CreateNewPaymentDocVendor(GenJnlLine3);

            //     END;

            until TempGenJnlLine.Next() = 0;
    end;

    local procedure CreateNewPaymentDoc(GenJnlLine: Record "Gen. Journal Line")
    var
        PaymentCCConfig: Record "A01 Payment Type Configuration";
        PaymentClass: Record "Payment Class";
        PaymentHeader: Record "Payment Header";
        PaymentLine: Record "Payment Line";
        Cust: Record Customer;
        NoSeriesMgt: Codeunit NoSeriesManagement;
        LineNum: Integer;
    begin


        if not PaymentCCConfig.Get(GenJnlLine."Journal Template Name", GenJnlLine."Journal Batch Name",
          GenJnlLine."A01 Payment Doc Type") then
            Error(ErrText01, GenJnlLine."Journal Template Name", GenJnlLine."Journal Batch Name", GenJnlLine."A01 Payment Doc Type");

        PaymentCCConfig.TestField("Payment Class");

        PaymentClass.Get(PaymentCCConfig."Payment Class");

        PaymentHeader.Init();

        PaymentClass.TESTFIELD("Header No. Series");
        PaymentHeader."No." := GenJnlLine."Document No.";

        PaymentLine.LockTable();
        ;
        PaymentHeader.Insert(true);

        PaymentHeader.Validate("Payment Class", PaymentCCConfig."Payment Class");
        PaymentHeader.Validate("Currency Code", GenJnlLine."Currency Code");

        Cust.GET(GenJnlLine."Account No.");
        PaymentHeader."A01 Check No." := GenJnlLine."A01 Check No.";
        PaymentHeader."A01 Customer No." := Cust."No.";
        PaymentHeader."A01 Customer Name" := Cust.Name;
        PaymentHeader."A01 Description" := GenJnlLine.Description;
        PaymentHeader.VALIDATE("Posting Date", GenJnlLine."Posting Date");
        PaymentHeader."A01 Origin Document No." := GenJnlLine."Document No.";

        PaymentHeader.Modify();


        LineNum := 0;
        PaymentLine.Init();
        PaymentLine."Document No." := NoSeriesMgt.GetNextNo(PaymentClass."Line No. Series", WorkDate(), true);
        PaymentLine."No." := PaymentHeader."No.";
        PaymentLine."Payment Class" := PaymentHeader."Payment Class";
        LineNum := LineNum + 10000;
        PaymentLine."Line No." := LineNum;
        PaymentLine.Insert();


        PaymentLine."Account Type" := PaymentLine."Account Type"::Customer;
        PaymentLine.VALIDATE(PaymentLine."Account No.", Cust."No.");
        PaymentLine."Currency Code" := GenJnlLine."Currency Code";
        PaymentLine."Currency Factor" := PaymentHeader."Currency Factor";
        PaymentLine.VALIDATE(Amount, -ABS(GenJnlLine.Amount));

        if ((GenJnlLine."A01 Payment Doc Type" = GenJnlLine."A01 Payment Doc Type"::"Direct Check")
          or (GenJnlLine."A01 Payment Doc Type" = GenJnlLine."A01 Payment Doc Type"::"Bank Draft")
          or (GenJnlLine."A01 Payment Doc Type" = GenJnlLine."A01 Payment Doc Type"::"Deferred Check")) then
            GenJnlLine.TESTFIELD("A01 Check No.");

        PaymentLine."Drawee Reference" := CopyStr(GenJnlLine."A01 Check No.", 1, 10);
        PaymentLine."Due Date" := GenJnlLine."Due Date";

        PaymentLine."Dimension Set ID" := GenJnlLine."Dimension Set ID";
        PaymentLine.Modify();

    end;


    /// <summary>
    /// PostBalancingEntries.
    /// </summary>
    /// <param name="SalesHeader">Record "Sales Header".</param>
    /// <param name="PostedInvoiceNo">Code[20].</param>
    /// <param name="ExtDocNo">Code[35].</param>
    /// <param name="SourceCode">Code[10].</param>
    procedure PostBalancingEntries(SalesHeader: Record "Sales Header"; PostedInvoiceNo: Code[20]; ExtDocNo: Code[35]; SourceCode: Code[10])
    var
        SalesPaymentLine: Record "A01 Sales Payment Method";
        GenJnlLine: Record "Gen. Journal Line";
    begin
        SalesPaymentLine.Reset();
        SalesPaymentLine.SetRange("Document Type", SalesPaymentLine."Document Type"::Order);
        SalesPaymentLine.SetRange("Document No.", SalesHeader."No.");
        if (SalesPaymentLine.FindSet()) then
            repeat
                CreateNewPaymentDocFromSalesHeader(SalesHeader, SalesPaymentLine, GenJnlLine."Applies-to Doc. Type"::Invoice, PostedInvoiceNo);
                PostBalancingEntry(SalesHeader, SalesPaymentLine, GenJnlLine."Applies-to Doc. Type"::Invoice, PostedInvoiceNo, ExtDocNo, SourceCode);
            until SalesPaymentLine.Next() < 1;
    end;

    local procedure CreateNewPaymentDocFromSalesHeader(SalesHeader: Record "Sales Header";
        SalesPaymentLine: Record "A01 Sales Payment Method"; DocType: Enum "Gen. Journal Document Type"; DocNo: Code[20])
    var
        PaymentCCConfig: Record "A01 Payment Type Configuration";
        PaymentClass: Record "Payment Class";
        PaymentHeader: Record "Payment Header";
        RCPaymentMethod: Record "A01 RC Payment Method";
        PaymentLine: Record "Payment Line";
        Cust: Record Customer;
        NoSeriesMgt: Codeunit NoSeriesManagement;
        LineNum: Integer;
    begin

        if not RCPaymentMethod.get(SalesHeader."Responsibility Center", SalesPaymentLine."Payment Method") then
            exit;

        if (RCPaymentMethod."Payment Class") = '' then
            exit;

        if (SalesPaymentLine."Validated Amount" <= 0) then
            exit;

        //PaymentCCConfig.TestField("Payment Class");

        PaymentClass.Get(RCPaymentMethod."Payment Class");

        PaymentHeader.Init();

        PaymentClass.TESTFIELD("Header No. Series");

        NoSeriesManagement.InitSeries(PaymentClass."Header No. Series", '', 0D, PaymentHeader."No.", PaymentHeader."No. Series");
        PaymentHeader.Validate("Payment Class", PaymentClass.Code);

        PaymentLine.LockTable();
        PaymentHeader.Insert(true);

        PaymentHeader.Validate("Payment Class", PaymentCCConfig."Payment Class");
        PaymentHeader.Validate("Currency Code", SalesHeader."Currency Code");

        Cust.GET(SalesHeader."Bill-to Customer No.");
        PaymentHeader."A01 Check No." := copystr(SalesPaymentLine.Reference, 1, 20);
        PaymentHeader."A01 Customer No." := Cust."No.";
        PaymentHeader."A01 Customer Name" := Cust.Name;
        PaymentHeader."A01 Description" := SalesHeader."Posting Description";
        PaymentHeader.VALIDATE("Posting Date", SalesHeader."Posting Date");
        PaymentHeader."A01 Origin Document No." := SalesHeader."No.";

        PaymentHeader.Modify();


        LineNum := 0;
        PaymentLine.Init();
        PaymentLine."Document No." := NoSeriesMgt.GetNextNo(PaymentClass."Line No. Series", WorkDate(), true);
        PaymentLine."No." := PaymentHeader."No.";
        PaymentLine."Payment Class" := PaymentHeader."Payment Class";
        LineNum := LineNum + 10000;
        PaymentLine."Line No." := LineNum;
        PaymentLine.Insert();


        PaymentLine."Account Type" := PaymentLine."Account Type"::Customer;
        PaymentLine.VALIDATE(PaymentLine."Account No.", Cust."No.");
        PaymentLine."Currency Code" := SalesHeader."Currency Code";
        PaymentLine."Currency Factor" := PaymentHeader."Currency Factor";
        PaymentLine.VALIDATE(Amount, -ABS(SalesPaymentLine."Validated Amount"));
        PaymentLine."Applies-to Doc. Type" := DocType;
        PaymentLine."Applies-to Doc. No." := DocNo;


        // if ((GenJnlLine."A01 Payment Doc Type" = GenJnlLine."A01 Payment Doc Type"::"Direct Check")
        //   or (GenJnlLine."A01 Payment Doc Type" = GenJnlLine."A01 Payment Doc Type"::"Bank Draft")
        //   or (GenJnlLine."A01 Payment Doc Type" = GenJnlLine."A01 Payment Doc Type"::"Deferred Check")) then
        //     GenJnlLine.TESTFIELD("A01 Check No.");

        PaymentLine."Drawee Reference" := CopyStr(PaymentHeader."A01 Check No.", 1, 10);
        PaymentLine."Due Date" := SalesHeader."Due Date";

        PaymentLine."Dimension Set ID" := SalesHeader."Dimension Set ID";
        PaymentLine.Modify();

    end;

    local procedure PostBalancingEntry(SalesHeader: Record "Sales Header"; SalesPaymentLine: Record "A01 Sales Payment Method"; DocType: Enum "Gen. Journal Document Type"; DocNo: Code[20];
                                                                                                                                             ExtDocNo: Code[35];
                                                                                                                                             SourceCode: Code[10])
    var
        //CustLedgEntry: Record "Cust. Ledger Entry";
        GenJnlLine: Record "Gen. Journal Line";
        RCPaymentMethod: Record "A01 RC Payment Method";
    //EntryFound: Boolean;
    begin
        //EntryFound := false;

        //if not EntryFound then
        //    FindCustLedgEntry(DocType, DocNo, CustLedgEntry);

        if not RCPaymentMethod.get(SalesHeader."Responsibility Center", SalesPaymentLine."Payment Method") then
            exit;

        if (RCPaymentMethod."Bal. Account No." = '') then
            exit;
        if (SalesPaymentLine."Validated Amount" <= 0) then
            exit;

        // if not PaymentMethod.get(SalesPaymentLine."Payment Method") then exit;
        // if PaymentMethod."Bal. Account No." = '' then exit;

        GenJnlLine.InitNewLine(
          SalesHeader."Posting Date", SalesHeader."Document Date", SalesHeader."VAT Reporting Date", SalesHeader."Posting Description",
          SalesHeader."Shortcut Dimension 1 Code", SalesHeader."Shortcut Dimension 2 Code",
          SalesHeader."Dimension Set ID", SalesHeader."Reason Code");


        GenJnlLine.CopyDocumentFields(Enum::"Gen. Journal Document Type"::" ", DocNo, ExtDocNo, SourceCode, '');
        GenJnlLine."Account Type" := GenJnlLine."Account Type"::Customer;
        GenJnlLine."Account No." := SalesHeader."Bill-to Customer No.";
        GenJnlLine.CopyFromSalesHeader(SalesHeader);
        GenJnlLine.SetCurrencyFactor(SalesHeader."Currency Code", SalesHeader."Currency Factor");

        if SalesHeader.IsCreditDocType() then
            GenJnlLine."Document Type" := GenJnlLine."Document Type"::Refund
        else
            GenJnlLine."Document Type" := GenJnlLine."Document Type"::Payment;


        SetApplyToDocNo(RCPaymentMethod, GenJnlLine, DocType, DocNo);

        SetAmountsForBalancingEntry(SalesPaymentLine."Validated Amount", GenJnlLine);

        // GenJnlLine."Orig. Pmt. Disc. Possible" := TotalSalesLine2."Pmt. Discount Amount";
        // GenJnlLine."Orig. Pmt. Disc. Possible(LCY)" :=
        //     CurrExchRate.ExchangeAmtFCYToLCY(
        //         SalesHeader.GetUseDate(), SalesHeader."Currency Code", TotalSalesLine2."Pmt. Discount Amount", SalesHeader."Currency Factor");

        GenJnlPostLine.RunWithCheck(GenJnlLine);

    end;

    // local procedure PostBalancingEntry(SalesHeader: Record "Sales Header"; TotalSalesLine2: Record "Sales Line"; TotalSalesLineLCY2: Record "Sales Line"; DocType: Enum "Gen. Journal Document Type"; DocNo: Code[20]; ExtDocNo: Code[35]; SourceCode: Code[10])
    // var
    //     CustLedgEntry: Record "Cust. Ledger Entry";
    //     GenJnlLine: Record "Gen. Journal Line";
    //     EntryFound: Boolean;
    // begin
    //     EntryFound := false;

    //     if not EntryFound then
    //         FindCustLedgEntry(DocType, DocNo, CustLedgEntry);

    //     GenJnlLine.InitNewLine(
    //       SalesHeader."Posting Date", SalesHeader."Document Date", SalesHeader."VAT Reporting Date", SalesHeader."Posting Description",
    //       SalesHeader."Shortcut Dimension 1 Code", SalesHeader."Shortcut Dimension 2 Code",
    //       SalesHeader."Dimension Set ID", SalesHeader."Reason Code");


    //     GenJnlLine.CopyDocumentFields(Enum::"Gen. Journal Document Type"::" ", DocNo, ExtDocNo, SourceCode, '');
    //     GenJnlLine."Account Type" := GenJnlLine."Account Type"::Customer;
    //     GenJnlLine."Account No." := SalesHeader."Bill-to Customer No.";
    //     GenJnlLine.CopyFromSalesHeader(SalesHeader);
    //     GenJnlLine.SetCurrencyFactor(SalesHeader."Currency Code", SalesHeader."Currency Factor");

    //     if SalesHeader.IsCreditDocType() then
    //         GenJnlLine."Document Type" := GenJnlLine."Document Type"::Refund
    //     else
    //         GenJnlLine."Document Type" := GenJnlLine."Document Type"::Payment;

    //     SetApplyToDocNo(SalesHeader, GenJnlLine, DocType, DocNo);

    //     SetAmountsForBalancingEntry(CustLedgEntry, TotalSalesLine2, TotalSalesLineLCY2, GenJnlLine);

    //     GenJnlLine."Orig. Pmt. Disc. Possible" := TotalSalesLine2."Pmt. Discount Amount";
    //     GenJnlLine."Orig. Pmt. Disc. Possible(LCY)" :=
    //         CurrExchRate.ExchangeAmtFCYToLCY(
    //             SalesHeader.GetUseDate(), SalesHeader."Currency Code", TotalSalesLine2."Pmt. Discount Amount", SalesHeader."Currency Factor");

    //     GenJnlPostLine.RunWithCheck(GenJnlLine);

    // end;

    local procedure SetAmountsForBalancingEntry(PayAmt: Decimal; var GenJnlLine: Record "Gen. Journal Line")
    begin
        GenJnlLine.Validate(Amount, -PayAmt);
        // GenJnlLine.Amount := TotalSalesLine2."Amount Including VAT" + CustLedgEntry."Remaining Pmt. Disc. Possible";
        // GenJnlLine."Source Currency Amount" := GenJnlLine.Amount;
        // CustLedgEntry.CalcFields(Amount);
        // if CustLedgEntry.Amount = 0 then
        //     GenJnlLine."Amount (LCY)" := TotalSalesLineLCY2."Amount Including VAT"
        // else
        //     GenJnlLine."Amount (LCY)" :=
        //       TotalSalesLineLCY2."Amount Including VAT" +
        //       Round(CustLedgEntry."Remaining Pmt. Disc. Possible" / CustLedgEntry."Adjusted Currency Factor");
        GenJnlLine."Allow Zero-Amount Posting" := true;
    end;

    // local procedure SetAmountsForBalancingEntry(CustLedgEntry: Record "Cust. Ledger Entry"; TotalSalesLine2: Record "Sales Line"; TotalSalesLineLCY2: Record "Sales Line"; var GenJnlLine: Record "Gen. Journal Line")
    // begin
    //     GenJnlLine.Amount := TotalSalesLine2."Amount Including VAT" + CustLedgEntry."Remaining Pmt. Disc. Possible";
    //     GenJnlLine."Source Currency Amount" := GenJnlLine.Amount;
    //     CustLedgEntry.CalcFields(Amount);
    //     if CustLedgEntry.Amount = 0 then
    //         GenJnlLine."Amount (LCY)" := TotalSalesLineLCY2."Amount Including VAT"
    //     else
    //         GenJnlLine."Amount (LCY)" :=
    //           TotalSalesLineLCY2."Amount Including VAT" +
    //           Round(CustLedgEntry."Remaining Pmt. Disc. Possible" / CustLedgEntry."Adjusted Currency Factor");
    //     GenJnlLine."Allow Zero-Amount Posting" := true;
    // end;

    local procedure SetApplyToDocNo(PayMethod: Record "A01 RC Payment Method"; var GenJnlLine: Record "Gen. Journal Line"; DocType: Enum "Gen. Journal Document Type"; DocNo: Code[20])
    begin

        if PayMethod."Bal. Account Type" = PayMethod."Bal. Account Type"::"Bank Account" then
            GenJnlLine."Bal. Account Type" := GenJnlLine."Bal. Account Type"::"Bank Account";
        if PayMethod."Bal. Account Type" = PayMethod."Bal. Account Type"::"G/L Account" then
            GenJnlLine."Bal. Account Type" := GenJnlLine."Bal. Account Type"::"G/L Account";
        GenJnlLine."Bal. Account No." := PayMethod."Bal. Account No.";
        GenJnlLine."Applies-to Doc. Type" := DocType;
        GenJnlLine."Applies-to Doc. No." := DocNo;

    end;

    /*local proc edure SetApplyToDocNo(SalesHeader: Record "Sales Header"; var GenJnlLine: Record "Gen. Journal Line"; DocType: Enum "Gen. Journal Document Type"; DocNo: Code[20])
    begin

        if SalesHeader."Bal. Account Type" = SalesHeader."Bal. Account Type"::"Bank Account" then
            GenJnlLine."Bal. Account Type" := GenJnlLine."Bal. Account Type"::"Bank Account";
        GenJnlLine."Bal. Account No." := SalesHeader."Bal. Account No.";
        GenJnlLine."Applies-to Doc. Type" := DocType;
        GenJnlLine."Applies-to Doc. No." := DocNo;

    end; */


    // local procedure FindCustLedgEntry(DocType: Enum "Gen. Journal Document Type"; DocNo: Code[20]; var CustLedgEntry: Record "Cust. Ledger Entry")
    // begin
    //     CustLedgEntry.SetRange("Document Type", DocType);
    //     CustLedgEntry.SetRange("Document No.", DocNo);
    //     CustLedgEntry.FindLast();
    // end;



}
