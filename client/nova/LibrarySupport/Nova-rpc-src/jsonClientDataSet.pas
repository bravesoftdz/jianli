unit jsonClientDataSet;
{------------------------------------
  ����˵�������ڲ�ѯ���ݼ���ִ��action����
  �������ڣ�2011/01/30
  ���ߣ�lanck
  ��Ȩ��nova
-------------------------------------}
interface

uses Windows, DBClient, Classes, DB, SysUtils, variants, Provider, DSintf,UGuidHelper;

type

  // �м����м������Ƴ���
  TRemoveDataControl = class(TPersistent)
  private
    FRowFilter: String;
    FLineFieldNames: TStrings;
    procedure SetLineFieldNames(const Value: TStrings);
    procedure SetRowFilter(const Value: String);
  public
    constructor Create;
    destructor Destroy; override;

  published
    property RowFilter: String read FRowFilter write SetRowFilter; // �м������Ƴ���������
    property LineFieldNames
      : TStrings read FLineFieldNames write SetLineFieldNames; // �м��ֶ��Ƴ�
  end;

  TjsonClientDataSet = class(TCustomClientDataSet)
  private
    { Private declarations }
    FKeyField:String;
    FDataSourceName:String;
    FQueryAddress:String;
    FSaveAddress:String;
    FInRefreshData: Boolean;
    FAutoActive: Boolean;
    FAutoCopyRecord: Boolean;
    FCanInsert: Boolean;
    FCanEdit: Boolean;
    FCanDelete: Boolean;
    FAutoGetDetail: Boolean;
    FFieldsValue: Variant;
    FCommitProvider: string;
    FMasterEof: Boolean;
    FAutoCloneData: Boolean;
    FCloneData: OleVariant;
    FEncryptFieldNames: TStrings;
    // FPaginated: TSIEPaginated;
    FRemoveDataControl: TRemoveDataControl;
    FUpdateDataSet: String;
    FMergeLog: Boolean;
    FrefreshAfterApplyUpdates:boolean;
    procedure InternalRefreshData(ANewData: TDataSet); // �ڲ�ˢ������
    procedure SetAutoGetDetail(AValue: Boolean);
    procedure SetEncryptFieldNames(const Value: TStrings);
    // procedure SetPaginated(const Value: TSIEPaginated);
    procedure SetRemoveDataControl(const Value: TRemoveDataControl);
    procedure SetDataSourceName(const Value: String);
    procedure SetKeyField(const Value: String);
    procedure SetSaveAddress(const Value: String);
    procedure SetQueryAddress(const Value: String);
    procedure SetUpdateDataSet(const Value: String);
    procedure setMergeLog(const Value: Boolean);
  protected
    { Protected declarations }
    // ����CheckDetailRecords������ÿ��ֻȡ�����Ӧ�����ݣ��´β���ȡ
    procedure CheckDetailRecords; override;
    // ����DoApplyUpdates����
    function DoApplyUpdates(Delta: OleVariant; MaxErrors: Integer;
      out ErrorCount: Integer): OleVariant; override;
    // ����DoGetRecords��ͨ���ͻ��˹������ӹ�ϵ����PacketRecords=-2ʱ����̬ȡ�ӱ�����
    function DoGetRecords(Count: Integer; out RecsOut: Integer;
      Options: Integer; const CommandText: WideString;
      Params: OleVariant): OleVariant; override;
    // ����DoBeforeInsert�������������ʱ���жϴ���
    procedure DoBeforeInsert; override;
    // ����DoBeforeEdit�����������޸�ʱ���жϴ���
    procedure DoBeforeEdit; override;
    // ����DoBeforeDelete����������ɾ��ʱ���жϴ���
    procedure DoBeforeDelete; override;
    // ����OpenCursor������ʱ���ɼ�¼�ֶ����ݵ�����
    procedure OpenCursor(InfoQuery: Boolean); override;
    // ����CloseCursor���ر�ʱ��ռ�¼�ֶ����ݵ�����
    procedure CloseCursor; override;
    // ����DoBeforeScroll���Զ���¼��һ��¼������
    procedure DoBeforeScroll; override;
    // ����DoNewRecord���Զ�������һ��¼������
    procedure DoOnNewRecord; override;
    // ����InternalRefresh ˢ�����ݼ�
    procedure InternalRefresh; override;
  public
    { Public declarations }
    FChildLinkField: string; // �ӱ�����ֶ�
    FMasterLinkField: string; // ��������ֶ�
    AllowGetRecords: Boolean; // �Ƿ������������
    FCheckChange: Boolean; // �Ƿ��ڱ���ʱ����Ƿ��޸�
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure RefreshData(ANewData: TDataSet); // �������ݼ������ݸ��¶�Ӧ����Ϣ
    procedure ApplyDelta(); // ֻ����Delta���ݣ�������������
    property CloneData: OleVariant read FCloneData write FCloneData; // Data����
    function IsUnique(locateField, locateValue, checkField: string): Boolean;
    property ProviderName;
    // ����Ƿ�Ψһ��True��Ψһ������Ψһ

  published
    { Published declarations }
    //���ڷ���action
    property DataSourceName: String read FDataSourceName write SetDataSourceName;
    property UpdateDataSet: String read FUpdateDataSet write SetUpdateDataSet;
    property QueryAddress: String read FQueryAddress write SetQueryAddress;
    property SaveAddress: String read FSaveAddress write SetSaveAddress;
    //�����������ݼ�������,Ĭ��ΪID�ֶ�
    property KeyField: String read FKeyField write SetKeyField;
    { *��XMLClietnDataSet����һ���ַ�������(EncryptFieldNames)��¼Ҫת������ֶ�* }
    property EncryptFieldNames: TStrings read FEncryptFieldNames write
      SetEncryptFieldNames;
    { *����ֶεĸ������⣨��û���޸Ĺ���ֵҲҪ������̨��a)	��������UpdateFiledNames��¼Ҫ������̨���ֶ�ֵ* }
    property AutoActive: Boolean read FAutoActive write FAutoActive; // ��ʼʱ�Զ�����
    property AutoCopyRecord
      : Boolean read FAutoCopyRecord write FAutoCopyRecord; // �Ƿ��Զ�����ԭ��¼
    property CanInsert: Boolean read FCanInsert write FCanInsert default true;
    // �Ƿ��������
    property CanEdit: Boolean read FCanEdit write FCanEdit default true;
    // �Ƿ������޸�
    property CanDelete: Boolean read FCanDelete write FCanDelete default true;
    // �Ƿ�����ɾ��
    property CommitProvider: string read FCommitProvider write FCommitProvider;
    // �����ύ��Provider��
    property AutoGetDetail
      : Boolean read FAutoGetDetail write SetAutoGetDetail
      default true; // �Ƿ��Զ�ȡ���ݣ����ڴӱ��Ƿ��Զ�ȡ�������Ӧ������
    property CheckChange
      : Boolean read FCheckChange write FCheckChange default false;
    // �Ƿ��ڱ���ʱ����Ƿ��޸Ĺ�
    property AutoCloneData
      : Boolean read FAutoCloneData write FAutoCloneData default
      true; // ��beforeEdit��beforeInsert��ʱ����һ��Data����
    // property Paginated: TSIEPaginated read FPaginated write SetPaginated;
    // ��������ʱ�Ƿ������־
    property MergeLog: Boolean read FMergeLog write setMergeLog default true;
    property RemoveDataControl
      : TRemoveDataControl read FRemoveDataControl
      write SetRemoveDataControl;
    procedure GetDetailRecords(); // ���������¼ȡ����ǰ�ӱ�ļ�¼
    property refreshAfterApplyUpdates:boolean read FrefreshAfterApplyUpdates write FrefreshAfterApplyUpdates default false;
    property Active;
    property Aggregates;
    property AggregatesActive;
    property AutoCalcFields;
    property CommandText;
    // property ConnectionBroker;
    property Constraints;
    property DataSetField;
    property DisableStringTrim;
    property FileName;
    property Filter;
    property Filtered;
    property FilterOptions;
    property FieldDefs;
    property IndexDefs;
    property IndexFieldNames;
    property IndexName;
    // property FetchOnDemand;

    property MasterFields;
    property MasterSource;
    property ObjectView;
    property PacketRecords;
    property Params;
    property ReadOnly;
    property RemoteServer;
    property StoreDefs;
    property BeforeOpen;
    property AfterOpen;
    property BeforeClose;
    property AfterClose;
    property BeforeInsert;
    property AfterInsert;
    property BeforeEdit;
    property AfterEdit;
    property BeforePost;
    property AfterPost;
    property BeforeCancel;
    property AfterCancel;
    property BeforeDelete;
    property AfterDelete;
    property BeforeScroll;
    property AfterScroll;
    property BeforeRefresh;
    property AfterRefresh;
    property OnCalcFields;
    property OnDeleteError;
    property OnEditError;
    property OnFilterRecord;
    property OnNewRecord;
    property OnPostError;
    property OnReconcileError;
    property BeforeApplyUpdates;
    property AfterApplyUpdates;
    property BeforeGetRecords;
    property AfterGetRecords;
    property BeforeRowRequest;
    property AfterRowRequest;
    property BeforeExecute;
    property AfterExecute;
    property BeforeGetParams;
    property AfterGetParams;
  end;

procedure Register;

implementation

{$R *.dcr}

procedure Register;
begin
  RegisterComponents('Nova', [TjsonClientDataSet]);
end;

// ���ַ������ָ�����ֵ��ַ����б���
procedure SeparateTerms(s: string; Separator: char; Terms: TStringList);
var
  hs: string;
  p: Integer;
begin
  Terms.Clear;
  if Length(s) = 0 then
    Exit;
  p := Pos(Separator, s);
  while p <> 0 do
  begin
    hs := Copy(s, 1, p - 1);
    Terms.Add(hs);
    System.Delete(s, 1, p);
    p := Pos(Separator, s);
  end;
  if Length(s) > 0 then
    Terms.Add(s);
end;
{ TRemoveDataControl }

constructor TRemoveDataControl.Create;
begin
  FLineFieldNames := TStringList.Create;
end;

destructor TRemoveDataControl.Destroy;
begin
  if Assigned(FLineFieldNames) then
    FreeAndNil(FLineFieldNames);
  inherited;
end;

procedure TRemoveDataControl.SetLineFieldNames(const Value: TStrings);
begin
  FLineFieldNames.Assign(Value);
end;

procedure TRemoveDataControl.SetRowFilter(const Value: String);
begin
  FRowFilter := Value;
end;

{ TjsonClientDataSet }

procedure TjsonClientDataSet.ApplyDelta;
var
  iErrCnt: Integer;
begin
  if ((Self.State = dsInsert) or (Self.State = dsEdit)) then
    Self.Post();
  if (Self.ChangeCount > 0) then
    DoApplyUpdates(Delta, 0, iErrCnt);

end;

procedure TjsonClientDataSet.CheckDetailRecords;
var
  usCurr: TUpdateStatus;
  cdsDelta: TCustomClientDataSet;
  MasterFieldList, IndexFieldList: TStringList;
   iIndexCount: integer;
  iIndex, RecCount: Integer;
  MyField: TField;
  fields, fieldValue: string;
  valueArray: array of string;
  haveRec: Boolean;
begin
  if ((not FInRefreshData) and FAutoGetDetail and AllowGetRecords) then
  begin
    if (FMasterEof) then
    begin
      // ������������ʱ��������Ϊ������������
      FMasterEof := Self.Eof and Self.Bof;
    end;
    if (FMasterEof) then
    begin
      // ����һ�μ���ʱ�����ӱ�ͬʱΪ��ʱ�����¼���ӱ���������Ч����������
      Close();
      FMasterEof := false;
      Open();
    end
    else
    begin
      if ((MasterSource <> nil) and (MasterSource.DataSet.State <> dsInsert)
          and ProviderEOF and Self.Eof) then
      begin
        ProviderEOF := false;
      end;

      // if (not (Self.State in [dsEdit,dsInsert])) and (Self.ChangeCount=0) then
      if MasterSource <> nil then
      begin
        haveRec := false;
        DSCursor.GetRecordCount(RecCount);
        // if (MasterSource.DataSet.State = dsEdit) then
        // exit;
        if (RecCount = 0) and (Self.ChangeCount > 0) then
        begin
          cdsDelta := TCustomClientDataSet.Create(nil);
          try
            cdsDelta.Data := Self.Delta;

            MasterFieldList := TStringList.Create;
            IndexFieldList := TStringList.Create;
            try
              SeparateTerms(Self.FMasterLinkField, ';', MasterFieldList);
              SeparateTerms(Self.FChildLinkField, ';', IndexFieldList);
              iIndexCount := MasterFieldList.Count-1;
              SetLength(valueArray, MasterFieldList.Count);
              // valueArray := VarArrayCreate([0, MasterFieldList.Count-1], varString);
              for iIndex := 0 to MasterFieldList.Count - 1 do
              begin
                MyField := Self.fields.FindField(IndexFieldList[iIndex]);
                if (Assigned(MyField)) then
                begin
                  fieldValue := MasterSource.DataSet.fieldbyname
                    (MasterFieldList[iIndex]).AsString;
                  if fieldValue = '' then
                  begin
                    fields := '';
                    break;
                  end;
                  if fields <> '' then
                    fields := fields + ';';
                  fields := fields + MyField.FieldName;
                  // if values<>'' then values := values + ',';
                  // values := values + fieldValue;
                  valueArray[iIndex] := fieldValue;
                end;
              end;
            finally
              MasterFieldList.Free;
              IndexFieldList.Free;
            end;

            if (fields <> '') then
              haveRec := cdsDelta.Locate(fields, valueArray, []);

            if haveRec then
              Exit;
          finally
            FreeAndNil(cdsDelta);
          end;
        end;
      end;
      inherited CheckDetailRecords;
    end;
  end;
end;

procedure TjsonClientDataSet.CloseCursor;
begin
  inherited;
  // �������
  FFieldsValue := Unassigned;

end;

constructor TjsonClientDataSet.Create(AOwner: TComponent);
begin
  FInRefreshData := false;
  FAutoActive := false;
  FAutoCopyRecord := false;
  FAutoGetDetail := true;
  FCanInsert := true;
  FCanEdit := true;
  FMergeLog := true;
  FrefreshAfterApplyUpdates := false;
  FCanDelete := true;
  FMasterEof := false;
  FCheckChange := false;
  AllowGetRecords := true;
  inherited Create(AOwner);
  FDataSourceName:='dataSet';
  ProviderName:=TGUID.NewGUID.ToString();

  // FPaginated := TSIEPaginated.Create(self);
  FEncryptFieldNames := TStringList.Create;
  RemoveDataControl := TRemoveDataControl.Create;

end;

destructor TjsonClientDataSet.Destroy;
begin
  // if Assigned(FPaginated) then
  // FPaginated.Free;

  inherited Destroy;
  if Assigned(FRemoveDataControl) then
    FreeAndNil(FRemoveDataControl);
  FreeAndNil(FEncryptFieldNames);
  FFieldsValue := Unassigned;
end;

function TjsonClientDataSet.DoApplyUpdates(Delta: OleVariant;
  MaxErrors: Integer; out ErrorCount: Integer): OleVariant;
var
  OwnerData: OleVariant;
  cdsDelta: TCustomClientDataSet;
  sKeyField:string;
begin
  DoBeforeApplyUpdates(OwnerData);
  // Result := AppServer.AS_ApplyUpdates(ProviderName, Delta, MaxErrors, ErrorCount, OwnerData);
  // ��Ϊʹ��CommitProvider��Ϊ�����ύ��ProviderName
  if (FCommitProvider = '') then
  begin
    FCommitProvider := ProviderName;
  end;
           //���ü�¼����add by lck 20101105
          if (self.KeyField='') then
          begin
            self.FieldByName('id').ProviderFlags:= self.FieldByName('id').ProviderFlags+ [pfInkey];
          end
          else
          begin
            self.FieldByName(self.KeyField).ProviderFlags:= self.FieldByName(self.KeyField).ProviderFlags+ [pfInkey];
          end;

  Result := AppServer.AS_ApplyUpdates(FCommitProvider, Delta, MaxErrors,
    ErrorCount, OwnerData);
  if (ErrorCount <> 0) then
  begin
    // ��������Ϣ�׳��쳣
    raise Exception.Create(Result);
  end
  else if (not VarIsNull(Result)) then
  begin
    // ���ɹ�����ʱ������Delta�����޸Ĺ�������
    cdsDelta := TCustomClientDataSet.Create(nil);
    try
      cdsDelta.Data := Result;
      InternalRefreshData(cdsDelta);
    finally
      FreeAndNil(cdsDelta);
    end;
    // ��շ������ݣ�ʹ��TCustomClientDataSet��Ϊ�ɹ�����
    Result := Unassigned;
    Result := NULL;
  end;
  DoAfterApplyUpdates(OwnerData);

end;

procedure TjsonClientDataSet.DoBeforeDelete;
begin
  if (not FCanDelete) then
    Abort();
  inherited;

end;

procedure TjsonClientDataSet.DoBeforeEdit;
begin
  if (not FCanEdit) then
    Abort();

  if FAutoCloneData then
  begin
    FCloneData := NULL;
    FCloneData := Self.Data;
  end;

  inherited;

end;

procedure TjsonClientDataSet.DoBeforeInsert;
begin
  if (not FCanInsert) then
    Abort();

  if FAutoCloneData then
  begin
    FCloneData := NULL;
    FCloneData := Self.Data;
  end;

  inherited;

end;

procedure TjsonClientDataSet.DoBeforeScroll;
var
  i: Integer;
begin
  inherited;
  // ��¼�ֶ����ݵ�������
  if (FAutoCopyRecord) then
  begin
    for i := 0 to fields.Count - 1 do
    begin
      FFieldsValue[i] := fields.fields[i].Value;
    end;
  end;

end;

function TjsonClientDataSet.DoGetRecords(Count: Integer; out RecsOut: Integer;
  Options: Integer; const CommandText: WideString;
  Params: OleVariant): OleVariant;
var

  MasterValues: OleVariant;
  MasterDataSet: TDataSet;
  i, iIndex: Integer;
  MyField: TField;
  iIndexCount: Integer;
  MasterFieldList, IndexFieldList: TStringList;

  Procedure RebuildParams;
  Var
    AParam: TParams;
    i: Integer;
    vAppend: Boolean;
  Begin
    vAppend := false;
    If VarIsNull(Params) Then
      Exit;
    Try
      AParam := TParams.Create(Self);
      UnpackParams(Params, AParam);

      For i := 0 To Self.Params.Count - 1 DO
      Begin
        IF AParam.FindParam(Self.Params.Items[i].Name) = Nil Then
        Begin
          AParam.CreateParam(Self.Params.Items[i].DataType,
            Self.Params.Items[i].Name, Self.Params.Items[i].ParamType)
            .Value := Self.Params.Items[i].Value;
          vAppend := true;
        End;
        If (Self.Params.Items[i].Name = Self.MasterFields) And
          (Self.MasterSource <> Nil) And (Self.MasterSource.DataSet <> Nil)
          And (Self.MasterSource.DataSet.Active) And
          (Self.MasterSource.DataSet.RecordCount > 0) And
          (Self.Params.Items[i].Value <> Self.MasterSource.DataSet.fieldbyname
            (Self.MasterFields).AsString) Then
        Begin
          AParam.ParamByName(Self.Params.Items[i].Name)
            .Value := Self.MasterSource.DataSet.fieldbyname(Self.MasterFields)
            .AsString;
          vAppend := true;
        End;
      End;
      If vAppend Then
        Params := PackageParams(AParam);
    Finally
      FreeAndNil(AParam);
    End;
  End;

begin
  RebuildParams;
  if ((Options <> 2) or (Count <> 0)) then
  begin
    if ((not Self.Active) and (PacketRecords = 0)) then
    begin
      if ((not VarIsNull(Params)) and Assigned(MasterSource)) then
      begin
        // �ӱ�
        if (MasterSource.DataSet.IsEmpty) then
        begin
          // ������������ֻ���������ȡ����
          Result := inherited DoGetRecords(Count, RecsOut, -1, CommandText,
            Params);
        end
        else
        begin
          // �ӱ��һ�μ�����������ĵ�ǰ��¼������Ϊ����ȡ����
          MasterDataSet := MasterSource.DataSet;
          MasterFieldList := TStringList.Create;
          IndexFieldList := TStringList.Create;
          try
            SeparateTerms(Self.FMasterLinkField, ';', MasterFieldList);
            SeparateTerms(Self.FChildLinkField, ';', IndexFieldList);
            iIndexCount := MasterFieldList.Count - 1;

            { *
              ���ܣ���DataSet��Params�������뵽MasterValues������
              1�����MasterFieldList�Ѿ�����Params�����ֶΣ������
              * }
            for i := 0 to Self.Params.Count - 1 do
            begin
              if IndexFieldList.IndexOf(Self.Params.Items[i].Name) < 0 then
              begin
                Inc(iIndexCount)
              end;
            end;
            { *End Modify By 2006-09-18/HBin(�Ʊ�)* }

            // �����ɱ���������
            MasterValues := VarArrayCreate([0, iIndexCount], varVariant);
            for iIndex := 0 to MasterFieldList.Count - 1 do
            begin
              MyField := MasterDataSet.fields.FindField
                (MasterFieldList[iIndex]);
              if (Assigned(MyField)) then
              begin
                MasterValues[iIndex] := VarArrayOf([IndexFieldList[iIndex],
                  MyField.Value, MyField.DataType]);
              end;
            end;

            { *
              ��DataSet��Params�������뵽MasterValues������
              1�����MasterFieldList�Ѿ�����Params�����ֶΣ������
              * }
            iIndex := MasterFieldList.Count - 1;
            for i := 0 to Self.Params.Count - 1 do
            begin
              if IndexFieldList.IndexOf(Self.Params.Items[i].Name) < 0 then
              begin
                Inc(iIndex);
                MasterValues[iIndex] := VarArrayOf([Self.Params.Items[i].Name,
                  Self.Params.Items[i].Value, Self.Params.Items[i].DataType]);
              end;
            end;
            { *End Modify By 2006-09-18/HBin(�Ʊ�)* }
          finally
            MasterFieldList.Free;
            IndexFieldList.Free;
          end;
          Result := inherited DoGetRecords(Count, RecsOut, Options,
            CommandText, MasterValues);

        end;
      end
      else if (Self.fields.Count > 0) then
      begin
        // �Ǵӱ���PacketRecords=0ʱ����Ϊֻ�������ȡ����
        // Options=-1��ʾֻ���ȡ����
        Result := inherited DoGetRecords(Count, RecsOut, -1, CommandText,
          Params);
      end;
    end
    else // û��RemoteServerҲ�账��  if (Assigned(Self.RemoteServer)) then
    begin
      Result := inherited DoGetRecords(Count, RecsOut, Options, CommandText,
        Params);
    end;

    // �����ؼ�¼��Ϊ����ʱ������Ϊ����
    if (RecsOut < 0) then
    begin
      raise Exception.Create(Result);
    end;
  end;

end;

procedure TjsonClientDataSet.DoOnNewRecord;
var
  i: Integer;
  MyField: TField;
begin
  // ���������ݸ��Ƶ��¼�¼�ֶ���
  if (FAutoCopyRecord) then
  begin
    for i := 0 to fields.Count - 1 do
    begin
      MyField := fields.fields[i];
      if ((MyField.AutoGenerateValue = arDefault) and
          (MyField.DefaultExpression = '') and
          (not MyField.ReadOnly) and (MyField.FieldKind = fkData) and
          (not(pfInKey in MyField.ProviderFlags))) then
        MyField.Value := FFieldsValue[i];
    end;
  end;
  inherited;
end;

procedure TjsonClientDataSet.GetDetailRecords;
begin
  // ���������¼ȡ����ǰ�ӱ�ļ�¼
  if (Self.Active and Self.Eof) then
  begin
    // ֻ��Ϊ��ʱ��ȡ����
    if ((MasterSource <> nil) and (MasterSource.DataSet.State <> dsInsert)
        and ProviderEOF and Self.Eof) then
    begin
      ProviderEOF := false;
    end;
    inherited CheckDetailRecords;
  end;
end;

procedure TjsonClientDataSet.InternalRefresh;
  procedure RefreshRecords;
  const
    Options: TGetRecordOptions = [grReset];
  var
    // I: Integer;
    // SeqNo: DWord;
    RecCount: Integer;
    // DataPacket: TDataPacket;
    MasterValues: OleVariant;
    MasterDataSet: TDataSet;
    iIndex: Integer;
    MyField: TField;
    iIndexCount: Integer;
    MasterFieldList, IndexFieldList: TStringList;
  begin
    DSCursor.GetRecordCount(RecCount);
    if (MasterSource <> nil) and not MasterSource.DataSet.IsEmpty and
      (MasterSource.DataSet.State <> dsInsert) then
    begin
      MasterDataSet := MasterSource.DataSet;
      MasterFieldList := TStringList.Create;
      IndexFieldList := TStringList.Create;
      try
        SeparateTerms(Self.FMasterLinkField, ';', MasterFieldList);
        SeparateTerms(Self.FChildLinkField, ';', IndexFieldList);
        iIndexCount := MasterFieldList.Count - 1;
        MasterValues := VarArrayCreate([0, iIndexCount], varVariant);
        for iIndex := 0 to MasterFieldList.Count - 1 do
        begin
          MyField := MasterDataSet.fields.FindField(MasterFieldList[iIndex]);
          if (Assigned(MyField)) then
          begin
            MasterValues[iIndex] := VarArrayOf([IndexFieldList[iIndex],
              MyField.Value, MyField.DataType]);
          end;
        end;
      finally
        MasterFieldList.Free;
        IndexFieldList.Free;
      end;

      DSBase.Reset;
      DSBase.SetProp(dspropDSISPARTIAL, Integer(false));
      AddDataPacket(DoGetRecords(-1, RecCount, 0, '', MasterValues), false);
      if Active then
        First;
    end;
  end;

begin
  if (MasterSource <> nil) and (not MasterSource.DataSet.IsEmpty) and
    (MasterSource.DataSet.State <> dsInsert) then
  begin
    RefreshRecords;
  end
  else
    inherited InternalRefresh;

end;

procedure TjsonClientDataSet.InternalRefreshData(ANewData: TDataSet);
var
  OldMasterSource: TDataSource;
  sKeyField: string;
  fldNewData, fldSelf: TField;
  i: Integer;
  vOldKeyValue: Variant;
  bFiltered: Boolean;
  bDataSetReadOnly: Boolean;
  bFieldReadOnly: Boolean;
  bCanEdit: Boolean;
  dsneBeforeScroll: TDataSetNotifyEvent;
  dsneAfterScroll: TDataSetNotifyEvent;
  dsneBeforeEdit: TDataSetNotifyEvent;
  dsneAfterEdit: TDataSetNotifyEvent;
  dsneBeforePost: TDataSetNotifyEvent;
  dsneAfterPost: TDataSetNotifyEvent;
  fneOnChange: TFieldNotifyEvent;
  fneOnValidate: TFieldNotifyEvent;
begin
  exit;

  // ȡ�������ֶ�
{  if (FKeyField='') then
  begin
    Self.FieldByName('id').ProviderFlags:= Self.FieldByName('id').ProviderFlags+ [pfInkey];
    sKeyField:='id';
  end
  else
  begin
    sKeyField := FKeyField;
    Self.FieldByName(sKeyField).ProviderFlags:= Self.FieldByName(sKeyField).ProviderFlags+ [pfInkey];
  end;}
  sKeyField:='';
  for i := 0 to Self.fields.Count - 1 do
  begin
    if (pfInKey in Self.fields.fields[i].ProviderFlags) then
    begin
      sKeyField := Self.fields.fields[i].FieldName;
      break;
    end;
  end;

  if (sKeyField = '') then
  begin
    sKeyField := 'userid';
    raise Exception.Create('δ��������������ˢ�����ݣ�');
  end;


  // ��¼״̬
  Self.DisableControls();
  OldMasterSource := Self.MasterSource;
  vOldKeyValue := Self.fieldbyname(sKeyField).Value;
  bDataSetReadOnly := Self.ReadOnly;
  bCanEdit := FCanEdit;
  dsneBeforeScroll := Self.BeforeScroll;
  dsneAfterScroll := Self.AfterScroll;
  dsneBeforeEdit := Self.BeforeEdit;
  dsneAfterEdit := Self.AfterEdit;
  dsneBeforePost := Self.BeforePost;
  dsneAfterPost := Self.AfterPost;
  Self.MasterSource := nil;
  Self.BeforeScroll := nil;
  Self.AfterScroll := nil;
  Self.BeforeEdit := nil;
  Self.AfterEdit := nil;
  Self.BeforePost := nil;
  Self.AfterPost := nil;
  Self.ReadOnly := false;
  FCanEdit := true;
  bFiltered := Self.Filtered;
  Self.Filtered := false;
  FInRefreshData := true;

  // ����������������
  try
    ANewData.Active := true;
    ANewData.First();
    while (not ANewData.Eof) do
    begin
      if (Self.Locate(sKeyField, ANewData.fieldbyname(sKeyField).Value, []))
        then
      begin
        Self.Edit();
        for i := 0 to ANewData.fields.Count - 1 do
        begin
          fldNewData := ANewData.fields.fields[i];
          fldSelf := Self.FindField(fldNewData.FieldName);
          if (Assigned(fldSelf) and (fldNewData.Value <> fldSelf.Value)) then
          begin
            // ��¼ԭ����
            bFieldReadOnly := fldSelf.ReadOnly;
            fneOnChange := fldSelf.OnChange;
            fneOnValidate := fldSelf.OnValidate;
            fldSelf.ReadOnly := false;
            fldSelf.OnChange := nil;
            fldSelf.OnValidate := nil;
            // �޸�ֵ
            fldSelf.Value := fldNewData.Value;
            // �ָ�ԭ����
            fldSelf.ReadOnly := bFieldReadOnly;
            fldSelf.OnChange := fneOnChange;
            fldSelf.OnValidate := fneOnValidate;
          end;
        end;
        Self.Post();
      end;
      ANewData.Next();
    end;
  finally
    // �ָ�״̬
    Self.Filtered := bFiltered;
    Self.MasterSource := OldMasterSource;
    Self.ReadOnly := bDataSetReadOnly;
    FCanEdit := bCanEdit;
    FInRefreshData := false;
    Self.Locate(sKeyField, vOldKeyValue, []);
    Self.BeforeScroll := dsneBeforeScroll;
    Self.AfterScroll := dsneAfterScroll;
    Self.BeforeEdit := dsneBeforeEdit;
    Self.AfterEdit := dsneAfterEdit;
    Self.BeforePost := dsneBeforePost;
    Self.AfterPost := dsneAfterPost;
    Self.EnableControls();
  end;

end;

function TjsonClientDataSet.IsUnique(locateField, locateValue,
  checkField: string): Boolean;
var
  dsTmp: TjsonClientDataSet;
  n, i: Integer;
  Value: string;
  MasterFieldList, IndexFieldList, FilterItems: TStringList;
  MasterField: TField;
  MasterDataSet: TDataSet;
begin
  if VarIsNull(FCloneData) or VarIsEmpty(FCloneData) then
    raise Exception.Create('û������Dataset��AutoCloneData���ԣ����Բ��ܽ���Ψһ��У�飡');

  dsTmp := TjsonClientDataSet.Create(nil);
  FilterItems:=nil;
  MasterFieldList:=nil;
  IndexFieldList:=nil;
  try

    if Self.MasterSource <> nil then
    begin
      MasterDataSet := Self.MasterSource.DataSet;
      try
        MasterFieldList := TStringList.Create;
        IndexFieldList := TStringList.Create;
        FilterItems := TStringList.Create;
        SeparateTerms(Self.FMasterLinkField, ';', MasterFieldList);
        SeparateTerms(Self.FChildLinkField, ';', IndexFieldList);
        for i := 0 to MasterFieldList.Count - 1 do
        begin
          MasterField := MasterDataSet.fields.FindField(MasterFieldList[i]);
          if (Assigned(MasterField)) then
          begin
            if Self.fieldbyname(IndexFieldList[i]).DataType = ftString then
              FilterItems.Add
                (IndexFieldList[i] + '=''' + MasterField.AsString + '''')
            else
              FilterItems.Add(IndexFieldList[i] + '=' + MasterField.AsString);
          end;
        end;
        for i := 0 to FilterItems.Count - 1 do
        begin
          if dsTmp.Filter <> '' then
            dsTmp.Filter := dsTmp.Filter + ' and ';
          dsTmp.Filter := dsTmp.Filter + FilterItems[i];
        end;
      finally
        MasterFieldList.Free;
        IndexFieldList.Free;
        FilterItems.Free;
      end;

      dsTmp.Filtered := true;

    end;
    dsTmp.Data := FCloneData;
    dsTmp.Active := true;
    dsTmp.First;
    n := 0;
    Value := Self.fieldbyname(checkField).AsString;
    while not dsTmp.Eof do
    begin
      if dsTmp.fieldbyname(locateField).AsString <> locateValue then
        if dsTmp.fieldbyname(checkField).AsString = Value then
          Inc(n);
      dsTmp.Next;
    end;

    if n >= 1 then
      Result := false
    else
      Result := true;
  finally
    dsTmp.Free;
  end;

end;

procedure TjsonClientDataSet.OpenCursor(InfoQuery: Boolean);
var
  i: Integer;
  temp:String;
begin
  Filtered := false;
  if (FMasterLinkField = '') or ((trim(FMasterLinkField) <> trim(MasterFields))
      and (trim(MasterFields) <> '')) then
  begin
    FMasterLinkField := MasterFields;
  end;

  if (FChildLinkField = '') or
    ((trim(FChildLinkField) <> trim(IndexFieldNames)) and
      (trim(IndexFieldNames) <> '')) then
  begin
    FChildLinkField := IndexFieldNames;
  end;
  inherited OpenCursor(InfoQuery);
 { try
    begin
      inherited OpenCursor(InfoQuery);
    end;
  except
  end;  }
  // ������¼���ݵ�����

  FFieldsValue := VarArrayCreate([0, fields.Count - 1], varVariant);
  for i := 0 to fields.Count - 1 do
  begin
    temp:=  '--'+  IntToStr(i) + Fields[i].FieldName + ':' + Fields[i].AsString;
    FFieldsValue[i] := fields.fields[i].Value;
    temp:=VarToStr(FFieldsValue[i]);
  end;

  FMasterEof := ((MasterSource <> nil) and (MasterSource.DataSet <> nil)
      and MasterSource.DataSet.Eof);

end;

procedure TjsonClientDataSet.RefreshData(ANewData: TDataSet);
begin
  InternalRefreshData(ANewData);
  MergeChangeLog();
  CancelUpdates();
end;

procedure TjsonClientDataSet.SetDataSourceName(const Value: String);
begin
  FDataSourceName := Value;
end;


procedure TjsonClientDataSet.SetAutoGetDetail(AValue: Boolean);
begin
  FAutoGetDetail := AValue;
  if (AValue) then
  begin
    // ��Ϊtrueʱ��ȡ����ǰ��ϸ
    GetDetailRecords();
  end;
end;

procedure TjsonClientDataSet.SetEncryptFieldNames(const Value: TStrings);
begin
  FEncryptFieldNames.Assign(Value);
end;

procedure TjsonClientDataSet.SetKeyField(const Value: String);
begin
  FKeyField := Value;
end;

procedure TjsonClientDataSet.setMergeLog(const Value: Boolean);
begin
  FMergeLog := Value;
end;

procedure TjsonClientDataSet.SetQueryAddress(const Value: String);
begin
  FQueryAddress := Value;
end;

procedure TjsonClientDataSet.SetRemoveDataControl
  (const Value: TRemoveDataControl);
begin
  FRemoveDataControl := Value;
end;

procedure TjsonClientDataSet.SetSaveAddress(const Value: String);
begin
  FSaveAddress := Value;
end;

procedure TjsonClientDataSet.SetUpdateDataSet(const Value: String);
begin
  FUpdateDataSet := Value;
end;

end.
