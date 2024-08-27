/// <summary>
/// Codeunit A01 Treso Mgt (ID 50007).
/// </summary>
codeunit 50007 "A01 Treso Mgt"
{
    var
        CurrExchRate: Record "Currency Exchange Rate";
        AddOnSetup: Record "A01 Afk Setup";
        NoSeriesManagement: Codeunit NoSeriesManagement;
        ErrText01: Label 'The payment document has not been configured for \template %1\sheet %2\type %3', comment = '%1=model,%2=journal,%3=type';
        TotalLineAmtInclVAT: Decimal;
        TotalLineAmtInclVATLCY: Decimal;
        TotalLineAmtLCY: Decimal;
        TotalLineUnitCostLCY: Decimal;
        TotalLineInvDiscountAmtLCY: Decimal;
        TotalLinePmtDiscountAmt: Decimal;
    //ApplyToDocType: integer;
    //ApplyToDocNo: Code[20];

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
    procedure PostBalancingEntriesFromPOS(SalesHeader: Record "Sales Header"; PostedInvoiceNo: Code[20]; ExtDocNo: Code[35];
    SourceCode: Code[10]; var GenJnlPostLine: Codeunit "Gen. Jnl.-Post Line")
    var
        SalesPaymentLine: Record "A01 Sales Payment Method";
        GenJnlLine: Record "Gen. Journal Line";
        RespCenter: Record "Responsibility Center";
    begin

        SalesHeader.TestField("Responsibility Center");
        RespCenter.Get(SalesHeader."Responsibility Center");
        if (not RespCenter."A01 Control Payment on Invoice") then
            exit;

        CheckPaymentAmount(SalesHeader);

        SalesPaymentLine.Reset();
        SalesPaymentLine.SetRange("Document Type", SalesPaymentLine."Document Type"::Order);
        SalesPaymentLine.SetRange("Document No.", SalesHeader."No.");
        if (SalesPaymentLine.FindSet()) then
            repeat
                CreateNewPaymentDocFromSalesHeader(SalesHeader, SalesPaymentLine, GenJnlLine."Applies-to Doc. Type"::Invoice, PostedInvoiceNo);
                PostBalancingEntry(SalesHeader, SalesPaymentLine, GenJnlLine."Applies-to Doc. Type"::Invoice, GenJnlPostLine, PostedInvoiceNo, ExtDocNo, SourceCode);
                SaveSalesPaymentLine(PostedInvoiceNo, SalesPaymentLine);
            until SalesPaymentLine.Next() < 1;



    end;

    local procedure SaveSalesPaymentLine(PostedNo: Code[20]; SalesPaymentLine: Record "A01 Sales Payment Method")
    var
        PostedSalesPaymentLine: Record "A01 Posted Sales Pay Method";
    begin
        PostedSalesPaymentLine.Init();
        PostedSalesPaymentLine.TransferFields(SalesPaymentLine);
        PostedSalesPaymentLine."Document No." := PostedNo;
        PostedSalesPaymentLine.Insert();
    end;

    local procedure CheckPaymentAction(SalesHeader: Record "Sales Header"; SalesPaymentLine: Record "A01 Sales Payment Method")
    var
        LblErrPayment: Label 'No valid payment action for the line %1', Comment = '%1=xxx';
    begin
        if (IsPOSGenLedgerPayment(SalesHeader, SalesPaymentLine)) then
            exit;
        if (IsPOSDocumentPayment(SalesHeader, SalesPaymentLine)) then
            exit;
        error(LblErrPayment, SalesPaymentLine."Payment Method");
    end;

    local procedure CreateNewPaymentDocFromSalesHeader(SalesHeader: Record "Sales Header";
        SalesPaymentLine: Record "A01 Sales Payment Method"; DocType: Enum "Gen. Journal Document Type"; DocNo: Code[20])
    var
        //PaymentCCConfig: Record "A01 Payment Type Configuration";
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

        PaymentClass.Get(RCPaymentMethod."Payment Class");

        PaymentHeader.Init();

        PaymentClass.TESTFIELD("Header No. Series");

        NoSeriesManagement.InitSeries(PaymentClass."Header No. Series", '', 0D, PaymentHeader."No.", PaymentHeader."No. Series");
        PaymentHeader.Validate("Payment Class", PaymentClass.Code);

        PaymentLine.LockTable();
        PaymentHeader.Insert(true);

        //PaymentHeader.Validate("Payment Class", PaymentCCConfig."Payment Class");
        PaymentHeader.Validate("Currency Code", SalesHeader."Currency Code");

        Cust.GET(SalesHeader."Bill-to Customer No.");
        PaymentHeader."A01 Check No." := copystr(SalesPaymentLine.Reference, 1, 20);
        PaymentHeader."A01 Customer No." := Cust."No.";
        PaymentHeader."A01 Customer Name" := Cust.Name;
        PaymentHeader."A01 Description" := SalesHeader."Posting Description";
        PaymentHeader.VALIDATE("Posting Date", SalesHeader."Posting Date");
        PaymentHeader."A01 Origin Document No." := SalesHeader."No.";
        PaymentHeader."A01 Payment Method" := RCPaymentMethod."Payment Method";
        SalesHeader.Testfield("Responsibility Center");
        PaymentHeader."A01 Responsibility Center" := SalesHeader."Responsibility Center";


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
        PaymentLine."A01 Payment Reference" := StrSubstNo(SalesPaymentLine.Reference, 1, 30);
        PaymentLine."Drawee Reference" := CopyStr(PaymentHeader."A01 Check No.", 1, 10);
        PaymentLine."Due Date" := SalesHeader."Due Date";

        PaymentLine."Dimension Set ID" := SalesHeader."Dimension Set ID";
        PaymentLine.Modify();

    end;

    procedure CreateNewPaymentDocFromCustomerSettlement(CustSettlement: Record "A01 Payment Document";
    CustSettlementLine: Record "A01 Payment Document Line"): Boolean
    var
        //PaymentCCConfig: Record "A01 Payment Type Configuration";
        PaymentClass: Record "Payment Class";
        PaymentHeader: Record "Payment Header";
        RCPaymentMethod: Record "A01 RC Payment Method";
        PaymentLine: Record "Payment Line";
        Cust: Record Customer;
        NoSeriesMgt: Codeunit NoSeriesManagement;
        LineNum: Integer;
    begin

        if not RCPaymentMethod.get(CustSettlementLine."Responsibility Center", CustSettlementLine."Payment Method") then
            exit;

        if (RCPaymentMethod."Payment Class") = '' then
            exit;

        if (CustSettlementLine."Validated Amount" <= 0) then
            exit;

        PaymentClass.Get(RCPaymentMethod."Payment Class");

        PaymentHeader.Init();

        PaymentClass.TestField("Header No. Series");

        NoSeriesManagement.InitSeries(PaymentClass."Header No. Series", '', 0D, PaymentHeader."No.", PaymentHeader."No. Series");
        PaymentHeader.Validate("Payment Class", PaymentClass.Code);

        PaymentLine.LockTable();
        PaymentHeader.Insert(true);

        //PaymentHeader.Validate("Payment Class", PaymentCCConfig."Payment Class");
        PaymentHeader.Validate("Currency Code", CustSettlement."Currency Code");

        Cust.GET(CustSettlement."Partner No.");
        PaymentHeader."A01 Check No." := copystr(CustSettlementLine.Reference, 1, 20);
        PaymentHeader."A01 Customer No." := Cust."No.";
        PaymentHeader."A01 Customer Name" := Cust.Name;
        PaymentHeader."A01 Description" := CustSettlement.Object;
        PaymentHeader.VALIDATE("Posting Date", CustSettlement."Posting Date");
        PaymentHeader."A01 Origin Document No." := CustSettlement."Posting No.";
        PaymentHeader."A01 Payment Method" := CustSettlementLine."Payment Method";
        CustSettlement.Testfield("Responsibility Center");
        PaymentHeader."A01 Responsibility Center" := CustSettlement."Responsibility Center";
        PaymentHeader."Dimension Set ID" := CustSettlement."Dimension Set ID";



        //PaymentHeader."A01 Posted Document No." := CustSettlement."Posting No.";

        PaymentHeader.Modify();


        LineNum := 0;
        PaymentLine.Init();
        PaymentClass.TestField("Line No. Series");
        PaymentLine."Document No." := NoSeriesMgt.GetNextNo(PaymentClass."Line No. Series", WorkDate(), true);
        PaymentLine."No." := PaymentHeader."No.";
        PaymentLine."Payment Class" := PaymentHeader."Payment Class";
        LineNum := LineNum + 10000;
        PaymentLine."Line No." := LineNum;
        PaymentLine.Insert();


        PaymentLine."Account Type" := PaymentLine."Account Type"::Customer;
        PaymentLine.VALIDATE(PaymentLine."Account No.", Cust."No.");
        PaymentLine."Currency Code" := CustSettlement."Currency Code";
        PaymentLine."Currency Factor" := PaymentHeader."Currency Factor";
        PaymentLine.VALIDATE(Amount, -ABS(CustSettlementLine."Validated Amount"));
        //PaymentLine."Applies-to Doc. Type" := DocType;
        //PaymentLine."Applies-to Doc. No." := DocNo;
        PaymentLine."Applies-to ID" := CustSettlement."Applies-to ID";
        PaymentLine.Validate("Due Date", CustSettlementLine."Due Date");


        // if ((GenJnlLine."A01 Payment Doc Type" = GenJnlLine."A01 Payment Doc Type"::"Direct Check")
        //   or (GenJnlLine."A01 Payment Doc Type" = GenJnlLine."A01 Payment Doc Type"::"Bank Draft")
        //   or (GenJnlLine."A01 Payment Doc Type" = GenJnlLine."A01 Payment Doc Type"::"Deferred Check")) then
        //     GenJnlLine.TESTFIELD("A01 Check No.");

        PaymentLine."Drawee Reference" := CopyStr(PaymentHeader."A01 Check No.", 1, 10);
        PaymentLine."A01 Payment Reference" := CustSettlementLine.Reference;
        //PaymentLine."Due Date" := CustSettlement."Due Date";

        PaymentLine."Dimension Set ID" := CustSettlement."Dimension Set ID";
        PaymentLine.Modify();

        exit(true);

    end;

    local procedure PostBalancingEntry(SalesHeader: Record "Sales Header";
    SalesPaymentLine: Record "A01 Sales Payment Method";
    DocType: Enum "Gen. Journal Document Type";
    var GenJnlPostLine: Codeunit "Gen. Jnl.-Post Line";
    DocNo: Code[20];
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

        GenJnlLine.SetSuppressCommit(true);
        GenJnlLine.CopyDocumentFields(Enum::"Gen. Journal Document Type"::" ", DocNo, ExtDocNo, SourceCode, '');
        GenJnlLine."Account Type" := GenJnlLine."Account Type"::Customer;
        GenJnlLine."Account No." := SalesHeader."Bill-to Customer No.";
        GenJnlLine.CopyFromSalesHeader(SalesHeader);
        GenJnlLine.SetCurrencyFactor(SalesHeader."Currency Code", SalesHeader."Currency Factor");

        if SalesHeader.IsCreditDocType() then
            GenJnlLine."Document Type" := GenJnlLine."Document Type"::Refund
        else
            GenJnlLine."Document Type" := GenJnlLine."Document Type"::Payment;

        GenJnlLine.Validate("Payment Method Code", RCPaymentMethod."Payment Method");
        GenJnlLine."Payment Reference" := SalesPaymentLine.Reference;

        SetBalAccAndApplyToDocNo(RCPaymentMethod, GenJnlLine, DocType, DocNo);

        SetAmountsForBalancingEntry(SalesPaymentLine."Validated Amount", GenJnlLine);

        // GenJnlLine."Orig. Pmt. Disc. Possible" := TotalSalesLine2."Pmt. Discount Amount";
        // GenJnlLine."Orig. Pmt. Disc. Possible(LCY)" :=
        //     CurrExchRate.ExchangeAmtFCYToLCY(7

        //         SalesHeader.GetUseDate(), SalesHeader."Currency Code", TotalSalesLine2."Pmt. Discount Amount", SalesHeader."Currency Factor");

        GenJnlPostLine.RunWithCheck(GenJnlLine);

    end;

    procedure PostCustSettlementLine(CustSettlement: Record "A01 Payment Document";
        CustSettlementLine: Record "A01 Payment Document Line";
        var GenJnlPostLine: Codeunit "Gen. Jnl.-Post Line"; ApplyToNo: Code[20]; ApplyType: integer): Boolean
    var
        //CustLedgEntry: Record "Cust. Ledger Entry";
        GenJnlLine: Record "Gen. Journal Line";
        RCPaymentMethod: Record "A01 RC Payment Method";
        SourceCodeSetup: Record "Source Code Setup";
    //EntryFound: Boolean;
    begin
        //EntryFound := false;

        //if not EntryFound then
        //    FindCustLedgEntry(DocType, DocNo, CustLedgEntry);
        SourceCodeSetup.Get();
        AddOnSetup.GetRecordOnce();

        if not RCPaymentMethod.get(CustSettlement."Responsibility Center", CustSettlementLine."Payment Method") then
            exit;

        if (RCPaymentMethod."Bal. Account No." = '') then
            exit;
        if (CustSettlementLine."Validated Amount" <= 0) then
            exit;

        // if not PaymentMethod.get(SalesPaymentLine."Payment Method") then exit;
        // if PaymentMethod."Bal. Account No." = '' then exit;

        // GenJnlLine.InitNewLine(
        //   SalesHeader."Posting Date", SalesHeader."Document Date", SalesHeader."VAT Reporting Date", SalesHeader."Posting Description",
        //   SalesHeader."Shortcut Dimension 1 Code", SalesHeader."Shortcut Dimension 2 Code",
        //   SalesHeader."Dimension Set ID", SalesHeader."Reason Code");
        GenJnlLine.InitNewLine(
          CustSettlement."Posting Date", CustSettlement."Posting Date", 0D, CustSettlement."Object",
          CustSettlement."Shortcut Dimension 1 Code", CustSettlement."Shortcut Dimension 2 Code",
          CustSettlement."Dimension Set ID", '');

        GenJnlLine.SetSuppressCommit(true);
        GenJnlLine.CopyDocumentFields(Enum::"Gen. Journal Document Type"::Payment, CustSettlement."Posting No.", CustSettlement."External Document No.", SourceCodeSetup."Payment Journal", '');



        GenJnlLine."Account Type" := GenJnlLine."Account Type"::Customer;
        GenJnlLine."Account No." := CustSettlement."Partner No.";

        //GenJnlLine.CopyFromSalesHeader(SalesHeader);
        //GenJnlLine.SetCurrencyFactor(CustSettlement."Currency Code", SalesHeader."Currency Factor");

        // if SalesHeader.IsCreditDocType() then
        //     GenJnlLine."Document Type" := GenJnlLine."Document Type"::Refund
        // else
        GenJnlLine."Document Type" := GenJnlLine."Document Type"::Payment;
        if (RCPaymentMethod."Payment Method" = AddOnSetup."Rebate Payment Method") then
            GenJnlLine."Document Type" := GenJnlLine."Document Type"::"Credit Memo";
        GenJnlLine."Payment Method Code" := CustSettlementLine."Payment Method";
        GenJnlLine."Payment Reference" := CustSettlementLine.Reference;


        SetBalAccAndApplyToID(RCPaymentMethod, GenJnlLine, ApplyToNo, ApplyType);

        SetAmountsForBalancingEntry(CustSettlementLine."Validated Amount", GenJnlLine);

        // GenJnlLine."Orig. Pmt. Disc. Possible" := TotalSalesLine2."Pmt. Discount Amount";
        // GenJnlLine."Orig. Pmt. Disc. Possible(LCY)" :=
        //     CurrExchRate.ExchangeAmtFCYToLCY(
        //         SalesHeader.GetUseDate(), SalesHeader."Currency Code", TotalSalesLine2."Pmt. Discount Amount", SalesHeader."Currency Factor");

        GenJnlPostLine.RunWithCheck(GenJnlLine);

        exit(true);

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

    local procedure SetBalAccAndApplyToDocNo(PayMethod: Record "A01 RC Payment Method"; var GenJnlLine: Record "Gen. Journal Line"; DocType: Enum "Gen. Journal Document Type"; DocNo: Code[20])
    begin

        if PayMethod."Bal. Account Type" = PayMethod."Bal. Account Type"::"Bank Account" then
            GenJnlLine."Bal. Account Type" := GenJnlLine."Bal. Account Type"::"Bank Account";
        if PayMethod."Bal. Account Type" = PayMethod."Bal. Account Type"::"G/L Account" then
            GenJnlLine."Bal. Account Type" := GenJnlLine."Bal. Account Type"::"G/L Account";
        GenJnlLine."Bal. Account No." := PayMethod."Bal. Account No.";
        GenJnlLine."Applies-to Doc. Type" := DocType;
        GenJnlLine."Applies-to Doc. No." := DocNo;

    end;

    local procedure SetBalAccAndApplyToID(PayMethod: Record "A01 RC Payment Method";
    var GenJnlLine: Record "Gen. Journal Line"; ApplyToNo: Code[20]; ApplyType: integer)
    var
    //CustLedgEntry: Record "Cust. Ledger Entry";
    begin

        if PayMethod."Bal. Account Type" = PayMethod."Bal. Account Type"::"Bank Account" then
            GenJnlLine."Bal. Account Type" := GenJnlLine."Bal. Account Type"::"Bank Account";
        if PayMethod."Bal. Account Type" = PayMethod."Bal. Account Type"::"G/L Account" then
            GenJnlLine."Bal. Account Type" := GenJnlLine."Bal. Account Type"::"G/L Account";
        GenJnlLine."Bal. Account No." := PayMethod."Bal. Account No.";

        if (ApplyToNo <> '') then begin
            GenJnlLine.Validate("Applies-to Doc. Type", ApplyType);
            GenJnlLine.Validate("Applies-to Doc. No.", ApplyToNo);
        end;



        // GenJnlLine."Applies-to Doc. Type" := GenJnlLine."Applies-to Doc. Type"::" ";
        // GenJnlLine."Applies-to Doc. No." := '';
        // GenJnlLine."Applies-to ID" := ApplyToID;

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
    // procedure IsMultiMeadlinesInvoice(SalesHeader: Record "Sales Header"): Boolean
    // var
    //     PaymentCond: Record "Payment Terms";
    // begin
    //     if (not PaymentCond.Get(SalesHeader."Payment Terms Code")) then
    //         exit(false);
    //     if (not PaymentCond."A01 Multi-deadlines") then
    //         exit(false);
    //     // if (SalesHeader."A01 Credit Duration (Month)" <= 0) then
    //     //     exit(false);
    //     exit(true);
    // end;
    procedure IsMultiMeadlinesInvoice(SalesHeader: Record "Sales Header"): Boolean
    var
    begin
        exit(IsMultiMeadlinesInvoice(SalesHeader."Payment Terms Code"));
    end;

    procedure IsMultiMeadlinesInvoice(PaymentTermsCode: Code[20]): Boolean
    var
        PaymentCond: Record "Payment Terms";
    begin
        if (not PaymentCond.Get(PaymentTermsCode)) then
            exit(false);
        if (not PaymentCond."A01 Multi-deadlines") then
            exit(false);
        exit(true);
    end;


    local procedure IsPostingWithoutDueCreditLine(SalesHeader: Record "Sales Header"): Boolean
    var
    //PaymentCond: Record "Payment Terms";
    begin
        exit(SalesHeader."A01 Interest rate" = 0);
    end;

    procedure PostMultiDeadlinesPaymentLines(var SalesHeader: Record "Sales Header";
    var TotalSalesLine2: Record "Sales Line"; var TotalSalesLineLCY2: Record "Sales Line"; CommitIsSuppressed: Boolean;
    PreviewMode: Boolean; DocType: Enum "Gen. Journal Document Type"; DocNo: Code[20]; ExtDocNo: Code[35]; SourceCode: Code[10];
    var GenJnlPostLine: Codeunit "Gen. Jnl.-Post Line"; var IsHandled: Boolean)
    var
        PaymentCond: Record "Payment Terms";
        CreditDueLine: Record "A01 Credit Depreciation Table";
        i: Integer;
        LineDueDate: Date;
        DeferredDateFormula: Text;
        lblFormula: label '<%1M>', comment = '%1=months';

    begin
        if (not IsMultiMeadlinesInvoice(SalesHeader)) then
            exit;

        SalesHeader.testfield("A01 Credit Duration (Month)");

        PaymentCond.Get(SalesHeader."Payment Terms Code");

        CheckCreditDueLines(SalesHeader);

        DeferredDateFormula := StrSubstNo(lblFormula, SalesHeader."A01 Deferred month");

        LineDueDate := CalcDate(DeferredDateFormula, SalesHeader."Due Date");

        i := 1;
        TotalLineAmtInclVAT := 0;
        TotalLineAmtInclVATLCY := 0;
        TotalLineAmtLCY := 0;
        TotalLineUnitCostLCY := 0;
        TotalLineInvDiscountAmtLCY := 0;
        TotalLinePmtDiscountAmt := 0;

        if (IsPostingWithoutDueCreditLine(SalesHeader)) then begin

            for i := 1 to SalesHeader."A01 Credit Duration (Month)" do begin

                IsHandled := true;

                ProcessCreditDueLine(SalesHeader, CreditDueLine, TotalSalesLine2, TotalSalesLineLCY2, DocType, DocNo, ExtDocNo, SourceCode, GenJnlPostLine, i, LineDueDate);

                LineDueDate := CalcDate('<1M>', LineDueDate);

            end;

        end else begin

            CreditDueLine.Reset();
            CreditDueLine.SetRange("Document Type", CreditDueLine."Document Type"::"Sales order");
            CreditDueLine.SetRange("Document No.", SalesHeader."No.");
            if CreditDueLine.FindSet() then
                repeat

                    IsHandled := true;

                    ProcessCreditDueLine(SalesHeader, CreditDueLine, TotalSalesLine2, TotalSalesLineLCY2, DocType, DocNo, ExtDocNo, SourceCode, GenJnlPostLine, i, LineDueDate);

                    LineDueDate := CalcDate('<1M>', LineDueDate);
                    i += 1;
                until CreditDueLine.Next() < 1;

            CreditDueLine.Reset();
            CreditDueLine.SetRange("Document Type", CreditDueLine."Document Type"::"Sales order");
            CreditDueLine.SetRange("Document No.", SalesHeader."No.");
            if not CreditDueLine.IsEmpty() then
                CreditDueLine.DeleteAll();
        end;





    end;

    local procedure RoundAmount(Amount: Decimal): Decimal
    begin
        AddOnSetup.Get();
        case AddOnSetup."MIR Due rounding rule" of
            AddOnSetup."MIR Due rounding rule"::Hundred:
                exit(Round(Amount, 100, '='));
            AddOnSetup."MIR Due rounding rule"::Thousand:
                exit(Round(Amount, 1000, '='));
            else
                exit(Amount);
        end;
    end;

    local procedure PostMultiDeadlinesPayment(var SalesHeader: Record "Sales Header";
                var CreditDueLine: Record "A01 Credit Depreciation Table";
                    DocType: Enum "Gen. Journal Document Type"; DocNo: Code[20];
                   ExtDocNo: Code[35];
                   SourceCode: Code[10];
                   var GenJnlPostLine: Codeunit "Gen. Jnl.-Post Line";
                   LineAmtInclVAT: Decimal;
                   LineAmtInclVATLCY: Decimal;
                   LineAmtLCY: Decimal;
                   LineUnitCostLCY: Decimal;
                   LineInvDiscountAmtLCY: Decimal;
                   LinePmtDiscountAmt: Decimal;
                   LineDueDate: Date;
                   LineId: Integer)
    var
        PaymentCond: Record "Payment Terms";
        CreditDueLineNew: Record "A01 Credit Depreciation Table";
        GenJnlLine: Record "Gen. Journal Line";
        CustLedgEntry: Record "Cust. Ledger Entry";
    begin
        if (not PaymentCond.Get(SalesHeader."Payment Terms Code")) then
            exit;
        if (not PaymentCond."A01 Multi-deadlines") then
            exit;


        GenJnlLine.InitNewLine(
          SalesHeader."Posting Date", SalesHeader."Document Date", SalesHeader."VAT Reporting Date", SalesHeader."Posting Description",
          SalesHeader."Shortcut Dimension 1 Code", SalesHeader."Shortcut Dimension 2 Code",
          SalesHeader."Dimension Set ID", SalesHeader."Reason Code");

        GenJnlLine.CopyDocumentFields(DocType, DocNo, ExtDocNo, SourceCode, '');
        GenJnlLine."Account Type" := GenJnlLine."Account Type"::Customer;
        GenJnlLine."Account No." := SalesHeader."Bill-to Customer No.";
        GenJnlLine.CopyFromSalesHeader(SalesHeader);
        GenJnlLine.SetCurrencyFactor(SalesHeader."Currency Code", SalesHeader."Currency Factor");

        GenJnlLine."System-Created Entry" := true;

        GenJnlLine.CopyFromSalesHeaderApplyTo(SalesHeader);
        GenJnlLine.CopyFromSalesHeaderPayment(SalesHeader);

        GenJnlLine.Amount := -LineAmtInclVAT;
        GenJnlLine."Source Currency Amount" := -LineAmtInclVAT;
        GenJnlLine."Amount (LCY)" := -LineAmtInclVATLCY;
        GenJnlLine."Sales/Purch. (LCY)" := -LineAmtLCY;
        GenJnlLine."Profit (LCY)" := -(LineAmtLCY - LineUnitCostLCY);
        GenJnlLine."Inv. Discount (LCY)" := -LineInvDiscountAmtLCY;
        GenJnlLine."Orig. Pmt. Disc. Possible" := -LinePmtDiscountAmt;
        GenJnlLine."Orig. Pmt. Disc. Possible(LCY)" :=
          CurrExchRate.ExchangeAmtFCYToLCY(
            SalesHeader.GetUseDate(), SalesHeader."Currency Code", -LinePmtDiscountAmt, SalesHeader."Currency Factor");

        GenJnlLine."Due Date" := LineDueDate;
        GenJnlLine."External Document No." := GenJnlLine."Document No.";
        //GenJnlLine."Document No." := Copystr(GenJnlLine."Document No." + '/' + Format(LineId), 1, 20);
        if (LineId > 1) then
            GenJnlLine."Document No." := Copystr(GenJnlLine."Document No.", 1, 17) + '/' + Format(LineId);
        //GenJnlLine."External Document No." := Copystr(GenJnlLine."Document No." + '/' + Format(LineId), 1, 35);

        //GenJnlLine."Document Type" := GenJnlLine."Document Type"::" ";
        //GenJnlLine."Pmt. Discount Date" := 0D;
        //GenJnlLine."Payment Discount %" := 0;


        // GenJnlLine.Amount := -TotalSalesLine2."Amount Including VAT";
        // GenJnlLine."Source Currency Amount" := -TotalSalesLine2."Amount Including VAT";
        // GenJnlLine."Amount (LCY)" := -TotalSalesLineLCY2."Amount Including VAT";
        // GenJnlLine."Sales/Purch. (LCY)" := -TotalSalesLineLCY2.Amount;
        // GenJnlLine."Profit (LCY)" := -(TotalSalesLineLCY2.Amount - TotalSalesLineLCY2."Unit Cost (LCY)");
        // GenJnlLine."Inv. Discount (LCY)" := -TotalSalesLineLCY2."Inv. Discount Amount";
        // GenJnlLine."Orig. Pmt. Disc. Possible" := -TotalSalesLine2."Pmt. Discount Amount";
        // GenJnlLine."Orig. Pmt. Disc. Possible(LCY)" :=
        //   CurrExchRate.ExchangeAmtFCYToLCY(
        //     SalesHeader.GetUseDate(), SalesHeader."Currency Code", -TotalSalesLine2."Pmt. Discount Amount", SalesHeader."Currency Factor");

        //OnBeforePostCustomerEntry(GenJnlLine, SalesHeader, TotalSalesLine2, TotalSalesLineLCY2, SuppressCommit, PreviewMode, GenJnlPostLine);
        GenJnlPostLine.RunWithCheck(GenJnlLine);

        if (not IsPostingWithoutDueCreditLine(SalesHeader)) then begin
            CustLedgEntry.Reset();
            CustLedgEntry.SetCurrentKey("Document No.");
            //CustLedgEntry.SetRange("Document Type", GenJnlLine."Document Type");
            CustLedgEntry.SetRange("Document No.", GenJnlLine."Document No.");
            CustLedgEntry.FindLast();

            CreditDueLineNew.Init();
            CreditDueLineNew.TransferFields(CreditDueLine);
            CreditDueLineNew."Due Date" := CustLedgEntry."Due Date";
            CreditDueLineNew."Cust Ledger Entry No." := CustLedgEntry."Entry No.";
            CreditDueLineNew."Dimension Set ID" := SalesHeader."Dimension Set ID";
            CreditDueLineNew."Document Type" := CreditDueLine."Document Type"::"Posted Sales invoice";
            CreditDueLineNew."Customer No." := CustLedgEntry."Customer No.";
            CreditDueLineNew."Amount to pay" := CreditDueLineNew."Monthly payment";
            CreditDueLineNew."Order No." := SalesHeader."No.";
            CreditDueLineNew."Document No." := DocNo;

            CreditDueLineNew.Insert(true);
        end;

        //OnAfterPostCustomerEntry(GenJnlLine, SalesHeader, TotalSalesLine2, TotalSalesLineLCY2, SuppressCommit, GenJnlPostLine);
    end;

    local procedure CheckCreditDueLines(var SalesHeader: Record "Sales Header")
    var
        CreditDueLine: Record "A01 Credit Depreciation Table";
    begin
        CreditDueLine.Reset();
        CreditDueLine.SetRange("Document Type", CreditDueLine."Document Type"::"Sales order");
        CreditDueLine.SetRange("Document No.", SalesHeader."No.");
        if CreditDueLine.FindSet() then
            repeat

            until CreditDueLine.Next() < 1;


        if (not IsPostingWithoutDueCreditLine(SalesHeader)) then
            if ((CreditDueLine.Count > 0) or (SalesHeader."A01 Credit Duration (Month)" > 0)) then
                SalesHeader.TestField("A01 Credit Duration (Month)", CreditDueLine.Count);
    end;

    local procedure ProcessCreditDueLine(var SalesHeader: Record "Sales Header"; var CreditDueLine: Record "A01 Credit Depreciation Table"; var TotalSalesLine2: Record "Sales Line"; var TotalSalesLineLCY2: Record "Sales Line"; var DocType: Enum "Gen. Journal Document Type"; DocNo: Code[20]; ExtDocNo: Code[35]; SourceCode: Code[10]; var GenJnlPostLine: Codeunit "Gen. Jnl.-Post Line"; i: Integer; LineDueDate: Date)
    var
        LineAmtInclVAT: Decimal;
        LineAmtInclVATLCY: Decimal;
        LineAmtLCY: Decimal;
        LineUnitCostLCY: Decimal;
        LineInvDiscountAmtLCY: Decimal;
        LinePmtDiscountAmt: Decimal;
    begin
        if (i <> SalesHeader."A01 Credit Duration (Month)") then begin

            LineAmtInclVAT := RoundAmount(TotalSalesLine2."Amount Including VAT" / SalesHeader."A01 Credit Duration (Month)");
            LineAmtInclVATLCY := RoundAmount(TotalSalesLineLCY2."Amount Including VAT" / SalesHeader."A01 Credit Duration (Month)");
            LineAmtLCY := RoundAmount(TotalSalesLineLCY2.Amount / SalesHeader."A01 Credit Duration (Month)");
            LineUnitCostLCY := RoundAmount(TotalSalesLineLCY2."Unit Cost (LCY)" / SalesHeader."A01 Credit Duration (Month)");
            LineInvDiscountAmtLCY := RoundAmount(TotalSalesLineLCY2."Inv. Discount Amount" / SalesHeader."A01 Credit Duration (Month)");
            LinePmtDiscountAmt := RoundAmount(TotalSalesLine2."Pmt. Discount Amount" / SalesHeader."A01 Credit Duration (Month)");

            TotalLineAmtInclVAT += LineAmtInclVAT;
            TotalLineAmtInclVATLCY += LineAmtInclVATLCY;
            TotalLineAmtLCY += LineAmtLCY;
            TotalLineUnitCostLCY += LineUnitCostLCY;
            TotalLineInvDiscountAmtLCY += LineInvDiscountAmtLCY;
            TotalLinePmtDiscountAmt += LinePmtDiscountAmt;

        end else begin

            LineAmtInclVAT := Round(TotalSalesLine2."Amount Including VAT" - TotalLineAmtInclVAT);
            LineAmtInclVATLCY := Round(TotalSalesLineLCY2."Amount Including VAT" - TotalLineAmtInclVATLCY);
            LineAmtLCY := Round(TotalSalesLineLCY2.Amount - TotalLineAmtLCY);
            LineUnitCostLCY := Round(TotalSalesLineLCY2."Unit Cost (LCY)" - TotalLineUnitCostLCY);
            LineInvDiscountAmtLCY := Round(TotalSalesLineLCY2."Inv. Discount Amount" - TotalLineInvDiscountAmtLCY);
            LinePmtDiscountAmt := Round(TotalSalesLine2."Pmt. Discount Amount" - TotalLinePmtDiscountAmt);

        end;

        PostMultiDeadlinesPayment(SalesHeader, CreditDueLine, DocType, DocNo, ExtDocNo, SourceCode, GenJnlPostLine, LineAmtInclVAT,
            LineAmtInclVATLCY, LineAmtLCY, LineUnitCostLCY, LineInvDiscountAmtLCY, LinePmtDiscountAmt, LineDueDate, i);
    end;

    /// <summary>
    /// ConfirmGenerationOnInterestOnCreditDue
    /// </summary>
    /// <param name="GenJnlLine"></param>
    procedure ConfirmGenerationOnInterestOnCreditDue(GenJnlLine: Record "Gen. Journal Line")
    var
        CreditDueLine: Record "A01 Credit Depreciation Table";
        pos: Integer;
        CustEntryNo: Integer;
        intValueStr: Text;
    begin
        //CustEntryNo := 0;
        if (GenJnlLine."Message to Recipient" = '') then
            exit;
        pos := StrPos(GenJnlLine."Message to Recipient", 'AFKGIE');
        if (pos > 0) then begin
            intValueStr := CopyStr(GenJnlLine."Message to Recipient", 7);
            Evaluate(CustEntryNo, intValueStr);
            if (CustEntryNo > 0) then begin
                CreditDueLine.SetRange("Cust Ledger Entry No.", CustEntryNo);
                if (CreditDueLine.FindFirst()) then begin
                    CreditDueLine."Interest Posted" := true;
                    CreditDueLine.Modify();
                end;
            end;
        end;
    end;

    /// <summary>
    /// TransferCreditDueLinesFromQuoteToOrder.
    /// </summary>
    /// <param name="SalesOrderHeader">Record "Sales Header".</param>
    /// <param name="SalesHeader">Record "Sales Header".</param>
    procedure TransferCreditDueLinesFromQuoteToOrder(SalesOrderHeader: Record "Sales Header"; SalesHeader: Record "Sales Header")
    var
        CreditDueLine: Record "A01 Credit Depreciation Table";
        CreditDueLineNew: Record "A01 Credit Depreciation Table";
    begin
        //CustEntryNo := 0;
        CreditDueLine.SetRange("Document Type", CreditDueLine."Document Type"::"Sales Quote");
        CreditDueLine.SetRange("Document No.", SalesHeader."No.");
        if CreditDueLine.FindSet() then
            repeat

                CreditDueLineNew.Init();
                CreditDueLineNew.TransferFields(CreditDueLine);
                CreditDueLineNew."Document Type" := CreditDueLine."Document Type"::"Sales order";
                CreditDueLineNew."Document No." := SalesOrderHeader."No.";
                CreditDueLineNew."Quote No." := SalesHeader."No.";
                CreditDueLineNew.Insert(true);

            until CreditDueLine.Next() < 1;

        CreditDueLine.Reset();
        CreditDueLine.SetRange("Document Type", CreditDueLine."Document Type"::"Sales Quote");
        CreditDueLine.SetRange("Document No.", SalesHeader."No.");
        if (not CreditDueLine.IsEmpty) then
            CreditDueLine.DeleteAll();
    end;

    procedure GetDueDays(CustLedgerEntry: Record "Cust. Ledger Entry"): Integer
    var
    begin
        if (CustLedgerEntry."Closed at Date" <> 0D) then
            exit(NosDays(CustLedgerEntry."Due Date", CustLedgerEntry."Closed at Date"))
        else
            exit(NosDays(CustLedgerEntry."Due Date", Today));
    end;

    procedure NosDays(Day1: Date; Day2: Date): Integer
    var
    begin
        if Day1 > Day2 then
            exit(0);
        if Day1 = 0D then
            exit(0);
        if Day2 = 0D then
            exit(0);

        exit(Day2 - Day1);
    end;


    local procedure IsPOSGenLedgerPayment(SalesHeader: Record "Sales Header"; SalesPaymentLine: Record "A01 Sales Payment Method"): Boolean
    var
        RCPaymentMethod: Record "A01 RC Payment Method";
    begin
        if not RCPaymentMethod.get(SalesHeader."Responsibility Center", SalesPaymentLine."Payment Method") then
            exit(false);

        if (RCPaymentMethod."Bal. Account No." = '') then
            exit(false);
        //if (SalesPaymentLine."Validated Amount" <= 0) then
        //    exit(false);
        if (SalesPaymentLine."Validated Amount" <> SalesPaymentLine.Amount) then
            exit(false);
        exit(true);
    end;

    local procedure IsPOSDocumentPayment(SalesHeader: Record "Sales Header"; SalesPaymentLine: Record "A01 Sales Payment Method"): Boolean
    var
        RCPaymentMethod: Record "A01 RC Payment Method";
    begin
        if not RCPaymentMethod.get(SalesHeader."Responsibility Center", SalesPaymentLine."Payment Method") then
            exit(false);

        if (RCPaymentMethod."Payment Class") = '' then
            exit(false);

        if (SalesPaymentLine."Validated Amount" <= 0) then
            exit(false);

        if (SalesPaymentLine."Validated Amount" <> SalesPaymentLine.Amount) then
            exit(false);
        exit(true);
    end;

    procedure CheckPaymentAmount(SalesHeader: Record "Sales Header")
    var
        SalesPaymentLine: Record "A01 Sales Payment Method";
        TotalPayment: Decimal;
        LabelPayAmt: Label 'The total amount to be paid %1 is different from the order %2', comment = '%1=xx %2=xxx';
    begin
        SalesPaymentLine.Reset();
        SalesPaymentLine.SetRange("Document Type", SalesPaymentLine."Document Type"::Order);
        SalesPaymentLine.SetRange("Document No.", SalesHeader."No.");
        if (SalesPaymentLine.FindSet()) then
            repeat
                CheckPaymentAction(SalesHeader, SalesPaymentLine);
                TotalPayment := TotalPayment + SalesPaymentLine."Validated Amount";
            until SalesPaymentLine.Next() < 1;

        SalesHeader.CalcFields("Amount Including VAT");
        if (SalesHeader."Amount Including VAT" <> TotalPayment) then
            //if (not confirm(LabelPayAmt)) then
                error(LabelPayAmt, TotalPayment, SalesHeader."Amount Including VAT");

    end;





}
