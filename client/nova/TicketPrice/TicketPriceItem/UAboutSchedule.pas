unit UAboutSchedule;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, USimpleEditForm, StdCtrls, Buttons, ExtCtrls, NovaHelp, NovaEdit, DB,
  DBClient, jsonClientDataSet, ImgList;

type
  TFrmAboutSchedule = class(TSimpleEditForm)
    Label3: TLabel;
    NovaEdtName: TNovaEdit;
    Label2: TLabel;
    NovaEdtValue: TNovaEdit;
    Label1: TLabel;
    NovaHSchdule: TNovaHelp;
    jcdsSaveItemAboutSchedule: TjsonClientDataSet;
    procedure bbtnSaveClick(Sender: TObject);
  private
    { Private declarations }
    log : String;
  public
    { Public declarations }
    relatetype:String;
    createtime: string;
    id,ticketpriceformulaitemid,scheduleid,createby:integer;
  end;

var
  FrmAboutSchedule: TFrmAboutSchedule;

implementation
uses PubFn, Services, UDMPublic;
{$R *.dfm}

procedure TFrmAboutSchedule.bbtnSaveClick(Sender: TObject);
var
  nResult: integer;
  sResult,result: string;
begin
  inherited;
  if (trim(NovaHSchdule.text)='') or (NovaHSchdule.Id<0) then
  begin
    NovaHSchdule.SetFocus;
    SysDialogs.Warning('请输入班次！');
    exit;
  end;
  if trim(NovaEdtValue.Text) = '' then
  begin
    NovaEdtValue.SetFocus;
    SysDialogs.Warning('请输入计算值！');
    exit;
  end;

  with jcdsSaveItemAboutSchedule do
  begin
    close;
    Params.ParamByName('formulaitemschedule.id').Value := id;
    Params.ParamByName('formulaitemschedule.ticketpriceformulaitem.id').Value := ticketpriceformulaitemid;
    Params.ParamByName('formulaitemschedule.value').Value := strtofloat(NovaEdtValue.Text);
    Params.ParamByName('formulaitemschedule.scheduleid').Value :=  NovaHSchdule.Id;
    Params.ParamByName('formulaitemschedule.createby').Value := createby;
    Params.ParamByName('formulaitemschedule.createtime').Value := createtime;
    try
      Execute;
      nResult := Params.ParamByName('flag').Value;
      sResult := Params.ParamByName('msg').Value;
      if (nResult <= 0) then
      begin
        SysDialogs.Warning(sResult);
        NovaHSchdule.SetFocus;
      end
      else
      begin
        if id > 0 then
          result := '修改'
        else
          result := '添加';
        log := result + '票价公式组成项明细：项目名称='+NovaEdtName.Text+',班次号='+
        NovaHSchdule.Text+',计算值='+NovaEdtValue.Text;
        SysLog.WriteLog('票价管理——>票价公式组成项',result,log);
        SysDialogs.ShowMessage(sResult);
        ModalResult := mrok;
      end;
    except
      on E: Exception do
      begin
        SysLog.WriteErr('车型相关票价公式组成项信息增加失败：' + E.Message);
      end;
    end;
  end;

end;

end.
