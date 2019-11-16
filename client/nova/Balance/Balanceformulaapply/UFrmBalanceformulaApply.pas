unit UFrmBalanceformulaApply;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, USimpleCRUDForm, DBGridEhGrouping, NvPrnDbgeh, DB, DBClient,
  jsonClientDataSet, ImgList, GridsEh, DBGridEh, NvDbgridEh, StdCtrls, ComCtrls,
  ToolWin, ExtCtrls, NovaHComboBox, NovaEdit, NovaHelp, NovaCheckedComboBox;

type
  TFrmBalanceformulaApply = class(TSimpleCRUDForm)
    Panel2: TPanel;
    Splitter1: TSplitter;
    GroupBox2: TGroupBox;
    DBGridEh1: TNvDbgridEh;
    GroupBox3: TGroupBox;
    NvDbgridEh1: TNvDbgridEh;
    Label1: TLabel;
    NovaCobTargets: TNovaHComboBox;
    ChbAudited: TCheckBox;
    ChbUnAudited: TCheckBox;
    jcsdQryBalanceformulas: TjsonClientDataSet;
    jcdsdqryBalanceformulaitem: TjsonClientDataSet;
    dsFormulas: TDataSource;
    dsformulasitem: TDataSource;
    Label2: TLabel;
    NovaEditNames: TNovaEdit;
    jcdsDelFormulaApply: TjsonClientDataSet;
    jcdsauditformulaapply: TjsonClientDataSet;
    NHelpRoute: TNovaHelp;
    NovaHUnit: TNovaHelp;
    NovaHelpVehicleno: TNovaHelp;
    Label4: TLabel;
    lbl3: TLabel;
    lbl4: TLabel;
    Label3: TLabel;
    NovaCkbOrg: TNovaCheckedComboBox;
    procedure FormCreate(Sender: TObject);
    procedure tbtnInsertClick(Sender: TObject);
    procedure tbtnFilterClick(Sender: TObject);
    procedure tbtnEditClick(Sender: TObject);
    procedure jcsdQryBalanceformulasAfterScroll(DataSet: TDataSet);
    procedure tbtnDeleteClick(Sender: TObject);
    procedure tbtnSaveClick(Sender: TObject);
    procedure dbgrdhResultDrawColumnCell(Sender: TObject; const Rect: TRect;
      DataCol: Integer; Column: TColumnEh; State: TGridDrawState);
  private
    { Private declarations }
    log : String;
    procedure qryBalanceformulaApply(formulaid:int64);
  public
    { Public declarations }
    procedure HandleAuthority(const Key:TGUID;aEnable:Boolean);override;
  end;

var
  FrmBalanceformulaApply: TFrmBalanceformulaApply;

implementation
uses UFrmBalanceformulaApplyEdt, PubFn, Services, UDMPublic;
{$R *.dfm}

procedure TFrmBalanceformulaApply.dbgrdhResultDrawColumnCell(Sender: TObject;
  const Rect: TRect; DataCol: Integer; Column: TColumnEh;
  State: TGridDrawState);
begin
  inherited;
  if (jcdsResult.FieldByName('isaudited').AsBoolean) and not
    (gdSelected in State) then
  begin
    dbgrdhResult.Canvas.Font.Color := clGreen; // ;
    dbgrdhResult.DefaultDrawColumnCell(Rect, DataCol, Column, State);
  end;
end;

procedure TFrmBalanceformulaApply.FormCreate(Sender: TObject);
begin
  inherited;
  NovaCkbOrg.Active:=false;
  NovaCkbOrg.Active:=true;
  jcdsdqryBalanceformulaitem.Active:=false;
  jcdsdqryBalanceformulaitem.Active:=true;

  NovaCobTargets.Active:=false;
  NovaCobTargets.Active:=true;
end;

procedure TFrmBalanceformulaApply.HandleAuthority(const Key: TGUID;
  aEnable: Boolean);
begin
  inherited;
  if GUIDToString(key)='{DCC9DF3C-A166-4CF9-9AF2-D10DF24D62C4}' then //
  begin
    tbtnSave.Visible:=aEnable;
    tbtn3.Visible:=aEnable;
  end
end;

procedure TFrmBalanceformulaApply.jcsdQryBalanceformulasAfterScroll(
  DataSet: TDataSet);
begin
  inherited;
  qryBalanceformulaApply(jcsdQryBalanceformulas.FieldByName('id').AsLargeInt);
end;

procedure TFrmBalanceformulaApply.qryBalanceformulaApply(formulaid: int64);
begin
  with jcdsResult do
  begin
    active := false;
    if NovaCobTargets.ItemIndex >= 0 then
      Params.ParamValues['filter_EQL_b!balancededucttargetid'] :=
        NovaCobTargets.HelpFieldValue['id']
    else
      Params.ParamValues['filter_EQL_b!balancededucttargetid'] := null;
    if ChbAudited.Checked and (not ChbUnAudited.Checked) then
      Params.ParamValues['filter_EQB_b!isaudited'] := true
    else if (not ChbAudited.Checked) and ChbUnAudited.Checked then
      Params.ParamValues['filter_EQB_b!isaudited'] := false
    else
      Params.ParamValues['filter_EQB_b!isaudited'] := null;
    if(trim(NovaEditNames.Text)<>'') then
      Params.ParamValues['filter_LIKES_bf!name'] := trim(NovaEditNames.Text);
    if formulaid>0 then
      Params.ParamValues['filter_EQL_bf!id'] := formulaid
    else
      Params.ParamValues['filter_EQL_bf!id'] := null;
    if (NHelpRoute.Text<>'') and (NHelpRoute.Id>0) then
      Params.ParamValues['filter_EQL_r!id'] := NHelpRoute.Id
    else
      Params.ParamValues['filter_EQL_r!id'] := null;
    if (NovaHUnit.Text<>'')  and (NovaHUnit.Id>0) then
      Params.ParamValues['filter_EQL_u!id'] := NovaHUnit.Id
    else
      Params.ParamValues['filter_EQL_u!id'] := null;
    if (NovaHelpVehicleno.Text<>'')  and (NovaHelpVehicleno.Id>0) then
      Params.ParamValues['filter_EQL_v!id'] := NovaHelpVehicleno.Id
    else
      Params.ParamValues['filter_EQL_v!id'] := null;
    if NovaCkbOrg.GetSelectID<>'' then
      Params.ParamValues['filter_INS_bf!orgid'] := NovaCkbOrg.GetSelectID
    else
      Params.ParamValues['filter_INS_bf!orgid'] := SysInfo.LoginUserInfo.OrgIDs;
    active := true;
  end;
end;

procedure TFrmBalanceformulaApply.tbtnDeleteClick(Sender: TObject);
var
  nResult: Integer;
  sResult: String;
begin
  if not jcdsResult.active then
    exit;
  if jcdsResult.RecordCount = 0 then
    exit;
  if jcdsResult.FieldByName('isaudited').AsBoolean then
  begin
    SysDialogs.Warning('�������Ѿ���˲���ɾ����');
    exit;
  end;
  if SysDialogs.Confirm('ɾ������', 'ȷ��Ҫɾ���ÿ۷���ϢӦ����') then
    try
      with jcdsDelFormulaApply do
      begin
        active := false;
        Params.ParamValues['balanceformulaapply.id'] := jcdsResult.FieldByName
          ('id').AsLargeInt;
        Params.ParamValues['balanceformulaapply.createby'] := Sysinfo.LoginUserInfo.UserID;
        execute;
        sResult := Params.ParamByName('msg').Value;
        nResult := Params.ParamByName('flag').Value;
        if (nResult = 1) then
        begin
          log := 'ɾ����ʽ�۷���ĿӦ�ã���ʽ�۷���='+jcdsResult.FieldByName('formulaname').AsString+
          ',�۷Ѷ���='+jcdsResult.FieldByName('targetname').AsString+',��ʼ����='+
          jcdsResult.FieldByName('startdate').AsString+',��������='+
          jcdsResult.FieldByName('enddate').AsString;
          SysLog.WriteLog('�������->��ʽ�۷���ĿӦ��','ɾ��',log);
          SysDialogs.ShowMessage(sResult);
          qryBalanceformulaApply(jcsdQryBalanceformulas.FieldByName('id').AsLargeInt);
        end
        else
          SysDialogs.Warning(sResult);
      end;
    except
      on e: Exception do
      begin
        SysLog.WriteErr('ɾ�����㹫ʽ�۷�Ӧ�ò���ʧ�ܣ�' + e.Message);
      end;
    end;
end;

procedure TFrmBalanceformulaApply.tbtnEditClick(Sender: TObject);
var
  curid: int64;
begin
  inherited;
  if not jcdsResult.active then
    exit;
  if jcdsResult.RecordCount = 0 then
    exit;
  try
    FrmBalanceformulaApplyEdt := TFrmBalanceformulaApplyEdt.Create(self);
    with FrmBalanceformulaApplyEdt do
    begin
      caption := '�޸Ľ��㹫ʽ�۷�Ӧ��';
      FrmBalanceformulaApplyEdt.edittype := Tedittype.update;
      id := jcdsResult.FieldByName('id').AsLargeInt;
      NovaHCobFormula.SetItemIndexByField('id',jcdsResult.FieldByName('balanceformulaid').AsLargeInt);


      balanceformulaid:=jcsdQryBalanceformulas.FieldByName('id').AsLargeInt;
      NovaCobTarget.SetItemIndexByField('id',
        jcdsResult.FieldByName('balancededucttargetid').AsLargeInt);
      //��Ϊ������ʽ����Ӧ�������
      if(jcdsResult.FieldByName('balancededucttargetid').AsLargeInt=8) then
        NovaCobTarget.Enabled:=false;
      DTPBuildStartDay.Date := jcdsResult.FieldByName('startdate').AsDateTime;
      DTPBuildEndDay.Date := jcdsResult.FieldByName('enddate').AsDateTime;

      NovaHelpSchedule.id := jcdsResult.FieldByName('scheduleid').AsLargeInt;
      NovaHelpSchedule.Text := jcdsResult.FieldByName('schedulecode').AsString;
      createby := jcdsResult.FieldByName('createby').AsLargeInt;
      isauditpass := jcdsResult.FieldByName('isauditpass').AsBoolean;
      isaudited := jcdsResult.FieldByName('isaudited').AsBoolean;
      createtime := jcdsResult.FieldByName('createtime').AsString;
      NovaHelpUnit.id := jcdsResult.FieldByName('unitid').AsLargeInt;
      NovaHelpUnit.Text := jcdsResult.FieldByName('unitname').AsString;
      NovaHelpVehicle.id := jcdsResult.FieldByName('vehicleid').AsLargeInt;
      NovaHelpVehicle.Text := jcdsResult.FieldByName('vehicleno').AsString;
      NovaHelpRoute.id := jcdsResult.FieldByName('routeid').AsLargeInt;
      NovaHelpRoute.Text := jcdsResult.FieldByName('routename').AsString;
      MeRemark.Text := jcdsResult.FieldByName('remarks').AsString;
      NovaHCobOrg.SetItemIndexByField('id',
        jcdsResult.FieldByName('orgid').AsLargeInt);

      NovaCobTarget.Enabled := False;
      if NovaHCobOrg.Text = '' then
      begin
        NovaHCobOrg.Enabled := False;
      end;
      if NovaHelpRoute.Text = '' then
      begin
        NovaHelpRoute.Enabled := False;
      end;
      if NovaHelpSchedule.Text='' then
      begin
        NovaHelpSchedule.Enabled := False;
      end;
      if NovaHelpUnit.Text='' then
      begin
        NovaHelpUnit.Enabled := False;
      end;
      if NovaHelpVehicle.Text = '' then
      begin
        NovaHelpVehicle.Enabled := False;
      end;

      if SysMainForm.showFormModal(FrmBalanceformulaApplyEdt, false) = mrok then
      begin
        curid := id;
        tbtnFilterClick(nil);
        jcdsResult.Locate('id', curid, []);
      end;
    end;
  finally
    FreeAndNil(FrmBalanceformulaApplyEdt);
  end;
end;

procedure TFrmBalanceformulaApply.tbtnFilterClick(Sender: TObject);
begin
  inherited;
  jcsdQryBalanceformulas.AfterScroll:=nil;
  jcsdQryBalanceformulas.Active:=false;
  if NovaCkbOrg.GetSelectID <>'' then
      jcsdQryBalanceformulas.Params.ParamValues['orgids'] := NovaCkbOrg.GetSelectID
  else
      jcsdQryBalanceformulas.Params.ParamValues['orgids'] := SysInfo.LoginUserInfo.OrgIDs;
  jcsdQryBalanceformulas.Active:=true;
  jcsdQryBalanceformulas.AfterScroll:=jcsdQryBalanceformulasAfterScroll;
  qryBalanceformulaApply(0);
  //jcsdQryBalanceformulas.FieldByName('id').AsString;
end;

procedure TFrmBalanceformulaApply.tbtnInsertClick(Sender: TObject);
var
  curid: int64;
begin
  inherited;
  if not jcsdQryBalanceformulas.Active then
    exit;
  if jcsdQryBalanceformulas.RecordCount=0 then
  begin
    SysDialogs.ShowInfo('������ӿ۷ѹ�ʽ��Ϣ');
    exit;
  end;
  try
    FrmBalanceformulaApplyEdt := TFrmBalanceformulaApplyEdt.Create(self);
    with FrmBalanceformulaApplyEdt do
    begin
      caption := '��ӽ��㹫ʽ�۷�Ӧ��';
      FrmBalanceformulaApplyEdt.edittype := Tedittype.add;
      NovaHCobFormula.SetItemIndexByField('id',jcsdQryBalanceformulas.FieldByName('id').AsLargeInt);
      balanceformulaid:=jcsdQryBalanceformulas.FieldByName('id').AsLargeInt;
      //��Ϊ������ʽ����Ӧ�������
      {if (jcsdQryBalanceformulas.FieldByName('parentid').AsLargeInt=0) then
      begin
         NovaCobTarget.SetItemIndexByField('id',8);
         NovaCobTarget.Enabled:=false;
      end; }
      if SysMainForm.showFormModal(FrmBalanceformulaApplyEdt, false) = mrok then
      begin
        curid := id;
        qryBalanceformulaApply(jcsdQryBalanceformulas.FieldByName('id').AsLargeInt);
        jcdsResult.Locate('id', curid, []);
      end;
    end;
  finally
    FreeAndNil(FrmBalanceformulaApplyEdt);
  end;
end;

procedure TFrmBalanceformulaApply.tbtnSaveClick(Sender: TObject);
var
  nResult: Integer;
  sResult: String;
  curid: int64;
begin
  if not jcdsResult.active then
    exit;
  if jcdsResult.RecordCount = 0 then
    exit;
  if jcdsResult.FieldByName('isaudited').AsBoolean then
  begin
    SysDialogs.Warning('�������Ѿ���ˣ�');
    exit;
  end;
  try
    with jcdsauditformulaapply do
    begin
      active := false;
      curid := jcdsResult.FieldByName('id').AsLargeInt;
      Params.ParamValues['balanceformulaapply.id'] := curid;
      Params.ParamValues['balanceformulaapply.auditor.id'] :=
        Sysinfo.LoginUserInfo.UserID;
      execute;
      sResult := Params.ParamByName('msg').Value;
      nResult := Params.ParamByName('flag').Value;
      if (nResult = 1) then
      begin
        SysDialogs.ShowMessage(sResult);
        //qryBalanceformulaApply(jcsdQryBalanceformulas.FieldByName('id').AsLargeInt);
        qryBalanceformulaApply(0);
        jcdsResult.Locate('id', curid, []);
      end
      else
        SysDialogs.Warning(sResult);
    end;
  except
    on e: Exception do
    begin
      SysLog.WriteErr('��˽��㹫ʽ�۷�Ӧ�ò���ʧ�ܣ�' + e.Message);
    end;
  end;
end;

end.
