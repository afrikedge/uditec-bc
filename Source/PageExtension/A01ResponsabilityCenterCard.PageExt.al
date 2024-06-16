/// <summary>
/// PageExtension A01 Responsability Center Card (ID 50001) extends Record Responsibility Center Card.
/// </summary>
pageextension 50001 "A01 Responsability Center Card" extends "Responsibility Center Card"
{
    layout
    {
        addafter("Location Code")
        {
            field("A01 Default Customer"; Rec."A01 Default Customer")
            {
                ApplicationArea = Basic, Suite;
            }
            field("A01 Theme Color 1"; Rec."A01 Theme Color 1")
            {
                ApplicationArea = Basic, Suite;
            }
            field("A01 Theme Color 2"; Rec."A01 Theme Color 2")
            {
                ApplicationArea = Basic, Suite;
            }
            field("A01 Theme Color 3"; Rec."A01 Theme Color 3")
            {
                ApplicationArea = Basic, Suite;
            }
            field("A01 Customer Price Group"; Rec."A01 Customer Price Group")
            {
                ApplicationArea = Basic, Suite;
            }
            field("A01 Current Promotion"; Rec."A01 Current Promotion")
            {
                ApplicationArea = Basic, Suite;
            }
            field("A01 Control Payment on Invoice"; Rec."A01 Control Payment on Invoice")
            {
                ApplicationArea = Basic, Suite;
            }
            field("A01 Price list change"; Rec."A01 Price list change")
            {
                ApplicationArea = Basic, Suite;
            }
        }
        addbefore(Control1900383207)
        {
            part("A01Resp Center Media Factbox"; "A01Resp Center Media Factbox")
            {
                Caption = 'Logo';
                ApplicationArea = all;
                SubPageLink = Code = field(Code);
            }
        }


    }

    actions
    {
        addafter("Dimensions")
        {
            action("A01ItemCategories")
            {
                ApplicationArea = Comments;
                //Promoted = true;
                //PromotedCategory = Category4;
                Caption = 'Item Categories';
                Image = Category;
                RunObject = Page "A01 Resp Center Categories";
                RunPageLink = "Responsability Center Code" = field(Code);
            }
            // group(A01Logo)
            // {
            action(A01ImportMedia)
            {
                ApplicationArea = All;
                Caption = 'Import Logo';
                Image = Import;
                Visible = false;


                trigger OnAction()
                var
                    FromFileName: Text;
                    InStreamPic: Instream;
                begin
                    if UploadIntoStream('Import', '', 'All Files (*.*)|*.*', FromFileName, InStreamPic) then begin
                        Rec."A01 Logo".ImportStream(InStreamPic, FromFileName);
                        Rec.Modify(true);
                    end;
                end;
            }

            action(A01ExportMedia)
            {
                ApplicationArea = all;
                Caption = 'Export Logo';
                Image = Export;
                Visible = false;

                trigger OnAction()
                var
                    TenantMedia: Record "Tenant Media";
                    InStreamPic: InStream;
                    ImageLbl: Label '%1_Image.jpg', Comment = '%1 = ImageName';
                    FileName: Text;
                begin
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
            // }

        }
    }
}
