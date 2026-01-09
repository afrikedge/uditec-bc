/// <summary>
/// PageExtension A01 Customer Card (ID 50006) extends Record Customer Card.
/// </summary>
pageextension 50006 "A01 Customer Card" extends "Customer Card"
{
    layout
    {
        modify("Credit Limit (LCY)")
        {
            Editable = CanSetCreditLimit;
        }
        modify("Salesperson Code")
        {
            Editable = not IsParentAccount;
        }
        addafter("Responsibility Center")
        {
            field("A01 Customer Type"; Rec."A01 Customer Type")
            {
                ApplicationArea = Basic, Suite;
            }
            field("A01 Legal Status"; Rec."A01 Legal Status")
            {
                ApplicationArea = Basic, Suite;
            }
            field("A01 Risk Level"; Rec."A01 Risk Level")
            {
                ApplicationArea = Basic, Suite;
            }
            field("A01 Identification Mode"; Rec."A01 Identification Mode")
            {
                ApplicationArea = Basic, Suite;
            }
            field("A01 Sales Mode"; Rec."A01 Sales Mode")
            {
                ApplicationArea = Basic, Suite;
                Editable = not IsParentAccount;
            }
            field("A01 Parent Customer"; Rec."A01 Parent Customer")
            {
                ApplicationArea = Basic, Suite;
            }
            field("A01 Allowed Item Category"; Rec."A01 Allowed Item Category")
            {
                ApplicationArea = Basic, Suite;
            }
            field("A01 Preferred Reminder Mode"; Rec."A01 Preferred Reminder Mode")
            {
                ApplicationArea = Basic, Suite;
            }
            field("A01 Contract No."; Rec."A01 Contract No.")
            {
                ApplicationArea = Basic, Suite;
            }
            field("A01ContractCompanyName"; ContractCompanyName)
            {
                Caption = 'Contract Company Name';
                ApplicationArea = Basic, Suite;
                Editable = false;
            }
            field("A01 ID Number"; Rec."A01 ID Number")
            {
                ApplicationArea = Basic, Suite;
            }

            field("A01 Employee Number"; Rec."A01 Employee Number")
            {
                ApplicationArea = Basic, Suite;
            }
            field("A01 Employee Function"; Rec."A01 Employee Function")
            {
                ApplicationArea = Basic, Suite;
            }
            field("A01 Employee Salary"; Rec."A01 Employee Salary")
            {
                ApplicationArea = Basic, Suite;
            }
            field("A01 Calc Risk Level"; Rec."A01 Calc Risk Level")
            {
                ApplicationArea = Basic, Suite;
            }
            field("A01 Gender"; Rec."A01 Gender")
            {
                ApplicationArea = Basic, Suite;
            }
            field("A01 Control Payment on Invoice"; Rec."A01 Control Payment on Invoice")
            {
                ApplicationArea = Basic, Suite;
            }
            field("A01 Customer Category"; Rec."A01 Customer Category")
            {
                ApplicationArea = Basic, Suite;
            }
            field("A01 Activity Center"; Rec."A01 Activity Center")
            {
                ApplicationArea = Basic, Suite;
                Editable = not IsParentAccount;
            }
            field("A01 Customer Level"; Rec."A01 Customer Level")
            {
                ApplicationArea = Basic, Suite;
            }
            field("A01 Customer Manager"; Rec."A01 Customer Manager")
            {
                ApplicationArea = Basic, Suite;
            }
            field("A01 Credit Limit Total"; A01CreditLimitTotal)
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Total Credit Limit';
            }
            field("A01 Balance Total"; A01BalanceTotal)
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Total Balance';
            }
            field("A01 Due Balance Total"; A01DueBalanceTotal)
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Total Due Balance';
            }
        }

        addafter("SIREN No.")
        {
            field("A01 NIF"; Rec."A01 NIF")
            {
                ApplicationArea = Basic, Suite;
            }
            field("A01 STAT"; Rec."A01 STAT")
            {
                ApplicationArea = Basic, Suite;
            }
            field("A01 CIF"; Rec."A01 CIF")
            {
                ApplicationArea = Basic, Suite;
            }
            field("A01 RCS"; Rec."A01 RCS")
            {
                ApplicationArea = Basic, Suite;
            }
        }
    }
    actions
    {
        addafter(ShipToAddresses)
        {
            action(A01Criteria)
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Scoring criteria';
                Image = ViewDetails;
                RunObject = Page "A01 Cust Scoring Criteria";
                RunPageLink = "Customer No." = field("No."), "Account Type" = const(Customer);
            }
            action(A01Scoring)
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Scoring';
                Image = ViewDetails;
                RunObject = Page "A01 Customer Scoring List";
                RunPageLink = "Customer No." = field("No."), "Account Type" = const(Customer);
            }
        }
        addafter(ApplyTemplate)
        {
            action(A01CalcStatus)
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Calculate status';
                Image = Calculate;
                trigger OnAction()
                var
                begin
                    Rec."A01 Calc Risk Level" := Rec.A01CalcCustStatus();
                    Rec.Modify();
                end;
            }
        }

    }
    trigger OnOpenPage()
    var
        UserSetup: Record "User Setup";
    begin
        if (UserSetup.Get(UserId)) then
            CanSetCreditLimit := UserSetup."A01 Can Set Credit Limit";
        IsParentAccount := Rec."A01 Customer Level" <> Rec."A01 Customer Level"::Operation;
    end;

    trigger OnAfterGetCurrRecord()
    var
        Contract: Record "A01 AGP Contrat";
        Cust: Record Customer;
        Contact: Record Contact;
    begin
        CalcTotals();
        ContractCompanyName := '';
        if (Contract.Get(Rec."A01 Contract No.")) then begin
            if (Contract."Account Type" = Contract."Account Type"::Customer) then
                if (Cust.Get(Contract."Customer No.")) then
                    ContractCompanyName := Cust.Name;
            if (Contract."Account Type" = Contract."Account Type"::Prospect) then
                if (Contact.Get(Contract."Customer No.")) then
                    ContractCompanyName := Contact.Name;
        end;
    end;

    local procedure CalcTotals()
    var
        ChildCustomer: Record Customer;
    begin
        A01CreditLimitTotal := 0;
        A01BalanceTotal := 0;
        A01DueBalanceTotal := 0;

        ChildCustomer.SetRange("A01 Parent Customer", Rec."No.");
        if ChildCustomer.FindSet() then
            repeat
                ChildCustomer.CalcFields("Balance", "Balance Due (LCY)");
                A01CreditLimitTotal += ChildCustomer."Credit Limit (LCY)";
                A01BalanceTotal += ChildCustomer."Balance";
                A01DueBalanceTotal += ChildCustomer."Balance Due (LCY)";
            until ChildCustomer.Next() < 1;
    end;

    var
        CanSetCreditLimit: Boolean;
        IsParentAccount: Boolean;
        ContractCompanyName: Text[100];
        A01CreditLimitTotal: Decimal;
        A01BalanceTotal: Decimal;
        A01DueBalanceTotal: Decimal;
}
