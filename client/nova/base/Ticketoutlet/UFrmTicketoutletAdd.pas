unit UFrmTicketoutletAdd;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs,USimpleEditForm,Services, StdCtrls, ExtCtrls, DB, DBClient,
  jsonClientDataSet, Buttons,NovaEdit, NovaComboBox, NovaHComboBox, NovaHelp,
  ImgList;

type
  TFrmTicketoutletAdd =  class(TSimpleEditForm)
    lbl1: TLabel;
    edtname: TNovaEdit;
    jsonCDSTicketoutletSave: TjsonClientDataSet;
    lbl6: TLabel;
    lbl12: TLabel;
    lbl7: TLabel;
    cbbtype: TNovaComboBox;
    lbl8: TLabel;
    lbl3: TLabel;
    lbl10: TLabel;
    lbl14: TLabel;
    cbbdistrictid: TNovaHelp;
    cbbgrade: TNovaComboBox;
    lbl2: TLabel;
    lbl5: TLabel;
    lbl4: TLabel;
    lbl9: TLabel;
    lbl11: TLabel;
    lbl13: TLabel;
    lbl15: TLabel;
    cbbOrgid: TNovaHComboBox;
    edtjianpin: TNovaEdit;
    edtperson: TNovaEdit;
    edtphone: TNovaEdit;
    mmoaddress: TMemo;
    Label1: TLabel;
    Chkisprint: TCheckBox;
    cbbstartstation: TNovaHComboBox;
    Label2: TLabel;
    Label3: TLabel;
    procedure bbtnSaveClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure cbbOrgidEnter(Sender: TObject);
   private
    log : String;
    { Private declarations }
  public
   id : Int64;
   createby,createtime,code,district,orgid:String;
  isactive:Boolean;
  public
    { Public declarations }
  end;

var
  FrmTicketoutletAdd: TFrmTicketoutletAdd;

implementation
     uses PubFn;
{$R *.dfm}

procedure TFrmTicketoutletAdd.bbtnSaveClick(Sender: TObject);
var nResult: integer;
    sResult:string;
begin
  inherited;
  if edtname.Text='' then
  begin
    SysDialogs.ShowMessage('��Ʊ�����Ʋ���Ϊ��');
    edtname.SetFocus;
     exit;
  end;
  if cbbtype.ItemIndex<0 then
  begin
    SysDialogs.ShowMessage('��ѡ�����');
    cbbtype.SetFocus;
    exit;
  end; if Trim(cbbdistrictid.Text) = '' then
  begin
    SysDialogs.ShowMessage('����д��������');
    cbbdistrictid.SetFocus;
    exit;
  end;
  if cbbgrade.ItemIndex < 0 then
  begin
    SysDialogs.ShowMessage('��ѡ�񼶱�');
    cbbgrade.SetFocus;
    exit;
  end;
  if Trim(cbbOrgid.Text) = '' then
  begin
    SysDialogs.ShowMessage('��ѡ��������վ');
    cbbOrgid.SetFocus;
    exit;
  end;
  if Trim(cbbstartstation.Text) = '' then
  begin
    SysDialogs.ShowMessage('��ѡ���Ӧ����վ��');
    cbbOrgid.SetFocus;
    exit;
  end;
  if edtperson.Text='' then
  begin
    SysDialogs.ShowMessage('��ϵ����������Ϊ��');
    edtperson.SetFocus;
     exit;
  end;
  if mmoaddress.Text='' then
  begin
    SysDialogs.ShowMessage('��Ʊ���ַ����Ϊ��');
    mmoaddress.SetFocus;
     exit;
  end;

  with jsonCDSTicketoutletSave do
  begin
    Close;
    if cbbdistrictid.Id > 0 then
    begin
      district := IntToStr(cbbdistrictid.Id);
    end;
    if cbbOrgid.ItemIndex >= 0 then
    begin
      orgid := cbbOrgid.HelpFieldValue['id'];
    end;
    Params.ParamByName('ticketoutlet.name').Value :=edtname.Text ;
    Params.ParamByName('ticketoutlet.address').Value :=mmoaddress.Text ;
    Params.ParamByName('ticketoutlet.contactphone').Value :=edtphone.Text ;
    Params.ParamByName('ticketoutlet.contactperson').Value :=edtperson.Text ;
    Params.ParamByName('ticketoutlet.grade').Value :=cbbgrade.GetSelectCode;
    Params.ParamByName('ticketoutlet.districtid').Value:=district;
    params.ParamByName('ticketoutlet.jianpin').Value := edtjianpin.Text;
    if id = 0 then
    begin
      Params.ParamByName('ticketoutlet.id').Value := -1 ;
      Params.ParamByName('ticketoutlet.code').Value := cbbOrgid.HelpFieldValue['code'];
    end
    else
    begin
      Params.ParamByName('ticketoutlet.id').Value := id;
      Params.ParamByName('ticketoutlet.code').Value := code;
    end;

    Params.ParamByName('ticketoutlet.type').Value:=cbbtype.GetSelectCode;
    Params.ParamByName('ticketoutlet.startstation.id').Value:=cbbstartstation.HelpFieldValue['id'];
    Params.ParamByName('ticketoutlet.orgid').Value:=orgid;
    Params.ParamByName('ticketoutlet.isprint').Value:=Chkisprint.Checked;
    Params.ParamByName('ticketoutlet.createby').Value :=  createby;
    Params.ParamByName('ticketoutlet.isactive').Value :=  isactive;
    Params.ParamByName('ticketoutlet.createtime').Value :=  createtime;
    try
      Execute;
      nResult := Params.ParamByName('flag').Value;
      sResult := Params.ParamByName('msg').Value;
      SysDialogs.ShowMessage(sResult);
      if (nResult <= 0) then
      begin
        edtname.SetFocus;
      end
      else
      begin
        if id > 0 then
        begin
          log := '�޸���Ʊ�㣺����=' + edtname.Text + ',����=' + cbbtype.Text +',��������='
          + cbbdistrictid.Text + ',����=' + cbbgrade.Text +',������վ=' + cbbOrgid.Text+
          ',��ƴ='+edtjianpin.Text +',��ϵ��='+edtperson.Text +',��ϵ�绰='+edtphone.Text
          + ',��ַ='+mmoaddress.Text;
          SysLog.WriteLog('Ʊ�����͡���>��Ʊ��','�޸�',log);
        end else
        begin
          log := '�����Ʊ�㣺����=' + edtname.Text + ',����=' + cbbtype.Text +',��������='
          + cbbdistrictid.Text + ',����=' + cbbgrade.Text +',������վ=' + cbbOrgid.Text+
          ',��ƴ='+edtjianpin.Text +',��ϵ��='+edtperson.Text +',��ϵ�绰='+edtphone.Text
          + ',��ַ='+mmoaddress.Text;
          SysLog.WriteLog('ҵ�������>��Ʊ�����','���',log);
        end;
        id := Params.ParamByName('id').Value;
        ModalResult := mrok;
      end;
    except
       on E: Exception do
      begin
        SysLog.WriteErr('��Ʊ������ʧ�ܣ�' + E.Message);
      end;
    end;
  end;

end;
procedure TFrmTicketoutletAdd.cbbOrgidEnter(Sender: TObject);
begin
  inherited;
  with cbbOrgid do
  begin
    Params.ParamValues['filter_EQL_t!id'] := SysInfo.LoginUserInfo.OrgID;
  end;
end;

procedure TFrmTicketoutletAdd.FormCreate(Sender: TObject);
begin
  inherited;
  cbbtype.Active:=False;
  cbbtype.Active:=True;

  cbbgrade.Active:=False;
  cbbgrade.Active:=True;

  cbbOrgid.Active := false;
  cbbOrgid.Active := true;

  cbbstartstation.Active := false;
  cbbstartstation.Active := true;

  isactive:=True;
end;

end.
