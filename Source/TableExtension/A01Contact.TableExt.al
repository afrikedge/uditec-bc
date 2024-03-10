/// <summary>
/// TableExtension A01 Contact (ID 50005) extends Record Contact.
/// </summary>
tableextension 50005 "A01 Contact" extends Contact
{
    fields
    {
        field(50000; "A01 Legal Status"; Enum "A01 Legal Status")
        {
            Caption = 'A01 Legal Status';
            DataClassification = CustomerContent;
        }
    }
}
