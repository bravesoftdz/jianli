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
    SysDialogs.Warning('�������ʻԱ��');
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
          types := '�޸�'
        else
          types := '���';


        log := 'ѭ��������='+NovaEdtName.Text;
        //+',ѭ����ʼ����='+FormatDateTime('yyyy-mm-dd',DateTpFromDate.Date)
        //+',ѭ����ʼ����='+ FormatDateTime('yyyy-mm-dd',DateTpEndDate.Date)
        if not (drivername='') then
        begin
          if not (drivername=NovaHelpDriver.Text) then
            log := log +',�ƻ���ʻԱ �� '+drivername+'�ĳ� '+NovaHelpDriver.Text
        end
        else
          log := log+' ����Ӽƻ���ʻԱ��'+NovaHelpDriver.Text;

        SysLog.WriteLog('���ѭ��:ѭ����ʻԱ',types,log);
        SysDialogs.ShowMessage(sResult);
        ModalResult := mrok;
      end;
    except
      on E: Exception do
      begin
        SysLog.WriteErr('��ʻԱѭ����Ϣ����ʧ�ܣ�' + E.Message);
      end;
    end;
  end;

end;

end.
