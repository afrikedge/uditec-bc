/// <summary>
/// Codeunit A01 EventsSubscribers_Page (ID 50003).
/// </summary>
codeunit 50003 "A01 EventsSubscribers_Page"
{
    [EventSubscriber(ObjectType::Page, Page::"Report Selection - Reminder", 'OnSetUsageFilterOnAfterSetFiltersByReportUsage', '', false, false)]
    local procedure ReportSelectionReminder_OnSetUsageFilterOnAfterSetFiltersByReportUsage(var Rec: Record "Report Selections"; ReportUsage2: Enum "Report Selection Usage Reminder")
    begin
        case ReportUsage2 of
            Enum::"Report Selection Usage Reminder"::"A01 Reminder 1":
                Rec.SetRange(Usage, Enum::"Report Selection Usage"::"A01 Reminder 1");
            Enum::"Report Selection Usage Reminder"::"A01 Reminder 2":
                Rec.SetRange(Usage, Enum::"Report Selection Usage"::"A01 Reminder 2");
            Enum::"Report Selection Usage Reminder"::"A01 Reminder 3":
                Rec.SetRange(Usage, Enum::"Report Selection Usage"::"A01 Reminder 3");
        end;
    end;

    [EventSubscriber(ObjectType::Page, Page::"Report Selection - Reminder", 'OnInitUsageFilterOnElseCase', '', false, false)]
    local procedure ReportSelectionReminder_OnInitUsageFilterOnElseCase(ReportUsage: Enum "Report Selection Usage"; var ReportUsage2: Enum "Report Selection Usage Reminder")
    begin
        case ReportUsage2 of
            Enum::"Report Selection Usage"::"A01 Reminder 1":
                ReportUsage2 := ReportUsage2::"A01 Reminder 1";
            Enum::"Report Selection Usage"::"A01 Reminder 2":
                ReportUsage2 := ReportUsage2::"A01 Reminder 2";
            Enum::"Report Selection Usage"::"A01 Reminder 3":
                ReportUsage2 := ReportUsage2::"A01 Reminder 3";
        end;
    end;
}
