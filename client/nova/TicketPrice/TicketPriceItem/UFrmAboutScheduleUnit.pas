unit UFrmAboutScheduleUnit;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, USimpleEditForm, StdCtrls, Buttons, ExtCtrls, DB, DBClient,
  jsonClientDataSet, NovaHelp, NovaEdit;

type
  TFrmAboutScheduleUnit = class(TSimpleEditForm)
    Label3: TLabel;
    Label2: TLabel;
    Label1: TLabel;
    jcdsSaveAboutScheduleUnit: TjsonClientDataSet;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    NovaEdtName: TNovaEdit;
    NovaHelpUnit: TNovaHelp;
    NovaHSchdule: TNovaHelp;
    NovaEdtValue: TNovaEdit;
    procedure bbtnSaveClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    relatetype:String;
    createtime: string;
    id,ticketpriceformulaitemid,scheduleid,unitid,createby:integer;
  end;

var
  FrmAboutScheduleUnit: TFrmAboutScheduleUnit;

implementation
uses PubFn, Services, UDMPublic;
{$R *.dfm}

procedure TFrmAboutScheduleUnit.bbtnSaveClick(Sender: TObject);
var
  nResult: integer;
  sResult: string;
begin
  inherited;
  if (trim(NovaHelpUnit.text)='') or (NovaHelpUnit.Id<0) then
  begin
    NovaHelpUnit.SetFocus;
    SysDialogs.Warning('请输入车属单位！');
    exit;
  end;
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

  with jcdsSaveAboutScheduleUnit do
  begin
    close;
    Params.ParamByName('formulaitemscheduleunit.id').Value := id;
    Params.ParamByName('formulaitemscheduleunit.ticketpriceformulaitem.id').Value := ticketpriceformulaitemid;
    Params.ParamByName('formulaitemscheduleunit.value').Value := strtofloat(NovaEdtValue.Text);
    Params.ParamByName('formulaitemscheduleunit.scheduleid').Value :=  NovaHSchdule.Id;
    Params.ParamByName('formulaitemscheduleunit.unitid').Value :=  NovaHelpUnit.Id;
    Params.ParamByName('formulaitemscheduleunit.createby').Value := createby;
    Params.ParamByName('formulaitemscheduleunit.createtime').Value := createtime;
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
