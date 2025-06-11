page 50130 "Activity Card"
{
    PageType = Card;
    SourceTable = Activities;
    ApplicationArea = All;
    Caption = 'Activity v2';

    layout
    {
        area(Content)
        {
            group(General)
            {
                field("No."; Rec."No.") { ApplicationArea = All; }
                field(Description; Rec.Description) { ApplicationArea = All; }
                field("Dimension Set ID"; Rec."Dimension Set ID") { ApplicationArea = All; Editable = false; }
            }
        }
    }

    actions
    {
        area(Processing)
        {
            action(AssignActivityDimension)
            {
                Caption = 'Assign Activity Dimension';
                ApplicationArea = All;
                Image = Dimensions;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;

                trigger OnAction()
                begin
                    if Rec."No." = '' then
                        Error('Activity code is required.');

                    Rec.EnsureActivityDimensionExists();
                    Rec.InsertOrUpdateActivityAsDimension();
                    Rec.AssignActivityDimension();
                    Rec.Modify();
                    Message('✅ Dimension assigned for Activity: %1', Rec."No.");
                end;
            }
        }
    }
}
