unit UFrmOutstationupmoneyAdd;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, USimpleEditForm, StdCtrls, Buttons, ExtCtrls, NovaEdit, NovaHelp,
  NovaComboBox, DB, DBClient, jsonClientDataSet, UDMPublic, Services,
  NovaHComboBox, ImgList, ComCtrls;

type
  TFrmOutstationupmoneyAdd = class(TSimpleEditForm)
    jcdssave: TjsonClientDataSet;
    Label59: TLabel;
    Label41: TLabel;
    Label33: TLabel;
    Label4: TLabel;
    Label19: TLabel;
    Label26: TLabel;
    Label43: TLabel;
    Label55: TLabel;
    Label48: TLabel;
    Label57: TLabel;
    Label49: TLabel;
    Label60: TLabel;
    Label14: TLabel;
    Label21: TLabel;
    lbl5: TLabel;
    lbl4: TLabel;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label5: TLabel;
    nvedtagentfee: TNovaEdit;
    nvedtprice: TNovaEdit;
    nvedtbalancemoney: TNovaEdit;
    nvedtwaterfee: TNovaEdit;
    nvedtstopfee: TNovaEdit;
    nvedtviolationfee: TNovaEdit;
    nvedtotherfee1: TNovaEdit;
    nvhlpRoute: TNovaHelp;
    dtpstartdate: TDateTimePicker;
    nvedtotherfee2: TNovaEdit;
    procedure bbtnSaveClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure nvedtpriceChange(Sender: TObject);
    procedure nvedtpriceClick(Sender: TObject);

  private
    { Private declarations }
    Foperationid: Integer;
    log: string;

    procedure totalfeemoney;

  public
    { Public declarations }
    outstationupmoneyid: Integer; // ;//number(10)	n
    orgid: Integer; // number(10)	y
    operatorid: Integer;
    createtime: TDateTime; // date	n	sys;//date
    createby: Integer; // number(10)	n
    updatetime: TDateTime; // date	n	sys;//date
    updateby: Integer; // number(10)	n
    operatername,oldroutename: string;
    property operationid: Integer read Foperationid;
  end;

var
  FrmOutstationupmoneyAdd: TFrmOutstationupmoneyAdd;

implementation

uses PubFn, DateUtils;
{$R *.dfm}

procedure TFrmOutstationupmoneyAdd.bbtnSaveClick(Sender: TObject);

var
  result: string;
begin
  inherited;

  if trim(nvhlpRoute.Text) ='' then
  begin
    SysDialogs.ShowMessage('��������·!');
    nvhlpRoute.SetFocus;
    exit;
  end;

  if (Trim(nvedtprice.Text) = '') then
  begin
    SysDialogs.ShowMessage('��վ��Ʊ����Ϊ��!');
    nvedtprice.Text := '0';
    nvedtprice.SetFocus;
    exit;
  end;

  if (Trim(nvedtagentfee.Text) = '') then
  begin
    SysDialogs.ShowMessage('���˴���Ѳ���Ϊ��!');
    nvedtagentfee.Text := '0';
    nvedtagentfee.SetFocus;
    exit;
  end;

  if (Trim(nvedtwaterfee.Text) = '') then
  begin
    SysDialogs.ShowMessage('ˮ�Ѳ���Ϊ��!');
    nvedtwaterfee.Text := '0';
    nvedtwaterfee.SetFocus;
    exit;
  end;

  if (Trim(nvedtstopfee.Text) = '') then
  begin
    SysDialogs.ShowMessage('ͣ���Ѳ���Ϊ��!');
    nvedtstopfee.Text := '0';
    nvedtstopfee.SetFocus;
    exit;
  end;

  if (Trim(nvedtviolationfee.Text) = '') then
  begin
    SysDialogs.ShowMessage('ΥԼ�Ѱ�Ѳ���Ϊ��!');
    nvedtviolationfee.Text := '0';
    nvedtviolationfee.SetFocus;
    exit;
  end;

  if (Trim(nvedtotherfee1.Text) = '') then
  begin
    SysDialogs.ShowMessage('��������1����Ϊ��!');
    nvedtotherfee1.Text := '0';
    nvedtotherfee1.SetFocus;
    exit;
  end;

  if (Trim(nvedtotherfee2.Text) = '') then
  begin
    SysDialogs.ShowMessage('��������2����Ϊ��!');
    nvedtotherfee2.Text := '0';
    nvedtotherfee2.SetFocus;
    exit;
  end;

  if (Trim(nvedtbalancemoney.Text) = '') then
  begin
    SysDialogs.ShowMessage('���ɽ���Ϊ��!');
    nvedtbalancemoney.Text := '0';
    nvedtbalancemoney.SetFocus;
    exit;
  end;


  if (Trim(nvedtprice.Text) <> '') then
  begin
    // ��վ��Ʊ���
    if StrToFloat(nvedtprice.Text) >= 100000000 then
    begin
      SysDialogs.ShowMessage('��վ��Ʊ�������ֵ������Χ(0~99999999.99)!');
      nvedtprice.SetFocus;
      exit;
    end;

  end;

  if (Trim(nvedtagentfee.Text) <> '') then
  begin
    // ���˴����
    if StrToFloat(nvedtagentfee.Text) >= 100000000 then
    begin
      SysDialogs.ShowMessage('���˴���ѽ����ֵ������Χ(0~99999999.99)!');
      nvedtagentfee.SetFocus;
      exit;
    end;

  end;

  if (Trim(nvedtwaterfee.Text) <> '') then
  begin
    // ˮ��
    if StrToFloat(nvedtwaterfee.Text) >= 100000000 then
    begin
      SysDialogs.ShowMessage('ˮ�ѽ����ֵ������Χ(0~99999999.99)!');
      nvedtwaterfee.SetFocus;
      exit;
    end;

  end;

  if (Trim(nvedtstopfee.Text) <> '') then
  begin
    // ͣ����
    if StrToFloat(nvedtstopfee.Text) >= 100000000 then
    begin
      SysDialogs.ShowMessage('ͣ���ѽ����ֵ������Χ(0~99999999.99)!');
      nvedtstopfee.SetFocus;
      exit;
    end;

  end;

  if (Trim(nvedtotherfee1.Text) <> '') then
  begin
    // ��������1
    if StrToFloat(nvedtotherfee1.Text) >= 100000000 then
    begin
      SysDialogs.ShowMessage('��������1�����ֵ������Χ(0~99999999.99)!');
      nvedtotherfee1.SetFocus;
      exit;
    end;

  end;

  if (Trim(nvedtotherfee2.Text) <> '') then
  begin
    // ��������2
    if StrToFloat(nvedtotherfee2.Text) >= 100000000 then
    begin
      SysDialogs.ShowMessage('��������2�����ֵ������Χ(0~99999999.99)!');
      nvedtotherfee2.SetFocus;
      exit;
    end;

  end;

  if (Trim(nvedtviolationfee.Text) <> '') then
  begin
    // ΥԼ�Ѱ��
    if StrToFloat(nvedtviolationfee.Text) >= 100000000 then
    begin
      SysDialogs.ShowMessage('ΥԼ�Ѱ�ѽ����ֵ������Χ(0~99999999.99)!');
      nvedtviolationfee.SetFocus;
      exit;
    end;

  end;


  if StrToFloat(nvedtbalancemoney.Text)<0 then
  begin
    SysDialogs.ShowMessage('���ɽ���С��0!');
    nvedtprice.SetFocus;
    exit;
  end;

  if StrToFloat(nvedtbalancemoney.Text) >= 100000000 then
  begin
    SysDialogs.ShowMessage('���ɽ����ֵ������Χ(0~99999999.99)!');
    nvedtprice.SetFocus;
    exit;
  end;

  with jcdssave do
  begin
    Active := false;
    if self.edittype = Tedittype.update then
    begin
      Params.ParamValues['outstationupmoney.id'] := IntToStr
        (outstationupmoneyid);
      Params.ParamValues['outstationupmoney.createby'] := IntToStr(createby);
      Params.ParamValues['outstationupmoney.createtime'] := FormatDateTime
        ('yyyy-mm-dd HH:mm:ss', createtime);
      Params.ParamByName('outstationupmoney.operatorid').Value := IntToStr
        (operatorid);
      Params.ParamByName('outstationupmoney.orgid').Value := IntToStr(orgid);
    end
    else
    begin
      Params.ParamByName('outstationupmoney.operatorid').Value :=
        SysInfo.LoginUserInfo.UserId;
      Params.ParamByName('outstationupmoney.orgid').Value :=
        SysInfo.LoginUserInfo.orgid;
    end;

    Params.ParamByName('outstationupmoney.departmonth').Value := FormatDateTime
      ('yyyymm', dtpstartdate.DateTime);
    Params.ParamByName('outstationupmoney.routename').Value
                                        := trim(nvhlpRoute.Text);
    Params.ParamByName('outstationupmoney.price').Value := Trim
      (nvedtprice.Text);
    Params.ParamByName('outstationupmoney.agentfee').Value := Trim
      (nvedtagentfee.Text);

    Params.ParamByName('outstationupmoney.waterfee').Value := Trim
      (nvedtwaterfee.Text);
    Params.ParamByName('outstationupmoney.stopfee').Value := Trim
      (nvedtstopfee.Text);
    Params.ParamByName('outstationupmoney.violationfee').Value := Trim
      (nvedtviolationfee.Text);
    Params.ParamByName('outstationupmoney.otherfee1').Value := Trim
      (nvedtotherfee1.Text);
    Params.ParamByName('outstationupmoney.otherfee2').Value := Trim
      (nvedtotherfee2.Text);
    Params.ParamByName('outstationupmoney.balancemoney').Value := Trim
      (nvedtbalancemoney.Text);

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
      if outstationupmoneyid > 0 then
      begin
        result := '�޸�:ID=' + VarToStr(Params.ParamValues['outstationupmoneyid']);
        log := 'ԭ��·='+oldroutename +',';
      end
      else
        result := '���:';
      log := log+ '����=' + SysInfo.LoginUserInfo.OrgName + ',' +
         '��=' + SysInfo.LoginUserInfo.UserName + ',�����·�=' +
        FormatDateTime('yyyy-mm', dtpstartdate.DateTime)
        + ',��·=' + nvhlpRoute.Text + ',��վ��Ʊ���=' + nvedtprice.Text +
        ',���˴����=' + nvedtagentfee.Text + ',ˮ��=' + nvedtwaterfee.Text +
        ',ͣ����=' + nvedtstopfee.Text + ',ΥԼ�Ѱ��=' +
        nvedtviolationfee.Text + ',��������1=' + nvedtotherfee1.Text +
        ',��������2=' + nvedtotherfee2.Text + ',���ɽ��=' +
        nvedtbalancemoney.Text;
      SysLog.WriteLog('�������->��վ�ɿ', result, log);

      self.ModalResult := mrOk;
    end;

    Foperationid := Params.ParamValues['outstationupmoneyid'];
  end;
end;

procedure TFrmOutstationupmoneyAdd.FormShow(Sender: TObject);
begin
  inherited;
  if self.edittype = Tedittype.add then
  begin
    dtpstartdate.DateTime := Now();
  end;
end;

procedure TFrmOutstationupmoneyAdd.nvedtpriceChange(Sender: TObject);
begin
  inherited;
  totalfeemoney;
end;

procedure TFrmOutstationupmoneyAdd.nvedtpriceClick(Sender: TObject);
begin
  inherited;
  nvedtprice.OnFocusSelectAll :=true;
end;

procedure TFrmOutstationupmoneyAdd.totalfeemoney();
var
  balancemoney: Double;
begin
  balancemoney := 0;
  if (Trim(nvedtprice.Text) <> '') then
  begin
    // ��վ��Ʊ���
    if StrToFloat(nvedtprice.Text) >= 100000000 then
    begin
      SysDialogs.ShowMessage('��վ��Ʊ�������ֵ������Χ(0~99999999.99)!');
      nvedtprice.SetFocus;
      exit;
    end;

    balancemoney := StrToFloat(Trim(nvedtprice.Text));
  end;

  if (Trim(nvedtagentfee.Text) <> '') then
  begin
    // ���˴����
    if StrToFloat(nvedtagentfee.Text) >= 100000000 then
    begin
      SysDialogs.ShowMessage('���˴���ѽ����ֵ������Χ(0~99999999.99)!');
      nvedtagentfee.SetFocus;
      exit;
    end;

    balancemoney := balancemoney - StrToFloat(Trim(nvedtagentfee.Text));
  end;

  if (Trim(nvedtwaterfee.Text) <> '') then
  begin
    // ˮ��
    if StrToFloat(nvedtwaterfee.Text) >= 100000000 then
    begin
      SysDialogs.ShowMessage('ˮ�ѽ����ֵ������Χ(0~99999999.99)!');
      nvedtwaterfee.SetFocus;
      exit;
    end;
    balancemoney := balancemoney - StrToFloat(Trim(nvedtwaterfee.Text));
  end;

  if (Trim(nvedtstopfee.Text) <> '') then
  begin
    // ͣ����
    if StrToFloat(nvedtstopfee.Text) >= 100000000 then
    begin
      SysDialogs.ShowMessage('ͣ���ѽ����ֵ������Χ(0~99999999.99)!');
      nvedtstopfee.SetFocus;
      exit;
    end;
    balancemoney := balancemoney - StrToFloat(Trim(nvedtstopfee.Text));
  end;

  if (Trim(nvedtotherfee1.Text) <> '') then
  begin
    // ��������1
    if StrToFloat(nvedtotherfee1.Text) >= 100000000 then
    begin
      SysDialogs.ShowMessage('��������1�����ֵ������Χ(0~99999999.99)!');
      nvedtotherfee1.SetFocus;
      exit;
    end;
    balancemoney := balancemoney - StrToFloat(Trim(nvedtotherfee1.Text));
  end;

  if (Trim(nvedtotherfee2.Text) <> '') then
  begin
    // ��������2
    if StrToFloat(nvedtotherfee2.Text) >= 100000000 then
    begin
      SysDialogs.ShowMessage('��������2�����ֵ������Χ(0~99999999.99)!');
      nvedtotherfee2.SetFocus;
      exit;
    end;
    balancemoney := balancemoney - StrToFloat(Trim(nvedtotherfee2.Text));
  end;

  if (Trim(nvedtviolationfee.Text) <> '') then
  begin
    // ΥԼ�Ѱ��
    if StrToFloat(nvedtviolationfee.Text) >= 100000000 then
    begin
      SysDialogs.ShowMessage('ΥԼ�Ѱ�ѽ����ֵ������Χ(0~99999999.99)!');
      nvedtviolationfee.SetFocus;
      exit;
    end;
    balancemoney := balancemoney - StrToFloat(Trim(nvedtviolationfee.Text));
  end;

  nvedtbalancemoney.Text := FloatToStr(balancemoney);

  if balancemoney<0 then
  begin
    SysDialogs.ShowMessage('���ɽ���С��0!');
    nvedtprice.SetFocus;
    exit;
  end;

  if balancemoney >= 100000000 then
  begin
    SysDialogs.ShowMessage('���ɽ����ֵ������Χ(0~99999999.99)!');
    nvedtprice.SetFocus;
    exit;
  end;

end;

end.
