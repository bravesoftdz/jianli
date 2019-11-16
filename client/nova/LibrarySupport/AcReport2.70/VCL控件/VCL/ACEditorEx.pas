unit ACEditorEx;

interface
uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ComCtrls, ToolWin, Menus, AcReportVCL, AC_DataListEx, DB,
  DSDesign, Ac_VarEx,
   DesignEditors, DesignIntf
  ,
  {$IFNDEF EH_LIB_35} ColnEdit {$ENDIF} {, dbugintf};

  type
{ TACDataListProperty }

  TACVariantsExProperty = class(TCollectionProperty)
  public
    procedure Edit; override;
    function GetColOptions: TColOptions; override;
    function GetValue: string; override;
  end;
                             
{ TACDataListExProperty}

  TACDataListExProperty = class(TPropertyEditor)
    function GetAttributes: TPropertyAttributes; override;
    function GetValue: string; override;
    procedure Edit; override;
  end;

{ TACReportExEditor }

  TACReportExEditor = class(TComponentEditor)
    procedure ExecuteVerb(Index: Integer); override;
    function GetVerb(Index: Integer): string; override;
    function GetVerbCount: Integer; override;
  end;



{var
  ACDataListEditor: TACDataListEditor;
 }

procedure Register;

implementation

{dd$R *.DFM}


procedure Register;
begin
  RegisterComponentEditor(TAcReportVCL, TACReportExEditor);

  RegisterPropertyEditor(TypeInfo(TACDataListEx), TAcReportVCL, 'DataSets',
    TACVariantsExProperty{TACDataListExProperty});
  RegisterPropertyEditor(TypeInfo(TACVariantsEx), TAcReportVCL, 'Variants',
    TACVariantsExProperty);
end;

type
  TDesigner = IDesigner;
  {$IFNDEF Delphi6}
 //  TFormDesigner = IFormDesigner;
  {$ENDIF}


type
  TPersistentCracker = class(TPersistent);



procedure ShowItemsEditor(Designer: TDesigner;
  AReport: TACReportVCL);
begin
  if AReport = nil then Exit;

  ShowCollectionEditorClass(Designer, TCollectionEditor, TComponent(AReport),
    TCollection(AReport.DataSets), 'DataSets', [coAdd, coDelete, coMove]);
end;

procedure ShowVariantsEditor(Designer: TDesigner;
  AReport: TACReportVCL);
var
  Editor: TCollectionEditor;
begin
  if AReport = nil then Exit;

  ShowCollectionEditorClass(Designer, TCollectionEditor, TComponent(AReport),
    TCollection(AReport.Variants), 'Variants', [coAdd, coDelete, coMove]);
end;

{ TACDataListEditor }

{ TACDataListExProperty }

procedure TACDataListExProperty.Edit;
begin
  ShowItemsEditor(Designer, TACReportVCL(GetComponent(0)));
end;

function TACDataListExProperty.GetAttributes: TPropertyAttributes;
begin
  Result := [paDialog, paReadOnly];
end;

function TACDataListExProperty.GetValue: string;
begin
  FmtStr(Result, '(%s)', [GetPropType^.Name]);
end;


{ TACReportExEditor }

procedure TACReportExEditor.ExecuteVerb(Index: Integer);
begin
  case Index of
    0: ShowItemsEditor(Designer, TACReportVCL(Component));
    1: ShowVariantsEditor(Designer, TACReportVCL(Component));
    2: begin
         if not TACReportVCL(Component).CustCopyDataset then
         begin
           ShowMessage('该功能仅在报表数据传递方式设置为手动复制时才有效!(属性CustCopyDataset = true)');
           Exit;
         end
         else
         if TACReportVCL(Component).Datasets.Count <= 0 then
         begin
           ShowMessage('数据集列表(Datasets)为空!');
           Exit;
         end
         else
         begin
           TACReportVCL(Component).FillDatasetsToEngine;
           ShowMessage('数据复制完毕');
         end;
       end;
    3: TACReportVCL(Component).ShowDesigner;
  end;
  
end;

function TACReportExEditor.GetVerb(Index: Integer): string;
begin
  case Index of
    0: Result := '数据集定义'; //'Datasets Editor ...';
    1: Result := '变量定义';
    2: Result := '将数据复制到报表引擎';
    3: Result := '设计报表';
  end;
end;

function TACReportExEditor.GetVerbCount: Integer;
begin
  Result := 4;
end;

{TACVariantsExProperty}

procedure TACVariantsExProperty.Edit;
begin
  ShowCollectionEditorClass(Designer, TCollectionEditor, TComponent(GetComponent(0)),
    TCollection(GetOrdValue), 'Variants', [coAdd, coDelete, coMove]);
end;

{
function TACVariantsExProperty.GetAttributes: TPropertyAttributes;
begin
  Result := [paDialog, paReadOnly];
end;
}


function TACVariantsExProperty.GetValue: string;
begin            
  FmtStr(Result, '(%s)', [GetPropType^.Name]);
end;


function TACVariantsExProperty.GetColOptions: TColOptions;
begin     
  Result := [];
end;


end.

