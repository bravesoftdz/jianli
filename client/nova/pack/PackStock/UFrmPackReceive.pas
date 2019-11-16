unit UFrmPackReceive;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, USimpleEditForm, StdCtrls, Buttons, ExtCtrls, NovaEdit, NovaHelp,
  NovaComboBox, DB, DBClient, jsonClientDataSet, UDMPublic, Services,
  NovaHComboBox, ImgList, ComCtrls, NovaPrint, Generics.Collections;

type
  TFrmPackReceive = class(TSimpleEditForm)
    jcdspackpicupsave: TjsonClientDataSet;
    GroupBox1: TGroupBox;
    jcdsupdateBillinuse: TjsonClientDataSet;
    lbl7: TLabel;
    lbl8: TLabel;
    lbl9: TLabel;
    lbl10: TLabel;
    lbl11: TLabel;
    lbl12: TLabel;
    nvedtname: TNovaEdit;
    nvedtpieces: TNovaEdit;
    nvedtsignaturer: TNovaEdit;
    nvedtcertificateno: TNovaEdit;
    nvedtpackno: TNovaEdit;
    dtppickupenddate: TDateTimePicker;
    lbl2: TLabel;
    nvhelpStation: TNovaHelp;
    lbl3: TLabel;
    nvhlpseller: TNovaHelp;
    grp1: TGroupBox;
    lbl13: TLabel;
    lbl14: TLabel;
    lbl15: TLabel;
    lbl16: TLabel;
    nvedttotalfee: TNovaEdit;
    nvedtpackfee: TNovaEdit;
    mmomtakecertificateno: TMemo;
    nvedtgoodsprice: TNovaEdit;
    dtppickupdate: TDateTimePicker;
    lbl1: TLabel;
    lbl4: TLabel;
    Novasellbyname: TNovaHelp;
    lbl5: TLabel;
    NovaEditTakename: TNovaEdit;
    lbl6: TLabel;
    NovaEdtshipprice: TNovaEdit;
    procedure bbtnSaveClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure nvedthandfeeChange(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure NovaEdtshippriceChange(Sender: TObject);

  private
    { Private declarations }
    Foperationid: Integer;
    log: string;
    schedulename, vehiclecodename: string;
    billPrint: TNovaPrint;
    printValue: TDictionary<String, String>; // ���������
    procedure totalfeemoney;
    procedure PrintClink;
    procedure updatepackbill;
  public
    { Public declarations }
    packid, packpickupid: Integer; // ;//number(10)	n
    tostationname:string;
    property operationid: Integer read Foperationid;
  end;

var
  FrmPackReceive: TFrmPackReceive;

implementation

uses PubFn, DateUtils;
{$R *.dfm}

procedure TFrmPackReceive.bbtnSaveClick(Sender: TObject);

var
  nvhelpstartstationid: Integer;
  nvhelpendstationid: Integer;
  result: string;
  packstatus: string;

begin
  inherited;

  with jcdspackpicupsave do
  begin
    Active := false;
    if self.edittype = Tedittype.update then
    begin

    end;

    Params.ParamByName('packpickup.packid').Value := packid; // �а�id
    Params.ParamByName('packpickup.shipprice').Value := NovaEdtshipprice.Text;
    // ���ܷ�
    Params.ParamByName('packpickup.handfee').Value := '0';
    // ���ջ���
    Params.ParamByName('packpickup.goodsprice').Value := nvedtgoodsprice.Text;
    // ����װж��
    Params.ParamByName('packpickup.packfee').Value := nvedtpackfee.Text;
    // �Ḷ����(���˺ϼƽ���)
    Params.ParamByName('packpickup.penalty').Value :='0'; // ���ɽ�
    Params.ParamByName('packpickup.totalfee').Value := nvedttotalfee.Text;
    // �ϼƽ��
    Params.ParamByName('packpickup.signaturer').Value := NovaEditTakename.Text;
    // ������
    Params.ParamByName('packpickup.signdate').Value := FormatDateTime
      ('yyyy-mm-dd HH:mm:ss', Now); ; // ��������
    Params.ParamByName('packpickup.operator').Value :=
      SysInfo.LoginUserInfo.UserID; // ������
    Params.ParamByName('packpickup.remak').Value := ''; // ��ע
    Params.ParamByName('packpickup.orgid').Value := SysInfo.LoginUserInfo.orgid;
    if getParametervalue('8007', SysInfo.LoginUserInfo.orgid) = '1' then
    begin
      Params.ParamByName('packpickno').Value :=
        SysInfo.LoginUserInfo.curBillNo.Items['PackReBill'];
    end;

    Params.ParamByName('packpickup.takecertificateno').Value:=mmomtakecertificateno.Text;
    bbtnSave.Enabled := false;
    Execute;
    bbtnSave.Enabled := true;
    if Params.ParamValues['msg'] <> '' then
    begin
      SysDialogs.ShowMessage(Params.ParamValues['msg']);
    end;
    if Params.ParamValues['flag'] = 1 then
    begin
      bbtnSave.Enabled := false;
      try
        if packpickupid > 0 then
          result := '�޸�'
        else
          result := '����';

        log := result + '�а����죺��������=' + SysInfo.LoginUserInfo.OrgName + ',' +
          result + '��=' + SysInfo.LoginUserInfo.UserName + ',�а�����=' +
          nvedtpackno.Text + ',��������=' + nvedtname.Text + ',����=' +
          nvedtpieces.Text +  ',����=' +
          nvedtgoodsprice.Text + ',�Ḷ��=' +
          nvedtpackfee.Text + ',���ɽ�=0' + ',�ϼƽ��=' +
          nvedttotalfee.Text + ',�ջ���=' + nvedtsignaturer.Text + ',֤����=' +
          nvedtcertificateno.Text + ',������=' + SysInfo.LoginUserInfo.UserName;
        SysLog.WriteLog('�а�����->�а����', result, log);

        if getParametervalue('8007', SysInfo.LoginUserInfo.orgid) = '1' then
        begin
          PrintClink;
          updatepackbill;
        end;

      finally
        Foperationid := Params.ParamValues['packpickupid'];
        self.ModalResult := mrOk;
      end;

    end;

  end;
end;

procedure TFrmPackReceive.totalfeemoney();
var
  totalfeemoney: Double;
begin
  { if (Trim(nvedtpackfee.Text) <> '') then
    begin
    //���˷�
    if StrToFloat(nvedtpackfee.Text)>=10000 then
    begin
    SysDialogs.ShowMessage('���˷ѽ����ֵ������Χ(0~9999.99)!');
    nvedtpackfee.SetFocus;
    exit;
    end;

    totalfeemoney := totalfeemoney + StrToFloat(Trim(nvedtpackfee.Text));
    end;


    if (Trim(nvedthandfee.Text) <> '') then
    begin
    //װж��
    if StrToFloat(nvedthandfee.Text)>=10000 then
    begin
    SysDialogs.ShowMessage('װж�ѽ����ֵ������Χ(0~9999.99)!');
    nvedthandfee.SetFocus;
    exit;
    end;
    totalfeemoney := totalfeemoney + StrToFloat(Trim(nvedthandfee.Text));
    end;

    nvedttotalfee.Text := FloatToStr(totalfeemoney);

    if totalfeemoney>=10000 then
    begin
    SysDialogs.ShowMessage('�ϼƽ����ֵ������Χ(0~9999.99)!');
    nvedttotalfee.SetFocus;
    exit;
    end;
    }
end;

procedure TFrmPackReceive.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  inherited;
  // if Assigned(printValue) then
  // printValue.Free;
end;

procedure TFrmPackReceive.FormShow(Sender: TObject);
begin
  inherited;
  NovaEditTakename.SetFocus;
  Novasellbyname.Id:=SysInfo.LoginUserInfo.UserID;
  Novasellbyname.text:=SysInfo.LoginUserInfo.UserName;
end;

procedure TFrmPackReceive.NovaEdtshippriceChange(Sender: TObject);
begin
  inherited;
  if (Trim(NovaEdtshipprice.Text) <> '') then
  begin
  //�����˷�
  if StrToFloat(NovaEdtshipprice.Text)>=10000 then
  begin
    SysDialogs.ShowMessage('�����˷ѽ����ֵ������Χ(0~9999.99)!');
    NovaEdtshipprice.SetFocus;
    exit;
  end;

  end;

  if (Trim(nvedtgoodsprice.Text) <> '') then
  begin
  //���մ���
  if StrToFloat(nvedtgoodsprice.Text)>=10000 then
  begin
    SysDialogs.ShowMessage('���մ�������ֵ������Χ(0~9999.99)!');
    nvedtgoodsprice.SetFocus;
    exit;
  end;
  end;

  nvedttotalfee.Text := FloatToStr(StrToFloat(Trim(NovaEdtshipprice.Text)) + StrToFloat(Trim(nvedtgoodsprice.Text)));

  if StrToFloat(nvedttotalfee.Text)>=10000 then
  begin
    SysDialogs.ShowMessage('�ϼƽ����ֵ������Χ(0~9999.99)!');
    nvedttotalfee.SetFocus;
    exit;
  end;


end;

procedure TFrmPackReceive.nvedthandfeeChange(Sender: TObject);
begin
  inherited;
  {
  nvedttotalfee.Text := FloatToStr(StrToFloat(trim(nvedtpackfee.Text))
       + StrToFloat
      (trim(NovaEdtshipprice.Text)) + StrToFloat(trim(nvedtgoodsprice.Text))); }
end;

procedure TFrmPackReceive.PrintClink();

begin

  printValue := TDictionary<String, String>.Create;
  billPrint := TNovaPrint.Create(self, TNovaPrint.GetTicketModelName('�а����쵥',
      '�а����쵥'));

  printValue.Clear;
  printValue.Add('sendstationname',nvhelpStation.Text);//��ֹվ��
  printValue.Add('tostation',tostationname ); // ����վ
  printValue.Add('packno', nvedtpackno.Text); // �а�����
  printValue.Add('packname', nvedtname.Text); // ��������
  printValue.Add('pieces', nvedtpieces.Text); // ����
  printValue.Add('packfee', nvedtpackfee.Text); // �ۺϷ����
  printValue.Add('shipprice', NovaEdtshipprice.Text); // �˷�

 // printValue.Add('packprice', nvedtpackprice.Text); // �Ḷ��
  printValue.Add('totalfee', nvedttotalfee.Text); // ����ϼƷ���

  printValue.Add('goodsprice', nvedtgoodsprice.Text); // ���ջ���

  printValue.Add('certificateno', mmomtakecertificateno.Text); // ����ƾ֤
  printValue.Add('consignee', nvedtsignaturer.Text); // �ջ���

  printValue.Add('signaturer', NovaEditTakename.Text); // ������
  printValue.Add('takecertificateno', mmomtakecertificateno.Text); // ������֤����
  printValue.Add('departdate', FormatDateTime('yyyy-MM-dd',dtppickupenddate.DateTime)); //�������
  printValue.Add('createbyname', SysInfo.LoginUserInfo.UserName); // �տ�Ա
  printValue.Add('sellbyname', nvhlpseller.Text);   // ����Ա

  printValue.Add('packrebillno', SysInfo.LoginUserInfo.curBillNo.Items['PackReBill']);  //�а����쵥��
  printValue.Add('printdate', FormatDateTime('yyyy-MM-dd HH:mm:ss', Now));
  // ǩ��ʱ��

  billPrint.SingleValue := printValue;
  billPrint.Print;

end;

procedure TFrmPackReceive.updatepackbill();
var
  billinusestatus, billinusenextno, billinusenextform: string;
begin

  with SysInfo.LoginUserInfo do
  begin
    billinusenextform := inttostr
      (strtoint64(SysInfo.LoginUserInfo.curBillNo.Items['PackReBill']));
    billinusenextno := inttostr
      (strtoint64(SysInfo.LoginUserInfo.curBillNo.Items['PackReBill'])
        + 1);

    curBillNo.AddOrSetValue('PackReBill', zerofill(billinusenextno,
        length(curBillNo.Items['PackReBill'])));
    curBillNum.AddOrSetValue('PackReBill', curBillNum.Items['PackReBill'] - 1);

    if curBillNum.Items['PackReBill'] > 0 then
      billinusestatus := '1'
    else
      billinusestatus := '2';

  end;

  with jcdsupdateBillinuse do
  begin
    Active := false;
    Params.ParamValues['billinusestatus'] := billinusestatus;
    Params.ParamValues['billinusenextno'] := billinusenextno;
    Params.ParamValues['billinusenextform'] := billinusenextform;
    Params.ParamValues['billtypecode'] := 'PackReBill';
    Execute;
    if Params.ParamValues['msg'] <> '' then
    begin
      SysDialogs.ShowMessage(Params.ParamValues['msg']);
    end;

    if Params.ParamValues['flag'] = -1 then
    begin

    end;

  end;
end;

end.
