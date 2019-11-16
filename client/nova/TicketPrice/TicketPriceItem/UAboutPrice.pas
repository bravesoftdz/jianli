unit UAboutPrice;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, USimpleEditForm, StdCtrls, Buttons, ExtCtrls, NovaEdit, DB, DBClient,
  jsonClientDataSet, ImgList;

type
  TFrmAboutPrice = class(TSimpleEditForm)
    Label3: TLabel;
    Label2: TLabel;
    Label1: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    NovaEdtName: TNovaEdit;
    NovaEdtValue: TNovaEdit;
    NovaEdtEndPrice: TNovaEdit;
    NovaEdtFromPrice: TNovaEdit;
    jcdsSaveAboutPrice: TjsonClientDataSet;
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
  FrmAboutPrice: TFrmAboutPrice;

implementation
uses PubFn, Services, UDMPublic;
{$R *.dfm}

procedure TFrmAboutPrice.bbtnSaveClick(Sender: TObject);
var
  msg: String;
  nResult: integer;
  sResult, result: string;
begin
  if trim(NovaEdtFromPrice.text) = '' then
  begin
    NovaEdtFromPrice.SetFocus;
    SysDialogs.Warning('�����뿪ʼ��̣�');
    exit;
  end;
  if trim(NovaEdtEndPrice.text) = '' then
  begin
    NovaEdtEndPrice.SetFocus;
    SysDialogs.Warning('�����������̣�');
    exit;
  end;
  if trim(NovaEdtValue.Text) = '' then
  begin
    NovaEdtValue.SetFocus;
    SysDialogs.Warning('���������ֵ��');
    exit;
  end;

  with jcdsSaveAboutPrice do
  begin
    close;
    Params.ParamByName('formulaitemprice.id').Value :=id;
    Params.ParamByName('formulaitemprice.fromprice').Value := trim(NovaEdtFromPrice.text);
    Params.ParamByName('formulaitemprice.endprice').Value := trim(NovaEdtEndPrice.text);
    Params.ParamByName('formulaitemprice.value').Value := trim(NovaEdtValue.text);
    Params.ParamByName('formulaitemprice.ticketpriceformulaitem.id').Value := ticketpriceformulaitemid;
    Params.ParamByName('formulaitemprice.createby').Value := createby;
    Params.ParamByName('formulaitemprice.createtime').Value := createtime;
    try
      Execute;
      nResult := Params.ParamByName('flag').Value;
      sResult := Params.ParamByName('msg').Value;
      SysDialogs.ShowMessage(sResult);
      if (nResult <= 0) then
      begin
        NovaEdtValue.SetFocus;
      end
      else
      begin
        if id > 0 then
          result := '�޸�'
        else
          result := '���';
        log := result + 'Ʊ�۹�ʽ�������ϸ����Ŀ����='+NovaEdtName.Text+',����Ʊ��='+
        NovaEdtFromPrice.Text+',����Ʊ��='+NovaEdtEndPrice.Text+',����ֵ='+NovaEdtValue.Text;
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

end.
