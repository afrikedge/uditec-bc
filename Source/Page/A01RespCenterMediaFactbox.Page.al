
/// <summary>
/// Page A01Resp Center Media Factbox (ID 50024).
/// </summary>
page 50024 "A01Resp Center Media Factbox"

{

    ApplicationArea = All;
    Caption = 'Images';
    PageType = CardPart;
    SourceTable = "Responsibility Center";
    DeleteAllowed = false;
    InsertAllowed = false;
    LinksAllowed = false;

    layout
    {
        area(content)
        {
            field("A01 Logo"; Rec."A01 Logo")
            {
                ApplicationArea = All;
                ShowCaption = false;
            }
        }
    }



    actions
    {
        area(processing)
        {
            action(ImportPicture)
            {
                ApplicationArea = All;
                Caption = 'Import';
                Image = Import;
                ToolTip = 'Import a picture file.';

                trigger OnAction()
                var
                    FromFileName: Text;
                    InStreamPic: Instream;
                begin
                    Rec.TestField(Code);
                    if Rec.Name = '' then
                        Error(MustSpecifyNameErr);

                    if Rec."A01 Logo".HasValue() then
                        if not Confirm(OverrideImageQst) then
                            exit;

                    if UploadIntoStream('Import', '', 'All Files (*.*)|*.*', FromFileName, InStreamPic) then begin
                        Rec."A01 Logo".ImportStream(InStreamPic, FromFileName);
                        Rec.Modify(true);
                    end;

                end;
            }
            action(ExportFile)
            {
                ApplicationArea = All;
                Caption = 'Export';
                Enabled = DeleteExportEnabled;
                Image = Export;
                ToolTip = 'Export the picture to a file.';

                trigger OnAction()
                var
                    TenantMedia: Record "Tenant Media";
                    InStreamPic: InStream;
                    ImageLbl: Label '%1_Image.jpg', Comment = '%1 = ImageName';
                    FileName: Text;
                begin
                    Rec.TestField(Code);
                    Rec.TestField(Name);

                    if not Rec."A01 Logo".HasValue then
                        exit;

                    if TenantMedia.Get(Rec."A01 Logo".MediaId) then begin
                        TenantMedia.CalcFields(Content);
                        if TenantMedia.Content.HasValue then begin
                            FileName := StrSubstNo(ImageLbl, Rec.TableCaption);
                            TenantMedia.Content.CreateInStream(InStreamPic);
                            DownloadFromStream(InStreamPic, '', '', '', FileName);
                        end;
                    end;
                end;
            }
            action(DeletePicture)
            {
                ApplicationArea = All;
                Caption = 'Delete';
                Enabled = DeleteExportEnabled;
                Image = Delete;
                ToolTip = 'Delete the record.';

                trigger OnAction()
                begin
                    Rec.TestField(Code);

                    if not Confirm(DeleteImageQst) then
                        exit;

                    Clear(Rec."A01 Logo");
                    Rec.Modify(true);
                end;
            }
        }
    }

    trigger OnAfterGetCurrRecord()
    begin
        SetEditableOnPictureActions();
    end;


    var
        OverrideImageQst: Label 'The existing picture will be replaced. Do you want to continue?';
        DeleteImageQst: Label 'Are you sure you want to delete the picture?';
        DeleteExportEnabled: Boolean;
        MustSpecifyNameErr: Label 'You must specify a name before you can import a picture.';

    local procedure SetEditableOnPictureActions()
    begin
        DeleteExportEnabled := Rec."A01 Logo".HasValue;
    end;
}
