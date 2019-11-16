{
 本单元重新实现了ADO的如下接口：Field, Fields, Recordset
 shaoyy, qq:229481711
}

unit CustAdoInt;

interface
uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, DB, ADODB, ADOInt;

type

  TAcProxFieldProperties = class(TComponent, Properties)
  protected
    function Get_Count: Integer; safecall;
    function _NewEnum: IUnknown; safecall;
    procedure Refresh; safecall;
    function Get_Item(Index: OleVariant): Property_; safecall;
  end;

  TAcProxFieldsProperties = class(TComponent, Properties)
  protected
    function Get_Count: Integer; safecall;
    function _NewEnum: IUnknown; safecall;
    procedure Refresh; safecall;
    function Get_Item(Index: OleVariant): Property_; safecall;
  end;

  TAcProxDatasetProperties = class(TComponent, Properties)
  protected
    function Get_Count: Integer; safecall;
    function _NewEnum: IUnknown; safecall;
    procedure Refresh; safecall;
    function Get_Item(Index: OleVariant): Property_; safecall;
  end;

  TAcProxField = class(TComponent, Field)
  private
    FInnerField: TField;
    FPops: TAcProxFieldProperties;
  protected
  //_ADO
    function Get_Properties: Properties; safecall;
  //Field
    function Get_ActualSize: Integer; safecall;
    function Get_Attributes: Integer; safecall;
    function Get_DefinedSize: Integer; safecall;
    function Get_Name: WideString; safecall;
    function Get_Type_: DataTypeEnum; safecall;
    function Get_Value: OleVariant; safecall;
    procedure Set_Value(pvar: OleVariant); safecall;
    function Get_Precision: Byte; safecall;
    function Get_NumericScale: Byte; safecall;
    procedure AppendChunk(Data: OleVariant); safecall;
    function GetChunk(Length: Integer): OleVariant; safecall;
    function Get_OriginalValue: OleVariant; safecall;
    function Get_UnderlyingValue: OleVariant; safecall;
    function Get_DataFormat: IUnknown; safecall;
    procedure Set_DataFormat(const ppiDF: IUnknown); safecall;
    procedure Set_Precision(pbPrecision: Byte); safecall;
    procedure Set_NumericScale(pbNumericScale: Byte); safecall;
    procedure Set_Type_(pDataType: DataTypeEnum); safecall;
    procedure Set_DefinedSize(pl: Integer); safecall;
    procedure Set_Attributes(pl: Integer); safecall;
  public
    constructor Create(AFiled: TField);
    destructor Destroy; override;
  end;

  TAcProxFields = class(TComponent, Fields)
  private
    FInnerFields: TFields;
    FieldList: TList;
    function GetFieldItem(AIndex: integer): TAcProxField;
    procedure ClearFields;
    procedure RefreshFields;
  protected
  //_Collection
    function Get_Count: Integer; safecall;
    function _NewEnum: IUnknown; safecall;
    procedure Refresh; safecall;
//    property Count: Integer read Get_Count;
  //Fields15
    function Get_Item(Index: OleVariant): Field; safecall;
  //  property Item[Index: OleVariant]: Field read Get_Item; default;
  //Fields
    procedure Append(const Name: WideString; Type_: DataTypeEnum; DefinedSize: Integer;
      Attrib: FieldAttributeEnum); safecall;
    procedure Delete(Index: OleVariant); safecall;
  public
    property FieldsItem[AIndex: integer]: TAcProxField read GetFieldItem;
    constructor Create(AFields: TFields);
    destructor Destroy; override;
  end;

  TAcProxDataset = class(TComponent, _Recordset)
  private
    Fields: TAcProxFields;
    FCommDataset: TDataset;
    FProps: TAcProxDatasetProperties;
  protected
    //_ADO
    function Get_Properties: Properties; safecall;
    //Record15
    function Get_AbsolutePosition: PositionEnum; safecall;
    procedure Set_AbsolutePosition(pl: PositionEnum); safecall;
    procedure Set_ActiveConnection(const pvar: IDispatch); safecall;
    procedure _Set_ActiveConnection(pvar: OleVariant); safecall;
    function Get_ActiveConnection: OleVariant; safecall;
    function Get_BOF: WordBool; safecall;
    function Get_Bookmark: OleVariant; safecall;
    procedure Set_Bookmark(pvBookmark: OleVariant); safecall;
    function Get_CacheSize: Integer; safecall;
    procedure Set_CacheSize(pl: Integer); safecall;
    function Get_CursorType: CursorTypeEnum; safecall;
    procedure Set_CursorType(plCursorType: CursorTypeEnum); safecall;
    function Get_EOF: WordBool; safecall;
    function Get_Fields: Fields; safecall;
    function Get_LockType: LockTypeEnum; safecall;
    procedure Set_LockType(plLockType: LockTypeEnum); safecall;
    function Get_MaxRecords: Integer; safecall;
    procedure Set_MaxRecords(plMaxRecords: Integer); safecall;
    function Get_RecordCount: Integer; safecall;
    procedure Set_Source(const pvSource: IDispatch); safecall;
    procedure _Set_Source(const pvSource: WideString); safecall;
    function Get_Source: OleVariant; safecall;
    procedure AddNew(FieldList: OleVariant; Values: OleVariant); safecall;
    procedure CancelUpdate; safecall;
    procedure Close; safecall;
    procedure Delete(AffectRecords: AffectEnum); safecall;
    function GetRows(Rows: Integer; Start: OleVariant; Fields: OleVariant): OleVariant; safecall;
    procedure Move(NumRecords: Integer; Start: OleVariant); safecall;
    procedure MoveNext; safecall;
    procedure MovePrevious; safecall;
    procedure MoveFirst; safecall;
    procedure MoveLast; safecall;
    procedure Open(Source: OleVariant; ActiveConnection: OleVariant; CursorType: CursorTypeEnum;
      LockType: LockTypeEnum; Options: Integer); safecall;
    procedure Requery(Options: Integer); safecall;
    procedure _xResync(AffectRecords: AffectEnum); safecall;
    procedure Update(Fields: OleVariant; Values: OleVariant); safecall;
    function Get_AbsolutePage: PositionEnum; safecall;
    procedure Set_AbsolutePage(pl: PositionEnum); safecall;
    function Get_EditMode: EditModeEnum; safecall;
    function Get_Filter: OleVariant; safecall;
    procedure Set_Filter(Criteria: OleVariant); safecall;
    function Get_PageCount: Integer; safecall;
    function Get_PageSize: Integer; safecall;
    procedure Set_PageSize(pl: Integer); safecall;
    function Get_Sort: WideString; safecall;
    procedure Set_Sort(const Criteria: WideString); safecall;
    function Get_Status: Integer; safecall;
    function Get_State: Integer; safecall;
    function _xClone: _Recordset; safecall;
    procedure UpdateBatch(AffectRecords: AffectEnum); safecall;
    procedure CancelBatch(AffectRecords: AffectEnum); safecall;
    function Get_CursorLocation: CursorLocationEnum; safecall;
    procedure Set_CursorLocation(plCursorLoc: CursorLocationEnum); safecall;
    function NextRecordset(out RecordsAffected: OleVariant): _Recordset; safecall;
    function Supports(CursorOptions: CursorOptionEnum): WordBool; safecall;
    function Get_Collect(Index: OleVariant): OleVariant; safecall;
    procedure Set_Collect(Index: OleVariant; pvar: OleVariant); safecall;
    function Get_MarshalOptions: MarshalOptionsEnum; safecall;
    procedure Set_MarshalOptions(peMarshal: MarshalOptionsEnum); safecall;
    procedure Find(const Criteria: WideString; SkipRecords: Integer;
      SearchDirection: SearchDirectionEnum; Start: OleVariant); safecall;
    
    //Record20
    procedure Cancel; safecall;
    function Get_DataSource: IUnknown; safecall;
    procedure Set_DataSource(const ppunkDataSource: IUnknown); safecall;
    procedure Save(const FileName: WideString; PersistFormat: PersistFormatEnum); safecall;
    function Get_ActiveCommand: IDispatch; safecall;
    procedure Set_StayInSync(pbStayInSync: WordBool); safecall;
    function Get_StayInSync: WordBool; safecall;
    function GetString(StringFormat: StringFormatEnum; NumRows: Integer; 
      const ColumnDelimeter: WideString; const RowDelimeter: WideString;
      const NullExpr: WideString): WideString; safecall;
    function Get_DataMember: WideString; safecall;
    procedure Set_DataMember(const pbstrDataMember: WideString); safecall;
    function CompareBookmarks(Bookmark1: OleVariant; Bookmark2: OleVariant): CompareEnum; safecall;
    function Clone(LockType: LockTypeEnum): _Recordset; safecall;
    procedure Resync(AffectRecords: AffectEnum; ResyncValues: ResyncEnum); safecall;

    //_Record
    procedure Seek(KeyValues: OleVariant; SeekOption: SeekEnum); safecall;
    procedure Set_Index(const pbstrIndex: WideString); safecall;
    function Get_Index: WideString; safecall;
  public
    constructor Create(ADataset: TDataset);
    destructor Destroy; override;
  end;

implementation

const
  adStateClosed = $00000000;
  {$EXTERNALSYM adStateClosed}
  adStateOpen = $00000001;
  {$EXTERNALSYM adStateOpen}
  adStateConnecting = $00000002;
  {$EXTERNALSYM adStateConnecting}
  adStateExecuting = $00000004;
  {$EXTERNALSYM adStateExecuting}
  adStateFetching = $00000008;
  {$EXTERNALSYM adStateFetching}

//type
 // RecordStatusEnum = TOleEnum;
const
  adRecOK = $00000000;
  {$EXTERNALSYM adRecOK}
  adRecNew = $00000001;
  {$EXTERNALSYM adRecNew}
  adRecModified = $00000002;
  {$EXTERNALSYM adRecModified}
  adRecDeleted = $00000004;
  {$EXTERNALSYM adRecDeleted}
  adRecUnmodified = $00000008;
  {$EXTERNALSYM adRecUnmodified}
  adRecInvalid = $00000010;
  {$EXTERNALSYM adRecInvalid}
  adRecMultipleChanges = $00000040;
  {$EXTERNALSYM adRecMultipleChanges}
  adRecPendingChanges = $00000080;
  {$EXTERNALSYM adRecPendingChanges}
  adRecCanceled = $00000100;
  {$EXTERNALSYM adRecCanceled}
  adRecCantRelease = $00000400;
  {$EXTERNALSYM adRecCantRelease}
  adRecConcurrencyViolation = $00000800;
  {$EXTERNALSYM adRecConcurrencyViolation}
  adRecIntegrityViolation = $00001000;
  {$EXTERNALSYM adRecIntegrityViolation}
  adRecMaxChangesExceeded = $00002000;
  {$EXTERNALSYM adRecMaxChangesExceeded}
  adRecObjectOpen = $00004000;
  {$EXTERNALSYM adRecObjectOpen}
  adRecOutOfMemory = $00008000;
  {$EXTERNALSYM adRecOutOfMemory}
  adRecPermissionDenied = $00010000;
  {$EXTERNALSYM adRecPermissionDenied}
  adRecSchemaViolation = $00020000;
  {$EXTERNALSYM adRecSchemaViolation}
  adRecDBDeleted = $00040000;
  {$EXTERNALSYM adRecDBDeleted}


function ADOTypeToFieldType(const ADOType: DataTypeEnum; EnableBCD: Boolean = True): TFieldType;
begin
  case ADOType of
    adEmpty: Result := ftUnknown;
    adTinyInt, adSmallInt: Result := ftSmallint;
    adError, adInteger, adUnsignedInt: Result := ftInteger;
    adBigInt, adUnsignedBigInt: Result := ftLargeInt;
    adUnsignedTinyInt, adUnsignedSmallInt: Result := ftWord;
    adSingle, adDouble: Result := ftFloat;
    adCurrency: Result := ftBCD;
    adBoolean: Result := ftBoolean;
    adDBDate: Result := ftDate;
    adDBTime: Result := ftTime;
    adDate, adDBTimeStamp, adFileTime, adDBFileTime: Result := ftDateTime;
    adChar: Result := ftFixedChar;
    adVarChar: Result := ftString;
    adBSTR, adWChar, adVarWChar: Result := ftWideString;
    adLongVarChar, adLongVarWChar: Result := ftMemo;
    adLongVarBinary: Result := ftBlob;
    adBinary: Result := ftBytes;
    adVarBinary: Result := ftVarBytes;
    adChapter: Result := ftDataSet;
    adPropVariant, adVariant: Result := ftVariant;
    adIUnknown: Result := ftInterface;
    adIDispatch: Result := ftIDispatch;
    adGUID: Result := ftGUID;
    adDecimal, adNumeric, adVarNumeric:
      if EnableBCD then Result := ftBCD
      else Result := ftFloat;
  else
    Result := ftUnknown;
  end;
end;

function FieldTypeToADOType(const FieldType: TFieldType): DataTypeEnum;
begin
  case FieldType of
    ftUnknown: Result := adEmpty;
    ftString, ftWideString: Result := adVarChar;
    ftSmallint: Result := adSmallint;
    ftInteger, ftAutoInc: Result := adInteger;
    ftWord: Result := adUnsignedSmallInt;
    ftBoolean: Result := adBoolean;
    ftFloat: Result := adDouble;
    ftCurrency, ftBCD: Result := adCurrency;
    ftDate: Result := adDBDate;
    ftTime: Result := adDBTime;
    ftDateTime: Result := adDBTimeStamp;
    ftBytes: Result := adBinary;
    ftVarBytes: Result := adVarBinary;
    ftMemo: Result := adLongVarChar;
    ftBlob, ftGraphic..ftTypedBinary: Result := adLongVarBinary;
    ftFixedChar: Result := adChar;
    ftLargeint: Result := adBigInt;
    ftVariant: Result := adVariant;
    ftInterface: Result := adIUnknown;
    ftIDispatch: Result := adIDispatch;
    ftGuid: Result := adGUID;
  else
    DatabaseErrorFmt('未知的类型', [FieldTypeNames[FieldType]]);
    Result := adEmpty;
  end;
end;

{ TAcProxDataset }

procedure TAcProxDataset.AddNew(FieldList, Values: OleVariant);
begin
 // FCommDataset.AppendRecord(Values);
end;

procedure TAcProxDataset.Cancel;
begin
  FCommDataset.Cancel;
end;

procedure TAcProxDataset.CancelBatch(AffectRecords: AffectEnum);
begin
  FCommDataset.Cancel;
end;

procedure TAcProxDataset.CancelUpdate;
begin
  FCommDataset.Cancel;
end;

function TAcProxDataset.Clone(LockType: LockTypeEnum): _Recordset;
begin
  Result := Self;
end;

procedure TAcProxDataset.Close;
begin
  FCommDataset.Close;
end;

function TAcProxDataset.CompareBookmarks(Bookmark1,
  Bookmark2: OleVariant): CompareEnum;
begin
  Result := FCommDataset.CompareBookmarks(Pointer(Integer(Bookmark1)), Pointer(Integer(Bookmark2)))
end;

procedure TAcProxDataset.Delete(AffectRecords: AffectEnum);
begin
  FCommDataset.Delete;
end;

procedure TAcProxDataset.Find(const Criteria: WideString;
  SkipRecords: Integer; SearchDirection: SearchDirectionEnum;
  Start: OleVariant);
begin

end;

function TAcProxDataset.Get_AbsolutePage: PositionEnum;
begin

end;

function TAcProxDataset.Get_AbsolutePosition: PositionEnum;
begin

end;

function TAcProxDataset.Get_ActiveCommand: IDispatch;
begin

end;

function TAcProxDataset.Get_ActiveConnection: OleVariant;
begin
  Result := Null;
end;

function TAcProxDataset.Get_BOF: WordBool;
begin
  Result := FCommDataset.Bof;
// if Result and FFirst then
   // Result := false;
    
 // Result := (FPosType = adPosBof);
end;

function TAcProxDataset.Get_Bookmark: OleVariant;
begin
  Result := Integer(FCommDataset.GetBookmark);
end;

function TAcProxDataset.Get_CacheSize: Integer;
begin
  Result := 0;
end;

function TAcProxDataset.Get_Collect(Index: OleVariant): OleVariant;
begin

end;

function TAcProxDataset.Get_CursorLocation: CursorLocationEnum;
begin
   Result := 0; //clUseClient
end;

function TAcProxDataset.Get_CursorType: CursorTypeEnum;
begin
  Result := 1; //ctKeyset
end;

function TAcProxDataset.Get_DataMember: WideString;
begin

end;

function TAcProxDataset.Get_DataSource: IUnknown;
begin
   Result := Null;
end;

function TAcProxDataset.Get_EditMode: EditModeEnum;
begin
  Result := 0; //adEditNone
end;

function TAcProxDataset.Get_EOF: WordBool;
begin
  Result := FCommDataset.Eof;
 // if Result and FLast then
  //  Result := false;
 //  Result := (FPosType = adPosEof);
end;

function TAcProxDataset.Get_Fields: Fields;
begin
  Result := Self.Fields;
end;

function TAcProxDataset.Get_Filter: OleVariant;
begin
  Result := FCommDataset.Filter
end;

function TAcProxDataset.GetRows(Rows: Integer; Start,
  Fields: OleVariant): OleVariant;
begin
  Result := Null;
end;

function TAcProxDataset.GetString(StringFormat: StringFormatEnum;
  NumRows: Integer; const ColumnDelimeter, RowDelimeter,
  NullExpr: WideString): WideString;
begin

end;

function TAcProxDataset.Get_Index: WideString;
begin
  Result := '';
end;

function TAcProxDataset.Get_LockType: LockTypeEnum;
begin
  Result := 1; //adLockReadOnly
end;

function TAcProxDataset.Get_MarshalOptions: MarshalOptionsEnum;
begin
  Result := 0;  //moMarshalAll, moMarshalModifiedOnly
end;

function TAcProxDataset.Get_MaxRecords: Integer;
begin
  Result := 999999;
end;

function TAcProxDataset.Get_PageCount: Integer;
begin
  Result := 0;
end;

function TAcProxDataset.Get_PageSize: Integer;
begin
  Result := 0;
end;

function TAcProxDataset.Get_Properties: Properties;
begin
  Result := Self.FProps;
end;

function TAcProxDataset.Get_RecordCount: Integer;
begin
  Result := Self.FCommDataset.RecordCount;
end;

function TAcProxDataset.Get_Sort: WideString;
begin

end;

function TAcProxDataset.Get_Source: OleVariant;
begin
  Result := Null;
end;

function TAcProxDataset.Get_State: Integer;
begin
  Result := 0;
  //if FCommDataset.Active then
    Result := Result or adStateOpen;
end;

function TAcProxDataset.Get_Status: Integer;
begin
  Result := 0;
end;

function TAcProxDataset.Get_StayInSync: WordBool;
begin
   Result := false;
end;

procedure TAcProxDataset.Move(NumRecords: Integer; Start: OleVariant);
begin
//  FCommDataset.First;
  FCommDataset.MoveBy(NumRecords);
end;

procedure TAcProxDataset.MoveFirst;
begin
  FCommDataset.First;
  FCommDataset.Next;  //消除Bof状态,ADO中MoveFirst后并非Bof状态
  FCommDataset.Prior;
end;

procedure TAcProxDataset.MoveLast;
begin
  FCommDataset.Last;
  FCommDataset.Prior; //消除Eof状态
  FCommDataset.Next;
end;

procedure TAcProxDataset.MoveNext;
begin
  //在ADO中，如果当前是Bof，执行MoveNext则是移到一行并消除Bof状态，与Delphi中的Dataset不一样(Dataset是移到第二行)
  if FCommDataset.Bof then
  begin
    FCommDataset.Next;
    FCommDataset.Prior;
    Exit;
  end;
  FCommDataset.Next;
end;

procedure TAcProxDataset.MovePrevious;
begin
  if FCommDataset.Eof then
  begin
    FCommDataset.Prior;
    FCommDataset.Next;
    Exit;
  end;
  FCommDataset.Prior;
end;

function TAcProxDataset.NextRecordset(
  out RecordsAffected: OleVariant): _Recordset;
begin
  Result := Self;
end;

procedure TAcProxDataset.Open(Source, ActiveConnection: OleVariant;
  CursorType: CursorTypeEnum; LockType: LockTypeEnum; Options: Integer);
begin
  FCommDataset.Open;
  FCommDataset.First;
end;

procedure TAcProxDataset.Requery(Options: Integer);
begin
  FCommDataset.Close;
  FCommDataset.Open;
end;

procedure TAcProxDataset.Resync(AffectRecords: AffectEnum;
  ResyncValues: ResyncEnum);
begin

end;

procedure TAcProxDataset.Save(const FileName: WideString;
  PersistFormat: PersistFormatEnum);
begin

end;

procedure TAcProxDataset.Seek(KeyValues: OleVariant; SeekOption: SeekEnum);
begin

end;

procedure TAcProxDataset.Set_AbsolutePage(pl: PositionEnum);
begin

end;

procedure TAcProxDataset.Set_AbsolutePosition(pl: PositionEnum);
begin

end;

procedure TAcProxDataset.Set_ActiveConnection(const pvar: IDispatch);
begin

end;

procedure TAcProxDataset.Set_Bookmark(pvBookmark: OleVariant);
begin
  FCommDataset.GotoBookmark(TBookMark(Integer(pvBookmark)));
end;

procedure TAcProxDataset.Set_CacheSize(pl: Integer);
begin

end;

procedure TAcProxDataset.Set_Collect(Index, pvar: OleVariant);
begin

end;

procedure TAcProxDataset.Set_CursorLocation(
  plCursorLoc: CursorLocationEnum);
begin

end;

procedure TAcProxDataset.Set_CursorType(plCursorType: CursorTypeEnum);
begin

end;

procedure TAcProxDataset.Set_DataMember(const pbstrDataMember: WideString);
begin

end;

procedure TAcProxDataset.Set_DataSource(const ppunkDataSource: IInterface);
begin

end;

procedure TAcProxDataset.Set_Filter(Criteria: OleVariant);
begin
  FCommDataset.Filter := Criteria;
end;

procedure TAcProxDataset.Set_Index(const pbstrIndex: WideString);
begin

end;

procedure TAcProxDataset._Set_ActiveConnection(pvar: OleVariant);
begin

end;

procedure TAcProxDataset._Set_Source(const pvSource: WideString);
begin

end;

function TAcProxDataset._xClone: _Recordset;
begin

end;

procedure TAcProxDataset._xResync(AffectRecords: AffectEnum);
begin

end;

procedure TAcProxDataset.Set_LockType(plLockType: LockTypeEnum);
begin

end;

procedure TAcProxDataset.Set_MarshalOptions(peMarshal: MarshalOptionsEnum);
begin

end;

procedure TAcProxDataset.Set_MaxRecords(plMaxRecords: Integer);
begin

end;

procedure TAcProxDataset.Set_PageSize(pl: Integer);
begin

end;

procedure TAcProxDataset.Set_Sort(const Criteria: WideString);
begin

end;

procedure TAcProxDataset.Set_Source(const pvSource: IDispatch);
begin

end;

procedure TAcProxDataset.Set_StayInSync(pbStayInSync: WordBool);
begin

end;

function TAcProxDataset.Supports(
  CursorOptions: CursorOptionEnum): WordBool;
begin
  if (adBookmark = CursorOptions) then
    Result :=  true; //adMovePrevious;
  if (adMovePrevious = CursorOptions) then
    Result :=  true; //adMovePrevious;
end;

procedure TAcProxDataset.Update(Fields, Values: OleVariant);
begin

end;

procedure TAcProxDataset.UpdateBatch(AffectRecords: AffectEnum);
begin

end;

constructor TAcProxDataset.Create(ADataset: TDataset);
begin
  inherited Create(nil);
  FCommDataset := ADataset;
  FProps := TAcProxDatasetProperties.Create(nil);
  Fields := TAcProxFields.Create(ADataset.Fields);
end;

destructor TAcProxDataset.Destroy;
begin
  Fields.Free;
  FProps.Free;
  inherited;
end;

{ TAcProxFields }

function TAcProxFields._NewEnum: IUnknown;
begin

end;

procedure TAcProxFields.Append(const Name: WideString; Type_: DataTypeEnum;
  DefinedSize: Integer; Attrib: FieldAttributeEnum);
begin

end;

procedure TAcProxFields.Delete(Index: OleVariant);
begin
  FieldsItem[Index].Free;
  FieldList.Delete(Index); 
end;

function TAcProxFields.Get_Count: Integer;
begin
  Result := FieldList.Count;
end;

function TAcProxFields.Get_Item(Index: OleVariant): Field;
begin
  Result := FieldsItem[Index]
end;

function TAcProxFields.GetFieldItem(AIndex: integer): TAcProxField;
begin
  Result := TAcProxField(FieldList[AIndex]);
end;

procedure TAcProxFields.Refresh;
begin
  RefreshFields;
end;

procedure TAcProxFields.RefreshFields;
var
  i: integer;
  AProxField: TAcProxField;
begin
  ClearFields;
  for i := 0 to FInnerFields.Count - 1 do
  begin
    AProxField := TAcProxField.Create(FInnerFields[i]);
    FieldList.Add(AProxField); 
  end;
end;

procedure TAcProxFields.ClearFields;
var
  i: integer;
begin
  for i := 0 to FieldList.Count - 1 do
    TAcProxField(FieldList[i]).Free;
  FieldList.Clear;    
end;

constructor TAcProxFields.Create(AFields: TFields);
begin
  inherited Create(nil);
  FieldList := TList.Create;
  FInnerFields := AFields;
  RefreshFields;
end;

destructor TAcProxFields.Destroy;
begin
  ClearFields;
  FieldList.Free;
  inherited;
end;

{ TAcProxField }

procedure TAcProxField.AppendChunk(Data: OleVariant);
begin

end;

function TAcProxField.Get_ActualSize: Integer;
begin
  Result := FInnerField.Size
end;

function TAcProxField.Get_Attributes: Integer;
begin
   Result := 0;
end;

function TAcProxField.Get_DataFormat: IUnknown;
begin
   Result := Null;
end;

function TAcProxField.Get_DefinedSize: Integer;
begin
   Result := FInnerField.Size;
end;

function TAcProxField.Get_Name: WideString;
begin
  Result := FInnerField.FieldName;
end;

function TAcProxField.Get_NumericScale: Byte;
begin
  Result := FInnerField.Size;
end;

function TAcProxField.Get_OriginalValue: OleVariant;
begin

end;

function TAcProxField.Get_Precision: Byte;
begin
   Result := FInnerField.Size;
end;

function TAcProxField.Get_Properties: Properties;
begin
  Result := Self.FPops;
end;

function TAcProxField.Get_Type_: DataTypeEnum;
begin
  Result := FieldTypeToADOType(FInnerField.DataType);
end;

function TAcProxField.Get_UnderlyingValue: OleVariant;
begin

end;

function TAcProxField.Get_Value: OleVariant;
begin
  Result := FInnerField.Value;
end;

function TAcProxField.GetChunk(Length: Integer): OleVariant;
begin

end;

procedure TAcProxField.Set_Attributes(pl: Integer);
begin

end;

procedure TAcProxField.Set_DataFormat(const ppiDF: IInterface);
begin

end;

procedure TAcProxField.Set_DefinedSize(pl: Integer);
begin

end;

procedure TAcProxField.Set_NumericScale(pbNumericScale: Byte);
begin

end;

procedure TAcProxField.Set_Precision(pbPrecision: Byte);
begin

end;

procedure TAcProxField.Set_Type_(pDataType: DataTypeEnum);
begin

end;

procedure TAcProxField.Set_Value(pvar: OleVariant);
begin
  FInnerField.Value := pVar 
end;

constructor TAcProxField.Create(AFiled: TField);
begin
  inherited Create(nil);
  FInnerField := AFiled; //TAcProxField.Create(AField); 
  FPops := TAcProxFieldProperties.Create(nil);
end;

destructor TAcProxField.Destroy;
begin
  FPops.Free;
  inherited;
end;

{ TAcProxFieldProperties }

function TAcProxFieldProperties._NewEnum: IUnknown;
begin

end;

function TAcProxFieldProperties.Get_Count: Integer;
begin
  Result := 0;
end;

function TAcProxFieldProperties.Get_Item(Index: OleVariant): Property_;
begin

end;

procedure TAcProxFieldProperties.Refresh;
begin

end;

{ TAcProxFieldsProperties }

function TAcProxFieldsProperties._NewEnum: IUnknown;
begin

end;

function TAcProxFieldsProperties.Get_Count: Integer;
begin
  Result := 0;
end;

function TAcProxFieldsProperties.Get_Item(Index: OleVariant): Property_;
begin

end;

procedure TAcProxFieldsProperties.Refresh;
begin

end;

{ TAcProxDatasetProperties }

function TAcProxDatasetProperties._NewEnum: IUnknown;
begin

end;

function TAcProxDatasetProperties.Get_Count: Integer;
begin
  Result := 0;
end;

function TAcProxDatasetProperties.Get_Item(Index: OleVariant): Property_;
begin

end;

procedure TAcProxDatasetProperties.Refresh;
begin

end;

end.


