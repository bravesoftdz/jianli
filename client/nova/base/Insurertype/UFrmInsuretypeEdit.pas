unit UFrmInsuretypeEdit;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, USimpleEditForm, StdCtrls, Buttons, ExtCtrls, NovaEdit, DB, DBClient,
  jsonClientDataSet, NovaComboBox, NovaHComboBox, ImgList;

type
  TFrmInsuretypeEdit = class(TSimpleEditForm)
    lblorg: TLabel;
    lblinsurer: TLabel;
    lblcode: TLabel;
    lblname: TLabel;
    lblpremium: TLabel;
    lblmaxinsureamount: TLabel;
    lbldividedrate: TLabel;
    lbldescription: TLabel;
    jsonCDSInsuretypeSave: TjsonClientDataSet;
    cbborgid: TNovaHComboBox;
    cbbinsurersid: TNovaHComboBox;
    edtcode: TNovaEdit;
    edtname: TNovaEdit;
    edtpremium: TNovaEdit;
    edtmaxinsureamount: TNovaEdit;
    edtdividedrate: TNovaEdit;
    mmodescription: TMemo;
    lbl1: TLabel;
    lbl2: TLabel;
    lbl3: TLabel;
    Label1: TLabel;
    lbl4: TLabel;
    lbl5: TLabel;
    lbl6: TLabel;
    lbl7: TLabel;
    lbl8: TLabel;
    lbl9: TLabel;
    lbl10: TLabel;
    lbl11: TLabel;
    edtYWmoney: TNovaEdit;
    edtSHmoney: TNovaEdit;
    edtEmoney: TNovaEdit;
    edtEMmoney: TNovaEdit;
    lbl12: TLabel;
    lbl13: TLabel;
    lbl14: TLabel;
    lbl15: TLabel;
    edt1: TEdit;
    procedure bbtnSaveClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure edtdividedrateExit(Sender: TObject);
    procedure cbborgidExit(Sender: TObject);
    procedure edtYWmoneyExit(Sender: TObject);
    procedure edtSHmoneyExit(Sender: TObject);
  private
    log : string;
    { Private declarations }
  public
    { Public declarations }
    id, createby,orgid,insurersid: LongWord;
    createtime: TDatetime;
    sign: Boolean;
  end;

var
  FrmInsuretypeEdit: TFrmInsuretypeEdit;

implementation

uses Services, PubFn;
{$R *.dfm}

procedure TFrmInsuretypeEdit.bbtnSaveClick(Sender: TObject);
var
  nResult: Integer;
  sResult: string;
begin
  with jsonCDSInsuretypeSave do
  begin
      Close;
    if cbbinsurersid.ItemIndex>=0 then
    begin
      insurersid := cbbinsurersid.HelpFieldValue['id'];
    end;
    if (trim(edtname.Text)='') then
    begin
      SysDialogs.Warning('����д������������');
      edtname.SetFocus;
      exit;
    end;
    if (trim(edtcode.Text)='') then
    begin
      SysDialogs.Warning('����д�������ͱ���');
      edtcode.SetFocus;
      exit;
    end;
    if (Trim(cbborgid.Text) = '') then
    begin
      SysDialogs.Warning('����д������վ');
      cbborgid.SetFocus;
      exit;
    end;
    if (insurersid <= 0) then
    begin
      SysDialogs.Warning('����д������˾');
      cbbinsurersid.SetFocus;
      exit;
    end;
    if (Trim(edtpremium.Text) = '') then
    begin
      SysDialogs.Warning('����д���շ���');
      edtpremium.SetFocus;
      exit;
    end;
    if (Trim(edtEmoney.Text) = '') then
    begin
      SysDialogs.Warning('����д�����˺����ս��');
      edtEmoney.SetFocus;
      exit;
    end;
    if (Trim(edtEMmoney.Text) = '') then
    begin
      SysDialogs.Warning('����д�����˺�ҽ�Ʊ��ս��');
      edtEMmoney.SetFocus;
      exit;
    end;
    if (Trim(edtmaxinsureamount.Text) = '') then
    begin
      SysDialogs.Warning('����д��󱣶�');
      edtmaxinsureamount.SetFocus;
      exit;
    end;
    if (Trim(edtdividedrate.Text) = '') then
    begin
      SysDialogs.Warning('����д��վ���ֳɱ���');
      edtdividedrate.SetFocus;
      exit;
    end;
    if StrToFloat(edtpremium.Text) < 0 then
    begin
      SysDialogs.Warning('���շ��ò���С��0');
      edtpremium.SetFocus;
      exit;
    end;
    //̫ƽ����������ã�ʮ�ߣ�
    if StrToFloat(edtYWmoney.Text) < 0 then
    begin
      SysDialogs.Warning('����ҽ�Ʒ��ò���С��0');
      edtYWmoney.SetFocus;
      exit;
    end;
    if StrToFloat(edtSHmoney.Text) < 0 then
    begin
      SysDialogs.Warning('�����˺����ò���С��0');
      edtSHmoney.SetFocus;
      exit;
    end;
    if StrToFloat(edtpremium.Text) <> StrToFloat(edtYWmoney.text)+StrToFloat(edtSHmoney.text) then
    begin
      SysDialogs.Warning('���շ���Ӧ�õ�������ҽ�Ʒ����������˺�����֮��');
      edtpremium.SetFocus;
      exit;
    end;
    if StrToFloat(edtEmoney.Text) < 0 then
    begin
      SysDialogs.Warning('�����˺����ս���С��0');
      edtYWmoney.SetFocus;
      exit;
    end;
    if StrToFloat(edtEMmoney.Text) < 0 then
    begin
      SysDialogs.Warning('�����˺�ҽ��ҽ�Ʊ��ս���ò���С��0');
      edtEMmoney.SetFocus;
      exit;
    end;
    if StrToFloat(edtmaxinsureamount.Text) < 0 then
    begin
      SysDialogs.Warning('��󱣶��С��0');
      edtmaxinsureamount.SetFocus;
      exit;
    end;
    Params.ParamByName('insuretype.id').Value :=id ;
    if cbborgid.ItemIndex>=0 then
    begin
      orgid := cbborgid.HelpFieldValue['id'];
    end;
    Params.ParamByName('insuretype.orgid').Value := orgid;
    Params.ParamByName('insuretype.insurersid').Value := insurersid;
    Params.ParamByName('insuretype.name').Value := edtname.Text;
    Params.ParamByName('insuretype.createby').Value := createby;
    Params.ParamByName('insuretype.createtime').Value := DateTimeToStr(createtime);
    Params.ParamByName('insuretype.code').Value := edtcode.Text;
    Params.ParamByName('insuretype.premium').Value := edtpremium.Text;
    //��������뱣��
    Params.ParamByName('insuretype.ywmoney').Value := edtYWmoney.Text;
    Params.ParamByName('insuretype.shmoney').Value := edtSHmoney.Text;
    Params.ParamByName('insuretype.emoney').Value  := edtEmoney.Text;
    Params.ParamByName('insuretype.emmoney').Value := edtEMmoney.Text;

    params.ParamByName('insuretype.maxinsureamount').Value := edtmaxinsureamount.Text;
    Params.ParamByName('insuretype.dividedrate').Value := StrToFloat(edtdividedrate.Text)/100;
    Params.ParamByName('insuretype.description').Value := mmodescription.Text;

    try
      Execute;
      nResult := Params.ParamByName('flag').Value;
      sResult := Params.ParamByName('msg').Value;
      SysDialogs.ShowMessage(sResult);
      if (nResult <= 0) then
      begin
        if Pos('��ͬ�ĳ�վ���ܴ�����ͬ�Ĳ�Ʒ����',sResult) >0 then
        begin
             edtcode.SetFocus;
        end
        else
        edtname.SetFocus;
      end
      else
      begin
        if id > 0 then
        begin
          log := '�޸ı������ͣ���������=' + cbborgid.Text + ',���չ�˾='+cbbinsurersid.Text
          + ',��Ʒ����='+edtcode.Text+',��Ʒ����='+edtname.Text+',���շ���='+edtpremium.Text
          +',��󱣶�='+edtmaxinsureamount.Text+',��վ���÷ֳ�='+edtdividedrate.Text
          +',˵��='+mmodescription.Text
          +',����ҽ�Ʒ�='+edtYWmoney.Text+',�����˺���='+edtSHmoney.text
          +',�����˺����ս��='+edtEmoney.Text+',�����˺�ҽ�Ʊ��ս��='+edtEMmoney.Text;
          SysLog.WriteLog('Ʊ�����͡���>��������', '�޸�', log);
        end else
        begin
          log := '��ӱ������ͣ���������=' + cbborgid.Text + ',���չ�˾='+cbbinsurersid.Text
          + ',��Ʒ����='+edtcode.Text+',��Ʒ����='+edtname.Text+',���շ���='+edtpremium.Text
          +',��󱣶�='+edtmaxinsureamount.Text+',��վ���÷ֳ�='+edtdividedrate.Text
          +',˵��='+mmodescription.Text
          +',����ҽ�Ʒ�='+edtYWmoney.Text+',�����˺���='+edtSHmoney.text
          +',�����˺����ս��='+edtEmoney.Text+',�����˺�ҽ�Ʊ��ս��='+edtEMmoney.Text;
          SysLog.WriteLog('ҵ�������>��������', '���', log);
        end;
        id := Params.ParamByName('id').Value;
        ModalResult := mrok;
      end;
    except
      on E: Exception do
      begin
        SysLog.WriteErr('����������Ϣ���ʧ�ܣ�' + E.Message);
      end;
    end;
  end;
end;

procedure TFrmInsuretypeEdit.cbborgidExit(Sender: TObject);
begin
  inherited;
  with cbbinsurersid do
  begin
    Params.ParamValues['filter_EQL_t!orgid'] := cbborgid.HelpFieldValue['id'];
  end;
end;

procedure TFrmInsuretypeEdit.edtdividedrateExit(Sender: TObject);
begin
  inherited;
  if (StrToFloat(edtdividedrate.Text) > 100) or (StrToFloat(edtdividedrate.Text) < 0) then
  begin
    SysDialogs.ShowMessage('������0-100֮�����');
    edtdividedrate.SetFocus;
    exit;
  end;
end;

procedure TFrmInsuretypeEdit.edtSHmoneyExit(Sender: TObject);
begin
  inherited;
  edtYWmoney.Text := FloatToStr( StrToFloat(edtpremium.text) - StrToFloat(edtSHmoney.Text) );
end;

procedure TFrmInsuretypeEdit.edtYWmoneyExit(Sender: TObject);
begin
  inherited;
  edtSHmoney.Text := FloatToStr( StrToFloat(edtpremium.text) - StrToFloat(edtYWmoney.Text) );
end;

procedure TFrmInsuretypeEdit.FormCreate(Sender: TObject);
begin
  inherited;
  cbborgid.Active := false;
  cbborgid.Active := true;

  cbbinsurersid.Active := false;
  cbbinsurersid.Active := true;
end;

end.
