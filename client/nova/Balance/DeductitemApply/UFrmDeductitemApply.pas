unit UFrmDeductitemApply;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, USimpleCRUDForm, DBGridEhGrouping, ComCtrls, NvPrnDbgeh, DB,
  FunctionItemIntf,
  DBClient, jsonClientDataSet, ImgList, GridsEh, DBGridEh, NvDbgridEh, StdCtrls,
  ToolWin, ExtCtrls, NovaComboBox, NovaHComboBox, Menus, Generics.Collections,
  NovaEdit, NovaHelp, NovaCheckedComboBox;

type
  TFrmDeductitemApply = class(TSimpleCRUDForm)
    GroupBox2: TGroupBox;
    TreeVItem: TTreeView;
    Label1: TLabel;
    NovaCobTargets: TNovaHComboBox;
    jscdCreatetree: TjsonClientDataSet;
    PopupMenu1: TPopupMenu;
    N1: TMenuItem;
    ChbAudited: TCheckBox;
    ChbUnAudited: TCheckBox;
    jcdsDelApply: TjsonClientDataSet;
    jcdsAuditDeductApply: TjsonClientDataSet;
    jcdsCancelAuditDeductApply: TjsonClientDataSet;
    jcdsResultitemname: TWideStringField;
    jcdsResulttargetname: TWideStringField;
    jcdsResultstartdate: TDateField;
    jcdsResultenddate: TDateField;
    jcdsResultorgname: TWideStringField;
    jcdsResultroutename: TWideStringField;
    jcdsResultschedulecode: TWideStringField;
    jcdsResultunitname: TWideStringField;
    jcdsResultvehicleno: TWideStringField;
    jcdsResultisaudited: TBooleanField;
    jcdsResultisauditpass: TBooleanField;
    jcdsResultauditorname: TWideStringField;
    jcdsResultremarks: TWideStringField;
    jcdsResultcreatetime: TDateTimeField;
    jcdsResultcreatename: TWideStringField;
    jcdsResultupdatetime: TDateTimeField;
    jcdsResultupdatename: TWideStringField;
    jcdsResultdeducttype: TWideStringField;
    jcdsResultdeductmoney: TFloatField;
    jcdsResultisdeductbeforebalance: TBooleanField;
    jcdsQryDeducttype: TjsonClientDataSet;
    jcdsResultdeducttypename: TWideStringField;
    Splitter1: TSplitter;
    jcdsResultid: TLargeintField;
    jcdsResultbalancedeductitemid: TLargeintField;
    jcdsResultbalancededucttargetid: TLargeintField;
    jcdsResultscheduleid: TLargeintField;
    jcdsResultunitid: TLargeintField;
    jcdsResultvehicleid: TLargeintField;
    jcdsResultrouteid: TLargeintField;
    jcdsResultcreateby: TLargeintField;
    jcdsResultorgid: TLargeintField;
    lbl3: TLabel;
    NovaHelpVehicleno: TNovaHelp;
    lbl4: TLabel;
    NovaHUnit: TNovaHelp;
    Label4: TLabel;
    NHelpRoute: TNovaHelp;
    Label2: TLabel;
    NovaHCbbOrg: TNovaHComboBox;
    N2: TMenuItem;
    procedure tbtnInsertClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure tbtnFilterClick(Sender: TObject);
    procedure tbtnDeleteClick(Sender: TObject);
    procedure tbtnEditClick(Sender: TObject);
    procedure TreeVItemClick(Sender: TObject);
    procedure N1Click(Sender: TObject);
    procedure tbtnSaveClick(Sender: TObject);
    procedure tbtnCancelClick(Sender: TObject);
    procedure jcdsResultAfterScroll(DataSet: TDataSet);
    procedure dbgrdhResultDrawColumnCell(Sender: TObject; const Rect: TRect;
      DataCol: Integer; Column: TColumnEh; State: TGridDrawState);
    procedure NovaHCbbOrgChange(Sender: TObject);
    procedure N2Click(Sender: TObject);
  private
    { Private declarations }
    log : String;
    TreeVItemId:int64;
        procedure createtree();
    procedure qryitemapply(itemid: int64);
  public
    { Public declarations }
    //class function getSubFunctionList:TList<TSubfunction>;
        procedure HandleAuthority(const Key:TGUID;aEnable:Boolean);override;
  end;

var
  FrmDeductitemApply: TFrmDeductitemApply;
  //FSubFunctionList: TList<TSubfunction>;



implementation

uses UFrmDeductitemApplyEdt, PubFn, TreeUnit, Services, UDMPublic;
{$R *.dfm}


procedure TFrmDeductitemApply.createtree;
var
   orgid:int64;
begin
   if NovaHCbbOrg.GetCount=0 then
     orgid:=sysinfo.LoginUserInfo.OrgID
   else
     orgid:=NovaHCbbOrg.HelpFieldValue['id'];
  jscdCreatetree.Active := False;
  jscdCreatetree.Params.ParamValues['orgid']:= orgid;
  jscdCreatetree.Active := True;
  if jscdCreatetree.RecordCount > 0 then
  begin
    TreeVItem.Items.Clear;
    BuildIDXTree(jscdCreatetree, TreeVItem, True);
  end
  else
    TreeVItem.Items.Clear;

end;

procedure TFrmDeductitemApply.dbgrdhResultDrawColumnCell(Sender: TObject;
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

procedure TFrmDeductitemApply.FormCreate(Sender: TObject);
var
   orgid:int64;
begin
  inherited;
  NovaHCbbOrg.Active:=false;
  NovaHCbbOrg.Active:=true;
  jcdsQryDeducttype.active := false;
  jcdsQryDeducttype.active := true;
  NovaCobTargets.active := false;
  NovaCobTargets.active := true;
   createtree();
end;





procedure TFrmDeductitemApply.HandleAuthority(const Key: TGUID;
  aEnable: Boolean);
begin
  inherited;
  if GUIDToString(key)='{1A09E4BD-80E7-4A04-8C13-0EE8EE9AFEF9}' then //
  begin
    tbtnSave.Visible:=aEnable;
    tbtn3.Visible:=aEnable;
  end
end;

procedure TFrmDeductitemApply.jcdsResultAfterScroll(DataSet: TDataSet);
begin
  inherited;
  if tbtnSave.Visible then
    if jcdsResult.FieldByName('isaudited').AsBoolean then
    begin
      tbtnSave.Enabled := false;
    end
    else
    begin
      tbtnSave.Enabled := true;
    end;
  if tbtnCancel.Visible then
    if jcdsResult.FieldByName('isaudited').AsBoolean then
    begin
      tbtnCancel.Enabled := true;
    end
    else
    begin
      tbtnCancel.Enabled := false;
    end;
end;

procedure TFrmDeductitemApply.N1Click(Sender: TObject);
var
  curid: int64;
begin
  inherited;
  try
    FrmDeductitemApplyEdt := TFrmDeductitemApplyEdt.Create(self);
    with FrmDeductitemApplyEdt do
    begin
      caption := '添加结算固定扣费应用';
      NovaEdtName.SetItemIndexByField('id',
        strtoint(PIDXRec(TreeVItem.Selected.Data).id));
      if SysMainForm.showFormModal(FrmDeductitemApplyEdt, false) = mrok then
      begin
        curid := id;
        tbtnFilterClick(nil);
        jcdsResult.Locate('id', curid, []);
      end;
    end;
  finally
    FreeAndNil(FrmDeductitemApplyEdt);
  end;
end;

procedure TFrmDeductitemApply.N2Click(Sender: TObject);
begin
  inherited;
  TreeVItem.Items.Clear;
  createtree();
end;

procedure TFrmDeductitemApply.NovaHCbbOrgChange(Sender: TObject);
begin
  inherited;
  createtree();
  qryitemapply(0);
end;

procedure TFrmDeductitemApply.qryitemapply(itemid: int64);

begin
   //createtree();
  with jcdsResult do
  begin
    active := false;

    if itemid > 0 then
    begin
      Params.ParamValues['filter_EQL_bi!orgid'] := NovaHCbbOrg.HelpFieldValue['id'];
      Params.ParamValues['filter_EQL_b!balancedeductitemid'] := itemid;
    end
    else
    begin
      Params.ParamValues['filter_EQL_bi!orgid'] := NovaHCbbOrg.HelpFieldValue['id'];
      Params.ParamValues['filter_EQL_b!balancedeductitemid'] := null;
    end;
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

    active := true;
  end;
end;

procedure TFrmDeductitemApply.tbtnCancelClick(Sender: TObject);
var
  nResult: Integer;
  sResult: String;
  curid: int64;
begin
  if not jcdsResult.active then
    exit;
  if jcdsResult.RecordCount = 0 then
    exit;
  if not jcdsResult.FieldByName('isaudited').AsBoolean then
  begin
    SysDialogs.Warning('该数据还未审核！');
    exit;
  end;
  try
    with jcdsCancelAuditDeductApply do
    begin
      active := false;
      curid := jcdsResult.FieldByName('id').AsLargeInt;
      Params.ParamValues['balancedeductapply.id'] := curid;
      Params.ParamValues['balancedeductapply.auditor.id'] :=
        Sysinfo.LoginUserInfo.UserID;
      execute;
      sResult := Params.ParamByName('msg').Value;
      nResult := Params.ParamByName('flag').Value;
      if (nResult = 1) then
      begin
        SysDialogs.ShowMessage(sResult);
        tbtnFilterClick(nil);
        jcdsResult.Locate('id', curid, []);
      end
      else
        SysDialogs.Warning(sResult);
    end;
  except
    on e: Exception do
    begin
      SysLog.WriteErr('取消审核结算票价相关扣费项目操作失败：' + e.Message);
    end;
  end;

end;

procedure TFrmDeductitemApply.tbtnDeleteClick(Sender: TObject);
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
    SysDialogs.Warning('该数据已经审核不能删除！');
    exit;
  end;
  if SysDialogs.Confirm('删除操作', '确认要删除该扣费信息应用吗？') then
    try
      with jcdsDelApply do
      begin
        active := false;
        Params.ParamValues['balancedeductapply.id'] := jcdsResult.FieldByName
          ('id').AsLargeInt;
        execute;
        sResult := Params.ParamByName('msg').Value;
        nResult := Params.ParamByName('flag').Value;
        if (nResult = 1) then
        begin
          log := '删除固定扣费项目应用：扣费项目='+jcdsResult.FieldByName('itemname').AsString+
          ',扣费类型='+jcdsResult.FieldByName('deducttypename').AsString+',打单时扣='
          +jcdsResult.FieldByName('isdeductbeforebalance').AsString+',扣费金额='+
          jcdsResult.FieldByName('deductmoney').AsString+',扣费对象='+
          jcdsResult.FieldByName('targetname').AsString+',开始日期='+
          jcdsResult.FieldByName('startdate').AsString+',结束日期='+
          jcdsResult.FieldByName('enddate').AsString;
          SysLog.WriteLog('结算管理->固定扣费项目应用','删除',log);
          SysDialogs.ShowMessage(sResult);
          tbtnFilterClick(nil);
        end
        else
          SysDialogs.Warning(sResult);
      end;
    except
      on e: Exception do
      begin
        SysLog.WriteErr('删除结算票价相关扣费项目操作失败：' + e.Message);
      end;
    end;

end;

procedure TFrmDeductitemApply.tbtnEditClick(Sender: TObject);
var
  curid: int64;
begin
  inherited;
  if not jcdsResult.active then
    exit;
  if jcdsResult.RecordCount = 0 then
    exit;
  try
    FrmDeductitemApplyEdt := TFrmDeductitemApplyEdt.Create(self);
    with FrmDeductitemApplyEdt do
    begin
      caption := '修改结算固定扣费应用';
      FrmDeductitemApplyEdt.edittype := Tedittype.update;

      id := jcdsResult.FieldByName('id').AsLargeInt;
      orgid:=self.NovaHCbbOrg.HelpFieldValue['id'];
      balancedeductitemid:=jcdsResult.FieldByName('balancedeductitemid').AsLargeInt;

      NovaCobTarget.SetItemIndexByField('id',
        jcdsResult.FieldByName('balancededucttargetid').AsLargeInt);


      DTPBuildStartDay.Date := jcdsResult.FieldByName('startdate').AsDateTime;
      DTPBuildEndDay.Date := jcdsResult.FieldByName('enddate').AsDateTime;

      NovaHelpSchedule.id := jcdsResult.FieldByName('scheduleid').AsLargeInt;
      NovaHelpSchedule.Text := jcdsResult.FieldByName('schedulecode').AsString;
      createby := jcdsResult.FieldByName('createby').AsLargeInt;
      isauditpass := jcdsResult.FieldByName('isauditpass').AsBoolean;
      isaudited := jcdsResult.FieldByName('isaudited').AsBoolean;
      createtime := FormatDateTime('yyyy-mm-dd hh:mm:ss',jcdsResult.FieldByName('createtime').AsDateTime);
      NovaHelpUnit.id := jcdsResult.FieldByName('unitid').AsLargeInt;
      NovaHelpUnit.Text := jcdsResult.FieldByName('unitname').AsString;
      NovaHelpVehicle.id := jcdsResult.FieldByName('vehicleid').AsLargeInt;
      NovaHelpVehicle.Text := jcdsResult.FieldByName('vehicleno').AsString;
      NovaHelpRoute.id := jcdsResult.FieldByName('routeid').AsLargeInt;
      NovaHelpRoute.Text := jcdsResult.FieldByName('routename').AsString;
      //MeRemark.Text := jcdsResult.FieldByName('remarks').AsString;

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

      if SysMainForm.showFormModal(FrmDeductitemApplyEdt, false) = mrok then
      begin
        curid := id;
        tbtnFilterClick(nil);
        jcdsResult.Locate('id', curid, []);
      end;

    end;
  finally
    FreeAndNil(FrmDeductitemApplyEdt);
  end;
end;

procedure TFrmDeductitemApply.tbtnFilterClick(Sender: TObject);
begin
  inherited;
//  if NovaCobTargets.ItemIndex > 0 then
//    qryitemapply(NovaCobTargets.HelpFieldValue['id'])
  if TreeVItemId > 0 then
     qryitemapply(strtoint(PIDXRec(TreeVItem.Selected.Data).id))
  else
    qryitemapply(0);
end;

procedure TFrmDeductitemApply.tbtnInsertClick(Sender: TObject);
var
  curid: int64;
begin
  inherited;
  try
    FrmDeductitemApplyEdt := TFrmDeductitemApplyEdt.Create(self);
    with FrmDeductitemApplyEdt do
    begin
      caption := '添加结算固定扣费应用';
      FrmDeductitemApplyEdt.edittype := Tedittype.add;

      orgid:= NovaHCbbOrg.HelpFieldValue['id'];
      if SysMainForm.showFormModal(FrmDeductitemApplyEdt, false) = mrok then
      begin
        curid := id;
        tbtnFilterClick(nil);
        jcdsResult.Locate('id', curid, []);
      end;
    end;
  finally
    FreeAndNil(FrmDeductitemApplyEdt);
  end;
end;

procedure TFrmDeductitemApply.tbtnSaveClick(Sender: TObject);
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
    SysDialogs.Warning('该数据已经审核！');
    exit;
  end;
  try
    with jcdsAuditDeductApply do
    begin
      active := false;
      curid := jcdsResult.FieldByName('id').AsLargeInt;
      Params.ParamValues['balancedeductapply.id'] := curid;
      Params.ParamValues['balancedeductapply.auditor.id'] :=
        Sysinfo.LoginUserInfo.UserID;
      execute;
      sResult := Params.ParamByName('msg').Value;
      nResult := Params.ParamByName('flag').Value;
      if (nResult = 1) then
      begin
        log := '审核固定扣费项目应用：扣费项目='+jcdsResult.FieldByName('itemname').AsString+
          ',扣费类型='+jcdsResult.FieldByName('deducttypename').AsString+',打单时扣='
          +jcdsResult.FieldByName('isdeductbeforebalance').AsString+',扣费金额='+
          jcdsResult.FieldByName('deductmoney').AsString+',扣费对象='+
          jcdsResult.FieldByName('targetname').AsString+',开始日期='+
          jcdsResult.FieldByName('startdate').AsString+',结束日期='+
          jcdsResult.FieldByName('enddate').AsString;
          SysLog.WriteLog('结算管理->固定扣费项目应用','审核',log);
        SysDialogs.ShowMessage(sResult);
        tbtnFilterClick(nil);
        jcdsResult.Locate('id', curid, []);
      end
      else
        SysDialogs.Warning(sResult);
    end;
  except
    on e: Exception do
    begin
      SysLog.WriteErr('审核结算票价相关扣费项目操作失败：' + e.Message);
    end;
  end;
end;

procedure TFrmDeductitemApply.TreeVItemClick(Sender: TObject);
begin
  inherited;
  TreeVItemId:=strtoint(PIDXRec(TreeVItem.Selected.Data).id);
  qryitemapply(TreeVItemId);
end;

initialization

//FSubFunctionList := TList<TSubfunction>.Create;
//FSubFunctionList.Add(TSubfunction.Create(key1, '审核通过'));
//FSubFunctionList.Add(TSubfunction.Create(key2, '取消审核'));

finalization

//FSubFunctionList.Free;

end.
