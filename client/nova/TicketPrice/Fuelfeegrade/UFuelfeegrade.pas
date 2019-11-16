unit UFuelfeegrade;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, USimpleCRUDForm, DBGridEhGrouping, NvPrnDbgeh, DB, DBClient,
  jsonClientDataSet, ImgList, GridsEh, DBGridEh, NvDbgridEh, StdCtrls, ComCtrls,
  ToolWin, ExtCtrls, NovaEdit, NovaHelp, NovaCheckedComboBox;

type
  TFrmFuelfeegrade = class(TSimpleCRUDForm)
    GroupBox2: TGroupBox;
    GroupBox3: TGroupBox;
    Splitter2: TSplitter;
    ToolBar3: TToolBar;
    ToolButton20: TToolButton;
    ToolButton21: TToolButton;
    ToolButton23: TToolButton;
    ToolButton22: TToolButton;
    ToolButton26: TToolButton;
    ToolButton25: TToolButton;
    NvDbgridEh2: TNvDbgridEh;
    Splitter1: TSplitter;
    Label1: TLabel;
    NovaCkbOrg: TNovaCheckedComboBox;
    Label8: TLabel;
    NHelpRoute: TNovaHelp;
    NvDbgridEh1: TNvDbgridEh;
    jscddelFuelfeegrade: TjsonClientDataSet;
    jcdsqryDistance: TjsonClientDataSet;
    DataSource1: TDataSource;
    jscdDelfuelfeegradedetail: TjsonClientDataSet;
    jscdDelDistance: TjsonClientDataSet;
    jscdqryFuelfeegradeapply: TjsonClientDataSet;
    DataSource2: TDataSource;
    DataSource3: TDataSource;
    ToolBar1: TToolBar;
    ToolButton1: TToolButton;
    ToolButton2: TToolButton;
    ToolButton3: TToolButton;
    ToolButton4: TToolButton;
    ToolButton5: TToolButton;
    ToolButton6: TToolButton;
    jscdDelFuelfeegradeapply: TjsonClientDataSet;
    procedure tbtnInsertClick(Sender: TObject);
    procedure tbtnFilterClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure tbtnEditClick(Sender: TObject);
    procedure tbtnDeleteClick(Sender: TObject);
    procedure ToolButton21Click(Sender: TObject);
    procedure jcdsResultAfterScroll(DataSet: TDataSet);
    procedure ToolButton23Click(Sender: TObject);
    procedure FormResize(Sender: TObject);
    procedure ToolButton26Click(Sender: TObject);
    procedure ToolButton2Click(Sender: TObject);
    procedure ToolButton3Click(Sender: TObject);
    procedure ToolButton5Click(Sender: TObject);
    procedure dbgrdhResultCellClick(Column: TColumnEh);
  private
    { Private declarations }
     procedure qrydistance(fuelfeegradeid:int64);
     procedure qryroutes(fuelfeegradeid,routeid:int64);
  public
    { Public declarations }
  end;

var
  FrmFuelfeegrade: TFrmFuelfeegrade;

implementation

uses UFrmFuelfeegradeEdt,UFrmFuelfeegradeApply,
 PubFn, Services, UDMPublic, UFrmFuelfeegradeDetail;
{$R *.dfm}

procedure TFrmFuelfeegrade.dbgrdhResultCellClick(Column: TColumnEh);
begin
  inherited;
  if not jcdsResult.active then
    exit;
  if jcdsResult.RecordCount = 0 then
    exit;
  qryroutes(jcdsResult.FieldByName('id').AsLargeInt,0);
end;

procedure TFrmFuelfeegrade.FormResize(Sender: TObject);
begin
  inherited;
  Panel1.Width:=trunc(self.Width/2);
  GroupBox3.Height:= trunc(self.Height/3)+10;
end;

procedure TFrmFuelfeegrade.FormShow(Sender: TObject);
begin
  inherited;
  NovaCkbOrg.Active := false;
  NovaCkbOrg.Active := true;
end;

procedure TFrmFuelfeegrade.jcdsResultAfterScroll(DataSet: TDataSet);
begin
  inherited;
  qrydistance(jcdsResult.FieldByName('id').AsLargeInt);
  //qryroutes(jcdsResult.FieldByName('id').AsLargeInt);
end;

procedure TFrmFuelfeegrade.qrydistance(fuelfeegradeid:int64);
begin
  jcdsqryDistance.Active:=false;
  jcdsqryDistance.Params.ParamValues['fuelfeegradeid']:=fuelfeegradeid;
  jcdsqryDistance.Active:=true;
end;

procedure TFrmFuelfeegrade.qryroutes(fuelfeegradeid,routeid:int64);
begin
  jscdqryFuelfeegradeapply.Active:=false;
  if fuelfeegradeid>0 then
    jscdqryFuelfeegradeapply.Params.ParamValues['filter_EQL_f!id']:=fuelfeegradeid
  else
    jscdqryFuelfeegradeapply.Params.ParamValues['filter_EQL_f!id']:=null;
  if (NHelpRoute.Text<>'') and (NHelpRoute.Id>0) then
    jscdqryFuelfeegradeapply.Params.ParamValues['filter_EQL_t!routeid']:=NHelpRoute.Id
  else
    jscdqryFuelfeegradeapply.Params.ParamValues['filter_EQL_t!routeid']:=null;
  jscdqryFuelfeegradeapply.Active:=true;
end;

procedure TFrmFuelfeegrade.tbtnDeleteClick(Sender: TObject);
var
  nResult: Integer;
  sResult,log: String;
begin
  if not jcdsResult.active then
    exit;
  if jcdsResult.RecordCount = 0 then
    exit;
  if SysDialogs.Confirm('ɾ������', 'ȷ��Ҫɾ����ȼ�ͷ�������Ϣ��') then
    try
      with jscddelFuelfeegrade do
      begin
        active := false;
        log := 'ɾ��ȼ�ͷ�������Ϣ������='+jcdsResult.FieldByName('orgname').AsString+
          ',����='+jcdsResult.FieldByName('grade').AsString+',�ͼ�������='
          +jcdsResult.FieldByName('fromprice').AsString+',ֹ='+
          jcdsResult.FieldByName('toprice').AsString;
        Params.ParamValues['fuelfeegrade.id'] := jcdsResult.FieldByName
          ('id').AsLargeInt;
        execute;
        sResult := Params.ParamByName('msg').Value;
        nResult := Params.ParamByName('flag').Value;
        if (nResult = 1) then
        begin
          SysLog.WriteLog('Ʊ�۹���->ȼ�ͷ�����','ɾ��',log);
          SysDialogs.ShowMessage(sResult);
          tbtnFilterClick(nil);
        end
        else
          SysDialogs.Warning(sResult);
          jscdqryFuelfeegradeapply.active := false;
          jscdqryFuelfeegradeapply.active := true;
          jcdsqryDistance.active := false;
          jcdsqryDistance.active := true;

      end;
    except
      on e: Exception do
      begin
        SysLog.WriteErr('ɾ��ȼ�ͷ����ò���ʧ�ܣ�' + e.Message);
      end;
    end;
end;

procedure TFrmFuelfeegrade.tbtnEditClick(Sender: TObject);
begin
  inherited;
  if not jcdsResult.active then
    exit;
  if jcdsResult.RecordCount = 0 then
    exit;
  try
    FrmFuelfeegradeEdt := TFrmFuelfeegradeEdt.Create(self);
    with FrmFuelfeegradeEdt do
    begin
      caption := '�޸�ȼ�͸��ӷ��ͼ�������Ϣ';
      id := jcdsResult.FieldByName('id').AsLargeInt;
      createby := sysinfo.LoginUserInfo.UserID;
      createtime:= jcdsResult.FieldByName('createtime').AsString;
      NovaHCobOrg.SetItemIndexByField('id',jcdsResult.FieldByName('orgid').AsLargeInt);
      NovaHcobOrg.Enabled:=false;
      NovaEdtFrom.Text:=jcdsResult.FieldByName('fromprice').AsString;
      NovaEdtTo.Text:=jcdsResult.FieldByName('toprice').AsString;
      if SysMainForm.showFormModal(FrmFuelfeegradeEdt, false) = mrok then
      begin
        tbtnFilterClick(nil);
        jcdsResult.Locate('id', id, []);
      end;
    end;
  finally
    FreeAndNil(FrmFuelfeegradeEdt);
  end;
end;

procedure TFrmFuelfeegrade.tbtnFilterClick(Sender: TObject);
begin
  inherited;
  jcdsResult.AfterScroll:=nil;

  with jcdsResult do
  begin
    Active := false;
    Params.ParamValues['orgids'] := NovaCkbOrg.GetSelectID;
    Active := true;
    if recordcount>0 then
    begin
      jcdsResultAfterScroll(nil);
      qryroutes(0,0);
    end;
  end;
  jcdsResult.AfterScroll:=jcdsResultAfterScroll;
end;

procedure TFrmFuelfeegrade.tbtnInsertClick(Sender: TObject);
begin
  inherited;
  try
    FrmFuelfeegradeEdt := TFrmFuelfeegradeEdt.Create(self);
    with FrmFuelfeegradeEdt do
    begin
      caption := '���ȼ�͸��ӷ��ͼ�������Ϣ';
      id := 0;
      createby := sysinfo.LoginUserInfo.UserID;
      if SysMainForm.showFormModal(FrmFuelfeegradeEdt, false) = mrok then
      begin
        tbtnFilterClick(nil);
        jcdsResult.Locate('id', id, []);
      end;
    end;
  finally
    FreeAndNil(FrmFuelfeegradeEdt);
  end;

end;

procedure TFrmFuelfeegrade.ToolButton21Click(Sender: TObject);
begin
  inherited;
  if not jcdsResult.Active then exit;
  if jcdsResult.RecordCount=0 then exit;
  try
    FrmFuelfeegradeDetail := TFrmFuelfeegradeDetail.Create(self);
    with FrmFuelfeegradeDetail do
    begin
      caption := '���ȼ�͸��ӷ�Ӫ�����������Ϣ';
      id := 0;
      fuelfeegradeid:=jcdsResult.FieldByName('id').AsLargeInt;
      createby := sysinfo.LoginUserInfo.UserID;
      if SysMainForm.showFormModal(FrmFuelfeegradeDetail, false) = mrok then
      begin
        jcdsResultAfterScroll(nil);
        jcdsqryDistance.Locate('id', id, []);
      end;
    end;
  finally
    FreeAndNil(FrmFuelfeegradeDetail);
  end;
end;

procedure TFrmFuelfeegrade.ToolButton23Click(Sender: TObject);
begin
  inherited;
  if not jcdsqryDistance.active then
    exit;
  if jcdsqryDistance.RecordCount = 0 then
    exit;
  try
    FrmFuelfeegradeDetail := TFrmFuelfeegradeDetail.Create(self);
    with FrmFuelfeegradeDetail do
    begin
      caption := '�޸�ȼ�͸��ӷ�Ӫ�����������Ϣ';
      id := jcdsqryDistance.FieldByName('id').AsLargeInt;
      createby := sysinfo.LoginUserInfo.UserID;
      createtime:= jcdsqryDistance.FieldByName('createtime').AsString;
      NovaEdtFee.Text:=jcdsqryDistance.FieldByName('fee').AsString;
      fuelfeegradeid := jcdsqryDistance.FieldByName('fuelfeegradeid').AsLargeInt;
      NovaEdtFromdistance.Text:=jcdsqryDistance.FieldByName('fromdistance').AsString;
      NovaEdttodistance.Text:=jcdsqryDistance.FieldByName('todistance').AsString;
      if SysMainForm.showFormModal(FrmFuelfeegradeDetail, false) = mrok then
      begin
        jcdsResultAfterScroll(nil);
        jcdsqryDistance.Locate('id', id, []);
      end;
    end;
  finally
    FreeAndNil(FrmFuelfeegradeDetail);
  end;
end;

procedure TFrmFuelfeegrade.ToolButton26Click(Sender: TObject);
var
  nResult: Integer;
  sResult,log: String;
begin
  if not jcdsqryDistance.active then
    exit;
  if jcdsqryDistance.RecordCount = 0 then
    exit;
  if SysDialogs.Confirm('ɾ������', 'ȷ��Ҫɾ����ȼ�ͷ���Ӫ�����Ϣ��') then
    try
      with jscdDelDistance do
      begin
        active := false;
        Params.ParamValues['fuelfeegradedetail.id'] := jcdsqryDistance.FieldByName
          ('id').AsLargeInt;
        log := 'ɾ��ȼ�ͷѷ���Ӫ�����Ϣ����ʼ='+jcdsqryDistance.FieldByName('fromdistance').AsString+
          ',����='+jcdsqryDistance.FieldByName('todistance').AsString+',ȼ�ͷ�='
          +jcdsqryDistance.FieldByName('fee').AsString;
        execute;
        sResult := Params.ParamByName('msg').Value;
        nResult := Params.ParamByName('flag').Value;
        if (nResult = 1) then
        begin
          SysLog.WriteLog('Ʊ�۹���->ȼ�ͷ�����','ɾ��',log);
          SysDialogs.ShowMessage(sResult);
          jcdsResultAfterScroll(nil);
        end
        else
          SysDialogs.Warning(sResult);
      end;
    except
      on e: Exception do
      begin
        SysLog.WriteErr('ɾ��ȼ�ͷѷ���Ӫ�����Ϣ����ʧ�ܣ�' + e.Message);
      end;
    end;
end;

procedure TFrmFuelfeegrade.ToolButton2Click(Sender: TObject);
begin
  inherited;
  if not jcdsResult.Active then exit;
  if jcdsResult.RecordCount=0 then exit;
  try
    FrmFuelfeegradeApply := TFrmFuelfeegradeApply.Create(self);
    with FrmFuelfeegradeApply do
    begin
      caption := '���ȼ�͸��ӷ�Ӧ����Ϣ';
      fuelfeegradeid:=jcdsResult.FieldByName('id').AsLargeInt;
      id := 0;
      createby := sysinfo.LoginUserInfo.UserID;
      DpFromDate.Date:=now;
      dptodate.Date:=now+100;

      if SysMainForm.showFormModal(FrmFuelfeegradeApply, false) = mrok then
      begin
        qryroutes(fuelfeegradeid,0);
        jcdsResult.Locate('id', id, []);
      end;
    end;
  finally
    FreeAndNil(FrmFuelfeegradeApply);
  end;
end;

procedure TFrmFuelfeegrade.ToolButton3Click(Sender: TObject);
begin
  inherited;
  if not jscdqryFuelfeegradeapply.Active then exit;
  if jscdqryFuelfeegradeapply.RecordCount=0 then exit;
  try
    FrmFuelfeegradeApply := TFrmFuelfeegradeApply.Create(self);
    with FrmFuelfeegradeApply do
    begin
      caption := '�޸�ȼ�͸��ӷ�Ӧ����Ϣ';
      NovaHCobOrg.SetItemIndexByField('id',jcdsResult.FieldByName('orgid').AsLargeInt);
      NovaHCobOrg.Enabled:=false;
      CREATETIME:=jscdqryFuelfeegradeapply.FieldByName('CREATETIME').AsString;
      fuelfeegradeid:=jscdqryFuelfeegradeapply.FieldByName('fuelfeegradeid').AsLargeInt;
      id := jscdqryFuelfeegradeapply.FieldByName('id').AsLargeInt;;
      createby := sysinfo.LoginUserInfo.UserID;
      DpFromDate.Date:=jscdqryFuelfeegradeapply.FieldByName('fromdate').AsDateTime;
      dptodate.Date:=jscdqryFuelfeegradeapply.FieldByName('todate').AsDateTime;
      NovaHRoute.Text:=jscdqryFuelfeegradeapply.FieldByName('routename').AsString;
      NovaHRoute.id:=jscdqryFuelfeegradeapply.FieldByName('routeid').AsLargeInt;
      if(jscdqryFuelfeegradeapply.FieldByName('vehicletypeid').Value<>null) then
        NovaVehicletype.SetItemIndexByField('id',jscdqryFuelfeegradeapply.FieldByName('vehicletypeid').AsLargeInt);
      if SysMainForm.showFormModal(FrmFuelfeegradeApply, false) = mrok then
      begin
        qryroutes(fuelfeegradeid,0);
        jscdqryFuelfeegradeapply.Locate('id', id, []);
      end;
    end;
  finally
    FreeAndNil(FrmFuelfeegradeApply);
  end;
end;

procedure TFrmFuelfeegrade.ToolButton5Click(Sender: TObject);
var
  nResult: Integer;
  sResult,log: String;
  fuelfeegradeid:int64;
begin
  if not jscdqryFuelfeegradeapply.active then
    exit;
  if jscdqryFuelfeegradeapply.RecordCount = 0 then
    exit;
  if SysDialogs.Confirm('ɾ������', 'ȷ��Ҫɾ����ȼ�ͷ�Ӧ����Ϣ��') then
    try
      with jscdDelFuelfeegradeapply do
      begin
        active := false;
        fuelfeegradeid:= jcdsResult.FieldByName('id').AsLargeInt;
        log := 'ɾ��ȼ�ͷ�����Ӧ����Ϣ����·����='+jscdqryFuelfeegradeapply.FieldByName('routename').AsString+
          ',����='+jcdsResult.FieldByName('grade').AsString+',��ʼ����='
          +jscdqryFuelfeegradeapply.FieldByName('fromdate').AsString+',��������='+
          jscdqryFuelfeegradeapply.FieldByName('todate').AsString;
        Params.ParamValues['fuelfeegradeapply.id'] := jscdqryFuelfeegradeapply.FieldByName
          ('id').AsLargeInt;
        execute;
        sResult := Params.ParamByName('msg').Value;
        nResult := Params.ParamByName('flag').Value;
        if (nResult = 1) then
        begin
          SysLog.WriteLog('Ʊ�۹���->ȼ�ͷ�����','ɾ��',log);
          SysDialogs.ShowMessage(sResult);
          qryroutes(fuelfeegradeid,0);
        end
        else
          SysDialogs.Warning(sResult);
      end;
    except
      on e: Exception do
      begin
        SysLog.WriteErr('ɾ��ȼ�ͷ�Ӧ����Ϣ����ʧ�ܣ�' + e.Message);
      end;
    end;

end;

end.
