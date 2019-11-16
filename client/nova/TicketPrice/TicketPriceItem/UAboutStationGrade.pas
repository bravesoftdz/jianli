unit UAboutStationGrade;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, USimpleEditForm, StdCtrls, Buttons, ExtCtrls, NovaEdit, NovaHComboBox,
  NovaComboBox, DB, DBClient, jsonClientDataSet, ImgList;

type
  TFrmAboutStationGrade = class(TSimpleEditForm)
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    NovaEdtValue: TNovaEdit;
    NovaEdtName: TNovaEdit;
    NovacbbStationGrade: TNovaComboBox;
    jcdsSaveItemAboutStationGrade: TjsonClientDataSet;
    procedure FormShow(Sender: TObject);
    procedure bbtnSaveClick(Sender: TObject);
  private
    { Private declarations }
    log : String;
  public
    { Public declarations }
    relatetype:String;
    createtime,stationgradename: string;
    id,ticketpriceformulaitemid,createby:integer;
  end;

var
  FrmAboutStationGrade: TFrmAboutStationGrade;

implementation
uses PubFn, Services, UDMPublic;
{$R *.dfm}

procedure TFrmAboutStationGrade.bbtnSaveClick(Sender: TObject);
var
  nResult: integer;
  sResult,result: string;
begin
  inherited;
  if NovacbbStationGrade.ItemIndex<0 then
  begin
    NovacbbStationGrade.SetFocus;
    SysDialogs.Warning('��ѡ�����վ�ȼ���');
    exit;
  end;
  if trim(NovaEdtValue.Text) = '' then
  begin
    NovaEdtValue.SetFocus;
    SysDialogs.Warning('���������ֵ��');
    exit;
  end;

  with jcdsSaveItemAboutStationGrade do
  begin
    close;
    Params.ParamByName('formulaitemorggrade.id').Value := id;
    Params.ParamByName('formulaitemorggrade.ticketpriceformulaitem.id').Value := ticketpriceformulaitemid;
    Params.ParamByName('formulaitemorggrade.value').Value := strtofloat(NovaEdtValue.Text);
    Params.ParamByName('formulaitemorggrade.stationgrade').Value :=  NovacbbStationGrade.GetSelectCode;
    Params.ParamByName('formulaitemorggrade.createby').Value := createby;
    Params.ParamByName('formulaitemorggrade.createtime').Value := createtime;
    try
      Execute;
      nResult := Params.ParamByName('flag').Value;
      sResult := Params.ParamByName('msg').Value;
      if (nResult <= 0) then
      begin
        SysDialogs.Warning(sResult);
        NovaEdtValue.SetFocus;
      end
      else
      begin
        if id > 0 then
          result := '�޸�'
        else
          result := '���';
        log := result + 'Ʊ�۹�ʽ�������ϸ����Ŀ����='+NovaEdtName.Text+',����վ�ȼ�='+
        NovacbbStationGrade.Text+',����ֵ='+NovaEdtValue.Text;
        SysLog.WriteLog('Ʊ�۹�����>Ʊ�۹�ʽ�����',result,log);
        SysDialogs.ShowMessage(sResult);
        ModalResult := mrok;
      end;
    except
      on E: Exception do
      begin
        SysLog.WriteErr('����վ�ȼ����Ʊ�۹�ʽ�������Ϣ����ʧ�ܣ�' + E.Message);
      end;
    end;
  end;


end;

procedure TFrmAboutStationGrade.FormShow(Sender: TObject);
begin
  inherited;
  NovacbbStationGrade.Active:=false;
  NovacbbStationGrade.Active:=true;
  if edittype=Tedittype.update then
  begin
    NovacbbStationGrade.ItemIndex:=NovacbbStationGrade.Items.IndexOf(stationgradename);
  end;

end;

end.
