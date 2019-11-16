unit UFrmPackDepartinvoicesEdit;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, USimpleEditForm, ImgList, StdCtrls, Buttons, ExtCtrls, NovaEdit, DB,
  DBClient, jsonClientDataSet,Generics.Collections, NovaPrint;

type
  TFrmPackDepartinvoicesEdit = class(TSimpleEditForm)
    lbl5: TLabel;
    edtstartdate: TNovaEdit;
    lbl2: TLabel;
    edtvehicletype: TNovaEdit;
    lbl3: TLabel;
    edtstartstation: TNovaEdit;
    lbl4: TLabel;
    edtendstation: TNovaEdit;
    Label1: TLabel;
    edtunit: TNovaEdit;
    Label2: TLabel;
    edtplanvehicle: TNovaEdit;
    lbl1: TLabel;
    edtschedule: TNovaEdit;
    lbl6: TLabel;
    edtstarttime: TNovaEdit;
    lbl7: TLabel;
    lbl9: TLabel;
    edtyeschecked: TNovaEdit;
    lbl10: TLabel;
    edtnochecked: TNovaEdit;
    jcdsFindPackDepNum: TjsonClientDataSet;
    dsResult: TDataSource;
    jcdsQryPackItems: TjsonClientDataSet;
    jcdsUpdatepack: TjsonClientDataSet;
    procedure FormShow(Sender: TObject);
    procedure bbtnSaveClick(Sender: TObject);
  private
    { Private declarations }
    log: String;
    billPackPrint: TNovaPrint;
    notprintValue: TList<string>; // 不打印项目
    printPackValue: TDictionary<String, String>; // 输出单变量
    multiplePacklist: TList < TDictionary < String, String >> ; // 输出数据集
    multiplePackValueValue: TDictionary<String, String>;
    procedure refreshBill; // 刷新票号

  public
    { Public declarations }
    sign: Boolean;
    scheduleplanid, reportvehicleid, isdepartinvoices,scheduleid,
      templtename: string;
    vehicleno, brandname, typename, routename, balanceunitname, checkedname,
      departtime, departstation, endstation, code, unitname, d1name, d2name, d3name,
      d4name, s1name, seatnum, distance, departdate: string;
    vehicleid, newdepartinvoicesid,departinvoicesid: Int64;
  end;

var
  FrmPackDepartinvoicesEdit: TFrmPackDepartinvoicesEdit;

implementation
uses Services,PubFn;
{$R *.dfm}

procedure TFrmPackDepartinvoicesEdit.bbtnSaveClick(Sender: TObject);
var
  piecesnums: integer;
  totalfeemoney,balancetotalfeemoney: double;
  sendstationname: string;
begin
  inherited;
  if (edtnochecked.Text = '') or (StrToInt(edtnochecked.Text) = 0) then
  begin
    SysDialogs.ShowMessage('没有未开运量单的了，不用进行补开！');
    Exit;
  end;
  if not checkBillno('BalanceBill') then
    Exit;
  try
    printPackValue := TDictionary<String, String>.Create;
    if not Assigned(billPackPrint) then
    begin
      billPackPrint := TNovaPrint.Create(self,
        TNovaPrint.GetTicketModelName('货物结算单', '货物结算单'));
    end;
    with jcdsQryPackItems do
    begin

      Active := false;

      Params.ParamValues['startdate'] := edtstartdate.Text;

      Params.ParamValues['enddate'] := edtstartdate.Text;

      Params.ParamValues['scheduleid'] := scheduleid;

      Params.ParamValues['isbukai'] := '1';
      Params.ParamValues['isreprint'] := '0';

      Params.ParamValues['filter_GED_ss!departdate'] := edtstartdate.Text;
      Params.ParamValues['filter_LED_ss!departdate'] := edtstartdate.Text;
      Params.ParamValues['filter_EQL_ss!departstationid'] :=
        Sysinfo.LoginUserInfo.StationID;
      Params.ParamValues['filter_INS_ss!status'] := '(0,2,4,5)';

      Params.ParamValues['filter_EQL_sd!id'] := scheduleid;

      Params.ParamValues['departinvoicesno'] :=
        Sysinfo.LoginUserInfo.curBillNo.Items['BalanceBill'];

      Active := true;

      if RecordCount < 1 then
      begin
        //SysDialogs.ShowMessage('该班次没有行包签发!');
        exit;
      end;

      multiplePacklist := TList < TDictionary < String, String >> .Create;
      while not Eof do
      begin
        sendstationname := FieldByName('sendstationname').AsString; // 发货站
        piecesnums := piecesnums + FieldByName('pieces').AsInteger; // 行包总件数
        totalfeemoney := totalfeemoney + FieldByName('totalfee').AsFloat; // 总金额
        balancetotalfeemoney := balancetotalfeemoney + FieldByName('balancefeecountmoney').AsFloat; //结算总金额
        multiplePackValueValue := TDictionary<String, String>.Create;
        multiplePackValueValue.Add('tostationvalue',
          FieldByName('tostationname').AsString); // 到站
        multiplePackValueValue.Add('pieces', FieldByName('pieces').AsString);
        // 件数
        multiplePackValueValue.Add('totalfeemoney',
          FieldByName('totalfee').AsString); // 金额
        multiplePackValueValue.Add('packno', FieldByName('packno').AsString);
        // 行包托运单号

        multiplePackValueValue.Add('balancefeecountmoney',
          FieldByName('balancefeecountmoney').AsString); // 结算金额
        multiplePacklist.Add(multiplePackValueValue);
        next;
      end;

    // 签发单号、发车日期、班次号、车牌号码、驾驶员、营运单位、行包件数、总金额，

      printPackValue.Clear;

      with jcdsUpdatepack do
        begin

          Active := false;

          Params.ParamValues['filter_GED_p!departdate'] := edtstartdate.Text;
          Params.ParamValues['filter_LED_p!departdate'] := edtstartdate.Text;
          Params.ParamValues['filter_EQS_p!status'] := '1';

          Params.ParamValues['filter_EQL_p!scheduleid'] := scheduleid;

          Params.ParamValues['singbillno'] :=
            Sysinfo.LoginUserInfo.curBillNo.Items['BalanceBill'];

          Execute;

        end;

      if getParametervalue('8088', Sysinfo.LoginUserInfo.OrgID) = '1' then
      begin
        printPackValue.Add('singbillno',
          Sysinfo.LoginUserInfo.curBillNo.Items['BalanceBill']); // 签发单号

        with Sysinfo.LoginUserInfo do
        begin
          curBillNo.AddOrSetValue('BalanceBill',
            zerofill(inttostr(strtoint64(curBillNo.Items['BalanceBill']) + 1),
              length(curBillNo.Items['BalanceBill'])));
          curBillNum.AddOrSetValue('BalanceBill',
            curBillNum.Items['BalanceBill'] - 1);
        end;
        refreshBill;

      end
      else
      begin
        printPackValue.Add('singbillno', ''); // 签发单号
      end;
      printPackValue.Add('fillopen','补开');
      printPackValue.Add('departdate',Params.ParamValues['packStockVo.departdate']); // 发车日期
      // 发车时间
      printPackValue.Add('departtime', Params.ParamValues['packStockVo.departtime']);
      printPackValue.Add('schedulevalue', Params.ParamValues['packStockVo.code']); // 班次
      printPackValue.Add('vehiclevalue', Params.ParamValues['packStockVo.vehicleno']);
      // 车牌号
      printPackValue.Add('drivername', Params.ParamValues['packStockVo.drivername']);
      // 驾驶员
      printPackValue.Add('unitname', Params.ParamValues['packStockVo.unitname']); // 营运单位
      printPackValue.Add('sellbyname', Sysinfo.LoginUserInfo.UserName); // 签发人
      printPackValue.Add('printdate', formatdatetime('yyyy-MM-dd HH:mm:ss',
          now));
      // 签发时间
      printPackValue.Add('sendstation', sendstationname); // 签发站

      printPackValue.Add('piecesnums', inttostr(piecesnums)); // 行包件数
      printPackValue.Add('totalfeecountmoney', floattostr(totalfeemoney));// 总金额
      printPackValue.Add('balancetotalfeecountmoney', floattostr(balancetotalfeemoney));// 结算总金额

    end;
    billPackPrint.MultipleValue := multiplePacklist;

    billPackPrint.SingleValue := printPackValue;
    billPackPrint.Print;

    ModalResult := mrOk;
  finally

  end;




end;

procedure TFrmPackDepartinvoicesEdit.FormShow(Sender: TObject);
begin
  inherited;

  with jcdsFindPackDepNum do
  begin
    Active := false;
    Params.ParamValues['scheduleplanid'] := scheduleplanid;
    Params.ParamValues['scheduleid'] := scheduleid;
    Params.ParamValues['departdate'] := departdate;

    Active := true;
  end;
  if not dsResult.DataSet.Active then
    Exit;
  if dsResult.DataSet.RecordCount > 0 then
  begin
      edtyeschecked.Text := jcdsFindPackDepNum.FieldByName('yesfaban').AsString;
      edtnochecked.Text:=jcdsFindPackDepNum.FieldByName('nofaban').AsString;
  end;

end;

procedure TFrmPackDepartinvoicesEdit.refreshBill;
begin
  if SysInfo.LoginUserInfo.curBillNo.ContainsKey('BalanceBill')
    and SysInfo.LoginUserInfo.curBillNum.ContainsKey('BalanceBill') and
    (SysInfo.LoginUserInfo.curBillNum.Items['BalanceBill'] > 0) then
  begin

  end
  else
  begin
    SysDialogs.Warning('请重置结算单号！');
  end;
end;

end.
