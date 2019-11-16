unit UFrmPackDepartinvoices;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, USimpleCRUDForm, DBGridEhGrouping, NvPrnDbgeh, DB, DBClient,
  jsonClientDataSet, ImgList, GridsEh, DBGridEh, NvDbgridEh, StdCtrls, ComCtrls,
  ToolWin, ExtCtrls, NovaCheckedComboBox, NovaComboBox, NovaEdit, NovaHelp,Generics.Collections,NovaPrint;

type
  TFrmPackDepartinvoices = class(TSimpleCRUDForm)
    Label1: TLabel;
    cbborg: TNovaCheckedComboBox;
    Label2: TLabel;
    dtpstartdate: TDateTimePicker;
    lbl2: TLabel;
    dtpenddate: TDateTimePicker;
    lbl3: TLabel;
    nvhlpschedule: TNovaHelp;
    lbl4: TLabel;
    cbbstatus: TNovaComboBox;
    chkiscomputeno: TCheckBox;
    chknotcomputeno: TCheckBox;
    Label7: TLabel;
    NovaHelpUnit: TNovaHelp;
    lbl1: TLabel;
    nvhlpcode: TNovaHelp;
    lbl5: TLabel;
    edtdepartinvoicesno: TNovaEdit;
    nvhlproute: TNovaHelp;
    lblroute: TLabel;
    jcdsResultCancel: TjsonClientDataSet;
    jcdsQryPackItems: TjsonClientDataSet;
    jcdsUpdatepack: TjsonClientDataSet;
    procedure FormCreate(Sender: TObject);
    procedure tbtnFilterClick(Sender: TObject);
    procedure tbtnDeleteClick(Sender: TObject);
    procedure tbtnEditClick(Sender: TObject);
    procedure tbtnInsertClick(Sender: TObject);
    procedure tbtnSaveClick(Sender: TObject);
  private
    { Private declarations }
    log : String;
    isAuthority,isinday,isprintbynewticketno:Boolean;
    billPackPrint: TNovaPrint;
    printPackValue: TDictionary<String, String>; // 输出单变量
    multiplePacklist: TList < TDictionary < String, String >> ; // 输出数据集
    multiplePackValueValue: TDictionary<String, String>;
    procedure PrintClink(scheduleid: int64;singbillno:string);
    procedure refreshBill; // 刷新票号
  public
    { Public declarations }
    procedure HandleAuthority(const Key:TGUID;aEnable:Boolean);override;
  end;

var
  FrmPackDepartinvoices: TFrmPackDepartinvoices;

implementation
uses Services, PubFn,UFrmPackDepartinvoicesDetail,UFrmPackDepartinvoicesEdit,UFrmpackreprint;
{$R *.dfm}

procedure TFrmPackDepartinvoices.FormCreate(Sender: TObject);
begin
  inherited;
  dtpstartdate.datetime := now();
  dtpenddate.datetime := now();

  cbborg.Active := False;
  cbborg.Active := True;

  cbbstatus.Active := false;
  cbbstatus.Active := true;
end;

procedure TFrmPackDepartinvoices.tbtnDeleteClick(Sender: TObject);
var nResult : LongWord;
    sResult, invoicesid : string;
begin
  inherited;
  if not dsResult.DataSet.Active then
    Exit;
  if dsResult.DataSet.RecordCount < 0 then
    Exit;
  if jcdsResult.FieldByName('status').Value = '2' then
  begin
    SysDialogs.Warning('该结算单已经结算，不能注销！');
    Exit;
  end;
  if jcdsResult.FieldByName('status').Value = '1' then
  begin
    SysDialogs.Warning('该记录已经是注销状态！');
    Exit;
  end;

  if (not isAuthority) and (SysInfo.LoginUserInfo.UserName<>jcdsResult.FieldByName('printname').Value) then
  begin
    SysDialogs.Warning('不能注销其他人的结算单！');
    Exit;
  end;
  if not isinday then
  begin
     if jcdsResult.FieldByName('departdate').AsDateTime<Trunc(Now()) then
     begin
       SysDialogs.Warning('你没有权限注销隔日结算单！');
       Exit;
     end;
  end;
  if not SysDialogs.Confirm('信息提示', '确认要注销该记录吗？') then
    exit;
  with jcdsResultCancel do
  begin
    Close;
    invoicesid := jcdsResult.FieldByName('id').AsString;
    Params.ParamValues['departinvoices.id'] := invoicesid;
    Params.ParamValues['departinvoices.scheduleplanid'] := jcdsResult.FieldByName('scheduleplanid').Value;
    Params.ParamValues['departinvoices.cancelby'] := SysInfo.LoginUserInfo.UserID;
    Params.ParamValues['departinvoices.cancelstationid'] := SysInfo.LoginUserInfo.StationID;
    try
      Execute;
      nResult := Params.ParamByName('flag').Value;
      sResult := Params.ParamByName('msg').Value;
      SysDialogs.ShowMessage(sResult);
      if (nResult = 1) then
      begin
        log := '注销行包结算单：发车日期='+jcdsResult.FieldByName('departdate').AsString+
        ',线路=' + jcdsResult.FieldByName('routename').AsString+
        ',班次='+jcdsResult.FieldByName('schedulename').AsString + ',单号='+
        jcdsResult.FieldByName('departinvoicesno').AsString + ',受理件数='+
        jcdsResult.FieldByName('pieces').AsString;
        SysLog.WriteLog('行包管理->行包结算单管理','注销结算单',log);
        tbtnFilterClick(Sender);
        jcdsResult.Locate('id', invoicesid, []);
      end;
    except
      on E: Exception do
      begin
        SysLog.WriteErr('行包结算单管理信息注销失败：' + E.Message);
      end;
    end;
  end;
end;

procedure TFrmPackDepartinvoices.tbtnEditClick(Sender: TObject);
begin
  inherited;
  if(not jcdsResult.Active) or(jcdsResult.RecordCount=0) then
    exit;

  FrmPackDepartinvoicesDetail := TFrmPackDepartinvoicesDetail.Create(self);
  with FrmPackDepartinvoicesDetail do
  begin
    departinvoicesid := jcdsResult.FieldByName('id').AsLargeInt;
    SysMainForm.showFormModal(FrmPackDepartinvoicesDetail);
    tbtnFilterClick(self);
  end;

end;

procedure TFrmPackDepartinvoices.tbtnFilterClick(Sender: TObject);
begin
  inherited;
    if FormatDateTime('yyyy-mm-dd', dtpstartdate.Date) > FormatDateTime('yyyy-mm-dd',
    dtpenddate.Date) then
  begin
    SysDialogs.ShowMessage('开始日期不能大于结束日期！');
    exit;
  end;
  if StrToInt(getParametervalue('0007', Sysinfo.LoginUserInfo.OrgID))
      <= trunc(dtpenddate.Date-dtpstartdate.Date)
    then
  begin
      SysDialogs.Warning('选择日期的天数差超过系统设置的最大可查询天数,请重新选择');
    exit;
  end;
  if ((Trim(nvhlproute.Text) = '') and (Trim(nvhlpschedule.Text) = '') and
      (Trim(nvhlpcode.Text) = '') and (Trim(NovaHelpUnit.Text)= '') and
      (Trim(edtdepartinvoicesno.Text) = '') )
  and (Trunc(dtpenddate.Date-dtpstartdate.Date) > 0) then
  begin
    SysDialogs.ShowMessage('在没有输入线路、班次、营运单位、营运车辆、单号的情况下，只能查询一天的数据！');
    Exit;
  end;
  with jcdsResult do
  begin
    Active := False;
    Params.ParamValues['filter_GED_t!departdate'] := FormatDateTime('yyyy-mm-dd', dtpstartdate.DateTime);
      Params.ParamValues['filter_LED_t!departdate'] := FormatDateTime('yyyy-mm-dd', dtpenddate.DateTime);
      if Trim(edtdepartinvoicesno.Text) = '' then
      begin
        Params.ParamValues['filter_LIKES_t!departinvoicesno'] := '';
      end else
      begin
        Params.ParamValues['filter_LIKES_t!departinvoicesno'] := edtdepartinvoicesno.Text;
      end;
    Params.ParamValues['filter_INS_t!printorgid'] := cbborg.GetSelectID;

    if (((nvhlproute.Text)<>'') and (nvhlproute.Id>0)) then
       Params.ParamValues['filter_EQL_ro!id'] := nvhlproute.Id
      else
       Params.ParamValues['filter_EQL_ro!id'] := '';
      if (NovaHelpUnit.Text<>'') and (NovaHelpUnit.Id>0) then
      begin
        Params.ParamValues['filter_EQL_unit!id'] := NovaHelpUnit.Id;
      end
      else
      begin
        Params.ParamValues['filter_EQL_unit!id'] := null;
      end;

      if Trim(nvhlpschedule.Text) = '' then
      begin
        Params.ParamValues['filter_EQL_t!scheduleid'] := '';
      end else
      begin
        Params.ParamValues['filter_EQL_t!scheduleid'] := nvhlpschedule.Id;
      end;
      if Trim(nvhlpcode.Text) = '' then
      begin
        Params.ParamValues['filter_EQL_t!vehicleid'] := '';
      end else
      begin
        Params.ParamValues['filter_EQL_t!vehicleid'] := nvhlpcode.Id;
      end;
      if Trim(cbbstatus.Text) = '' then
      begin
        Params.ParamValues['filter_EQS_t!status'] := '';
      end else
      begin
        Params.ParamValues['filter_EQS_t!status'] := TCommInfo(cbbstatus.Items.Objects[cbbstatus.ItemIndex]).Value;
      end;

      if chkiscomputeno.Checked and chknotcomputeno.Checked then
    begin
      Params.ParamValues['filter_EQS_t!datatype'] := '';
    end
    else if chkiscomputeno.Checked then
    begin
      Params.ParamValues['filter_EQS_t!datatype'] := '0';
    end
    else if chknotcomputeno.Checked then
    begin
      Params.ParamValues['filter_EQS_t!datatype'] := '1';
    end
    else
    begin
      Params.ParamValues['filter_EQS_t!datatype'] := '';
    end;

    Active := True;
  end;
end;

procedure TFrmPackDepartinvoices.tbtnInsertClick(Sender: TObject);
var invoicesid, nResult : LongWord;
    sResult, temp : string;
    curid:Int64;
begin
  inherited;
   if not dsResult.DataSet.Active then
    exit;
  if dsResult.DataSet.RecordCount < 1 then
    exit;
  if jcdsResult.FieldByName('status').Value = '2' then
  begin
    SysDialogs.ShowMessage('该结算单已经结算，不能补开！');
    Exit;
  end;

  with FrmPackDepartinvoicesEdit do
  begin
    FrmPackDepartinvoicesEdit := TFrmPackDepartinvoicesEdit.Create(Self);
    Caption := '补开结算单';
    sign := true;
    invoicesid := jcdsResult.FieldByName('id').AsInteger;
    departinvoicesid := jcdsResult.FieldByName('id').AsLargeInt;
    scheduleplanid := jcdsResult.FieldByName('scheduleplanid').AsString;
    scheduleid := jcdsResult.FieldByName('scheduleid').AsString;
    departdate := jcdsResult.FieldByName('departdate').AsString;
    reportvehicleid := jcdsResult.FieldByName('reportid').AsString;
    vehicleid := jcdsResult.FieldByName('vehicleid').AsLargeInt;

    departtime:= jcdsResult.FieldByName('departtime').AsString;

    edtstartdate.Text:= jcdsResult.FieldByName('departdate').AsString;
    edtvehicletype.Text:= jcdsResult.FieldByName('vehicletypename').AsString;
    edtstartstation.Text:= jcdsResult.FieldByName('startstationname').AsString;
    edtendstation.Text:= jcdsResult.FieldByName('endstationname').AsString;
    edtunit.Text:= jcdsResult.FieldByName('unitname').AsString;
    edtplanvehicle.Text := jcdsResult.FieldByName('reportname').AsString;
    edtschedule.Text := jcdsResult.FieldByName('schedulename').AsString;
    edtstarttime.Text:= jcdsResult.FieldByName('departtime').AsString;

    if jcdsResult.FieldByName('status').Value = '0' then
    begin
      isdepartinvoices := '0';
    end else
    begin
      isdepartinvoices := '';
    end;
    if SysMainForm.showFormModal(FrmPackDepartinvoicesEdit, false) = mrok then
    begin
        curid:=departinvoicesid;
        tbtnFilterClick(Self);
        jcdsResult.Locate('id', curid, []);
    end;
  end;

end;

procedure TFrmPackDepartinvoices.tbtnSaveClick(Sender: TObject);
begin
  inherited;
  if not dsResult.DataSet.Active then
    exit;
  if dsResult.DataSet.RecordCount < 1 then
    exit;
  if jcdsResult.FieldByName('status').Value = '2' then
  begin
    SysDialogs.ShowMessage('该结算单已经结算，不能重打！');
    Exit;
  end;
  if not SysDialogs.Confirm('提示信息', '确认进行重打操作？') then
  begin
    exit;
  end;

  Frmpackreprint := TFrmpackreprint.Create(self);
  try
  with Frmpackreprint do
  begin
    if SysMainForm.showFormModal(Frmpackreprint, false) = mrok then
    begin
      if isprintbynewbillno=1 then
      begin
          isprintbynewticketno:=false;
      end
      else if isprintbynewbillno=2 then
      begin
          isprintbynewticketno:=true;
      end
      else
      begin
           exit;
      end;
    end;
  end;
  finally
    FreeAndNil(Frmpackreprint);
  end;

  PrintClink(jcdsResult.FieldByName('scheduleid').AsLargeInt,jcdsResult.FieldByName('departinvoicesno').AsString);

end;

procedure TFrmPackDepartinvoices.HandleAuthority(const Key: TGUID;
  aEnable: Boolean);
begin
  inherited;
  if GUIDToString(key)='{7D5B1824-8BC3-4778-87AF-59A306085AC5}' then
  begin
    isAuthority:=aEnable;
  end ;
  //注销隔日结算单
  if GUIDToString(key)='{BB6C77F4-22F6-4F0D-B263-C3222F2241CC}' then
  begin
    isinday:=aEnable;
  end ;
  if GUIDToString(key)='{BBCEFA4E-B7E8-4191-843C-A24FA9B00A02}' then
  begin
    tbtnEdit.Visible:=aEnable;
  end ;


end;

procedure TFrmPackDepartinvoices.PrintClink(scheduleid: int64;singbillno:string);
var
  piecesnums: integer;
  totalfeemoney,balancetotalfeemoney: double;
  sendstationname: string;
begin
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

      Params.ParamValues['startdate'] := jcdsResult.FieldByName('departdate').AsString;
      Params.ParamValues['enddate'] := jcdsResult.FieldByName('departdate').AsString;

      Params.ParamValues['scheduleid'] := scheduleid;

      Params.ParamValues['isbukai'] := '0'; //不是补开

      Params.ParamValues['filter_GED_ss!departdate'] := jcdsResult.FieldByName('departdate').AsString;
      Params.ParamValues['filter_LED_ss!departdate'] := jcdsResult.FieldByName('departdate').AsString;
      Params.ParamValues['filter_EQL_ss!departstationid'] :=
        Sysinfo.LoginUserInfo.StationID;
      Params.ParamValues['filter_INS_ss!status'] := '(0,2,4,5)';

      Params.ParamValues['filter_EQL_sd!id'] := scheduleid;

      if isprintbynewticketno then //新号重打
      begin
         Params.ParamValues['isreprint'] := '1';  //新结算单号
          Params.ParamValues['departinvoicesno'] :=
        Sysinfo.LoginUserInfo.curBillNo.Items['BalanceBill'];
      end
      else
      begin
         Params.ParamValues['isreprint'] := '2'; //原结算单号
         Params.ParamValues['departinvoicesno'] := singbillno;
      end;


      Active := true;

      if RecordCount < 1 then
      begin
        //SysDialogs.ShowMessage('该班次没有行包签发!')
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

      if isprintbynewticketno then     //新号重打
      begin
        printPackValue.Add('singbillno',
          Sysinfo.LoginUserInfo.curBillNo.Items['BalanceBill']);

        with jcdsUpdatepack do
        begin

          Active := false;

          Params.ParamValues['filter_GED_p!departdate'] := jcdsResult.FieldByName('departdate').AsString;
          Params.ParamValues['filter_LED_p!departdate'] := jcdsResult.FieldByName('departdate').AsString;
          Params.ParamValues['filter_EQS_p!status'] := '1';

          Params.ParamValues['filter_EQL_p!scheduleid'] := scheduleid;

          Params.ParamValues['singbillno'] :=
            Sysinfo.LoginUserInfo.curBillNo.Items['BalanceBill'];

          Execute;

        end;

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
        printPackValue.Add('singbillno',singbillno); // 原号重打
      end;

      printPackValue.Add('fillopen','重打');
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

  finally

  end;
end;

procedure TFrmPackDepartinvoices.refreshBill;
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
