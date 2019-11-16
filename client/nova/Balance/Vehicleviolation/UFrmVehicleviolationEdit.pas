unit UFrmVehicleviolationEdit;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, USimpleEditForm, ImgList, StdCtrls, Buttons, ExtCtrls, NovaEdit,
  NovaHelp, ComCtrls, DB, DBClient, jsonClientDataSet;

type
  TFrmVehicleviolationEdit = class(TSimpleEditForm)
    lbl1: TLabel;
    lbl2: TLabel;
    nvhelpvehicleno: TNovaHelp;
    NHelpRoute: TNovaHelp;
    jcdsVehSave: TjsonClientDataSet;
    jcdsRoutename: TjsonClientDataSet;
    lbl3: TLabel;
    lbl4: TLabel;
    lbl5: TLabel;
    lbl6: TLabel;
    dtpdepartdate: TDateTimePicker;
    edtdeparttime: TDateTimePicker;
    edtdebit: TNovaEdit;
    mmoremark: TMemo;
    lbl7: TLabel;
    lbl8: TLabel;
    lbl9: TLabel;
    procedure bbtnSaveClick(Sender: TObject);
    procedure nvhelpvehiclenoIdChange(Sender: TObject);
    procedure edtdebitExit(Sender: TObject);
  private
    { Private declarations }
    log : string;
  public
    { Public declarations }
    flag : boolean;
    createtime, billdate : TDate;
    id, createby, orgid, billor,balancetype : Int64;
    vehicleid, notenum : string;
  end;

var
  FrmVehicleviolationEdit: TFrmVehicleviolationEdit;

implementation

uses Services;
{$R *.dfm}

procedure TFrmVehicleviolationEdit.bbtnSaveClick(Sender: TObject);
var sResult : string;
    nResult : Int64;
begin
  inherited;
  if Trim(nvhelpvehicleno.Text) = '' then
  begin
    SysDialogs.ShowMessage('请填写违规车辆信息！');
    Exit;
  end;
  if nvhelpvehicleno.Id = 0 then
  begin
    SysDialogs.ShowMessage('请填写违规车辆信息！');
    Exit;
  end;
  if Trim(edtdebit.Text) = '' then
  begin
    SysDialogs.ShowMessage('请填写罚金信息！');
    Exit;
  end;
  with jcdsVehSave do
  begin
    Close;
    if nvhelpvehicleno.Id = 0 then
    begin
      vehicleid := vehicleid;
    end else
    begin
      vehicleid := IntToStr(nvhelpvehicleno.Id);
    end;
    Params.ParamByName('vehicleviolation.id').Value := id;
    Params.ParamByName('vehicleviolation.vehicleid').Value := vehicleid;
    Params.ParamByName('vehicleviolation.createby').Value := createby;
    Params.ParamByName('vehicleviolation.createtime').Value := DateTimeToStr(createtime);
    Params.ParamByName('vehicleviolation.routename').Value := NHelpRoute.Text;
    Params.ParamByName('vehicleviolation.violationdate').Value := FormatDateTime('YYYY-MM-DD', dtpdepartdate.DateTime);
    Params.ParamByName('vehicleviolation.departtime').Value := FormatDateTime('hh:mm',edtdeparttime.Time);
    Params.ParamByName('vehicleviolation.remark').Value := mmoremark.Text;
    params.ParamByName('vehicleviolation.debit').Value := edtdebit.Text;
    Params.ParamByName('vehicleviolation.ishandle').Value := 0;
    params.ParamByName('vehicleviolation.balancetype').Value := balancetype;
    params.ParamByName('vehicleviolation.status').Value := 0;
    params.ParamByName('vehicleviolation.orgid').Value := SysInfo.LoginUserInfo.OrgID;
    params.ParamByName('vehicleviolation.billor').Value := billor;
    params.ParamByName('vehicleviolation.billdate').Value := DateTimeToStr(billdate);
    params.ParamByName('vehicleviolation.notenum').Value := notenum;
    try
      Execute;
      nResult := Params.ParamByName('flag').Value;
      sResult := Params.ParamByName('msg').Value;
      SysDialogs.ShowMessage(sResult);
      if (nResult <= 0) then
      begin
        nvhelpvehicleno.SetFocus;
      end
      else
      begin
        if id > 0 then
        begin
          log := '修改营运车辆违规处理：车牌号码='+nvhelpvehicleno.Text;
          if Trim(NHelpRoute.Text) <> '' then
          begin
            log := log + ',营运线路='+NHelpRoute.Text;
          end;
          log := log + ',发车日期='+DateTimeToStr(dtpdepartdate.DateTime)+',发车时间='+
          DateTimeToStr(edtdeparttime.Time)+',罚金='+edtdebit.Text+',违规情况='+mmoremark.Text+
          ',修改人=';
          SysLog.WriteLog('结算管理——>营运车辆违规处理','修改',log);
        end else
        begin
          log := '添加营运车辆违规处理：车牌号码='+nvhelpvehicleno.Text;
          if Trim(NHelpRoute.Text) <> '' then
          begin
            log := log + ',营运线路='+NHelpRoute.Text;
          end;
          log := log + ',发车日期='+DateTimeToStr(dtpdepartdate.DateTime)+',发车时间='+
          DateTimeToStr(edtdeparttime.Time)+',罚金='+edtdebit.Text+',违规情况='+mmoremark.Text;
          SysLog.WriteLog('结算管理——>营运车辆违规处理','添加',log);
        end;
        id := Params.ParamByName('id').Value;
        ModalResult := mrok;
      end;
    except
      on E: Exception do
      begin
        SysDialogs.ShowMessage('客户端操作异常');
        SysLog.WriteErr('营运车辆违规处理添加失败：' + E.Message);
      end;
    end;
  end;
end;

procedure TFrmVehicleviolationEdit.edtdebitExit(Sender: TObject);
begin
  inherited;
  if Trim(edtdebit.Text) = '' then
    edtdebit.Text := '0'
  else
    edtdebit.Text := formatfloat('0.00', StrToFloat(edtdebit.Text));
  if Length(Trim(edtdebit.Text)) > 9 then
  begin
    SysDialogs.ShowMessage('只能输入6位整数。请重新输入！');
    edtdebit.SetFocus;
    Exit;
  end;

end;

procedure TFrmVehicleviolationEdit.nvhelpvehiclenoIdChange(Sender: TObject);
begin
  inherited;
  if id = 0 then
  begin
    with jcdsRoutename do
    begin
      Params.ParamValues['vehicleid'] := nvhelpvehicleno.Id;
      Execute;
      if Params.ParamByName('msg').AsString = 'null' then
        NHelpRoute.Text := ''
      else
        NHelpRoute.Text := Params.ParamByName('msg').AsString;
    end;
  end;
end;

end.
