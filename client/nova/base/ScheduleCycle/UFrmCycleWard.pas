unit UFrmCycleWard;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, USimpleEditForm, StdCtrls, Buttons, ExtCtrls, ComCtrls, NovaEdit,
  NovaHelp, DB, DBClient, jsonClientDataSet, ImgList;

type
  TFrmCycleWard = class(TSimpleEditForm)
    Label2: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    NovaEdtName: TNovaEdit;
    DateTpFromDate: TDateTimePicker;
    DateTpEndDate: TDateTimePicker;
    jcdsSaveSteward: TjsonClientDataSet;
    NovaHelpSteward: TNovaHelp;
    procedure bbtnSaveClick(Sender: TObject);
  private
    log : String;
    { Private declarations }
  public
    { Public declarations }
    id, createby,pid,orderno: integer;
    createtime,stewardname:string;
  end;

var
  FrmCycleWard: TFrmCycleWard;

implementation
uses PubFn,Services, UDMPublic;
{$R *.dfm}

procedure TFrmCycleWard.bbtnSaveClick(Sender: TObject);
var
  msg,types: String;
  nResult: integer;
  sResult: string;
begin
  inherited;
  if (trim(NovaHelpSteward.Text)='') or (NovaHelpSteward.Id<=0) then
  begin
    SysDialogs.Warning('请输入乘务员！');
    NovaHelpSteward.SetFocus;
    exit;
  end;

  with jcdsSaveSteward do
  begin
    close;
    Params.ParamByName('cycleschemessteward.id').Value := id;
    Params.ParamByName('cycleschemessteward.orderno').Value := orderno;

    Params.ParamByName('cycleschemessteward.steward.id').Value := NovaHelpSteward.Id;
    Params.ParamByName('cycleschemessteward.cyclescheme.id').Value := pid;
    Params.ParamByName('cycleschemessteward.createby').Value := createby;
    Params.ParamByName('cycleschemessteward.createtime').Value := createtime;
    try
      Execute;
      nResult := Params.ParamByName('flag').Value;
      sResult := Params.ParamByName('msg').Value;
      if (nResult <= 0) then
      begin
        SysDialogs.Warning(sResult);
        NovaHelpSteward.SetFocus;
      end
      else
      begin
        if id>0 then
          types:='修改'
        else
          types:='添加';
        log :=log +'循环组名称='+NovaEdtName.Text+',循环开始日期='+
        FormatDateTime('yyyy-mm-dd',DateTpFromDate.Date)+',循环开始日期='+
        FormatDateTime('yyyy-mm-dd',DateTpEndDate.Date);

        if not(stewardname='' )then
        begin
          if not (stewardname=NovaHelpSteward.Text) then
            log :=log+'计划乘务员 由 '+stewardname+' 改成 '+NovaHelpSteward.Text;
        end
        else
        log:=log+',添加计划乘务员:'+ NovaHelpSteward.Text;
        
        SysLog.WriteLog('班次循环:循环乘务员',types,log);
        SysDialogs.ShowMessage(sResult);
        ModalResult := mrok;
      end;
    except
      on E: Exception do
      begin
        SysLog.WriteErr('乘务员循环信息增加失败：' + E.Message);
      end;
    end;
  end;
end;

end.
