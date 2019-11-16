unit UFrmFuelfeegradeDetail;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, USimpleEditForm, ImgList, StdCtrls, Buttons, ExtCtrls, NovaEdit, DB,
  DBClient, jsonClientDataSet;

type
  TFrmFuelfeegradeDetail = class(TSimpleEditForm)
    Label1: TLabel;
    NovaEdtFromdistance: TNovaEdit;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    NovaEdttodistance: TNovaEdit;
    NovaEdtFee: TNovaEdit;
    Label5: TLabel;
    jscdsaveFuelfeegradedetail: TjsonClientDataSet;
    procedure bbtnSaveClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    id,fuelfeegradeid,createby:int64;
    createtime:string;
  end;

var
  FrmFuelfeegradeDetail: TFrmFuelfeegradeDetail;

implementation
uses  PubFn, Services, UDMPublic;
{$R *.dfm}

procedure TFrmFuelfeegradeDetail.bbtnSaveClick(Sender: TObject);
var
  nResult: integer;
  sResult,log,optype: String;
begin
  inherited;
  if NovaEdtFromdistance.Text='' then
  begin
    SysDialogs.Warning('请输入营运开始里程！');
    NovaEdtFromdistance.SetFocus;
    exit;
  end;
  if NovaEdttodistance.Text='' then
  begin
    SysDialogs.Warning('请输入营运结束里程！');
    NovaEdttodistance.SetFocus;
    exit;
  end;
  if strtoint(NovaEdttodistance.Text)<=strtofloat(NovaEdtFromdistance.Text) then
  begin
    SysDialogs.Warning('营运开始里程不能大于结束里程！');
    NovaEdttodistance.SetFocus;
    exit;
  end;
  if NovaEdtFee.Text='' then
  begin
    SysDialogs.Warning('请输入燃油附加费！');
    NovaEdtFee.SetFocus;
    exit;
  end;
  if StrToFloat(NovaEdtFee.Text)>=999.99 then
  begin
    SysDialogs.Warning('超过预设值！请输入不超过999.99的费用！');
    NovaEdtFee.SetFocus;
    exit;
  end;

  try
    with jscdsaveFuelfeegradedetail do
    begin
      active := false;
      Params.ParamValues['fuelfeegradedetail.id'] := id;
      Params.ParamValues['fuelfeegradedetail.fuelfeegradeid'] :=fuelfeegradeid;
      Params.ParamValues['fuelfeegradedetail.fromdistance'] :=NovaEdtFromdistance.Text;
      Params.ParamValues['fuelfeegradedetail.todistance'] := NovaEdttodistance.Text;
      Params.ParamValues['fuelfeegradedetail.fee'] := NovaEdtFee.Text;
      Params.ParamValues['fuelfeegradedetail.createby'] := createby;
      Params.ParamValues['fuelfeegradedetail.updateby'] := sysinfo.LoginUserInfo.UserID;
      if createtime<>'' then
        Params.ParamValues['fuelfeegradedetail.createtime'] := createtime;
      execute;
      nResult := Params.ParamByName('flag').Value;
      sResult := Params.ParamByName('msg').Value;
      if (nResult = 1) then
      begin
        if id > 0 then
          optype := '修改'
        else
          optype := '添加';
        log := optype +'燃油附加费营运里程区间信息：营运开始里程='
        +NovaEdtFromdistance.Text+',结束里程='+NovaEdttodistance.Text+
        ',燃油附加费='+NovaEdtFee.Text;
        SysLog.WriteLog('票价管理->燃油附加费设置',optype,log);
        id := Params.ParamByName('id').Value;
        SysDialogs.ShowMessage(sResult);
        ModalResult := mrok;
      end
      else
      begin
        SysDialogs.Warning(sResult);
        NovaEdtFromdistance.SetFocus;
      end;
    end;
  except
    on E: Exception do
    begin
      SysLog.WriteErr('保存燃油附加费营运里程区间信息操作失败：' + E.Message);
    end;
  end;

end;

end.
