unit UFrmAboutVehcile;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, USimpleEditForm, StdCtrls, Buttons, ExtCtrls, NovaHComboBox, DB,
  DBClient, jsonClientDataSet, NovaEdit, ImgList;

type
  TFrmAboutVehcile = class(TSimpleEditForm)
    Label1: TLabel;
    NovaHcbbVehcile: TNovaHComboBox;
    NovaEdtValue: TNovaEdit;
    Label2: TLabel;
    Label3: TLabel;
    NovaEdtName: TNovaEdit;
    jcdsSaveItemAboutVchile: TjsonClientDataSet;
    lbl1: TLabel;
    lbl2: TLabel;
    lbl3: TLabel;
    procedure FormShow(Sender: TObject);
    procedure bbtnSaveClick(Sender: TObject);
  private
    { Private declarations }
    log : String;
  public
    { Public declarations }
    relatetype:String;
    createtime,vchcilename: string;
    id,ticketpriceformulaitemid,createby:integer;
  end;

var
  FrmAboutVehcile: TFrmAboutVehcile;

implementation
uses PubFn, Services, UDMPublic;
{$R *.dfm}

procedure TFrmAboutVehcile.bbtnSaveClick(Sender: TObject);
var
  nResult: integer;
  sResult,result: string;
begin
  inherited;
  if NovaHcbbVehcile.ItemIndex<0 then
  begin
    NovaHcbbVehcile.SetFocus;
    SysDialogs.Warning('��ѡ���ͣ�');
    exit;
  end;
  if trim(NovaEdtValue.Text) = '' then
  begin
    NovaEdtValue.SetFocus;
    SysDialogs.Warning('���������ֵ��');
    exit;
  end;

  with jcdsSaveItemAboutVchile do
  begin
    close;
    Params.ParamByName('formulaitemvehcile.id').Value := id;
    Params.ParamByName('formulaitemvehcile.ticketpriceformulaitem.id').Value := ticketpriceformulaitemid;
    Params.ParamByName('formulaitemvehcile.value').Value := strtofloat(NovaEdtValue.Text);
    Params.ParamByName('formulaitemvehcile.vehciletypeid').Value :=  NovaHcbbVehcile.HelpFieldValue['id'];
    Params.ParamByName('formulaitemvehcile.createby').Value := createby;
    if createtime<>'' then
       Params.ParamByName('formulaitemvehcile.createtime').Value := createtime;
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
        log := result + 'Ʊ�۹�ʽ�������ϸ����Ŀ����='+NovaEdtName.Text+',����='+
        NovaHcbbVehcile.Text+',����ֵ='+NovaEdtValue.Text;
        SysLog.WriteLog('Ʊ�۹�����>Ʊ�۹�ʽ�����',result,log);
        SysDialogs.ShowMessage(sResult);
        ModalResult := mrok;
      end;
    except
      on E: Exception do
      begin
        SysLog.WriteErr('�������Ʊ�۹�ʽ�������Ϣ����ʧ�ܣ�' + E.Message);
      end;
    end;
  end;

end;

procedure TFrmAboutVehcile.FormShow(Sender: TObject);
begin
  inherited;
  NovaHcbbVehcile.Active:=false;
  NovaHcbbVehcile.Active:=true;
  if self.edittype=Tedittype.update then
  begin
   NovaHcbbVehcile.ItemIndex:=NovaHcbbVehcile.Items.IndexOf(vchcilename);
  end;
end;

end.
