codeunit 50013 "A01 Customer Settlement Post"
{
    EventSubscriberInstance = Manual;
    TableNo = "A01 Payment Document";

    trigger OnRun()
    begin

        if (not PreviewMode) then
            if not ConfirmPosting(CustomerSettlement) then
                exit;


        CustomerSettlement.Copy(Rec);
        Code();
        Rec := CustomerSettlement;

        OnAfterOnRun(Rec, PostedCustSettlement);

        if PreviewMode then
            GenJnlPostPreview.ThrowError();

        if (PrintPostedDoc) then begin
            Commit();
            PostedCustSettlement.get(CustomerSettlement."Posting No.");
            PostedCustSettlement.PrintRecords(false);
        end;


    end;

    var
        CustomerSettlement: Record "A01 Payment Document";
        PostedCustSettlement: Record "A01 Posted Payment Document";
        CustSettlementLine: Record "A01 Payment Document Line";
        PostedCustSettlementLine: Record "A01 Posted Payment Doc Line";
        SourceCodeSetup: Record "Source Code Setup";
        AfkSetup: Record "A01 Afk Setup";
        NoSeriesMgt: Codeunit NoSeriesManagement;
        GLMgt: Codeunit "A01 General Legder Mgt";
        DocumentErrorsMgt: Codeunit "Document Errors Mgt.";
        GenJnlPostLine: Codeunit "Gen. Jnl.-Post Line";
        GenJnlPostPreview: Codeunit "Gen. Jnl.-Post Preview";
        TresoMgt: Codeunit "A01 Treso Mgt";
        DocRequestMgt: Codeunit "A01 Document Request Mgt";
        PreviewMode: Boolean;
        DocumentTitleMsg: Label '#1################################\\', Comment = '%1 = Document description';
        CheckingLinesMsg: Label 'Checking lines        #2######\', Comment = '%2 = counter';
        PostingLinesMsg: Label 'Posting lines         #3######', Comment = '%3 = counter';
        LblDocDescription: Label '%1 %2', Comment = '%1 = table caption, %2= N°';
        CopyFromToMsg: Label '%1 %2 -> %3 %4', Comment = '%1,%2 = table captions, %3,%4 = Order No.';
        LblPostSettlementYesNo: Label 'Do you want to post this settlement ?';
        HideProgressWindow: Boolean;
        Window: Dialog;
        //ErrorText: Text[250];
        SourceCode: Code[10];
        LineCount: Integer;
        PrintPostedDoc: Boolean;
    //ModifyHeader: Boolean;
    //LinesToPost: Boolean;
    //SuppressCommit: Boolean;
    //PreviewMode: Boolean;

    /// <summary>
    /// Code.
    /// </summary>
    procedure "Code"()
    var
        IsHandled: Boolean;
    begin

        AfkSetup.GetRecordOnce();

        IsHandled := false;
        OnBeforeCode(CustomerSettlement, IsHandled);
        if IsHandled then
            exit;

        ValidateHeader(CustomerSettlement);



        if not HideProgressWindow then begin
            Window.Open(
            DocumentTitleMsg +
            CheckingLinesMsg +
            PostingLinesMsg);
            Window.Update(1, StrSubstNo(LblDocDescription, CustomerSettlement.TableCaption(), CustomerSettlement."No."));
        end;

        LockTables(CustomerSettlement, CustSettlementLine);

        SetPostingNosSeries();

        CheckDim();

        CheckLines();

        SourceCodeSetup.Get();
        SourceCode := SourceCodeSetup."Cash Receipt Journal";

        // Insert posted header
        InsertPostedHeader(CustomerSettlement);

        InsertPostedLines();

        PostJournalLinesAndPaymentDocs(CustomerSettlement);

        FinalizePost(CustomerSettlement."No.");
    end;


    local procedure InsertPostedHeader(CustSettlement: Record "A01 Payment Document")
    var
        IsHandled: Boolean;
    begin
        OnBeforeInsertPostedHeader(CustSettlement);
        PostedCustSettlement.LockTable();
        PostedCustSettlement.Init();
        PostedCustSettlement.TransferFields(CustSettlement);
        OnInsertPostedHeaderOnAfterTransferfields(CustSettlement, PostedCustSettlement);

        // PostedCustSettlement."Pre-Assigned No." := CustSettlement."No.";
        // if CustSettlement."Posting No." <> '' then begin
        //     PostedCustSettlement."No." := CustSettlement."Posting No.";
        //     if not HideProgressWindow then
        //         Window.Update(
        //             1,
        //             StrSubstNo(
        //                 CopyFromToMsg, CustSettlement.TableCaption(), CustSettlement."No.",
        //                 PostedCustSettlement.TableCaption(), PostedCustSettlement."No."));
        // end;

        CustSettlement.TestField("Posting No.");
        PostedCustSettlement."No." := CustSettlement."Posting No.";
        if not HideProgressWindow then
            Window.Update(
                1,
                StrSubstNo(
                    CopyFromToMsg, CustSettlement.TableCaption(), CustSettlement."No.",
                    PostedCustSettlement.TableCaption(), PostedCustSettlement."No."));


        PostedCustSettlement."Source Code" := SourceCode;
        PostedCustSettlement."Settled By" := CopyStr(UserId(), 1, MaxStrLen(PostedCustSettlement."Settled By"));
        PostedCustSettlement."Settlement Date" := today;
        IsHandled := false;
        OnInsertPostedHeaderOnBeforeInsert(CustSettlement, PostedCustSettlement, IsHandled);
        if not IsHandled then
            PostedCustSettlement.Insert(true);
    end;

    local procedure SaveCustSettlementLine(SettlementLine: Record "A01 Payment Document Line")
    begin
        LineCount := LineCount + 1;
        if not HideProgressWindow then
            Window.Update(3, LineCount);

        InsertPostedLine(PostedCustSettlement, SettlementLine);

    end;



    local procedure PostJournalLinesAndPaymentDocs(CustSettlement: Record "A01 Payment Document")
    var
        SettlementLine: Record "A01 Payment Document Line";
        CustLedgEntry: record "Cust. Ledger Entry";
        IsHandled: Boolean;
        ApplyToDocType: Integer;
        ApplyToDocNo: code[20];
        PaymentPosted_Bordereau: Boolean;
        PaymentPosted_Journal: Boolean;
        PaymentPosted: Boolean;
        Err01: Label 'No payment transaction has been created for this document';
    begin

        OnBeforeCreateJournalLines(CustSettlement, GenJnlPostLine, IsHandled);
        if IsHandled then
            exit;

        if (CustSettlement."Applies-to ID" <> '') then begin
            CustLedgEntry.SetCurrentKey("Applies-to ID");
            CustLedgEntry.SetRange("Applies-to ID", CustSettlement."Applies-to ID");
            if (CustLedgEntry.FindFirst()) then begin
                ApplyToDocType := CustLedgEntry."Document Type".AsInteger();
                ApplyToDocNo := CustLedgEntry."Document No.";
            end;
        end;

        SettlementLine.SetRange("Document No.", CustSettlement."No.");
        if SettlementLine.FindSet() then
            repeat
                PaymentPosted_Bordereau := TresoMgt.CreateNewPaymentDocFromCustomerSettlement(CustSettlement, SettlementLine);
                PaymentPosted_Journal := TresoMgt.PostCustSettlementLine(CustSettlement, SettlementLine, GenJnlPostLine, ApplyToDocNo, ApplyToDocType);

                if (PaymentPosted_Bordereau or PaymentPosted_Journal) then
                    PaymentPosted := true;

            until SettlementLine.Next() < 1;

        if (not PaymentPosted) then
            Error(Err01);

        //Update future interets lines for Rebate
        if (IsRebasePayment(CustSettlement)) then
            UpdateFutureInterestLines(CustSettlement);
    end;

    local procedure InsertPostedLine(PostedCommSetttleHeader: Record "A01 Posted Payment Document"; CommSettleLine: Record "A01 Payment Document Line")
    var
        IsHandled: Boolean;
    begin
        IsHandled := false;
        OnBeforeInsertPostedLine(PostedCommSetttleHeader, CommSettleLine, PostedCustSettlementLine, IsHandled);
        if IsHandled then
            exit;
        PostedCustSettlementLine.Init();
        PostedCustSettlementLine.TransferFields(CommSettleLine);
        // PostedCustSettlementLine."Settlement Date" := Today;
        // PostedCustSettlementLine."User Id" := Copystr(UserId, 1, 50);
        PostedCustSettlementLine."Document No." := PostedCommSetttleHeader."No.";
        PostedCustSettlementLine.Insert();
    end;

    local procedure CheckLines()
    var
        PayMethod: Record "Payment Method";
        LblValidated: Label 'All lines must be validated for this operation';
    begin
        CustSettlementLine.Reset();
        CustSettlementLine.SetRange("Document No.", CustomerSettlement."No.");
        if (CustSettlementLine.IsEmpty) then
            Error(DocumentErrorsMgt.GetNothingToPostErrorMsg());
        if CustSettlementLine.FindSet() then
            repeat
                CustSettlementLine.TestField("Payment Method");
                PayMethod.get(CustSettlementLine."Payment Method");
                if (PayMethod."A01 Reference required") then
                    CustSettlementLine.TestField(Reference);
                if (CustSettlementLine.Amount <> CustSettlementLine."Validated Amount") then
                    Error(LblValidated);
            until CustSettlementLine.Next() < 1;
    end;

    local procedure CheckDim()
    begin

    end;

    local procedure ValidateHeader(CustSettlement: Record "A01 Payment Document")
    begin

        GLMgt.CheckCashboxClosingDateOnCustSettlement(CustSettlement);

        DocRequestMgt.CheckNonValidatedRequestAlreadyExists(CustSettlement);

        CustSettlement.TestField("Posting Date");
        CustSettlement.TestField("Responsibility Center");
        CustSettlement.TestField("Partner No.");
        CustSettlement.TestField("No.");
        CustSettlement.TestField(Object);
        CustSettlement.CalcFields("Validated Amount");
        CustSettlement.TestField("Validated Amount");

        if (IsRebasePayment(CustSettlement)) then
            CheckAmountForRebate(CustSettlement);

    end;

    local procedure LockTables(var CustSettlement: Record "A01 Payment Document"; var SettlementLine: Record "A01 Payment Document Line")
    begin
        CustSettlement.LockTable();
        SettlementLine.LockTable();
    end;

    local procedure SetPostingNosSeries()
    var
        ModifyHeader: Boolean;
    begin
        ModifyHeader := false;
        if CustomerSettlement."Posting No." = '' then begin
            AfkSetup.TestField("Posted Cust Settlement Nos");
            CustomerSettlement."Posting No." := NoSeriesMgt.GetNextNo(AfkSetup."Posted Cust Settlement Nos", CustomerSettlement."Posting Date", true);

            // if CustomerSettlement."No. Series" <> '' then
            //     AfkSetup.TestField("Posted Cust Settlement Nos");
            // if CustomerSettlement."No. Series" <> CustomerSettlement."Posting No. Series" then begin
            //     CustomerSettlement."Posting No." := NoSeriesMgt.GetNextNo(CustomerSettlement."Posting No. Series", CustomerSettlement."Posting Date", true);
            ModifyHeader := true;
            // end;
        end;

        if ModifyHeader then begin
            CustomerSettlement.Modify();
            // if not (SuppressCommit or PreviewMode) then
            //     Commit();
        end;
    end;

    local procedure FinalizePost(DocNo: Code[20])
    begin
        CustSettlementLine.Reset();
        CustSettlementLine.SetRange("Document No.", DocNo);
        CustSettlementLine.DeleteAll();
        CustomerSettlement.Delete();
    end;

    // local procedure PostGenJnlLine(var NextLineNo: Integer; CustSettlement: Record "A01 Payment Document"; CustSettlementLine: Record "A01 Payment Document Line")
    // var
    //     GenJournalLine: Record "Gen. Journal Line";
    //     lblCustSettlement: Label 'Cust settlement %1', Comment = '%1 = Comm Settlement No';
    //     ExpenseAccount: Code[20];
    // begin

    //     CustSetup.Get();


    // end;
    procedure CalcValuesForRebate(var CustSettlement: Record "A01 Payment Document")
    var
    begin
        if (not IsRebasePayment(CustSettlement)) then
            exit;
        CustSettlement.TestField(CustSettlement."External Document No.");
        CustSettlement."Abandon Interets" := GetAbandonInterets(CustSettlement."External Document No.");
        CustSettlement."Rebate Balance" := GetBalance(CustSettlement."External Document No.") - CustSettlement."Abandon Interets";
        CustSettlement.Modify();
    end;

    local procedure CheckAmountForRebate(CustSettlement: Record "A01 Payment Document")
    var
        CustSettlementLine1: Record "A01 Payment Document Line";
        RebateInteretsPayment: decimal;
        RebateOthersPayment: decimal;
        ErrLbl01: Label 'The amount of interest in lines does not match the remainder to be abandoned';
        ErrLbl02: Label 'The amount to be paid in lines does not match the remainder amount';
    begin
        AfkSetup.GetRecordOnce();
        AfkSetup.TestField("Rebate Payment Method");

        CustSettlementLine1.SetRange("Document No.", CustSettlement."No.");
        if CustSettlementLine1.FindSet() then
            repeat
                if (CustSettlementLine1."Payment Method" = AfkSetup."Rebate Payment Method") then
                    RebateInteretsPayment += CustSettlementLine1."Validated Amount"
                else
                    RebateOthersPayment += CustSettlementLine1."Validated Amount";
            until CustSettlementLine1.Next() < 1;

        if ((RebateInteretsPayment <> CustSettlement."Abandon Interets") or (CustSettlement."Abandon Interets" = 0)) then
            Error(ErrLbl01);

        if (RebateOthersPayment < CustSettlement."Rebate Balance") then
            Error(ErrLbl02);
    end;

    local procedure UpdateFutureInterestLines(CustSettlement: Record "A01 Payment Document")
    var
        CreditAmortLine: Record "A01 Credit Depreciation Table";
    begin
        CreditAmortLine.Reset();
        CreditAmortLine.SetRange("Document Type", CreditAmortLine."Document Type"::"Posted Sales invoice");
        CreditAmortLine.SetRange("Document No.", CustSettlement."External Document No.");
        if CreditAmortLine.FindSet(true) then
            repeat
                if (CreditAmortLine."Due Date" >= Today) then begin
                    CreditAmortLine."Interest Posted" := true;
                    CreditAmortLine.Modify();
                end;
            until CreditAmortLine.Next() < 1;
    end;

    local procedure GetAbandonInterets(InvoiceNo: Code[35]): decimal
    var
        CreditAmortLine: Record "A01 Credit Depreciation Table";
    begin
        CreditAmortLine.Reset();
        CreditAmortLine.SetRange("Document Type", CreditAmortLine."Document Type"::"Posted Sales invoice");
        CreditAmortLine.SetRange("Document No.", InvoiceNo);
        if CreditAmortLine.FindSet() then
            repeat
                if (CreditAmortLine."Due Date" >= Today) then
                    exit(CreditAmortLine."Abandoned interests");
            until CreditAmortLine.Next() < 1;
    end;

    local procedure GetBalance(InvoiceNo: Code[35]): decimal
    var
        //CreditAmortLine: Record "A01 Credit Depreciation Table";
        CustLedgerEntry: record "Cust. Ledger Entry";
        Balance: Decimal;
    begin
        // CreditAmortLine.Reset();
        // CreditAmortLine.SetRange("Document Type", CreditAmortLine."Document Type"::"Posted Sales invoice");
        // CreditAmortLine.SetRange("Document No.", InvoiceNo);
        // if CreditAmortLine.FindSet() then
        //     repeat
        //         Balance += CreditAmortLine."Amount to pay" - CreditAmortLine."Paid Amount";
        //     until CreditAmortLine.Next() < 1;

        CustLedgerEntry.SetCurrentKey("External Document No.");
        CustLedgerEntry.SetRange("External Document No.", InvoiceNo);
        CustLedgerEntry.SetAutoCalcFields("Remaining Amt. (LCY)");
        if CustLedgerEntry.FindSet() then
            repeat
                Balance += CustLedgerEntry."Remaining Amt. (LCY)";
            until CustLedgerEntry.Next() < 1;

        exit(Balance);
    end;

    local procedure ConfirmPosting(var CustSettlement: Record "A01 Payment Document") Result: Boolean
    var
        IsHandled: Boolean;
    begin
        IsHandled := false;
        OnBeforeConfirmPosting(CustSettlement, Result, IsHandled);
        if (IsHandled) then
            exit(Result);
        Result := Confirm(LblPostSettlementYesNo, false);

    end;

    local procedure IsRebasePayment(CustSettlement: Record "A01 Payment Document"): Boolean
    var
        CustSettlementLine1: Record "A01 Payment Document Line";
    begin
        AfkSetup.GetRecordOnce();
        CustSettlementLine1.Reset();
        CustSettlementLine1.SetRange("Document No.", CustSettlement."No.");
        CustSettlementLine1.SetRange("Payment Method", AfkSetup."Rebate Payment Method");
        exit(not CustSettlementLine1.IsEmpty());
    end;

    local procedure InsertPostedLines()
    begin
        CustSettlementLine.Reset();
        CustSettlementLine.SetRange("Document No.", CustomerSettlement."No.");
        if CustSettlementLine.FindSet() then
            repeat
                SaveCustSettlementLine(CustSettlementLine);
            until CustSettlementLine.Next() = 0;
    end;

    procedure SetPreviewMode(NewPreviewMode: Boolean)
    Begin
        PreviewMode := NewPreviewMode;
    end;

    procedure SetToPrint(print: Boolean)
    var
    begin
        PrintPostedDoc := print;
    end;

    procedure Preview(var PaymentHeader: Record "A01 Payment Document")
    var
        CustPaymentPost: Codeunit "A01 Customer Settlement Post";
        GenJnlPostPreview2: Codeunit "Gen. Jnl.-Post Preview";
    Begin
        BindSubscription(CustPaymentPost);
        GenJnlPostPreview2.Preview(CustPaymentPost, PaymentHeader);
    end;

    [IntegrationEvent(false, false)]
    local procedure OnBeforeCode(var CustSettlement: Record "A01 Payment Document"; var IsHandled: Boolean);
    begin
    end;

    [IntegrationEvent(false, false)]
    local procedure OnBeforeConfirmPosting(var CustSettlement: Record "A01 Payment Document"; var Result: Boolean; var IsHandled: Boolean);
    begin
    end;

    [IntegrationEvent(false, false)]
    local procedure OnAfterOnRun(var CustSettlement: Record "A01 Payment Document"; var PostedCustSettlement: Record "A01 Posted Payment Document");
    begin
    end;

    [IntegrationEvent(false, false)]
    local procedure OnBeforeInsertPostedHeader(var CustSettlement: Record "A01 Payment Document");
    begin
    end;

    [IntegrationEvent(false, false)]
    local procedure OnInsertPostedHeaderOnAfterTransferfields(CustSettlement: Record "A01 Payment Document"; var PostedCustSettlement: Record "A01 Posted Payment Document");
    begin
    end;

    [IntegrationEvent(false, false)]
    local procedure OnInsertPostedHeaderOnBeforeInsert(CustSettlement: Record "A01 Payment Document"; var PostedCustSettlement: Record "A01 Posted Payment Document"; var IsHandled: Boolean);
    begin
    end;

    [IntegrationEvent(false, false)]
    local procedure OnBeforeInsertPostedLine(PostedCustSettlement: Record "A01 Posted Payment Document"; CustSettlementLine: Record "A01 Payment Document Line"; var PostedCustSettlementLine: Record "A01 Posted Payment Doc Line"; var IsHandled: Boolean);
    begin
    end;

    [IntegrationEvent(false, false)]
    local procedure OnBeforeCreateJournalLines(CustSettlement: Record "A01 Payment Document"; var GenJnlPostLine: Codeunit "Gen. Jnl.-Post Line"; var IsHandled: Boolean);
    begin
    end;
}
