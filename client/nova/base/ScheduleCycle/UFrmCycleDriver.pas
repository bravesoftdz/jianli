unit UFrmCycleDriver;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, USimpleEditForm, StdCtrls, Buttons, ExtCtrls, NovaHelp, ComCtrls,
  NovaEdit, DB, DBClient, jsonClientDataSet, ImgList;

type
  TFrmCycleDriver = class(TSimpleEditForm)
    Label1: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    NovaEdtName: TNovaEdit;
    DateTpFromDate: TDateTimePicker;
    DateTpEndDate: TDateTimePicker;
    Label2: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    jcdsSaveDriver: TjsonClientDataSet;
    NovaHelpDriver: TNovaHelp;
    procedure bbtnSaveClick(Sender: TObject);
  private
    log : String;
    { Private declarations }
  public
    { Public declarations }
    id, createby,pid,orderno: integer;
    createtime,drivername:string;
  end;

var
  FrmCycleDriver: TFrmCycleDriver;

implementation
uses PubFn,Services, UDMPublic;
{$R *.dfm}

procedure TFrmCycleDriver.bbtnSaveClick(Sender: TObject);
var
  msg,types: String;
  nResult: integer;
  sResult: string;
begin
  inherited;
  if (trim(NovaHelpDriver.Text)='') or (NovaHelpDriver.Id<=0) then
  begin
    SysDialogs.Warning('请输入驾驶员！');
    NovaHelpDriver.SetFocus;
    exit;
  end;

  with jcdsSaveDriver do
  begin
    close;
    Params.ParamByName('cycleschemesdriver.id').Value := id;
    Params.ParamByName('cycleschemesdriver.orderno').Value := orderno;

    Params.ParamByName('cycleschemesdriver.driver.id').Value := NovaHelpDriver.Id;
    Params.ParamByName('cycleschemesdriver.cyclescheme.id').Value := pid;
    Params.ParamByName('cycleschemesdriver.createby').Value := createby;
    Params.ParamByName('cycleschemesdriver.createtime').Value := createtime;
    try
      Execute;
      nResult := Params.ParamByName('flag').Value;
      sResult := Params.ParamByName('msg').Value;
      if (nResult <= 0) then
      begin
        SysDialogs.Warning(sResult);
        NovaHelpDriver.SetFocus;
      end
      else
      begin
        if  id>0 then
          types := '修改'
        else
          types := '添加';


        log := '循环组名称='+NovaEdtName.Text;
        //+',循环开始日期='+FormatDateTime('yyyy-mm-dd',DateTpFromDate.Date)
        //+',循环开始日期='+ FormatDateTime('yyyy-mm-dd',DateTpEndDate.Date)
        if not (drivername='') then
        begin
          if not (drivername=NovaHelpDriver.Text) then
            log := log +',计划驾驶员 由 '+drivername+'改成 '+NovaHelpDriver.Text
        end
        else
          log := log+' ，添加计划驾驶员：'+NovaHelpDriver.Text;

        SysLog.WriteLog('班次循环:循环驾驶员',types,log);
        SysDialogs.ShowMessage(sResult);
        ModalResult := mrok;
      end;
    except
      on E: Exception do
      begin
        SysLog.WriteErr('驾驶员循环信息增加失败：' + E.Message);
      end;
    end;
  end;

end;

end.
