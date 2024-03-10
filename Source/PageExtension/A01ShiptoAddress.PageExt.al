/// <summary>
/// PageExtension A01 Ship-to Address (ID 50007) extends Record Ship-to Address.
/// </summary>
pageextension 50007 "A01 Ship-to Address" extends "Ship-to Address"
{
    layout
    {
        addafter("Shipment Method Code")
        {
            field("A01 Time preference"; Rec."A01 Time preference")
            {
                ApplicationArea = Basic, Suite;
            }
            field("A01 Place"; Rec."A01 Place")
            {
                ApplicationArea = Basic, Suite;
            }
            field("A01 Neighborhood"; Rec."A01 Neighborhood")
            {
                ApplicationArea = Basic, Suite;
            }
            field("A01 Area"; Rec."A01 Area")
            {
                ApplicationArea = Basic, Suite;
            }
            field("A01 Road Type"; Rec."A01 Road Type")
            {
                ApplicationArea = Basic, Suite;
            }
            field("A01 Road Type (Others)"; Rec."A01 Road Type (Others)")
            {
                ApplicationArea = Basic, Suite;
            }
            field("A01 Walking distance"; Rec."A01 Walking distance")
            {
                ApplicationArea = Basic, Suite;
            }
            field("A01 Walking distance (Others)"; Rec."A01 Walking distance (Others)")
            {
                ApplicationArea = Basic, Suite;
            }
            field("A01 Delivery Location"; Rec."A01 Delivery Location")
            {
                ApplicationArea = Basic, Suite;
            }
            field("A01 Motorcycle Access"; Rec."A01 Motorcycle Access")
            {
                ApplicationArea = Basic, Suite;
            }
            field("A01 Access Plan"; Rec."A01 Access Plan")
            {
                ApplicationArea = Basic, Suite;
            }
            field("A01 Access Type"; Rec."A01 Access Type")
            {
                ApplicationArea = Basic, Suite;
            }
            field("A01 Truck Type"; Rec."A01 Truck Type")
            {
                ApplicationArea = Basic, Suite;
            }
            field("A01 Public parking presence"; Rec."A01 Public parking presence")
            {
                ApplicationArea = Basic, Suite;
            }
            field("A01 Remarks"; Rec."A01 Remarks")
            {
                ApplicationArea = Basic, Suite;
            }
        }
        addbefore(Control1900383207)
        {
            part("A01 ShipToAdressMediaFactbox"; "A01 ShipToAdressMediaFactbox")
            {
                Caption = 'Ground Plan';
                ApplicationArea = all;
                SubPageLink = Code = field(Code);
            }
        }
    }
    actions
    {
        addafter("&Address")
        {
            action(A01ImportMedia)
            {
                ApplicationArea = All;
                Caption = 'Import Ground plan';//Plan de masse
                Image = Import;
                Visible = false;

                trigger OnAction()
                var
                    FromFileName: Text;
                    InStreamPic: Instream;
                begin
                    if UploadIntoStream('Import', '', 'All Files (*.*)|*.*', FromFileName, InStreamPic) then begin
                        Rec."A01 Ground plan".ImportStream(InStreamPic, FromFileName);
                        Rec.Modify(true);
                    end;
                end;
            }
        }
    }
}
