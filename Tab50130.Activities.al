table 50130 "Activities"
{
    DataClassification = CustomerContent;

    fields
    {
        field(1; "No."; Code[20]) { }
        field(2; Description; Text[100])
        {
            trigger OnValidate()
            begin
                SubmitActivityDimensionVaues();
            end;
        }
        field(3; "Dimension Set ID"; Integer) { }
    }

    keys
    {
        key(PK; "No.") { Clustered = true; }
    }

    // For manual "No." entry only. If auto-assigned, remove this.
    trigger OnInsert()
    begin
        // if "No." <> '' then
        //     ValidateAndAssignActivityDimension();
    end;

    procedure SubmitActivityDimensionVaues()
    var
        Dim: Record Dimension;
        ActivityDim: TextConst ENU = 'ACTIVITIES';
        DimensionValue: Record "Dimension Value";
    begin
        Dim.Reset();
        Dim.Get(ActivityDim);
        DimensionValue."Dimension Code" := ActivityDim;
        DimensionValue.Code := "No.";
        DimensionValue.Name := Description;
        DimensionValue."Dimension Value Type" := DimensionValue."Dimension Value Type"::Standard;
        if not DimensionValue.Insert(true) then
            Error('failed %1', GetLastErrorText);
    end;

    procedure ValidateAndAssignActivityDimension()
    begin
        if "No." = '' then
            exit; // Skip if no code yet

        Message('🔧 Running dimension assignment for: %1', "No.");

        EnsureActivityDimensionExists();
        InsertOrUpdateActivityAsDimension();
        AssignActivityDimension();
    end;

    procedure EnsureActivityDimensionExists()
    var
        Dim: Record Dimension;
    begin
        if not Dim.Get('ACTIVITIES') then begin
            Dim.Init();
            Dim."Code" := 'ACTIVITIES';
            Dim."Name" := 'Activities';
            Dim.Insert();
        end;
    end;

    procedure InsertOrUpdateActivityAsDimension()
    var
        DimVal: Record "Dimension Value";
    begin
        if not DimVal.Get('ACTIVITIES', "No.") then begin
            Message('➕ Inserting dimension value for: %1', "No.");
            DimVal.Init();
            DimVal."Dimension Code" := 'ACTIVITIES';
            DimVal."Code" := "No.";
            DimVal.Name := Description;
            DimVal.Insert();
        end else begin
            DimVal.Name := Description;
            DimVal.Modify();
        end;
    end;

    procedure AssignActivityDimension()
    var
        TempDim: Record "Dimension Set Entry" temporary;
        DimMgt: Codeunit "DimensionManagement";
    begin
        TempDim.Init();
        TempDim."Dimension Code" := 'ACTIVITIES';
        TempDim."Dimension Value Code" := "No.";
        TempDim.Insert();
        "Dimension Set ID" := DimMgt.GetDimensionSetID(TempDim);
    end;
}
