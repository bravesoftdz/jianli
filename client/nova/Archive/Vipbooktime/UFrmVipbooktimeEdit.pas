unit UFrmVipbooktimeEdit;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, USimpleEditForm, DB, DBClient, jsonClientDataSet, StdCtrls, NovaEdit,
  Buttons, ExtCtrls, ImgList, NovaComboBox, NovaHComboBox, NovaHelp;

type
  TFrmVipbooktimeEdit = class(TSimpleEditForm)
    lblname: TLabel;
    nvedtTime: TNovaEdit;
    jcdsVipbooktimeSave: TjsonClientDataSet;
    Label6: TLabel;
    Label7: TLabel;
    NovaCbbOrg: TNovaHComboBox;
    lblcode: TLabel;
    lbl3: TLabel;
    nvcbbVipgrade: TNovaComboBox;
    Label1: TLabel;
    Label2: TLabel;
    nvtype: TNovaHelp;
    procedure bbtnSaveClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    id,orgid:Integer;
    createtime:string;
    createby:string;
    updatetime:string;
    updateby:string;
  end;

var
  FrmVipbooktimeEdit: TFrmVipbooktimeEdit;

implementation

uses Services, PubFn,UDMPublic;
{$R *.dfm}

procedure TFrmVipbooktimeEdit.bbtnSaveClick(Sender: TObject);
var
  nResult: integer;
  sResult: string;
begin
  if NovaCbbOrg.ItemIndex<0 then
  begin
    SysDialogs.ShowMessage('��ѡ������������');
    NovaCbbOrg.SetFocus;
    exit;
  end;
  if (self.edittype=Tedittype.add) and (trim(nvcbbVipgrade.Text) ='') then
  begin
      SysDialogs.Warning('��ѡ���Ա�ȼ�!');
      nvcbbVipgrade.SetFocus;
      exit;
  end;
  if trim(nvedtTime.Text)='' then
  begin
      SysDialogs.Warning('����д������!');
      nvedtTime.SetFocus;
      exit;
  end;

  with jcdsVipbooktimeSave do
  begin
    Close;
    if id>0 then
        Params.ParamValues['vipbooktime.orgid']:=orgid
    else
        Params.ParamValues['vipbooktime.orgid']:=NovaCbbOrg.HelpFieldValue['id'];

    Params.ParamValues['vipbooktime.booktime']:= nvedtTime.Text;
    if self.edittype=Tedittype.update then
    begin
      Params.ParamValues['vipbooktime.id']:=id;
      Params.ParamByName('vipbooktime.createby').Value := createby;
      Params.ParamByName('vipbooktime.createtime').Value := createtime;
      Params.ParamValues['vipbooktime.vipgrade']:= nvtype.Text;
    end
    else
    begin
      Params.ParamValues['vipbooktime.vipgrade']:= nvcbbVipgrade.Text;
      Params.ParamByName('vipbooktime.updateby').Value := createby;
      Params.ParamByName('vipbooktime.updatetime').Value := updatetime;
    end;
    try
      Execute;
      nResult := Params.ParamByName('flag').Value;
      sResult := Params.ParamByName('msg').Value;
      SysDialogs.ShowMessage(sResult);
      if (nResult <> 1) then
      begin
        nvcbbVipgrade.SetFocus;
      end
      else
      begin
        id := Params.ParamByName('id').Value;
        ModalResult := mrok;
      end;
    except
      on E: Exception do
      begin
        SysLog.WriteErr('��Ա��Ʊʱ������ʧ�ܣ�' + E.Message);
      end;
    end;
  end;
end;

procedure TFrmVipbooktimeEdit.FormCreate(Sender: TObject);
begin
  inherited;
   nvcbbVipgrade.Active := false;
    nvcbbVipgrade.Active := true;

  with NovaCbbOrg do
  begin
    Active := False;
    Params.ParamValues['filter_INS_t!id'] :=SysInfo.LoginUserInfo.OrgIDs;
    Params.ParamValues['filter_INS_t!type'] :='(1,2)'; //��վ����͵�
    Active := True;
    if Items.Count>0 then
    begin
      ItemIndex:=0;
    end;
  end;
end;

end.
