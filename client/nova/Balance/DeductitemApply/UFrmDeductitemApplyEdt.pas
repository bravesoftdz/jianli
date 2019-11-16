unit UFrmDeductitemApplyEdt;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, USimpleEditForm, StdCtrls, Buttons, ExtCtrls, NovaHelp, ComCtrls,
  NovaEdit, NovaComboBox, DB, DBClient, jsonClientDataSet, NovaHComboBox,
  ImgList, NovaCheckedComboBox, DBGridEhGrouping, GridsEh, DBGridEh, NvDbgridEh;

type
  TFrmDeductitemApplyEdt = class(TSimpleEditForm)
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    DTPBuildStartDay: TDateTimePicker;
    DTPBuildEndDay: TDateTimePicker;
    GroupBox1: TGroupBox;
    Label5: TLabel;
    NovaHelpRoute: TNovaHelp;
    Label6: TLabel;
    NovaHelpSchedule: TNovaHelp;
    Label7: TLabel;
    NovaHelpUnit: TNovaHelp;
    Label8: TLabel;
    NovaHelpVehicle: TNovaHelp;
    jcdsSaveApply: TjsonClientDataSet;
    NovaCobTarget: TNovaHComboBox;
    NovaEdtName: TNovaHComboBox;
    Label9: TLabel;
    Label10: TLabel;
    Label11: TLabel;
    NovaHCobOrg: TNovaHComboBox;
    Label12: TLabel;
    Label13: TLabel;
    jscdQryCheckOrg: TjsonClientDataSet;
    NvDbgridEh1: TNvDbgridEh;
    ds1: TDataSource;
    lbl1: TLabel;
    procedure bbtnSaveClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure NovaCobTargetChange(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
    log : String;
  public
    { Public declarations }
    id, createby,orgid,balancedeductitemid: int64;
    createtime: String;
    isauditpass, isaudited: boolean;
  end;

var
  FrmDeductitemApplyEdt: TFrmDeductitemApplyEdt;

implementation

uses PubFn, Services, UDMPublic;
{$R *.dfm}

procedure TFrmDeductitemApplyEdt.bbtnSaveClick(Sender: TObject);
var
  nResult: integer;
  sResult,result,orgids,types: String;
  scheduleid, vehicleid, routeid,orgid, unitid: int64;
begin
  inherited;
  scheduleid := 0;
  vehicleid := 0;
  routeid := 0;
  unitid := 0;
  orgid := 0;
 // SysInfo.LoginUserInfo.POrgID
//  NvChkOrg.CheckById();
//filter_EQL_t!parentid
  if NovaEdtName.ItemIndex < 0 then
  begin
    SysDialogs.Warning('请选择扣费项目！');
    NovaEdtName.SetFocus;
    exit;
  end;
  if NovaCobTarget.ItemIndex < 0 then
  begin
    SysDialogs.Warning('请输入选择扣费对象！');
    NovaCobTarget.SetFocus;
    exit;
  end;
  if (formatdatetime('yyyymmdd', DTPBuildStartDay.Date) > formatdatetime
      ('yyyymmdd', DTPBuildEndDay.Date)) then
  begin
    SysDialogs.Warning('开始日期不能大于结束日期！');
    DTPBuildStartDay.SetFocus;
    exit;
  end;
  if NovaCobTarget.ItemIndex = 0 then
  begin
    // 车牌+班次
    if (trim(NovaHelpSchedule.Text) = '') or (NovaHelpSchedule.id = 0) then
    begin
      SysDialogs.Warning('请输入营运班次！');
      NovaHelpSchedule.SetFocus;
      exit;
    end;
    if (trim(NovaHelpVehicle.Text) = '') or (NovaHelpVehicle.id = 0) then
    begin
      SysDialogs.Warning('请输入营运车辆！');
      NovaHelpVehicle.SetFocus;
      exit;
    end;
    scheduleid := NovaHelpSchedule.id;
    vehicleid := NovaHelpVehicle.id;
  end
  else if NovaCobTarget.ItemIndex = 1 then
  begin
    // 营运单位+班次
    if (trim(NovaHelpSchedule.Text) = '') or (NovaHelpSchedule.id = 0) then
    begin
      SysDialogs.Warning('请输入营运班次！');
      NovaHelpSchedule.SetFocus;
      exit;
    end;
    if (trim(NovaHelpUnit.Text) = '') or (NovaHelpUnit.id = 0) then
    begin
      SysDialogs.Warning('请输入营运单位！');
      NovaHelpUnit.SetFocus;
      exit;
    end;
    scheduleid := NovaHelpSchedule.id;
    unitid := NovaHelpUnit.id;
  end
  else if NovaCobTarget.ItemIndex = 2 then
  begin
    // 车牌
    if (trim(NovaHelpVehicle.Text) = '') or (NovaHelpVehicle.id = 0) then
    begin
      SysDialogs.Warning('请输入营运车辆！');
      NovaHelpVehicle.SetFocus;
      exit;
    end;
    vehicleid := NovaHelpVehicle.id;
  end
  else if NovaCobTarget.ItemIndex = 3 then
  begin
    // 班次
    if (trim(NovaHelpSchedule.Text) = '') or (NovaHelpSchedule.id = 0) then
    begin
      SysDialogs.Warning('请输入营运班次！');
      NovaHelpSchedule.SetFocus;
      exit;
    end;
    scheduleid := NovaHelpSchedule.id;
  end
  else if NovaCobTarget.ItemIndex = 4 then
  begin
    // 营运单位+线路
    if (trim(NovaHelpRoute.Text) = '') or (NovaHelpRoute.id = 0) then
    begin
      SysDialogs.Warning('请输入营运线路！');
      NovaHelpRoute.SetFocus;
      exit;
    end;
    if (trim(NovaHelpUnit.Text) = '') or (NovaHelpUnit.id = 0) then
    begin
      SysDialogs.Warning('请输入营运单位！');
      NovaHelpUnit.SetFocus;
      exit;
    end;
    routeid := NovaHelpRoute.id;
    unitid := NovaHelpUnit.id;
  end
  else if NovaCobTarget.ItemIndex = 5 then
  begin
    // 营运单位
    if (trim(NovaHelpUnit.Text) = '') or (NovaHelpUnit.id = 0) then
    begin
      SysDialogs.Warning('请输入营运单位！');
      NovaHelpUnit.SetFocus;
      exit;
    end;
    unitid := NovaHelpUnit.id;
  end
  else if NovaCobTarget.ItemIndex = 6 then
  begin
    // 线路
    if (trim(NovaHelpRoute.Text) = '') or (NovaHelpRoute.id = 0) then
    begin
      SysDialogs.Warning('请输入营运线路！');
      NovaHelpRoute.SetFocus;
      exit;
    end;
    routeid := NovaHelpRoute.id;
  end
  else if NovaCobTarget.ItemIndex = 7 then
  begin
    // 机构
    if NovaHCobOrg.ItemIndex<0 then
    begin
      SysDialogs.Warning('请选择机构！');
      NovaHCobOrg.SetFocus;
      exit;
    end;
    orgid := NovaHCobOrg.HelpFieldValue['id'];
  end;
  try
    with jcdsSaveApply do
    begin
      active := false;
      Params.ParamValues['balancedeductapply.id'] := id;
      Params.ParamValues['balancedeductapply.balancedeductitemid'] :=
        NovaEdtName.HelpFieldValue['id'];
      Params.ParamValues['balancedeductapply.balancededucttargetid'] :=
        NovaCobTarget.HelpFieldValue['id'];
      Params.ParamValues['balancedeductapply.createby'] := createby;
      if createtime<>'' then      
      Params.ParamValues['balancedeductapply.createtime'] := createtime;
      Params.ParamValues['balancedeductapply.enddate'] := formatdatetime
        ('yyyy-mm-dd', DTPBuildEndDay.Date);
      Params.ParamValues['balancedeductapply.isaudited'] := isaudited;
      Params.ParamValues['balancedeductapply.isauditpass'] := isauditpass;
      Params.ParamValues['balancedeductapply.remarks'] := '';
      if routeid > 0 then
        Params.ParamValues['balancedeductapply.route.id'] := routeid;
      if scheduleid > 0 then
        Params.ParamValues['balancedeductapply.schedule.id'] := scheduleid;
      Params.ParamValues['balancedeductapply.startdate'] := formatdatetime
        ('yyyy-mm-dd', DTPBuildStartDay.Date);
      if unitid > 0 then
        Params.ParamValues['balancedeductapply.unit.id'] := unitid;
      if vehicleid > 0 then
        Params.ParamValues['balancedeductapply.vehicle.id'] := vehicleid;
      if orgid > 0 then
        Params.ParamValues['balancedeductapply.org.id'] := orgid;
      orgids:='';
      types:='';
      with jscdQryCheckOrg do
      begin
         First;
         while(not Eof) do
         begin
           if FieldByName('isselect').AsBoolean then
           begin
               orgids:=orgids+','+fieldbyname('orgid').AsString;
               types:=types+','+fieldbyname('type').AsString;
           end;
           Next;
         end;
      end;
      if Length(orgids)>0 then
      begin
          orgids:=Copy(orgids,2,Length(orgids));
          types:=Copy(types,2,Length(types));
      end;
     Params.ParamValues['balancedeductapply.orgids'] := orgids;
     Params.ParamValues['balancedeductapply.types'] := types;
     bbtnSave.Enabled := False;//保存按钮置为不可用
     execute;

      nResult := Params.ParamByName('flag').Value;
      sResult := Params.ParamByName('msg').Value;
      if (nResult = 1) then
      begin
        if id > 0 then
          result := '修改'
        else
          result := '添加';
        log := result +'固定扣费项目应用：扣费对象='+NovaCobTarget.Text+',扣费项目='
        +NovaEdtName.Text+',开始日期='+formatdatetime('yyyy-mm-dd', DTPBuildStartDay.Date)+
        ',结束日期='+formatdatetime('yyyy-mm-dd', DTPBuildEndDay.Date);
        if NovaCobTarget.ItemIndex = 0 then
        begin
          log := log + ',班次='+NovaHelpSchedule.Text+',车牌='+
          NovaHelpVehicle.Text;
        end
        else if NovaCobTarget.ItemIndex = 1 then
        begin
          log := log + ',班次'+NovaHelpSchedule.Text+',营运单位='+
          NovaHelpUnit.Text;
        end
        else if NovaCobTarget.ItemIndex = 2 then
        begin
          log := log +',车牌号='+NovaHelpVehicle.Text;
        end
        else if NovaCobTarget.ItemIndex = 3 then
        begin
          log:=log+',班次='+NovaHelpSchedule.Text;
        end
        else if NovaCobTarget.ItemIndex = 4 then
        begin
          log := log +',营运单位='+NovaHelpUnit.Text+',线路='+
          NovaHelpRoute.Text;
        end
        else if NovaCobTarget.ItemIndex = 5 then
        begin
          log:=log+',营运单位='+NovaHelpUnit.Text;
        end
        else if NovaCobTarget.ItemIndex = 6 then
        begin
          log:=log+',线路='+NovaHelpRoute.Text;
        end
        else if NovaCobTarget.ItemIndex = 7 then
        begin
          log:=log+',机构='+NovaHCobOrg.Text;
        end;
        SysLog.WriteLog('结算管理->固定扣费项目应用',result,log);
        id := Params.ParamByName('curid').Value;
        SysDialogs.ShowMessage(sResult);
        if (self.edittype = Tedittype.add) then
        begin
          //添加操作，不关闭页面
          bbtnSave.Enabled := True;//保存按钮置为可用
          //清空控件的值
          id := 0;
          NovaHCobOrg.Clear;
          NovaHelpRoute.Clear;
          NovaHelpUnit.Clear;
          NovaHelpSchedule.Clear;
          NovaHelpVehicle.Clear;
          ModalResult := mrok;
        end
        else
        begin
          ModalResult := mrok;
        end;
      end
      else
      begin
        SysDialogs.Warning(sResult);
        NovaEdtName.SetFocus;
        bbtnSave.Enabled := True;//保存按钮置为可用
      end;
    end;
  except
    on E: Exception do
    begin
      SysLog.WriteErr('保存结算扣费项目应用操作失败：' + E.Message);
    end;
  end;

end;

procedure TFrmDeductitemApplyEdt.FormCreate(Sender: TObject);
begin
  inherited;
  NovaCobTarget.active := false;
  NovaCobTarget.active := true;

  NovaHCobOrg.active := false;
  NovaHCobOrg.active := true;
end;

procedure TFrmDeductitemApplyEdt.FormShow(Sender: TObject);
begin
  inherited;
  with NovaEdtName do
  begin
    active := false;
    Params.ParamValues['filter_EQL_t!orgid'] := orgid;
    active := true;
  end;
  if balancedeductitemid>0 then
  begin
    NovaEdtName.SetItemIndexByField('id', balancedeductitemid);
  end;

  with jscdQryCheckOrg do
  begin
    active := false;
    Params.ParamValues['curid'] := id;
    active := true;
  end;

end;

procedure TFrmDeductitemApplyEdt.NovaCobTargetChange(Sender: TObject);
begin
  inherited;
  if NovaCobTarget.ItemIndex = 0 then
  begin
    // 车牌+班次
    NovaHelpRoute.Enabled := false;
    NovaHelpRoute.Clear;
    NovaHelpSchedule.Enabled := true;
    NovaHelpSchedule.SetFocus;
    NovaHelpUnit.Enabled := false;
    NovaHelpUnit.Clear;
    NovaHelpVehicle.Enabled := true;
    NovaHCobOrg.Enabled := false;
    NovaHCobOrg.ItemIndex := -1;
  end
  else if NovaCobTarget.ItemIndex = 1 then
  begin
    // 营运单位+班次
    NovaHelpRoute.Enabled := false;
    NovaHelpRoute.Clear;
    NovaHelpSchedule.Enabled := true;
    NovaHelpSchedule.SetFocus;
    NovaHelpUnit.Enabled := true;
    NovaHelpVehicle.Enabled := false;
    NovaHelpVehicle.Clear;
    NovaHCobOrg.Enabled := false;
    NovaHCobOrg.ItemIndex := -1;
  end
  else if NovaCobTarget.ItemIndex = 2 then
  begin
    // 车牌
    NovaHelpRoute.Enabled := false;
    NovaHelpRoute.Clear;
    NovaHelpSchedule.Enabled := false;
    NovaHelpSchedule.Clear;
    NovaHelpUnit.Enabled := false;
    NovaHelpUnit.Clear;
    NovaHelpVehicle.Enabled := true;
    NovaHelpVehicle.SetFocus;
    NovaHCobOrg.Enabled := false;
    NovaHCobOrg.ItemIndex := -1;
  end
  else if NovaCobTarget.ItemIndex = 3 then
  begin
    // 班次
    NovaHelpRoute.Enabled := false;
    NovaHelpRoute.Clear;
    NovaHelpSchedule.Enabled := true;
    NovaHelpSchedule.SetFocus;
    NovaHelpUnit.Enabled := false;
    NovaHelpUnit.Clear;
    NovaHelpVehicle.Enabled := false;
    NovaHelpVehicle.Clear;
    NovaHCobOrg.Enabled := false;
    NovaHCobOrg.ItemIndex := -1;
  end
  else if NovaCobTarget.ItemIndex = 4 then
  begin
    // 营运单位+线路
    NovaHelpRoute.Enabled := true;
    NovaHelpRoute.SetFocus;
    NovaHelpSchedule.Enabled := false;
    NovaHelpSchedule.Clear;
    NovaHelpUnit.Enabled := true;
    NovaHelpVehicle.Enabled := false;
    NovaHelpVehicle.Clear;
    NovaHCobOrg.Enabled := false;
    NovaHCobOrg.ItemIndex := -1;
  end
  else if NovaCobTarget.ItemIndex = 5 then
  begin
    // 营运单位
    NovaHelpRoute.Enabled := false;
    NovaHelpRoute.Clear;
    NovaHelpSchedule.Enabled := false;
    NovaHelpSchedule.Clear;
    NovaHelpUnit.Enabled := true;
    NovaHelpUnit.SetFocus;
    NovaHelpVehicle.Enabled := false;
    NovaHelpVehicle.Clear;
    NovaHCobOrg.Enabled := false;
    NovaHCobOrg.ItemIndex := -1;
  end
  else if NovaCobTarget.ItemIndex = 6 then
  begin
    // 线路
    NovaHelpRoute.Enabled := true;
    NovaHelpRoute.SetFocus;
    NovaHelpSchedule.Enabled := false;
    NovaHelpSchedule.Clear;
    NovaHelpUnit.Enabled := false;
    NovaHelpUnit.Clear;
    NovaHelpVehicle.Enabled := false;
    NovaHelpVehicle.Clear;
    NovaHCobOrg.Enabled := false;
    NovaHCobOrg.ItemIndex := -1;
  end
  else if NovaCobTarget.ItemIndex = 7 then
  begin
    // 机构
    NovaHelpRoute.Enabled := false;
    NovaHelpRoute.Clear;
    NovaHelpSchedule.Enabled := false;
    NovaHelpSchedule.Clear;
    NovaHelpUnit.Enabled := false;
    NovaHelpUnit.Clear;
    NovaHelpVehicle.Enabled := false;
    NovaHelpVehicle.Clear;
    NovaHCobOrg.Enabled := false;
    //NovaHCobOrg.SetFocus;
    NovaHCobOrg.SetItemIndexByField('id',orgid);

  end
  else
  begin
    NovaHelpRoute.Enabled := true;
    NovaHelpSchedule.Enabled := true;
    NovaHelpUnit.Enabled := true;
    NovaHelpVehicle.Enabled := true;
  end;
end;

end.
