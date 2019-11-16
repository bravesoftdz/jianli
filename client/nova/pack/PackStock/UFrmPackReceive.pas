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
    printValue: TDictionary<String, String>; // 输出单变量
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

    Params.ParamByName('packpickup.packid').Value := packid; // 行包id
    Params.ParamByName('packpickup.shipprice').Value := NovaEdtshipprice.Text;
    // 保管费
    Params.ParamByName('packpickup.handfee').Value := '0';
    // 代收货款
    Params.ParamByName('packpickup.goodsprice').Value := nvedtgoodsprice.Text;
    // 到货装卸费
    Params.ParamByName('packpickup.packfee').Value := nvedtpackfee.Text;
    // 提付费用(托运合计金额费)
    Params.ParamByName('packpickup.penalty').Value :='0'; // 滞纳金
    Params.ParamByName('packpickup.totalfee').Value := nvedttotalfee.Text;
    // 合计金额
    Params.ParamByName('packpickup.signaturer').Value := NovaEditTakename.Text;
    // 提领人
    Params.ParamByName('packpickup.signdate').Value := FormatDateTime
      ('yyyy-mm-dd HH:mm:ss', Now); ; // 提领日期
    Params.ParamByName('packpickup.operator').Value :=
      SysInfo.LoginUserInfo.UserID; // 办理人
    Params.ParamByName('packpickup.remak').Value := ''; // 备注
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
          result := '修改'
        else
          result := '提领';

        log := result + '行包提领：所属机构=' + SysInfo.LoginUserInfo.OrgName + ',' +
          result + '人=' + SysInfo.LoginUserInfo.UserName + ',行包单号=' +
          nvedtpackno.Text + ',货物名称=' + nvedtname.Text + ',件数=' +
          nvedtpieces.Text +  ',货款=' +
          nvedtgoodsprice.Text + ',提付费=' +
          nvedtpackfee.Text + ',滞纳金=0' + ',合计金额=' +
          nvedttotalfee.Text + ',收货人=' + nvedtsignaturer.Text + ',证件号=' +
          nvedtcertificateno.Text + ',办理人=' + SysInfo.LoginUserInfo.UserName;
        SysLog.WriteLog('行包管理->行包入库', result, log);

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
    //托运费
    if StrToFloat(nvedtpackfee.Text)>=10000 then
    begin
    SysDialogs.ShowMessage('托运费金额数值超出范围(0~9999.99)!');
    nvedtpackfee.SetFocus;
    exit;
    end;

    totalfeemoney := totalfeemoney + StrToFloat(Trim(nvedtpackfee.Text));
    end;


    if (Trim(nvedthandfee.Text) <> '') then
    begin
    //装卸费
    if StrToFloat(nvedthandfee.Text)>=10000 then
    begin
    SysDialogs.ShowMessage('装卸费金额数值超出范围(0~9999.99)!');
    nvedthandfee.SetFocus;
    exit;
    end;
    totalfeemoney := totalfeemoney + StrToFloat(Trim(nvedthandfee.Text));
    end;

    nvedttotalfee.Text := FloatToStr(totalfeemoney);

    if totalfeemoney>=10000 then
    begin
    SysDialogs.ShowMessage('合计金额数值超出范围(0~9999.99)!');
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
  //代收运费
  if StrToFloat(NovaEdtshipprice.Text)>=10000 then
  begin
    SysDialogs.ShowMessage('代收运费金额数值超出范围(0~9999.99)!');
    NovaEdtshipprice.SetFocus;
    exit;
  end;

  end;

  if (Trim(nvedtgoodsprice.Text) <> '') then
  begin
  //代收贷款
  if StrToFloat(nvedtgoodsprice.Text)>=10000 then
  begin
    SysDialogs.ShowMessage('代收贷款金额数值超出范围(0~9999.99)!');
    nvedtgoodsprice.SetFocus;
    exit;
  end;
  end;

  nvedttotalfee.Text := FloatToStr(StrToFloat(Trim(NovaEdtshipprice.Text)) + StrToFloat(Trim(nvedtgoodsprice.Text)));

  if StrToFloat(nvedttotalfee.Text)>=10000 then
  begin
    SysDialogs.ShowMessage('合计金额数值超出范围(0~9999.99)!');
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
  billPrint := TNovaPrint.Create(self, TNovaPrint.GetTicketModelName('行包提领单',
      '行包提领单'));

  printValue.Clear;
  printValue.Add('sendstationname',nvhelpStation.Text);//起止站点
  printValue.Add('tostation',tostationname ); // 提领站
  printValue.Add('packno', nvedtpackno.Text); // 行包单号
  printValue.Add('packname', nvedtname.Text); // 货物名称
  printValue.Add('pieces', nvedtpieces.Text); // 件数
  printValue.Add('packfee', nvedtpackfee.Text); // 综合服务费
  printValue.Add('shipprice', NovaEdtshipprice.Text); // 运费

 // printValue.Add('packprice', nvedtpackprice.Text); // 提付费
  printValue.Add('totalfee', nvedttotalfee.Text); // 提领合计费用

  printValue.Add('goodsprice', nvedtgoodsprice.Text); // 代收货款

  printValue.Add('certificateno', mmomtakecertificateno.Text); // 提领凭证
  printValue.Add('consignee', nvedtsignaturer.Text); // 收货人

  printValue.Add('signaturer', NovaEditTakename.Text); // 提领人
  printValue.Add('takecertificateno', mmomtakecertificateno.Text); // 提领人证件号
  printValue.Add('departdate', FormatDateTime('yyyy-MM-dd',dtppickupenddate.DateTime)); //入库日期
  printValue.Add('createbyname', SysInfo.LoginUserInfo.UserName); // 收款员
  printValue.Add('sellbyname', nvhlpseller.Text);   // 货管员

  printValue.Add('packrebillno', SysInfo.LoginUserInfo.curBillNo.Items['PackReBill']);  //行包提领单号
  printValue.Add('printdate', FormatDateTime('yyyy-MM-dd HH:mm:ss', Now));
  // 签发时间

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
