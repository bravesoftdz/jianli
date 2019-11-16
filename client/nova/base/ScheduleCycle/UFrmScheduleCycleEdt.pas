unit UFrmScheduleCycleEdt;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, USimpleEditForm, StdCtrls, Buttons, ExtCtrls, NovaEdit, ComCtrls, DB,
  DBClient, jsonClientDataSet, ImgList, NovaHelp;

type
  TFrmScheduleCycleEdt = class(TSimpleEditForm)
    Label1: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    GroupBox1: TGroupBox;
    Label8: TLabel;
    NovaEdtDRIVERPERIOD: TNovaEdit;
    Label9: TLabel;
    NovaEdtDRIVERSTEP: TNovaEdit;
    Label7: TLabel;
    NovaEdtDRIVERNUM: TNovaEdit;
    GroupBox2: TGroupBox;
    Label5: TLabel;
    NovaEdtVEHICLESTEP: TNovaEdit;
    NovaEdtVEHICLEPERIOD: TNovaEdit;
    Label6: TLabel;
    GroupBox3: TGroupBox;
    Label2: TLabel;
    Label13: TLabel;
    Label14: TLabel;
    NovaEdtSTEWARDPERIOD: TNovaEdit;
    NovaEdtSTEWARDSTEP: TNovaEdit;
    NovaEdtSTEWARDNUM: TNovaEdit;
    DateTpFromDate: TDateTimePicker;
    DateTpEndDate: TDateTimePicker;
    jcdsSavecyclescheme: TjsonClientDataSet;
    Label10: TLabel;
    Label11: TLabel;
    Label12: TLabel;
    NovaEdtName: TNovaHelp;
    procedure bbtnSaveClick(Sender: TObject);
    procedure NovaEdtDRIVERNUMExit(Sender: TObject);
    procedure NovaEdtSTEWARDNUMExit(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    log : String;
    { Private declarations }
  public
    { Public declarations }
    id, createby,orgid: Int64;
    createtime:string;
  end;

var
  FrmScheduleCycleEdt: TFrmScheduleCycleEdt;

implementation
uses PubFn,Services, UDMPublic;
{$R *.dfm}

procedure TFrmScheduleCycleEdt.bbtnSaveClick(Sender: TObject);
var
  msg: String;
  nResult: integer;
  sResult: string;
begin
  inherited;

  if ((trim(NovaEdtName.Text)='') or  (NovaEdtName.Id=0)) then
  begin
    SysDialogs.Warning('请输入循环组名称！');
    NovaEdtName.SetFocus;
    exit;
  end;
  if (trunc(DateTpFromDate.DateTime)>trunc(DateTpEndDate.DateTime)) then
  begin
    SysDialogs.Warning('开始日期不能大于结束日期！');
    DateTpFromDate.SetFocus;
    exit;
  end;

  if (trim(NovaEdtVEHICLEPERIOD.Text) = '') then
  begin
    SysDialogs.Warning('请输入车辆的循环周期！');
    NovaEdtVEHICLEPERIOD.SetFocus;
    exit;
  end;

  if (trim(NovaEdtVEHICLESTEP.Text) = '') then
  begin
    SysDialogs.Warning('请输入车辆的循环步长！');
    NovaEdtVEHICLESTEP.SetFocus;
    exit;
  end;

  if (trim(NovaEdtDRIVERPERIOD.Text) = '') then
  begin
     NovaEdtDRIVERPERIOD.Text:='0';
   { SysDialogs.Warning('请输入驾驶员的循环周期！');
    NovaEdtDRIVERPERIOD.SetFocus;
    exit;  }
  end;
  if (trim(NovaEdtDRIVERSTEP.Text) = '') then
  begin
     NovaEdtDRIVERSTEP.Text:='0';
    {SysDialogs.Warning('请输入驾驶员的循环步长！');
    NovaEdtDRIVERSTEP.SetFocus;
    exit; }
  end;
  if (trim(NovaEdtDRIVERNUM.Text) = '') then
  begin
   NovaEdtDRIVERNUM.Text:='0';
   { SysDialogs.Warning('请输入驾驶员的当班人数！');
    NovaEdtDRIVERNUM.SetFocus;
    exit;}
  end;

  if (trim(NovaEdtSTEWARDPERIOD.Text) = '') then
    NovaEdtSTEWARDPERIOD.text:='0';
  if (trim(NovaEdtSTEWARDSTEP.Text) = '') then
    NovaEdtSTEWARDSTEP.text:='0';
  if (trim(NovaEdtSTEWARDNUM.Text) = '') then
    NovaEdtSTEWARDNUM.text:='0';


  with jcdsSavecyclescheme do
  begin
    close;
    Params.ParamByName('cyclescheme.id').Value := id;

    Params.ParamByName('cyclescheme.routeid').Value := NovaEdtName.Id;
    Params.ParamByName('cyclescheme.name').Value := NovaEdtName.text;
    Params.ParamByName('cyclescheme.startdate').Value := FormatDateTime('yyyy-mm-dd',DateTpFromDate.DateTime);
    Params.ParamByName('cyclescheme.enddate').Value := FormatDateTime('yyyy-mm-dd',DateTpEndDate.DateTime);
    Params.ParamByName('cyclescheme.vehicleperiod').Value := NovaEdtVEHICLEPERIOD.Text;
    Params.ParamByName('cyclescheme.vehiclestep').Value := NovaEdtVEHICLESTEP.Text;
    Params.ParamByName('cyclescheme.driverperiod').Value := NovaEdtDRIVERPERIOD.Text;
    Params.ParamByName('cyclescheme.driverstep').Value := NovaEdtDRIVERSTEP.Text;
    Params.ParamByName('cyclescheme.drivernum').Value := NovaEdtDRIVERNUM.Text;
    Params.ParamByName('cyclescheme.stewardperiod').Value := NovaEdtSTEWARDPERIOD.Text;
    Params.ParamByName('cyclescheme.stewardstep').Value :=NovaEdtSTEWARDSTEP.Text;
    Params.ParamByName('cyclescheme.stewardnum').Value :=NovaEdtSTEWARDNUM.Text;
    Params.ParamByName('cyclescheme.orgid').Value := orgid;
    Params.ParamByName('cyclescheme.createby').Value := createby;

    if createtime<>'' then
      Params.ParamByName('cyclescheme.createtime').Value := createtime;
    try
      Execute;
      nResult := Params.ParamByName('flag').Value;
      sResult := Params.ParamByName('msg').Value;
      SysDialogs.ShowMessage(sResult);
      if (nResult <= 0) then
      begin
        NovaEdtName.SetFocus;
      end
      else
      begin
        if id>0 then
        begin
           log:=log+'，修改后,班次循环组：名称='+NovaEdtName.Text+',循环开始日期='+
          FormatDateTime('yyyy-mm-dd',DateTpFromDate.DateTime)+',循环结束日期='+
          FormatDateTime('yyyy-mm-dd',DateTpEndDate.DateTime)+',循环周期='+
          NovaEdtVEHICLEPERIOD.Text+',步长='+NovaEdtVEHICLESTEP.Text;
          SysLog.WriteLog('业务管理——>班次循环','修改',log);
        end
        else
        begin
          log := '添加班次循环组：名称='+NovaEdtName.Text+',循环开始日期='+
          FormatDateTime('yyyy-mm-dd',DateTpFromDate.DateTime)+',循环结束日期='+
          FormatDateTime('yyyy-mm-dd',DateTpEndDate.DateTime)+',循环周期='+
          NovaEdtVEHICLEPERIOD.Text+',步长='+NovaEdtVEHICLESTEP.Text;
          SysLog.WriteLog('业务管理——>班次循环','添加',log);
        end;

        id:=  Params.ParamByName('cycleschemeid').Value;
        ModalResult := mrok;
      end;
    except
      on E: Exception do
      begin
        SysLog.WriteErr('班次循环组信息增加失败：' + E.Message);
      end;
    end;
  end;

end;

procedure TFrmScheduleCycleEdt.FormShow(Sender: TObject);
begin
  inherited;
    if id>0 then
    begin
      log:='修改前班次循环的有效日期为：'+FormatDateTime('yyyy-mm-dd',DateTpFromDate.DateTime)
      +',结束日期为:'+FormatDateTime('yyyy-mm-dd',DateTpEndDate.DateTime)+',循环线路：'+NovaEdtName.text
      +',车辆周期：'+NovaEdtVEHICLEPERIOD.Text+'步长为:'+NovaEdtVEHICLESTEP.Text;
    end;
end;

procedure TFrmScheduleCycleEdt.NovaEdtDRIVERNUMExit(Sender: TObject);
begin
  inherited;
  if(NovaEdtDRIVERNUM.Text<>'') and (strtoint(NovaEdtDRIVERNUM.Text)>4) then
  begin
    SysDialogs.Warning('驾驶员的当班人数不能超过4个！');
    NovaEdtDRIVERNUM.SetFocus;
    exit;
  end;
end;

procedure TFrmScheduleCycleEdt.NovaEdtSTEWARDNUMExit(Sender: TObject);
begin
  inherited;
  if(NovaEdtSTEWARDNUM.Text<>'') and (strtoint(NovaEdtSTEWARDNUM.Text)>2) then
  begin
    SysDialogs.Warning('乘务员的当班人数不能超过2个！');
    NovaEdtSTEWARDNUM.SetFocus;
    exit;
  end;
end;

end.
