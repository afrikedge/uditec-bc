codeunit 50013 "A01 Customer Settlement Post"
{
    TableNo = "A01 Payment Document";

    trigger OnRun()
    begin
        CustomerSettlement.Copy(Rec);
        Code();
        Rec := CustomerSettlement;

        OnAfterOnRun(Rec, PostedCustSettlement);
    end;

    var
        CustomerSettlement: Record "A01 Payment Document";
        PostedCustSettlement: Record "A01 Posted Payment Document";
        CustSettlementLine: Record "A01 Payment Document Line";
        PostedCustSettlementLine: Record "A01 Posted Payment Doc Line";
        SourceCodeSetup: Record "Source Code Setup";
        AfkSetup: Record "A01 Afk Setup";
        NoSeriesMgt: Codeunit NoSeriesManagement;
        DocumentErrorsMgt: Codeunit "Document Errors Mgt.";
        GenJnlPostLine: Codeunit "Gen. Jnl.-Post Line";
        TresoMgt: Codeunit "A01 Treso Mgt";
        DocRequestMgt: Codeunit "A01 Document Request Mgt";
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

        AfkSetup.Get();

        IsHandled := false;
        OnBeforeCode(CustomerSettlement, IsHandled);
        if IsHandled then
            exit;

        ValidateHeader(CustomerSettlement);

        if not ConfirmPosting(CustomerSettlement) then
            exit;

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
        IsHandled: Boolean;
    begin

        OnBeforeCreateJournalLines(CustSettlement, GenJnlPostLine, IsHandled);
        if IsHandled then
            exit;

        SettlementLine.SetRange("Document No.", CustSettlement."No.");
        if SettlementLine.FindSet() then
            repeat
                TresoMgt.CreateNewPaymentDocFromCustomerSettlement(CustSettlement, SettlementLine);
                TresoMgt.PostCustSettlementLine(CustSettlement, SettlementLine, GenJnlPostLine);

            until SettlementLine.Next() < 1;


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

        DocRequestMgt.CheckIfValidationRequestExists(CustSettlement);

        CustSettlement.TestField("Posting Date");
        CustSettlement.TestField("Responsibility Center");
        CustSettlement.TestField("Partner No.");
        CustSettlement.TestField("No.");
        CustSettlement.TestField(Object);
        CustSettlement.CalcFields("Validated Amount");
        CustSettlement.TestField("Validated Amount");

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

    local procedure InsertPostedLines()
    begin
        CustSettlementLine.Reset();
        CustSettlementLine.SetRange("Document No.", CustomerSettlement."No.");
        if CustSettlementLine.FindSet() then
            repeat
                SaveCustSettlementLine(CustSettlementLine);
            until CustSettlementLine.Next() = 0;
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
