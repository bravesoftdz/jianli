unit UFrmTicketReturnRateCfgEdit;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, USimpleEditForm, DB, DBClient, jsonClientDataSet, StdCtrls, NovaEdit,
  Buttons, ExtCtrls, ImgList, NovaComboBox, NovaHComboBox;

type
  TFrmTicketReturnRateCfgEdit = class(TSimpleEditForm)
    lblname: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    nvedtprerate: TNovaEdit;
    jcdsticketreturnrateSave: TjsonClientDataSet;
    Label6: TLabel;
    Label7: TLabel;
    NovaCbbOrg: TNovaHComboBox;
    lblcode: TLabel;
    cbbtimepoint: TComboBox;
    cbbtimetag: TComboBox;
    lbl3: TLabel;
    lbl4: TLabel;
    procedure bbtnSaveClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    id:Integer;
    createtime:string;
    createby:string;
    updatetime:string;
    updateby:string;
  end;

var
  FrmTicketReturnRateCfgEdit: TFrmTicketReturnRateCfgEdit;

implementation

uses Services, PubFn,UDMPublic;
{$R *.dfm}

procedure TFrmTicketReturnRateCfgEdit.bbtnSaveClick(Sender: TObject);
var
  nResult: integer;
  sResult: string;
begin
  if NovaCbbOrg.ItemIndex<0 then
  begin
    SysDialogs.ShowMessage('��ѡ��������������');
    NovaCbbOrg.SetFocus;
    exit;
  end;
  if(cbbtimetag.ItemIndex=-1) then
  begin
      SysDialogs.Warning('����дʱ���');
      cbbtimetag.SetFocus;
      exit;
  end;
  if(cbbtimepoint.ItemIndex=-1) then
  begin
      SysDialogs.Warning('����дʱ���');
      cbbtimepoint.SetFocus;
      exit;
  end;
   if(Strtoint(nvedtprerate.Text) >=100) then
  begin
      SysDialogs.Warning('���ʴ���100%�����壡');
      nvedtprerate.SetFocus;
    exit;
  end;
   if(Strtoint(nvedtprerate.Text) <=0) then
  begin
      SysDialogs.Warning('����С��0%�����壡');
      nvedtprerate.SetFocus;
    exit;
  end;
  {
  if cbbtimepoint.Enabled and (cbbtimepoint.ItemIndex=0) then
  begin
      SysDialogs.Warning('ʱ��㲻��Ϊ����ʱ��');
      cbbtimepoint.SetFocus;
      exit;
  end;}

  if (trim(nvedtprerate.Text)='') then
  begin
    SysDialogs.Warning('����д֮ǰ����');
    nvedtprerate.SetFocus;
    exit;
  end;
  with jcdsticketreturnrateSave do
  begin
    Close;
    Params.ParamValues['ticketreturnrate.orgid']:=NovaCbbOrg.HelpFieldValue['id'];
    if cbbtimetag.ItemIndex=0 then
      Params.ParamValues['ticketreturnrate.timepoint']:=cbbtimepoint.ItemIndex
    else
      Params.ParamValues['ticketreturnrate.timepoint']:=cbbtimepoint.ItemIndex*-1;
    Params.ParamByName('ticketreturnrate.prerate').Value := StrToFloat(nvedtprerate.Text)/100;
    if self.edittype=Tedittype.update then
    begin
      Params.ParamByName('ticketreturnrate.id').Value := id;
      Params.ParamByName('ticketreturnrate.createby').Value := createby;
      Params.ParamByName('ticketreturnrate.createtime').Value := createtime;
      Params.ParamByName('ticketreturnrate.updateby').Value := createby;
      Params.ParamByName('ticketreturnrate.updatetime').Value := updatetime;
    end;
    try
      Execute;
      nResult := Params.ParamByName('flag').Value;
      sResult := Params.ParamByName('msg').Value;
      SysDialogs.ShowMessage(sResult);
      if (nResult <> 1) then
      begin
        nvedtprerate.SetFocus;
      end
      else
      begin
        id := Params.ParamByName('id').Value;
        ModalResult := mrok;
      end;
    except
      on E: Exception do
      begin
        SysLog.WriteErr('��Ʊ�������ʧ�ܣ�' + E.Message);
      end;
    end;
  end;
end;

procedure TFrmTicketReturnRateCfgEdit.FormCreate(Sender: TObject);
begin
  inherited;
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

procedure TFrmTicketReturnRateCfgEdit.FormShow(Sender: TObject);
begin
  inherited;
  if self.edittype=Tedittype.update then
  begin
    if cbbtimepoint.Enabled then
      cbbtimetag.SetFocus
    else
      nvedtprerate.SetFocus;
  end
  else
    NovaCbbOrg.SetFocus;
end;

end.
