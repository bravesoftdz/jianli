unit UFrmAboutDistance;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, USimpleEditForm, StdCtrls, Buttons, ExtCtrls, NovaEdit, DB, DBClient,
  jsonClientDataSet, ImgList;

type
  TFrmAboutDistance = class(TSimpleEditForm)
    Label3: TLabel;
    NovaEdtName: TNovaEdit;
    Label2: TLabel;
    NovaEdtValue: TNovaEdit;
    Label1: TLabel;
    NovaEdtEndDistance: TNovaEdit;
    Label5: TLabel;
    Label6: TLabel;
    jcdsSaveAboutDistance: TjsonClientDataSet;
    NovaEdtFromDistance: TNovaEdit;
    procedure bbtnSaveClick(Sender: TObject);
  private
    { Private declarations }
    log : String;
  public
    { Public declarations }
    relatetype,createtime, item: String;
    ticketpriceformulaitemid, createby,id: integer;
  end;

var
  FrmAboutDistance: TFrmAboutDistance;

implementation
uses PubFn, Services, UDMPublic;
{$R *.dfm}

procedure TFrmAboutDistance.bbtnSaveClick(Sender: TObject);
var
  msg: String;
  nResult: integer;
  sResult,result: string;
begin
  if trim(NovaEdtFromDistance.text) = '' then
  begin
    NovaEdtFromDistance.SetFocus;
    SysDialogs.Warning('请输入开始里程！');
    exit;
  end;
  if trim(NovaEdtEndDistance.text) = '' then
  begin
    NovaEdtEndDistance.SetFocus;
    SysDialogs.Warning('请输入结束里程！');
    exit;
  end;
  if trim(NovaEdtValue.Text) = '' then
  begin
    NovaEdtValue.SetFocus;
    SysDialogs.Warning('请输入计算值！');
    exit;
  end;

  with jcdsSaveAboutDistance do
  begin
    close;
    Params.ParamByName('formulaitemdistance.id').Value :=id;
    Params.ParamByName('formulaitemdistance.fromdistance').Value := trim(NovaEdtFromDistance.text);
    Params.ParamByName('formulaitemdistance.enddistance').Value := trim(NovaEdtEndDistance.text);
    Params.ParamByName('formulaitemdistance.value').Value := trim(NovaEdtValue.text);
    Params.ParamByName('formulaitemdistance.ticketpriceformulaitem.id').Value := ticketpriceformulaitemid;
    Params.ParamByName('formulaitemdistance.createby').Value := createby;
    Params.ParamByName('formulaitemdistance.createtime').Value := createtime;
    try
      Execute;
      nResult := Params.ParamByName('flag').Value;
      sResult := Params.ParamByName('msg').Value;
      SysDialogs.ShowMessage(sResult);
      if (nResult <= 0) then
      begin
        NovaEdtFromDistance.SetFocus;
      end
      else
      begin
        if id > 0 then
          result := '修改'
        else
          result := '添加';
        log := result + '票价公式组成项明细：项目名称='+NovaEdtName.Text+',开始里程='+
        NovaEdtFromDistance.Text+',结束里程='+NovaEdtEndDistance.Text+',计算值='+
        NovaEdtValue.Text;
        SysLog.WriteLog('票价管理——>票价公式组成项',result,log);
        ModalResult := mrok;
      end;
    except
      on E: Exception do
      begin
        SysLog.WriteErr('票价公式组成项增加失败：' + E.Message);
      end;
    end;
  end;

end;

end.
