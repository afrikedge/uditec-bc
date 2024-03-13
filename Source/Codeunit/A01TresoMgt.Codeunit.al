/// <summary>
/// Codeunit A01 Treso Mgt (ID 50007).
/// </summary>
codeunit 50007 "A01 Treso Mgt"
{
    var
        ErrText01: Label 'Le document de paiement n''a pas été configuré pour \le modèle %1\la feuille %2\le type %3', comment = '%1=model,%2=journal,%3=type';


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


}
