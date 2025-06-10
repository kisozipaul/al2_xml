table 50125 CustomerImport
{
    DataClassification = CustomerContent;
    Caption = 'Customer Import';

    fields
    {
        field(1; "No"; Code[20])
        {
            DataClassification = CustomerContent;
        }
        field(2; "Name"; Text[100])
        {
            DataClassification = CustomerContent;
        }
        field(3; "Address"; Text[100])
        {
            DataClassification = CustomerContent;
        }
        field(4; "City"; Text[50])
        {
            DataClassification = CustomerContent;
        }
    }

    keys
    {
        key(PK; "No") { Clustered = true; }
    }
}

xmlport 50127 "Import Customers CSV"
{
    Format = VariableText;
    Direction = Import;
    FieldDelimiter = ',';
    UseRequestPage = true;
    Caption = 'Import Customers from CSV';

    schema
    {
        textelement(Customers)
        {
            tableelement(CustomerTable; CustomerImport)
            {
                AutoSave = true;

                fieldelement(No; CustomerTable."No") { }
                fieldelement(Name; CustomerTable."Name") { }
                fieldelement(Address; CustomerTable."Address") { }
                fieldelement(City; CustomerTable."City") { }
            }
        }
    }
}

page 50125 CustomerImportList
{
    PageType = List;
    SourceTable = CustomerImport;
    ApplicationArea = All;
    UsageCategory = Lists;
    Caption = 'Imported Customers';

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("No"; Rec."No") { }
                field("Name"; Rec."Name") { }
                field("Address"; Rec."Address") { }
                field("City"; Rec."City") { }
            }
        }
    }
}

pageextension 50126 CustomerImportListExt extends CustomerImportList
{
    actions
    {
        addlast(Processing)
        {
            action("Import Customers from CSV")
            {
                Caption = 'Import Customers from CSV';
                ApplicationArea = All;
                Image = Import;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;

                RunObject = xmlport "Import Customers CSV";

                trigger OnAction()
                begin
                    // Optional: you can leave this empty
                end;
            }
        }
    }
}
