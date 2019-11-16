unit UFrmAboutRouteStop;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, USimpleEditForm, StdCtrls, Buttons, ExtCtrls, DB, DBClient,
  jsonClientDataSet, NovaHComboBox, NovaHelp, NovaEdit, ImgList;

type
  TFrmAboutRouteStop = class(TSimpleEditForm)
    Label3: TLabel;
    Label1: TLabel;
    Label2: TLabel;
    NovaEdtName: TNovaEdit;
    NovaEdtValue: TNovaEdit;
    NovaHelpRoute: TNovaHelp;
    NovaHCbbRouteStop: TNovaHComboBox;
    Label4: TLabel;
    jcdsSaveAboutRoute: TjsonClientDataSet;
    procedure bbtnSaveClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure NovaHelpRouteIdChange(Sender: TObject);
  private
    { Private declarations }
    log : String;
  public
    { Public declarations }
    relatetype,createtime,stationname, item: String;
    ticketpriceformulaitemid, createby,id: integer;
  end;

var
  FrmAboutRouteStop: TFrmAboutRouteStop;

implementation
uses PubFn, Services, UDMPublic;
{$R *.dfm}

procedure TFrmAboutRouteStop.bbtnSaveClick(Sender: TObject);
var
  msg: String;
  nResult: integer;
  sResult,result: string;
begin
  if NovaHelpRoute.id < 0 then
  begin
    NovaHelpRoute.SetFocus;
    SysDialogs.Warning('��ѡ�������·��');
    exit;
  end;

  if NovaHCbbRouteStop.ItemIndex<0 then
  begin
    NovaHCbbRouteStop.SetFocus;
    SysDialogs.Warning('��ѡ��ͣ���㣡');
    exit;
  end;
  if trim(NovaEdtValue.Text) = '' then
  begin
    NovaEdtValue.SetFocus;
    SysDialogs.Warning('���������ֵ��');
    exit;
  end;

  with jcdsSaveAboutRoute do
  begin
    close;
    Params.ParamByName('formulaitemroutestop.id').Value :=id;
    Params.ParamByName('formulaitemroutestop.routeid').Value := NovaHelpRoute.id;
    Params.ParamByName('formulaitemroutestop.stationid').Value := NovaHCbbRouteStop.HelpFieldValue['id'];
    Params.ParamByName('formulaitemroutestop.value').Value := trim(NovaEdtValue.text);
    Params.ParamByName('formulaitemroutestop.ticketpriceformulaitem.id').Value := ticketpriceformulaitemid;
    Params.ParamByName('formulaitemroutestop.createby').Value := createby;
    Params.ParamByName('formulaitemroutestop.createtime').Value := createtime;
    try
      Execute;
      nResult := Params.ParamByName('flag').Value;
      sResult := Params.ParamByName('msg').Value;
      SysDialogs.ShowMessage(sResult);
      if (nResult <= 0) then
      begin
        NovaHelpRoute.SetFocus;
      end
      else
      begin
        if id > 0 then
          result := '�޸�'
        else
          result := '���';
        log := result + 'Ʊ�۹�ʽ�������ϸ����Ŀ����='+NovaEdtName.Text+',��·����='+
        NovaHelpRoute.Text+',ͣ����='+NovaHCbbRouteStop.Text+
        ',����ֵ='+NovaEdtValue.Text;
        SysLog.WriteLog('Ʊ�۹�����>Ʊ�۹�ʽ�����',result,log);
        ModalResult := mrok;
      end;
    except
      on E: Exception do
      begin
        SysLog.WriteErr('Ʊ�۹�ʽ���������ʧ�ܣ�' + E.Message);
      end;
    end;
  end;

end;

procedure TFrmAboutRouteStop.FormShow(Sender: TObject);
begin
  inherited;
  if edittype=Tedittype.update then
  begin
     NovaHelpRouteIdChange(sender);
  end;
end;

procedure TFrmAboutRouteStop.NovaHelpRouteIdChange(Sender: TObject);
begin
  inherited;
  if (NovaHelpRoute.Id>0)then
  begin
     NovaHCbbRouteStop.Active:=false;
     NovaHCbbRouteStop.Params.ParamValues['helpType']:='RouteStopHelp';
     NovaHCbbRouteStop.Params.ParamValues['param']:=NovaHelpRoute.Id;
     NovaHCbbRouteStop.Active:=true;
     NovaHCbbRouteStop.ItemIndex:=NovaHCbbRouteStop.Items.IndexOf(stationname);
  end;
end;

end.
