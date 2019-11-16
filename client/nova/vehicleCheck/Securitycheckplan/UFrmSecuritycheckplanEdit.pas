unit UFrmSecuritycheckplanEdit;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, USimpleEditForm, DB, DBClient, jsonClientDataSet, NovaHelp, StdCtrls,
  NovaEdit, NovaComboBox, ComCtrls, Buttons, ExtCtrls, NovaHComboBox, ImgList;

type
  TFrmSecuritycheckplanEdit = class(TSimpleEditForm)
    Label1: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    jsonCDSVehSave: TjsonClientDataSet;
    Label11: TLabel;
    nvhlpcode: TNovaHelp;
    cbbperiodtype: TNovaComboBox;
    edtperiod: TNovaEdit;
    cbbstartdate: TDateTimePicker;
    dtpenddate: TDateTimePicker;
    lbl1: TLabel;
    lbl16: TLabel;
    Label2: TLabel;
    Label6: TLabel;
    procedure bbtnSaveClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure cbbunitnameChange(Sender: TObject);
    procedure cbbperiodtypeChange(Sender: TObject);
  private
    log : String;
    { Private declarations }
  public
    { Public declarations }
    flag:boolean;
    vehicleid,createby: string;
    id : Int64;
    createtime:TDateTime;
  end;

var
  FrmSecuritycheckplanEdit: TFrmSecuritycheckplanEdit;

implementation

uses Services, PubFn;
{$R *.dfm}

procedure TFrmSecuritycheckplanEdit.bbtnSaveClick(Sender: TObject);
var
  nResult: Integer;
  sResult: string;
begin
  if Trim(nvhlpcode.Text) = '' then
  begin
    SysDialogs.Warning('请选择车牌号码');
    nvhlpcode.SetFocus;
    exit;
  end;
  if (cbbperiodtype.ItemIndex < 0) then
  begin
    SysDialogs.Warning('请选择安检周期类型');
    cbbperiodtype.SetFocus;
    exit;
  end;
  if (trim(edtperiod.Text) = '') then
  begin
    SysDialogs.Warning('请选择安检周期');
    edtperiod.SetFocus;
    exit;
  end;
  with jsonCDSVehSave do
  begin
    Close;
    if nvhlpcode.Id = 0 then
    begin
      vehicleid := vehicleid;
    end else
    begin
      vehicleid := IntToStr(nvhlpcode.Id);
    end;
    if Trim(vehicleid) = ''then
    begin
      SysDialogs.Warning('请填写正确的车牌号码');
      nvhlpcode.SetFocus;
      exit;
    end;
    Params.ParamByName('securitycheckplan.id').Value := id;
    Params.ParamByName('securitycheckplan.vehicleid').Value := vehicleid;
    Params.ParamByName('securitycheckplan.createby').Value := createby;
    Params.ParamByName('securitycheckplan.createtime').Value := DateTimeToStr(createtime);
    Params.ParamByName('securitycheckplan.period').Value := edtperiod.Text;
    Params.ParamByName('securitycheckplan.startdate').Value := DateTimeToStr(cbbstartdate.DateTime);
    Params.ParamByName('securitycheckplan.enddate').Value := DateTimeToStr(dtpenddate.DateTime);
    Params.ParamByName('securitycheckplan.periodtype').Value := TCommInfo(cbbperiodtype.Items.Objects[cbbperiodtype.ItemIndex]).Value;
    
    try
      Execute;
      nResult := Params.ParamByName('flag').Value;
      sResult := Params.ParamByName('msg').Value;
      SysDialogs.ShowMessage(sResult);
      if (nResult <= 0) then
      begin
        cbbstartdate.SetFocus;
      end
      else
      begin
        if id > 0 then
        begin
          log := '修改安检计划：车牌号码='+nvhlpcode.Text+',安检类型='+cbbperiodtype.Text
          +',安检周期='+edtperiod.Text+'天';
          SysLog.WriteLog('安检管理——>安检计划','修改',log);
        end else
        begin
          log := '添加安检计划：车牌号码='+nvhlpcode.Text+',安检类型='+cbbperiodtype.Text
          +',安检周期='+edtperiod.Text+'天';
          SysLog.WriteLog('安检管理——>安检计划','添加',log);
        end;
        id := Params.ParamByName('id').Value;
        ModalResult := mrok;
      end;
    except
      on E: Exception do
      begin
        SysLog.WriteErr('安检计划信息添加失败：' + E.Message);
      end;
    end;
  end;
end;

procedure TFrmSecuritycheckplanEdit.cbbperiodtypeChange(Sender: TObject);
begin
  inherited;
  if cbbperiodtype.ItemIndex = 0 then
  begin
    edtperiod.Text := '1';
    edtperiod.Enabled := True;
  end else if cbbperiodtype.ItemIndex = 1 then
  begin
    edtperiod.Text := '15';
    edtperiod.Enabled := False;
    dtpenddate.DateTime := cbbstartdate.DateTime + 15;
  end else if cbbperiodtype.ItemIndex = 2 then
  begin
    edtperiod.Text := '30';
    edtperiod.Enabled := False;
    dtpenddate.DateTime := cbbstartdate.DateTime + 30;
  end else if cbbperiodtype.ItemIndex = 3 then
  begin
    edtperiod.Text := '90';
    edtperiod.Enabled := False;
    dtpenddate.DateTime := cbbstartdate.DateTime + 90;
  end else if cbbperiodtype.ItemIndex = 4 then
  begin
    edtperiod.Text := '365';
    edtperiod.Enabled := False;
    dtpenddate.DateTime := cbbstartdate.DateTime + 365;
  end;
end;

procedure TFrmSecuritycheckplanEdit.cbbunitnameChange(Sender: TObject);
begin
  inherited;
  nvhlpcode.Text := '';
end;

procedure TFrmSecuritycheckplanEdit.FormCreate(Sender: TObject);
begin
  inherited;
  cbbstartdate.DateTime := now();
  dtpenddate.DateTime := Now();

  cbbperiodtype.Active:= false;
  cbbperiodtype.Active:= true;
end;

end.
