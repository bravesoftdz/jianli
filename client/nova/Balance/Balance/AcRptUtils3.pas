unit AcRptUtils3;

interface
uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, DB, AcReport_TLB;

type

  TAcNetStream = class(TComponent, IAcNetStream)
  private
    FConnStream: TStream;
  protected
    function Read(var Buffer: WideString; Count: Integer): Integer; safecall;
    function Write(const Buffer: WideString; Count: Integer): Integer; safecall;
    function Seek(Offset: Integer; Origin: SeekOrg): Integer; safecall;
    function GetSize: Integer; safecall;
    procedure SetSize(NewSize: Integer); safecall;
  public
    constructor Create(AConnStream: TStream);
    procedure ConnectTo(AConnStream: TStream);
  end;

  procedure AddCommonDatasetToAcReport(ADataset: TDataset; ARptEngine: TAcRptEngine;
   ATableName: string; const ASetFieldAliasName: boolean = true; const AIfGlobal: boolean = false);

  function LoadAcFromStream(AcEngineInt: IAcRptEngine; AStream: TStream): boolean; overload;
  function LoadAcFromStream(AcEngineObj: TAcRptEngine; AStream: TStream): boolean; overload;
  function SaveAcToStream(AcEngineInt: IAcRptEngine; AStream: TStream): boolean; overload;
  function SaveAcToStream(AcEngineObj: TAcRptEngine; AStream: TStream): boolean; overload;

  function LoadAcFromCommonBlobField(AcEngineInt: IAcRptEngine; ABlobField: TField;
     const ATitle: string = ''; const IfDisableSaveToFile: boolean = true): boolean; overload;
  function SaveAcToCommonBlobField(AcEngineInt: IAcRptEngine; ABlobField: TField): boolean; overload;
  function LoadAcFromCommonBlobField(AcEngineObj: TAcRptEngine; ABlobField: TField;
     const ATitle: string = ''; const IfDisableSaveToFile: boolean = true): boolean; overload;
  function SaveAcToCommonBlobField(AcEngineObj: TAcRptEngine; ABlobField: TField): boolean; overload;

  procedure AcCheckLastErrorAndRaise(AcEngineInt: IAcRptEngine); overload;
  function  AcGetLastErrorMsg(AcEngineInt: IAcRptEngine): string; overload;
  procedure AcCheckLastErrorAndRaise(AcEngineObj: TAcRptEngine); overload;
  function  AcGetLastErrorMsg(AcEngineObj: TAcRptEngine): string; overload;
  procedure AcSetFieldsAliasByDispName(ADataName: string; Fields: TFields; AcEngineInt: TAcRptEngine);

implementation

procedure AcSetFieldsAliasByDispName(ADataName: string; Fields: TFields; AcEngineInt: TAcRptEngine);
var
  i: integer;
  SFields, SAlias: string;
begin
  SFields := '';
  SAlias := '';
  for i := 0 to Fields.Count - 1 do
  begin
    SFields := SFields + Fields[i].FieldName + ',';
    SAlias := SAlias + Fields[i].DisplayLabel + ',';
  end;
  Delete(SFields, Length(SFields), 1);
  Delete(SAlias, Length(SAlias), 1);
  AcEngineInt.SetDataFieldAliasName(ADataName, SFields, SAlias);
end;

procedure AddCommonDatasetToAcReport(ADataset: TDataset; ARptEngine: TAcRptEngine;
   ATableName: string; const ASetFieldAliasName: boolean = true; const AIfGlobal: boolean = false);
var
  ABuilder: ICustDataBuilder;

  procedure _CreateTable;
  var
    ii: integer;
    AFieldName: string;
  begin
    ABuilder.NewTable(ATableName);
    for ii := 0 to ADataset.FieldCount - 1 do
    begin
      AFieldName := ADataset.Fields[ii].FieldName;
      if ASetFieldAliasName then
        AFieldName := ADataset.Fields[ii].DisplayLabel;

      if (ADataset.Fields[ii].DataType in [ftInteger, ftSmallint, ftAutoInc, ftWord, ftBoolean]) then
        ABuilder.AddIntegerField(ATableName, AFieldName)
      else
      if ADataset.Fields[ii].DataType in [ftFloat, ftBCD, ftCurrency] then
        ABuilder.AddFloatField(ATableName, AFieldName)
      else
      if ADataset.Fields[ii].DataType in [ftDateTime, ftDate] then
        ABuilder.AddDateTimeField(ATableName, AFieldName)
      else
      if ADataset.Fields[ii] is TBooleanField then
        ABuilder.AddBooleanField(ATableName, AFieldName)
      else
      if ADataset.Fields[ii].DataType in [ftString, ftWideString, ftFixedChar] then
        ABuilder.AddStringField(ATableName, AFieldName, ADataset.Fields[ii].Size)
      else
      if ADataset.Fields[ii] is TBlobField then
        ABuilder.AddBlobField(ATableName, AFieldName)
      else
        ABuilder.AddVariantField(ATableName, AFieldName) //ADataset.Fields[ii].Size
    end;
  end;

  procedure _CopyData;
  var
    ii: integer;
    sti: TAcNetStream;
    st: TStream;
    AIndx: integer;
  begin
    ABuilder.OpenTable(ATableName);
    AIndx := ABuilder.SetCurrentTable(ATableName); //执行此行后，以下的方法调用可以省略TableName参数，同时提高执行效率
    with ADataset do
    begin
      Open;
      First;
      while not Eof do
      begin
        ABuilder.AppendEmptyRow('');
        for ii := 0 to ADataset.FieldCount - 1 do
        begin
          if ADataset.Fields[ii] is TBlobField then
          begin
            st := TMemoryStream.Create;
            sti := TAcNetStream.Create(st);
            try
              TBlobField(ADataset.Fields[ii]).SaveToStream(st);
              st.Position := 0;

              ABuilder.SetBlobField('', ADataset.Fields[ii].DisplayLabel, sti);
            finally
              st.Free;
              sti.Free;
            end;
          end
          else
            ABuilder.SetFieldValue(ATableName, ii, ADataset.Fields[ii].Value); //字段参数即可以用ii,也可以用 ADataset.Fields[ii].DisplayLabel
        end;
        Next;
      end;
    end;
  end;

begin
  if ATableName = '' then
    ATableName := ADataset.Name;

  if AIfGlobal then
    ABuilder := ARptEngine.GlobalCustDataBuilder
  else
    ABuilder := ARptEngine.CustDataBuilder;

  if ABuilder.TableExist(ATableName) then
    ABuilder.RemoveTable(ATableName);

  _CreateTable;
  _CopyData;
end;

function LoadAcFromCommonBlobField(AcEngineInt: IAcRptEngine; ABlobField: TField;
  const ATitle: string = ''; const IfDisableSaveToFile: boolean = true): boolean;
var
  st: TStream;
  ANetStream: TAcNetStream;
begin
  Result := true;
  if ABlobField.IsNull then
  begin
    AcEngineInt.ClearContents;
    Exit;
  end;
  st := TMemoryStream.Create;
  ANetStream := TAcNetStream.Create(st);
  try
    AcEngineInt.SetReportFile(ATitle);
    TBlobField(ABlobField).SaveToStream(st);
    st.Position := 0;
    Result := (AcEngineInt.LoadFromStream(ANetStream) = 0);
    AcEngineInt.DisableSaveToFile := IfDisableSaveToFile;//True表示禁止退出设计器时提示保存到文件
  finally
    ANetStream.Free;
    st.Free;
  end;
end;

function SaveAcToCommonBlobField(AcEngineInt: IAcRptEngine; ABlobField: TField): boolean;
var
  st: TStream;
  ANetStream: TAcNetStream;
begin
  st := TMemoryStream.Create;
  ANetStream := TAcNetStream.Create(st);
  try
    AcEngineInt.SaveToStream(ANetStream);
    st.Position := 0;
    ABlobField.DataSet.Edit;
    TBlobField(ABlobField).LoadFromStream(st);
  finally
    ANetStream.Free;
    st.Free;
  end;
  Result := true;
end;

function LoadAcFromCommonBlobField(AcEngineObj: TAcRptEngine; ABlobField: TField;
  const ATitle: string = ''; const IfDisableSaveToFile: boolean = true): boolean;
begin
  Result := LoadAcFromCommonBlobField(AcEngineObj.DefaultInterface, ABlobField, ATitle, IfDisableSaveToFile);
end;

function SaveAcToCommonBlobField(AcEngineObj: TAcRptEngine; ABlobField: TField): boolean;
begin
  Result := SaveAcToCommonBlobField(AcEngineObj.DefaultInterface, ABlobField);
end;

function LoadAcFromStream(AcEngineInt: IAcRptEngine; AStream: TStream): boolean;
var
  ANetStream: TAcNetStream;
begin
  ANetStream := TAcNetStream.Create(AStream);
  try
    Result := (AcEngineInt.LoadFromStream(ANetStream) = 0);
  finally
    ANetStream.Free;
  end;
end;

function LoadAcFromStream(AcEngineObj: TAcRptEngine; AStream: TStream): boolean;
begin
  Result := LoadAcFromStream(AcEngineObj.DefaultInterface, AStream);
end;

function SaveAcToStream(AcEngineInt: IAcRptEngine; AStream: TStream): boolean;
var
  ANetStream: TAcNetStream;
begin
  ANetStream := TAcNetStream.Create(AStream);
  try
    Result := (AcEngineInt.SaveToStream(ANetStream) = 0);
  finally
    ANetStream.Free;
  end;
end;

function SaveAcToStream(AcEngineObj: TAcRptEngine; AStream: TStream): boolean;
begin
  Result := SaveAcToStream(AcEngineObj.DefaultInterface, AStream);
end;

procedure AcCheckLastErrorAndRaise(AcEngineInt: IAcRptEngine);
var
  n: integer;
  ws: WideString;
begin
  AcEngineInt.GetLastError(n, ws);
  if n <> 0 then
    raise Exception.Create(ws);
end;

function AcGetLastErrorMsg(AcEngineInt: IAcRptEngine): string;
var
  n: integer;
  ws: WideString;
begin
  Result := '';
  AcEngineInt.GetLastError(n, ws);
  if n <> 0 then
    Result := ws;
end;

procedure AcCheckLastErrorAndRaise(AcEngineObj: TAcRptEngine);
begin
  AcGetLastErrorMsg(AcEngineObj.DefaultInterface);
end;

function  AcGetLastErrorMsg(AcEngineObj: TAcRptEngine): string;
begin
  Result := AcGetLastErrorMsg(AcEngineObj.DefaultInterface);
end;

{ TAcNetStream }

procedure TAcNetStream.ConnectTo(AConnStream: TStream);
begin
  FConnStream := AConnStream;
end;

constructor TAcNetStream.Create(AConnStream: TStream);
begin
  inherited Create(nil);
  FConnStream := AConnStream;
end;

function TAcNetStream.GetSize: Integer;
begin
  Result := FConnStream.Size;
end;

function TAcNetStream.Read(var Buffer: WideString; Count: Integer): Integer;
var
  buf: array of byte;
  i: integer;
begin
  SetLength(buf, Count);
  Result := FConnStream.Read(buf[0], Count);
  Buffer := '';
  for i := 0 to Result - 1 do
   Buffer := Buffer + WideChar(buf[i]);
end;

function TAcNetStream.Seek(Offset: Integer; Origin: SeekOrg): Integer;
begin
  Result := FConnStream.Seek(Offset, Origin);
end;

procedure TAcNetStream.SetSize(NewSize: Integer);
begin
  FConnStream.Size := NewSize;
end;

function TAcNetStream.Write(const Buffer: WideString;
  Count: Integer): Integer;
var
  buf: array of byte;
  i: integer;
  c: Char;
begin
  SetLength(buf, Count);
  for i := 1 to Count do
  begin
    c := Char(Buffer[i]);
    buf[i - 1] := Ord(c);
  end;
  Result := FConnStream.Write(buf[0], Count);
end;


end.
