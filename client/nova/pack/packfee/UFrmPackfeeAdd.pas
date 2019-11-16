unit UFrmPackfeeAdd;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, USimpleEditForm, StdCtrls, Buttons, ExtCtrls, NovaEdit, NovaHelp,
  NovaComboBox, DB, DBClient, jsonClientDataSet, UDMPublic, Services,
  NovaHComboBox, ImgList, NovaCheckedComboBox;

type
  TFrmPackfeeAdd = class(TSimpleEditForm)
    nvedtfeekg: TNovaEdit;
    lblname: TLabel;
    lbldistricttype: TLabel;
    lblendstation: TLabel;
    lblstartstation: TLabel;
    lbltype: TLabel;
    lblgrade: TLabel;
    jcdspackfeesave: TjsonClientDataSet;
    lbl1: TLabel;
    lbl2: TLabel;
    lbl3: TLabel;
    lbl4: TLabel;
    lbl5: TLabel;
    lbl6: TLabel;
    Label5: TLabel;
    Label3: TLabel;
    NovaCbbOrg: TNovaHComboBox;
    nvedtfromdistance: TNovaEdit;
    nvedttodistance: TNovaEdit;
    nvedtfromweight: TNovaEdit;
    nvedttoweight: TNovaEdit;
    nvedtfee: TNovaEdit;
    Label2: TLabel;
    Label4: TLabel;
    NovaHelpPricetype: TNovaHComboBox;
    Label1: TLabel;
    Label6: TLabel;
    procedure bbtnSaveClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
    Foperationid: Integer;
    log : String;
  public
    { Public declarations }
    packfeeid: Integer;
    createby:Integer;
    createtime:TDateTime;
    property operationid: Integer read Foperationid;
  end;

var
  FrmPackfeeAdd: TFrmPackfeeAdd;

implementation

{$R *.dfm}

procedure TFrmPackfeeAdd.bbtnSaveClick(Sender: TObject);
var
  nvhelpstartstationid: Integer;
  nvhelpendstationid: Integer;
  result : string;
begin
  inherited;
  if NovaCbbOrg.ItemIndex < 0 then
  begin
    SysDialogs.ShowMessage('��ѡ������������');
    NovaCbbOrg.SetFocus;
    exit;
  end;
  if Trim(nvedtfromdistance.Text) = '' then
  begin
    SysDialogs.ShowMessage('��ʼ��̲���Ϊ��!');
    nvedtfromdistance.SetFocus;
    exit;
  end;
  if (Trim(nvedttodistance.Text) = '') then
  begin
    SysDialogs.ShowMessage('��ֹ��̲���Ϊ��!');
    nvedttodistance.SetFocus;
    exit;
  end;

  if (StrToInt(Trim(nvedttodistance.Text)) <= StrToInt
      (Trim(nvedtfromdistance.Text))) then
  begin
    SysDialogs.ShowMessage('��ֹ��̲���С�ڵ�����ʼ���!');
    nvedttodistance.SetFocus;
    exit;
  end;

  if Trim(nvedtfromweight.Text) = '' then
  begin
    SysDialogs.ShowMessage('��ʼ��������Ϊ��!');
    nvedtfromweight.SetFocus;
    exit;
  end;

  {if StrToInt(Trim(nvedtfromweight.Text))>=10000  then
  begin
    SysDialogs.ShowMessage('��ʼ����ֵ������Χ(0~9999.99)!');
    nvedtfromweight.SetFocus;
    exit;
  end;}

  if (Trim(nvedttoweight.Text) = '') then
  begin
    SysDialogs.ShowMessage('��ֹ��������Ϊ��!');
    nvedttoweight.SetFocus;
    exit;
 end;

 {if StrToInt(Trim(nvedttoweight.Text))>=10000  then
  begin
    SysDialogs.ShowMessage('��ֹ����ֵ������Χ(0~9999.99)!');
    nvedttoweight.SetFocus;
    exit;
  end;}

  if (StrToFloat(Trim(nvedttoweight.Text)) <= StrToFloat
      (Trim(nvedtfromweight.Text))) then
  begin
    SysDialogs.ShowMessage('��ֹ��������С�ڵ�����ʼ����!');
    nvedttoweight.SetFocus;
    exit;
  end;

  if (Trim(nvedtfee.Text)='') then
  begin
    SysDialogs.ShowMessage('��ͼ۲���Ϊ��!');
    nvedtfee.SetFocus;
    exit;
  end;

  if StrToFloat(Trim(nvedtfee.Text))>=10000  then
  begin
    SysDialogs.ShowMessage('��ͼ�ֵ������Χ(0~9999.99)!');
    nvedtfee.SetFocus;
    exit;
  end;

  if (Trim(nvedtfeekg.Text)='') then
  begin
    SysDialogs.ShowMessage('����ÿǧ�˵��۲���Ϊ��!');
    nvedtfeekg.SetFocus;
    exit;
  end;

  if StrToFloat(Trim(nvedtfeekg.Text))>=10000  then
  begin
    SysDialogs.ShowMessage('����ÿǧ�˵���ֵ������Χ(0~9999.99)!');
    nvedtfeekg.SetFocus;
    exit;
  end;

  with jcdspackfeesave do
  begin
    Params.ParamValues['packfee.packfeetypeid'] := NovaHelpPricetype.HelpFieldValue['id'];
    Params.ParamValues['packfee.orgid'] := NovaCbbOrg.HelpFieldValue['id'];
    if self.edittype = Tedittype.update then
    begin
    Params.ParamValues['packfee.id'] := IntToStr(packfeeid);
    Params.ParamValues['packfee.createby']:= IntToStr(createby);
    Params.ParamValues['packfee.createtime']:= FormatDateTime('yyyy-mm-dd', createtime);
    end ;

    Params.ParamValues['packfee.fromdistance'] := Trim(nvedtfromdistance.Text);
    Params.ParamValues['packfee.todistance']:= Trim(nvedttodistance.Text);
    Params.ParamValues['packfee.fromweight']:= Trim(nvedtfromweight.Text);
    Params.ParamValues['packfee.toweight']:= Trim(nvedttoweight.Text);
    Params.ParamValues['packfee.fee']:= Trim(nvedtfee.Text);
    Params.ParamValues['packfee.feekg']:= Trim(nvedtfeekg.Text);
    bbtnSave.Enabled :=false;
    Execute;
    bbtnSave.Enabled :=true;
    if Params.ParamValues['msg'] <> '' then
    begin
      SysDialogs.ShowMessage(Params.ParamValues['msg']);
    end;
    if Params.ParamValues['flag'] = 1 then
    begin
      bbtnSave.Enabled :=false;
      if packfeeid > 0 then
        result := '�޸�'
      else
        result := '���';
      log := result +Params.ParamValues['packfeeid']+ '�а��շѱ�׼����������='+NovaCbbOrg.HelpFieldValue['name']+',��ʼ���='+
      nvedtfromdistance.Text+',��ֹ���='+nvedttodistance.Text+',��ʼ����='+nvedtfromweight.Text+
      ',��ֹ����='+nvedttoweight.Text+',ÿ����ͼ�='+nvedtfee.Text+',��ÿǧ�˵���='+nvedtfeekg.Text;
      SysLog.WriteLog('�а�����->�շѱ�׼����',result,log);
      self.ModalResult := mrOk;
    end;
    Foperationid := Params.ParamValues['packfeeid'];
  end;
end;

procedure TFrmPackfeeAdd.FormCreate(Sender: TObject);
begin
  inherited;
  with NovaCbbOrg do
  begin
    Active := False;
    Params.ParamValues['filter_INS_t!id'] := SysInfo.LoginUserInfo.OrgIDs;
    Params.ParamValues['filter_INS_t!type'] := '(1,2)'; // ��վ����͵�
    Active := True;
    if Items.Count > 0 then
    begin
      ItemIndex := 0;
    end;
  end;
  //NovaHelpPricetype
  with NovaHelpPricetype do
  begin
    Active := False;
    Active := True;
    if Items.Count > 0 then
    begin
      ItemIndex := 0;
    end;
  end;
end;

procedure TFrmPackfeeAdd.FormShow(Sender: TObject);
begin
  inherited;
  if self.edittype = Tedittype.update then
    NovaCbbOrg.SetFocus
  else
    // nvhelpstartstation.SetFocus;
    NovaCbbOrg.SetFocus;
end;

end.
