table 50110 "Xml Port Sample"
{
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "No."; Code[20])
        {
        }
        field(2; Description; Text[100])
        {
        }
        field(3; Amount; Decimal)
        {

        }
        field(4; "Date Inserted"; DateTime)
        {
            Editable = false;
        }
        field(5; "Inserted By"; Code[50])
        {
            Editable = false;
        }
    }

    keys
    {
        key(pk; "No.")
        {
            Clustered = true;
        }
    }

    trigger OnInsert()
    begin
        "Date Inserted" := CurrentDateTime;
        "Inserted By" := UserId;
    end;
}

page 50110 "Xml Port Sample"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = "Xml Port Sample";
    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field("No."; Rec."No.")
                {

                }
                field(Description; Rec.Description)
                {

                }
                field(Amount; Rec.Amount)
                {

                }
                field("Date Inserted"; Rec."Date Inserted")
                {
                }
                field("Inserted By"; Rec."Inserted By")
                {
                }

            }
        }
    }
    actions
    {
        area(Processing)
        {
            action("Import/Export")
            {
                ApplicationArea = All;
                Image = Import;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                RunObject = xmlport "Xml Port Sample";
                trigger OnAction()
                begin
                end;
            }

            // "Xml Port Sample Xml Export"

            action("XML Export")
            {
                ApplicationArea = All;
                Image = Export;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                RunObject = xmlport "Xml Port Sample Xml Export";
            }

            action("XMLPortToImport")
            {
                ApplicationArea = All;
                Image = Export;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                RunObject = xmlport "Xml Port To Import";
            }
            action("XMLPortToImport II")
            {
                ApplicationArea = All;
                Image = Export;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                RunObject = xmlport "Xml Port To Import II";
            }

            action("XMLPortFixed Width")
            {
                ApplicationArea = All;
                Image = CopyFixedAssets;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                RunObject = xmlport "Fixed Length XML Port";

            }

        }
    }
}

xmlport 50114 "Xml Port Sample"
{
    Format = VariableText;
    //   Direction = 
    schema
    {
        textelement(XMLPORTSAMPLE)
        {
            tableelement(XMLP_Sample; "Xml Port Sample")
            {
                AutoUpdate = true;
                AutoReplace = false;
                AutoSave = true;
                fieldelement(No; XMLP_Sample."No.")
                {

                }
                fieldelement(Description; XMLP_Sample.Description)
                {
                    MinOccurs = Zero;
                }
                fieldelement(Amount; XMLP_Sample.Amount)
                {
                }
            }
        }
    }

}

xmlport 50115 "Xml Port Sample Xml Export"
{
    Format = Xml;
    schema
    {
        textelement(XMLFormat)
        {
            tableelement(XmlPortSample; "Xml Port Sample")
            {
                fieldelement(SystemId; XmlPortSample.SystemId) { }
                textelement(General)
                {
                    fieldelement(No; XmlPortSample."No.")
                    {
                        fieldattribute(Description; XmlPortSample.Description)
                        {
                        }

                    }
                    fieldelement(Amount; XmlPortSample.Amount) { }

                }
                textelement(Logs)
                {
                    fieldelement(DateInserted; XmlPortSample."Date Inserted")
                    {
                    }
                    fieldelement(InsertedBy; XmlPortSample."Inserted By")
                    {
                    }
                }
            }
        }
    }
}

xmlport 50116 "Xml Port To Import"
{
    Format = Xml;


    schema
    {
        textelement(XMLImport)
        {
            tableelement(XmlPortSample; "Xml Port Sample")
            {
                fieldattribute(No; XmlPortSample."No.") { }
                fieldattribute(Description; XmlPortSample.Description) { }
                fieldattribute(Amount; XmlPortSample.Amount) { }
            }
        }
    }
}
xmlport 50117 "Xml Port To Import II"
{
    Format = Xml;

    schema
    {
        textelement(XMLImport)
        {
            tableelement(XmlPortSample; "Xml Port Sample")
            {
                fieldelement(No; XmlPortSample."No.") { }
                fieldelement(Description; XmlPortSample.Description) { }
                fieldelement(Amount; XmlPortSample.Amount) { }
            }
        }
    }
}

xmlport 50118 "Fixed Length XML Port"
{
    Format = FixedText;
    schema
    {
        textelement(FixedXml)
        {
            tableelement(XmlPortSample; "Xml Port Sample")
            {
                AutoUpdate = true;
                fieldelement(No; XmlPortSample."No.")
                {
                    Width = 20;
                }
                fieldelement(Description; XmlPortSample.Description)
                {
                    Width = 100;
                }
                fieldelement(Amount; XmlPortSample.Amount)
                {
                    Width = 10;
                }
            }
        }
    }

}









