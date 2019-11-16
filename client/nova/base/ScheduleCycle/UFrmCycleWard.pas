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
    SysDialogs.Warning('���������Ա��');
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
          types:='�޸�'
        else
          types:='���';
        log :=log +'ѭ��������='+NovaEdtName.Text+',ѭ����ʼ����='+
        FormatDateTime('yyyy-mm-dd',DateTpFromDate.Date)+',ѭ����ʼ����='+
        FormatDateTime('yyyy-mm-dd',DateTpEndDate.Date);

        if not(stewardname='' )then
        begin
          if not (stewardname=NovaHelpSteward.Text) then
            log :=log+'�ƻ�����Ա �� '+stewardname+' �ĳ� '+NovaHelpSteward.Text;
        end
        else
        log:=log+',��Ӽƻ�����Ա:'+ NovaHelpSteward.Text;
        
        SysLog.WriteLog('���ѭ��:ѭ������Ա',types,log);
        SysDialogs.ShowMessage(sResult);
        ModalResult := mrok;
      end;
    except
      on E: Exception do
      begin
        SysLog.WriteErr('����Աѭ����Ϣ����ʧ�ܣ�' + E.Message);
      end;
    end;
  end;
end;

end.
