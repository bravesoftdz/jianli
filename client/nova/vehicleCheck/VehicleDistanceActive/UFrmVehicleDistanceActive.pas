unit UFrmVehicleDistanceActive;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, USimpleCRUDForm, DBGridEhGrouping, DB, DBClient, jsonClientDataSet,
  PrnDbgeh, ImgList, GridsEh, DBGridEh, ComCtrls, ToolWin, ExtCtrls, StdCtrls,
  NovaComboBox, NovaEdit, NovaHelp, NvPrnDbgeh, NvDbgridEh,
   NovaCheckedComboBox,UDMPublic, Services, PubFn;

type
  TFrmVehicleDistanceActive = class(TSimpleCRUDForm)
    lbldate: TLabel;
    lbl1: TLabel;
    dtpstartdate: TDateTimePicker;
    dtpenddate: TDateTimePicker;
    lbl2: TLabel;
    lblUserId: TLabel;
    jcdsSave: TjsonClientDataSet;
    nvhlpUserid: TNovaHelp;
    nvhlpvehicleno: TNovaHelp;
    procedure tbtnFilterClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure tbtnInsertClick(Sender: TObject);
    procedure tbtnEditClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    vehicleid : Integer;
  end;

var
  FrmVehicleDistanceActive: TFrmVehicleDistanceActive;

implementation

uses UFrmVehicleDistanceActiveHistory;
{$R *.dfm}

procedure TFrmVehicleDistanceActive.FormShow(Sender: TObject);
begin
  inherited;
  dtpstartdate.Date := Now;
  dtpenddate.Date := Now;
  //是否开启车辆二期维护有效期
  if getParametervalue('6006', Sysinfo.LoginUserInfo.OrgID) = '0' then
  begin
     dbgrdhResult.Columns[3].Visible := False;
  end
  else
  begin
    dbgrdhResult.Columns[3].Visible := True;
  end;
end;

//查询最后一次激活记录
procedure TFrmVehicleDistanceActive.tbtnFilterClick(Sender: TObject);
begin
 inherited;
 //是否开启车辆里程限制
  if getParametervalue('0143', Sysinfo.LoginUserInfo.OrgID) = '0' then
  begin
    SysDialogs.ShowMessage('参数0143未开启车辆里程限制的功能！');
    exit;
  end;

  if FormatDateTime('yyyymmdd', dtpstartdate.Date) > FormatDateTime('yyyymmdd',
    dtpenddate.Date)then
  begin
    SysDialogs.ShowMessage('开始日期不能大于结束日期！');
    exit;
  end;

  with jcdsResult do
  begin
    Active := false;
      Params.ParamByName('startdate').Value
      := FormatDateTime('yyyy-mm-dd hh:mm:ss',dtpstartdate.DateTime);
    Params.ParamByName('enddate').Value
      := FormatDateTime('yyyy-mm-dd hh:mm:ss',dtpenddate.DateTime)+' 23:59:59' ;
     if Trim(nvhlpvehicleno.Text) = '' then
    begin
      Params.ParamValues['vehicleid'] := '';
    end else
    begin
      Params.ParamValues['vehicleid'] := nvhlpvehicleno.Id
    end;
    if (not (Trim(nvhlpUserid.Text) = '')) and (nvhlpUserid.Id>0) then //用户名
    begin
      Params.ParamValues['userid']:= nvhlpUserid.HelpFieldValue['id'];
    end
   else
    begin
      Params.ParamValues['userid']:= '';
    end;

    Active := True;
  end;
end;

//查询历史激活记录
procedure TFrmVehicleDistanceActive.tbtnEditClick(Sender: TObject);
begin
  try
    frmVehicleDistanceActiveHistory := TfrmVehicleDistanceActiveHistory.Create(self);
    with frmVehicleDistanceActiveHistory do
    begin
      Caption := '车辆里程限制激活历史记录';
      dtpstartdate.Date:= Now;
      dtpenddate.Date := Now;
      if  (jcdsResult.Active=True) and (jcdsResult.RecordCount>0)  then
     begin
      nvhlpvehicleno.Text := jcdsResult.FieldByName('vehicleno').AsString;
      vehicleno :=  jcdsResult.FieldByName('vehicleno').AsString;
      vehicleid := jcdsResult.FieldByName('vehicleid').AsInteger;
      with jcdsVehicledistancehistory do
      begin
        Active:=False;
        Params.ParamByName('filter_GTD_vd!createtime').Value
              := FormatDateTime('yyyy-mm-dd hh:mm:ss',dtpstartdate.DateTime);
        Params.ParamByName('filter_LED_vd!createtime').Value
              := FormatDateTime('yyyy-mm-dd hh:mm:ss',dtpenddate.DateTime) ;
        Params.ParamByName('filter_EQL_v!id').Value := jcdsResult.FieldByName('vehicleid').AsString;
        Active := True;
      end;
     end;
      ShowModal;
    end;
  finally
    FreeAndNil(frmVehicleDistanceActiveHistory);
  end;

end;

 //激活车辆
procedure TFrmVehicleDistanceActive.tbtnInsertClick(Sender: TObject);
var  msg,sResult: String;
  nResult: integer;
begin
  if not jcdsResult.active then
    exit;

  if jcdsResult.RecordCount = 0 then
    exit;
  if not SysDialogs.Confirm('信息提示', '确认要激活车辆:'
          +jcdsResult.FieldByName('vehicleno').AsString+'吗?') then
    exit;

  with jcdsSave do
  begin
   try
    close;
     Params.ParamByName('vehicledistance.vehicleid').Value
                      :=jcdsResult.FieldByName('vehicleid').AsString;
     Params.ParamByName('vehicledistance.lastactivetime').Value
                      :=jcdsResult.FieldByName('createtime').AsString;
     Params.ParamByName('vehicledistance.departdistance').Value
                      :=jcdsResult.FieldByName('departdistance').AsString;
     Params.ParamByName('vehicledistance.limitdistance').Value
                      :=jcdsResult.FieldByName('distancelimit').AsString;
     Execute;
     nResult := Params.ParamByName('flag').Value;
     sResult := Params.ParamByName('msg').Value;
     SysDialogs.ShowMessage(sResult);
     if (nResult > 0) then
     begin
       SysLog.WriteLog('车辆行驶里程管理', '激活车辆里程',
       '车牌号：'+jcdsResult.FieldByName('vehicleno').AsString +','
       +'激活时已发班里程：'+jcdsResult.FieldByName('departdistance').AsString);
      vehicleid := Params.ParamByName('vehicleid').Value;

     end;
       tbtnFilterClick(Sender);
      jcdsResult.Locate('vehicleid',vehicleid,[] );

   except
      on E: Exception do
      begin
        SysLog.WriteErr('激活失败：' + E.Message);
      end;
    end;

  end;
end;
end.
