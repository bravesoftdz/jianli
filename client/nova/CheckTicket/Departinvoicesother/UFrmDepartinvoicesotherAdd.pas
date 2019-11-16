unit UFrmDepartinvoicesotherAdd;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, USimpleEditForm, ImgList, StdCtrls, Buttons, ExtCtrls, ComCtrls,
  NovaEdit, NovaHelp, NovaHComboBox, DBGridEhGrouping, GridsEh, DBGridEh,
  NvDbgridEh, NovaComboBox, ToolWin, DB, DBClient, jsonClientDataSet, Services,
  UDMPublic, PubFn, NvPrnDbgeh, SeatPlan, UICcardRW,
  Generics.Collections, FunctionItemIntf, NovaPrint,
  NovaCheckedComboBox, Menus, MMSystem, UIDCardReader;

type
  TFrmDepartinvoicesotherAdd = class(TSimpleEditForm)
    lbl2: TLabel;
    Label3: TLabel;
    lbl8: TLabel;
    lbl1: TLabel;
    lbl3: TLabel;
    lbl6: TLabel;
    lbl5: TLabel;
    lbl7: TLabel;
    lbldriver2id: TLabel;
    nvhlpvehicle: TNovaHelp;
    nvhlpschedule: TNovaHelp;
    edtDepartinvoicesno: TNovaEdit;
    nvhlpdepartstation: TNovaHelp;
    dtpdepartdate: TDateTimePicker;
    cbbdriver1id: TNovaHelp;
    cbbdriver2id: TNovaHelp;
    cbbsteward1id: TNovaHelp;
    grp1: TGroupBox;
    nvdbgrdhdbgrdh1: TNvDbgridEh;
    mmo: TMemo;
    tlb1: TToolBar;
    btnInsertDep: TToolButton;
    btnUpdateDep: TToolButton;
    btn1: TToolButton;
    btndelDep: TToolButton;
    Label1: TLabel;
    nvhlpreachstation: TNovaHelp;
    lbl4: TLabel;
    Label6: TLabel;
    Label8: TLabel;
    Label10: TLabel;
    Label12: TLabel;
    edttotalmoney: TNovaEdit;
    NvEdtTicketnum: TNovaEdit;
    NovaEbalancemoney: TNovaEdit;
    NovaEstationfee: TNovaEdit;
    NovaEagentfee: TNovaEdit;
    Label4: TLabel;
    cbbtickettype: TNovaHComboBox;
    lbl11: TLabel;
    Label11: TLabel;
    nvhlptime: TNovaEdit;
    GroupBox2: TGroupBox;
    NvDbgridEh1: TNvDbgridEh;
    jcsdQryRoutePrice: TjsonClientDataSet;
    DataSource1: TDataSource;
    jcdsResultSavedepartinvoicesother: TjsonClientDataSet;
    jcdsQrydepartinvoicesotherdetail: TjsonClientDataSet;
    DataSource2: TDataSource;
    jsonDelDepartinvoicesotherdetail: TjsonClientDataSet;
    jcdsQryrouteid: TjsonClientDataSet;
    Label2: TLabel;
    nvedtbalanceprice: TNovaEdit;
    Label14: TLabel;
    Label15: TLabel;
    Label17: TLabel;
    Label5: TLabel;
    nvhelpunit: TNovaHelp;
    Label18: TLabel;
    cbbvehicletype: TNovaComboBox;
    jcdsQryvehicleid: TjsonClientDataSet;
    bbtnClear: TBitBtn;
    Label7: TLabel;
    rgreturntrip: TComboBox;
    ToolButton1: TToolButton;
    NovaCobDataFrom: TNovaComboBox;
    Label9: TLabel;
    Label13: TLabel;
    Label16: TLabel;
    NovaEagentfeePercent: TNovaEdit;
    Label21: TLabel;
    nvhlpseller: TNovaHelp;
    Label20: TLabel;
    nvhcbbOrg: TNovaHComboBox;
    lblOrgid: TLabel;
    chkdno: TCheckBox;
    Label19: TLabel;
    Label22: TLabel;
    Label23: TLabel;
    Label24: TLabel;
    nvhlp1: TNovaHelp;
    btn2: TToolButton;
    jsonClientDataSet: TjsonClientDataSet;
    jsnclntcheckinvoiceno: TjsonClientDataSet;
    jsnclntResult: TjsonClientDataSet;
    lbl9: TLabel;
    NovaEdtOtherFee: TNovaEdit;
    jcdsqryUnit: TjsonClientDataSet;
    procedure edtticketpriceChange(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure nvhlpscheduleExit(Sender: TObject);
    procedure jcsdQryRoutePriceAfterScroll(DataSet: TDataSet);
    procedure btnInsertDepClick(Sender: TObject);
    procedure bbtnSaveClick(Sender: TObject);
    procedure nvdbgrdhdbgrdh1DblClick(Sender: TObject);
    procedure btndelDepClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure dtpdepartdateChange(Sender: TObject);
    procedure nvedtbalancepriceChange(Sender: TObject);
    procedure NvDbgridEh1DblClick(Sender: TObject);
    procedure bbtnClearClick(Sender: TObject);
    procedure btnUpdateDepClick(Sender: TObject);
    procedure ToolButton1Click(Sender: TObject);
    procedure FormKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure nvhlpscheduleIdChange(Sender: TObject);
    procedure NovaEagentfeePercentChange(Sender: TObject);
    procedure NovaEstationfeeChange(Sender: TObject);
    procedure NovaEbalancemoneyChange(Sender: TObject);
    procedure NvEdtTicketnumChange(Sender: TObject);
    procedure edttotalmoneyChange(Sender: TObject);
    procedure NovaCobDataFromChange(Sender: TObject);
    procedure nvhlpvehicleIdChange(Sender: TObject);
    procedure btn2Click(Sender: TObject);
    function edtDepartinvoicesnoMouseLeave(Sender: TObject):Boolean;

  private
    { Private declarations }
    log: String;
    billPinter: TNovaPrint;
    printValue: TDictionary<String, String>; // 输出单变量
    multiplelist: TList < TDictionary < String, String >> ; // 输出数据集
  public
    { Public declarations }
    createby, detailcreateby, detailcreatetime, createtime, orgid, gotoway,
      departway, departdate, vehicleno, departno, departstation, driver1,
      driver2, driver3, driver4, steward1, steward2, departinvoicesno,
      departtime, reachestation, tickettype, templtename: string;
    departinvoicesotherid, driver1id, driver2id, departinvoicesotherdetailid,
      id, departstationid, driver4id, steward1id, steward2id,
      scheduleid: Int64;
    cbbtickettypeid, price, ticketnum, stationfee, agentfee, balancefee: string;
    sign: Boolean;
    p3068 : string;//3068:手工结算单是否进行自动结算扣费  0否，1是
  end;

var
  FrmDepartinvoicesotherAdd: TFrmDepartinvoicesotherAdd;

implementation

{$R *.dfm}

procedure TFrmDepartinvoicesotherAdd.bbtnClearClick(Sender: TObject);
begin
  inherited;

  departinvoicesotherid := 0;
  departinvoicesotherdetailid := 0;
  nvhlpschedule.Text := '';
  nvhlpvehicle.Text := '';
  nvhlptime.Text := '';
  // 单号自增
  if chkdno.Checked then // 自增
  begin
    edtDepartinvoicesno.Text := inttostr
      (StrToInt(edtDepartinvoicesno.Text) + 1);
  end
  else // 手写
  begin
    edtDepartinvoicesno.Text := '';
  end;
  // edtDepartinvoicesno.Text := '';
  nvhelpunit.Text := '';
  nvhlp1.text :='';
  cbbvehicletype.Text := '';
  NovaEagentfee.Text := '0';
  NvEdtTicketnum.Text := '0';
  NovaEstationfee.Text := '0';
  nvedtbalanceprice.Text := '0';
  NovaEbalancemoney.Text := '0';
  edttotalmoney.Text := '0';
  nvhlpdepartstation.Text := '';
  nvhlpreachstation.Text := '';
  cbbdriver1id.Text := '';
  cbbdriver2id.Text := '';
  cbbsteward1id.Text := '';

  with jcsdQryRoutePrice do
  begin
    Active := false;
    Params.ParamValues['routeid'] := 0;
    Params.ParamValues['scheduleid'] := 0;
    Active := True;
  end;

  with jcdsQrydepartinvoicesotherdetail do
  begin
    Active := false;
    Params.ParamValues['filter_EQL_t!departinvoicesotherid'] := 0;
    Active := True;
  end;
  nvhlpvehicle.SetFocus;
end;

procedure TFrmDepartinvoicesotherAdd.bbtnSaveClick(Sender: TObject);
begin
  inherited;
  ModalResult := mrok;
end;

procedure TFrmDepartinvoicesotherAdd.btn2Click(Sender: TObject);
var
  multipleValueValue: TDictionary<String, String>;
  totledistance: Double;
begin
  inherited;
  if not jcdsQrydepartinvoicesotherdetail.Active then
    exit;
  if jcdsQrydepartinvoicesotherdetail.RecordCount = 0 then
    exit;

  if templtename = '' then
    templtename := TNovaPrint.GetTicketModelName('结算单', '默认结算单');
  if not Assigned(billPinter) then
    billPinter := TNovaPrint.Create(self, templtename);
  if not Assigned(printValue) then
    printValue := TDictionary<String, String>.Create
  else
    printValue.Clear;
  try

    with jsnclntResult do
    begin
      Active := false;
      Params.ParamValues['filter_EQL_d!id'] := departinvoicesotherid;
      Active := True;
      printValue.Add('agentfee', fieldbyname('agentfee').AsString);
      printValue.Add('balanceamount', fieldbyname('balancemoney').AsString);
      printValue.Add('uuname', fieldbyname('unname').AsString);
      printValue.Add('ufname', fieldbyname('unfullname').AsString);
      printValue.Add('departdate', fieldbyname('departdate').AsString);
      printValue.Add('departtime', fieldbyname('departtime').AsString);
      printValue.Add('driver1', fieldbyname('d1name').AsString);
      printValue.Add('driver2', fieldbyname('d2name').AsString);
      printValue.Add('stewardname', fieldbyname('ste1name').AsString);
      printValue.Add('usiname', fieldbyname('seller').AsString);
      printValue.Add('reachstation', fieldbyname('reachstationname').AsString);
      printValue.Add('endstation', fieldbyname('reachstationname').AsString);
      printValue.Add('fullpeople', fieldbyname('ticketnum').AsString);
      printValue.Add('ticketnum', fieldbyname('ticketnum').AsString);
      printValue.Add('invoicesno', fieldbyname('departinvoicesno').AsString);
      printValue.Add('printby', SysInfo.LoginUserInfo.UserName);
      printValue.Add('printtime', FormatDateTime('yyyy-mm-dd HH:mm:ss', now));
      printValue.Add('printstation', SysInfo.LoginUserInfo.stationName);
      printValue.Add('routename', fieldbyname('routename').AsString);
      printValue.Add('distance', fieldbyname('distance').AsString);
      printValue.Add('vehicleno', fieldbyname('vehiclename').AsString);
      printValue.Add('planseatnum', fieldbyname('seatnum').AsString);
      printValue.Add('stationservicefee', fieldbyname('stationfee').AsString);
      printValue.Add('ticketoutlet', SysInfo.LoginUserInfo.ticketoutletsname);
      printValue.Add('balanceunit', fieldbyname('balanceunitname').AsString);
      printValue.Add('totalamount', fieldbyname('totalmoney').AsString);
      printValue.Add('schedulecode', fieldbyname('schedulecode').AsString);
      printValue.Add('unit', fieldbyname('unitname').AsString);
      printValue.Add('balanceunitfullname',
        fieldbyname('balanceunitname').AsString);
      printValue.Add('vtname', fieldbyname('vehicletypename').AsString);
      billPinter.SingleValue := printValue;
    end;

    if not Assigned(multiplelist) then
      multiplelist := TList < TDictionary < String, String >> .Create
    else
      multiplelist.Clear;
    with jcdsQrydepartinvoicesotherdetail do
    begin
      Active := false;
      Params.ParamValues['filter_EQL_t!departinvoicesotherid'] :=
        departinvoicesotherid;
      Active := True;
      first;
      if RecordCount > 0 then
      begin
        while (not Eof) do
        begin

          multipleValueValue := TDictionary<String, String>.Create;
          multipleValueValue.Add('fromstation',
            fieldbyname('fromstationname').AsString);
          multipleValueValue.Add('reachstation',
            fieldbyname('reachstationname').AsString);
          multipleValueValue.Add('price', fieldbyname('price').AsString);
          multipleValueValue.Add('distance', fieldbyname('distance').AsString);
          multipleValueValue.Add('totalamount',
            fieldbyname('totalamount').AsString);
          multipleValueValue.Add('balanceprice',
            fieldbyname('balanceprice').AsString);
          multipleValueValue.Add('balanceamount',
            fieldbyname('balanceamount').AsString);
          // multipleValueValue.Add('noservicestationfee', FieldByName('noservicestationfee').AsString);
          // multipleValueValue.Add('noservicestationfee',
          // FloatToStr((FieldByName('noservicestationfee').AsFloat)/(FieldByName('fullpeople').AsInteger)));  //新增只扣除站务费的结算单价，按到达站分组
          multipleValueValue.Add('noagentbalanceamount',
            fieldbyname('balanceamount').AsString);
          multipleValueValue.Add('fullpeople',
            fieldbyname('qticketnum').AsString);
          multipleValueValue.Add('halfpeople',
            fieldbyname('bticketnum').AsString);
          multipleValueValue.Add('psdistance',
            fieldbyname('totaldistance').AsString);
          totledistance := totledistance + fieldbyname('totaldistance').AsFloat;
          multiplelist.Add(multipleValueValue);
          Next;
        end;

      end;
    end;
    if totledistance > 0 then
      printValue.Add('totalpsdistance', FloatToStr(totledistance));
    billPinter.SingleValue := printValue;
    billPinter.MultipleValue := multiplelist;
    billPinter.Print;
  except
    on E: Exception do
    begin
      SysLog.WriteErr('结算单补录重打失败：' + E.Message);
    end;
  end;
end;

procedure TFrmDepartinvoicesotherAdd.btndelDepClick(Sender: TObject);
var
  nResult: LongWord;
  sResult, log: string;
begin
  inherited;
  if not jcdsQrydepartinvoicesotherdetail.Active then
    exit;
  if jcdsQrydepartinvoicesotherdetail.RecordCount <= 0 then
    exit;
  if not SysDialogs.Confirm('信息提示', '确认要删除该记录吗!') then
    exit;
  with jsonDelDepartinvoicesotherdetail do
    try
      close;
      Params.ParamByName('departinvoicesotherdetail.id').Value :=
        jcdsQrydepartinvoicesotherdetail.fieldbyname('id').AsInteger;
      Execute;
      nResult := Params.ParamByName('flag').Value;
      sResult := Params.ParamByName('msg').Value;
      SysDialogs.showmessage(sResult);
      if (nResult = 1) then
      begin
        log := '删除[单号]:' + jcdsQrydepartinvoicesotherdetail.fieldbyname
          ('departinvoicesno').AsString + ',[发车时间]' +
          jcdsQrydepartinvoicesotherdetail.fieldbyname('departdate')
          .AsString + ':' + jcdsQrydepartinvoicesotherdetail.fieldbyname
          ('departtime').AsString + ',[上车站]' +
          jcdsQrydepartinvoicesotherdetail.
          fieldbyname('fromstationname').AsString + ',[到达站]' +
          jcdsQrydepartinvoicesotherdetail.fieldbyname('reachstationname')
          .AsString;
        SysLog.WriteLog('检票管理->结算单补录', '删除补录明细', log);
        with jcdsQrydepartinvoicesotherdetail do
        begin
          Active := false;
          Params.ParamValues['filter_EQL_t!departinvoicesotherid'] :=
            departinvoicesotherid;
          Active := True;
        end;
      end;
    except
      on E: Exception do
      begin
        SysLog.WriteErr('结算单补录明细信息删除失败：' + E.Message);
      end;
    end;
end;

procedure TFrmDepartinvoicesotherAdd.btnInsertDepClick(Sender: TObject);
var
  nResult: Integer;
  balanceunitid: Int64;
  sResult, log, optype: string;
begin
  inherited;
  if nvhlpvehicle.id = 0 then
  begin
    SysDialogs.Warning('请输入车牌号！');
    nvhlpvehicle.SetFocus;
    exit;
  end;
  if Trim(edtDepartinvoicesno.Text) = '' then
  begin
    SysDialogs.Warning('请输入单号');
    edtDepartinvoicesno.SetFocus;
    exit;
  end;
  try
    if  edtDepartinvoicesnoMouseLeave(Self) then
    begin
      Exit;
    end;
  except
    on E: Exception do

  end;
  if (Trim(nvhlpschedule.Text) = '') or (nvhlpschedule.id = 0) then
  begin
    SysDialogs.Warning('请输入班次号');
    nvhlpschedule.SetFocus;
    exit;
  end;
  if Trim(nvhlptime.Text) = '' then
  begin
    SysDialogs.Warning('请输入发车时间');
    nvhlptime.SetFocus;
    exit;
  end;
  if (StrToInt(NvEdtTicketnum.Text) = 0) and
    (NovaCobDataFrom.GetSelectValue <> '货物') and
    (NovaCobDataFrom.GetSelectValue <> '包车') then
  begin
    SysDialogs.Warning('请输入人数');
    NvEdtTicketnum.SetFocus;
    exit;
  end;
  if nvhlpdepartstation.id = 0 then
  begin
    SysDialogs.Warning('请输入发车站');
    nvhlpdepartstation.SetFocus;
    exit;
  end;

  if nvhlpreachstation.id = 0 then
  begin
    SysDialogs.Warning('请输入到达站');
    nvhlpreachstation.SetFocus;
    exit;
  end;

  if cbbdriver1id.id > 0 then
  begin
    driver1id := cbbdriver1id.id
  end;
  if cbbdriver2id.id > 0 then
  begin
    driver2id := cbbdriver2id.id;
  end;
  if cbbsteward1id.id > 0 then
  begin
    steward1id := cbbsteward1id.id;
  end;
  if nvhlpschedule.id > 0 then
  begin
    scheduleid := nvhlpschedule.id;
  end;
  if Trim(nvhlpschedule.Text) = '' then
  begin
    scheduleid := 0;
  end;

  if nvhlpdepartstation.id = nvhlpreachstation.id then
  begin
    SysDialogs.showmessage('上车站点与到达站不能相同！');
    nvhlpreachstation.SetFocus;
    exit;
  end;
  if cbbtickettype.ItemIndex < 0 then
    cbbtickettypeid := cbbtickettypeid
  else
    cbbtickettypeid := cbbtickettype.HelpFieldValue['id'];

  with jcdsResultSavedepartinvoicesother do
  begin
    close;
    if (nvhlpseller.Text <> '') and (nvhlpseller.Id > 0) then
    begin
      Params.ParamValues['departinvoicesother.seller'] := nvhlpseller.id;
    end
    else
    begin
      Params.ParamValues['departinvoicesother.seller'] := -1;//售票员如果为空，存为-1，避免不填时存为0异站用户
    end;
    Params.ParamValues['departinvoicesother.id'] := departinvoicesotherid;
    Params.ParamValues['departinvoicesother.orgid'] := nvhcbbOrg.HelpFieldValue
      ['id'];
    if createby='' then
       createby:=IntToStr(sysinfo.LoginUserInfo.UserID);

    Params.ParamValues['departinvoicesother.createby'] := createby;
    Params.ParamValues['departinvoicesother.createtime'] := createtime;
    Params.ParamValues['departinvoicesother.vehicleid'] := nvhlpvehicle.id;
    Params.ParamValues['departinvoicesother.departstationid'] :=
      nvhlpdepartstation.id;
    Params.ParamValues['departinvoicesother.departinvoicesno'] :=
      edtDepartinvoicesno.Text;
    Params.ParamValues['departinvoicesother.departdate'] := DateTimeToStr
      (dtpdepartdate.DateTime);
    Params.ParamValues['departinvoicesother.selfdepartdate'] := DateTimeToStr
      (dtpdepartdate.DateTime);
    Params.ParamValues['departinvoicesother.departtime'] := nvhlptime.Text;
    //

    Params.ParamValues['departinvoicesother.price'] := edttotalmoney.Text;
    Params.ParamValues['departinvoicesother.balanceprice'] := nvedtbalanceprice.Text;
    Params.ParamValues['departinvoicesother.othterfee'] := NovaEdtOtherFee.Text;
    Params.ParamValues['departinvoicesother.reachstationid'] := nvhlpreachstation.Id;
    Params.ParamValues['departinvoicesother.tickettypeid'] := cbbtickettypeid;
    Params.ParamValues['departinvoicesother.schedule.id'] := scheduleid;
    Params.ParamValues['departinvoicesother.driver1.id'] := driver1id;
    Params.ParamValues['departinvoicesother.driver2.id'] := driver2id;
    Params.ParamValues['departinvoicesother.steward1.id'] := steward1id;
    if rgreturntrip.ItemIndex = 1 then
    begin
      Params.ParamValues['departinvoicesother.isreturntrip'] := 'true';
    end
    else
    begin
      Params.ParamValues['departinvoicesother.isreturntrip'] := 'false';
    end;
    Params.ParamValues['departinvoicesother.departinvoicesotherdetailid'] := departinvoicesotherdetailid;

    Params.ParamValues['departinvoicesother.isoriginator'] := True;
    Params.ParamValues['departinvoicesother.datafrom'] :=
      NovaCobDataFrom.ItemIndex;
    Params.ParamValues['departinvoicesother.ticketnum'] := NvEdtTicketnum.Text;
    Params.ParamValues['departinvoicesother.totalmoney'] := strtofloat(edttotalmoney.Text)
      * strtoint(NvEdtTicketnum.Text) ;
    Params.ParamValues['departinvoicesother.agentfee'] := NovaEagentfee.Text;
    Params.ParamValues['departinvoicesother.balancemoney'] :=
      NovaEbalancemoney.Text;
    Params.ParamValues['departinvoicesother.stationfee'] :=
      NovaEstationfee.Text;
    if nvhlp1.Text = '' then
    begin
      Params.ParamValues['departinvoicesother.balanceunitid'] := nvhelpunit.id;
    end
    else
    begin
      balanceunitid := nvhlp1.id;
      Params.ParamByName('departinvoicesother.balanceunitid').Value :=
        balanceunitid;
    end;
    try
      Execute;
      nResult := Params.ParamByName('flag').Value;
      sResult := Params.ParamByName('msg').Value;
      if (nResult <= 0) then
      begin
        SysDialogs.ShowError(sResult);
        nvhlpvehicle.SetFocus;
      end
      else
      begin
        if departinvoicesotherid > 0 then
        begin
          optype := '修改结算单补录';
          log := '修改';
          if (gotoway = '去程') and (rgreturntrip.ItemIndex <> 0) then
            log := log + '[去程] 改成  [回程]';
          if (gotoway = '回程') and (rgreturntrip.ItemIndex = 0) then
            log := log + '[回程] 改成  [去程]';
          if departdate <> DateTimeToStr(dtpdepartdate.DateTime) then
            log := log + ',[发车日期] 由 ' + departdate + '改成' + DateTimeToStr
              (dtpdepartdate.DateTime);
          if vehicleno <> nvhlpvehicle.Text then
            log := log + ',[车牌] 由 ' + vehicleno + ' 改成 ' + nvhlpvehicle.Text;
          if departno <> edtDepartinvoicesno.Text then
            log := log + ',[运单号] 由 ' + departno + ' 改成 ' +
              edtDepartinvoicesno.Text;
          if departstation <> nvhlpdepartstation.Text then
            log := log + ',[发车站] 由' + departstation + ' 改成 ' +
              nvhlpdepartstation.Text;

        end
        else
        begin
          optype := '添加结算单补录';
          log := '添加';
          if rgreturntrip.ItemIndex = 0 then
          begin
            log := log + '[方向]=去程';
          end
          else
          begin
            log := log + '[方向]=回程';
          end;
          log := log + ',[车牌]=' + nvhlpvehicle.Text + ',[本站班次]=' +
            nvhlpschedule.Text + ',[单号]=' +
            edtDepartinvoicesno.Text + ',[发车站]=' + nvhlpdepartstation.Text +
            ',[异站发车日期]=' + FormatDateTime('yyyy-mm-dd', dtpdepartdate.Date)
            + ',[异站发车时间]=' + nvhlptime.Text + ',[本站发车时间]=' + nvhlptime.Text;
        end;
        SysLog.WriteLog('检票管理->结算单补录', optype, log);

        departinvoicesotherid := Params.ParamByName('id').Value;
      end;
    except
      on E: Exception do
      begin
        SysLog.WriteErr('结算单补录添加失败：' + E.Message);
      end;
    end;
  end;
  NovaEagentfee.Text := '0';
  NvEdtTicketnum.Text := '0';
  NovaEstationfee.Text := '0';
  nvedtbalanceprice.Text := '0';
  NovaEbalancemoney.Text := '0';
  edttotalmoney.Text := '0';
  NovaEdtOtherFee.Text:='0';
  nvhlpreachstation.Text := '';
  nvhlpreachstation.SetFocus;

  with jcdsQrydepartinvoicesotherdetail do
  begin
    Active := false;
    Params.ParamValues['filter_EQL_t!departinvoicesotherid'] :=
      departinvoicesotherid;
    Active := True;
  end;
end;

procedure TFrmDepartinvoicesotherAdd.btnUpdateDepClick(Sender: TObject);
begin
  inherited;
  bbtnClearClick(Sender);
end;

procedure TFrmDepartinvoicesotherAdd.dtpdepartdateChange(Sender: TObject);
begin
  inherited;
  nvhlpschedule.Params.ParamValues['departdate'] := FormatDateTime
    ('yyyy-mm-dd', dtpdepartdate.Date);
end;

function TFrmDepartinvoicesotherAdd.edtDepartinvoicesnoMouseLeave
  (Sender: TObject):Boolean;
var
  nResult: string;
begin
  inherited;
  if (edtDepartinvoicesno.Text <> '') and (departinvoicesotherid=0)  then
  begin
    with jsnclntcheckinvoiceno do
    begin
      Active := false;
      Params.ParamValues['departinvoiceno'] := edtDepartinvoicesno.Text;
      Active := True;
      nResult := jsnclntcheckinvoiceno.fieldbyname('isexist').AsString;
      if nResult <> '0' then
      begin
        SysDialogs.showmessage('结算单补录单号重复，请重新输入！');
        edtDepartinvoicesno.SetFocus;
        Result:=True;
        exit;
      end;
      Result:=False;
    end;
  end;
  Result:=False;
end;

procedure TFrmDepartinvoicesotherAdd.edtticketpriceChange(Sender: TObject);
begin
  inherited;
  // edtbalanceamount.Text := formatfloat('0.00',StrToFloat(edtticketprice.Text)*StrToInt(edtnum.Text)-
  // StrToFloat(edtstationservicefree.Text)-StrToFloat(edtotherfee.Text)-StrToFloat(edtagentfee.Text));
end;

procedure TFrmDepartinvoicesotherAdd.FormCreate(Sender: TObject);
begin
  inherited;
  dtpdepartdate.DateTime := now();
  cbbtickettype.Active := false;
  cbbtickettype.Active := True;
  cbbtickettype.ItemIndex := 0;
  NovaCobDataFrom.Active := false;
  NovaCobDataFrom.Active := True;
  NovaCobDataFrom.ItemIndex := 0;
  nvhcbbOrg.Active := false;
  nvhcbbOrg.Active := True;
  nvhcbbOrg.SetItemIndexByField('id', SysInfo.LoginUserInfo.orgid);
  nvhlpschedule.Params.ParamValues['departdate'] := FormatDateTime
    ('yyyy-mm-dd', dtpdepartdate.Date);
  if nvhlpdepartstation.Text = '' then
  begin
    nvhlpdepartstation.Text := SysInfo.LoginUserInfo.stationName;
    nvhlpdepartstation.id := SysInfo.LoginUserInfo.StationID;
  end;
end;

procedure TFrmDepartinvoicesotherAdd.FormKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;
  if (Key = vk_F1) then
  begin
    // Key := 0;
    btnInsertDepClick(Sender);
  end
  else if Key = VK_F2 then
  begin
    bbtnClearClick(Sender);
  end
  else if Key = VK_F3 then
  begin
    btndelDepClick(Sender);
  end
  else if Key = VK_F4 then
  begin
    ToolButton1Click(Sender);
  end;

end;

procedure TFrmDepartinvoicesotherAdd.FormShow(Sender: TObject);
var
  scheduleidforedit, routeidbyscheduleid: Int64;
begin
  inherited;
  //判断参数3068:手工结算单是否进行自动结算扣费  0否，1是
  if (p3068 = '1') then
  begin
    NovaEagentfee.Enabled := False;
    NovaEagentfeePercent.Enabled := False;
    NovaEstationfee.Enabled := False;
  end;

  if Trim(NovaCobDataFrom.Text) = '货物' then
  begin
    NvEdtTicketnum.Enabled := false;
  end
  else
  begin
    NvEdtTicketnum.Enabled := True;
  end;
  scheduleidforedit := nvhlpschedule.id;
  with jcdsQryrouteid do
  begin
    Active := false;
    Params.ParamValues['scheduleid'] := scheduleidforedit;
    Active := True;
    if RecordCount > 0 then
    begin
      routeidbyscheduleid := fieldbyname('routeid').AsLargeInt;
    end;
  end;

  with jcsdQryRoutePrice do
  begin
    Active := false;
    Params.ParamValues['routeid'] := routeidbyscheduleid;
    Params.ParamValues['scheduleid'] := scheduleidforedit;
    Params.ParamValues['departdate'] := DateTimeToStr(dtpdepartdate.DateTime);
    Active := True;
  end;

  if departinvoicesotherid > 0 then
  begin
    with jcdsQrydepartinvoicesotherdetail do
    begin
      Active := false;
      Params.ParamValues['filter_EQL_t!departinvoicesotherid'] :=
        departinvoicesotherid;
      Active := True;
      departinvoicesotherdetailid :=
        jcdsQrydepartinvoicesotherdetail.fieldbyname('id').AsLargeInt;
      detailcreateby := jcdsQrydepartinvoicesotherdetail.fieldbyname('createby')
        .AsString;

      detailcreatetime := jcdsQrydepartinvoicesotherdetail.fieldbyname
        ('createtime').AsString;
      nvhlpdepartstation.id := jcdsQrydepartinvoicesotherdetail.fieldbyname
        ('fromstationid').AsLargeInt;
      nvhlpdepartstation.Text := jcdsQrydepartinvoicesotherdetail.fieldbyname
        ('fromstationname').AsString;
      nvhlpreachstation.id := jcdsQrydepartinvoicesotherdetail.fieldbyname
        ('reachstationid').AsLargeInt;
      nvhlpreachstation.Text := jcdsQrydepartinvoicesotherdetail.fieldbyname
        ('reachstationname').AsString;
      NvEdtTicketnum.Text := jcdsQrydepartinvoicesotherdetail.fieldbyname
        ('ticketnum').AsString;
      edttotalmoney.Text := jcdsQrydepartinvoicesotherdetail.fieldbyname
        ('price').AsString;
      NovaEstationfee.Text := jcdsQrydepartinvoicesotherdetail.fieldbyname
        ('stationservicefee').AsString;
      NovaEagentfee.Text := jcdsQrydepartinvoicesotherdetail.fieldbyname
        ('agentfee').AsString;
      nvedtbalanceprice.Text := jcdsQrydepartinvoicesotherdetail.fieldbyname
        ('balanceprice').AsString;
      NovaEbalancemoney.Text := jcdsQrydepartinvoicesotherdetail.fieldbyname
        ('balanceamount').AsString;

    end;
  end;

  nvhlpvehicle.SetFocus;
end;

procedure TFrmDepartinvoicesotherAdd.jcsdQryRoutePriceAfterScroll
  (DataSet: TDataSet);
begin
  inherited;
  // nvhlpdepartstation.id := jcsdQryRoutePrice.FieldByName('fromstationid')
  // .AsLargeInt;
  // nvhlpdepartstation.Text := jcsdQryRoutePrice.FieldByName('fromstationname')
  // .AsString;
  // nvhlpreachstation.id := jcsdQryRoutePrice.FieldByName('reachstationid')
  // .AsLargeInt;
  // nvhlpreachstation.Text := jcsdQryRoutePrice.FieldByName('reachstationname')
  // .AsString;
  // edttotalmoney.Text := floattostr(jcsdQryRoutePrice.FieldByName('price')
  // .AsFloat);
end;

procedure TFrmDepartinvoicesotherAdd.NovaCobDataFromChange(Sender: TObject);
begin
  inherited;
  if Trim(NovaCobDataFrom.GetSelectValue) = '货物' then
  begin
    NvEdtTicketnum.Text := '0';
    NvEdtTicketnum.Enabled := false;
  end
  else
  begin
    NvEdtTicketnum.Enabled := True;
  end;
end;

procedure TFrmDepartinvoicesotherAdd.NovaEagentfeePercentChange
  (Sender: TObject);
begin
  inherited;
  if (Trim(NovaEagentfeePercent.Text) = '') or (Trim(NovaEagentfeePercent.Text) = '0') then
    exit;
  NovaEagentfee.Text := FormatCurr('0.00',
    StrToCurr(NovaEbalancemoney.Text) * StrToCurr(NovaEagentfeePercent.Text));
end;

procedure TFrmDepartinvoicesotherAdd.NovaEbalancemoneyChange(Sender: TObject);
begin
  inherited;
  NovaEagentfeePercentChange(nil);
end;

procedure TFrmDepartinvoicesotherAdd.NovaEstationfeeChange(Sender: TObject);
begin
  inherited;
  if (StrToCurr(edttotalmoney.Text) > 0) and
    (StrToCurr(NvEdtTicketnum.Text) > 0) then
  begin
    nvedtbalanceprice.Text := FormatCurr('0.00',
      StrToCurr(edttotalmoney.Text) -(StrToCurr(self.NovaEdtOtherFee.Text)
          / StrToCurr(NvEdtTicketnum.Text))- (StrToCurr(NovaEstationfee.Text)
          / StrToCurr(NvEdtTicketnum.Text)));
  end;
end;

procedure TFrmDepartinvoicesotherAdd.nvdbgrdhdbgrdh1DblClick(Sender: TObject);
begin
  inherited;
  if not jcdsQrydepartinvoicesotherdetail.Active then
    exit;
  if jcdsQrydepartinvoicesotherdetail.RecordCount <= 0 then
    exit;
  // Chbisoriginator.Checked:= jcdsQrydepartinvoicesotherdetail.FieldByName('isoriginator').AsBoolean;
  departinvoicesotherdetailid := jcdsQrydepartinvoicesotherdetail.fieldbyname
    ('id').AsLargeInt;
  nvhlpdepartstation.id := jcdsQrydepartinvoicesotherdetail.fieldbyname
    ('fromstationid').AsLargeInt;
  nvhlpdepartstation.Text := jcdsQrydepartinvoicesotherdetail.fieldbyname
    ('fromstationname').AsString;
  nvhlpreachstation.id := jcdsQrydepartinvoicesotherdetail.fieldbyname
    ('reachstationid').AsLargeInt;
  nvhlpreachstation.Text := jcdsQrydepartinvoicesotherdetail.fieldbyname
    ('reachstationname').AsString;
  edttotalmoney.Text := FloatToStr(jcdsQrydepartinvoicesotherdetail.fieldbyname
      ('price').AsFloat);

  nvedtbalanceprice.Text := FloatToStr
    (jcdsQrydepartinvoicesotherdetail.fieldbyname('balanceprice').AsFloat);
  NovaEstationfee.Text := FloatToStr
    (jcdsQrydepartinvoicesotherdetail.fieldbyname('stationservicefee')
      .AsFloat);
  NovaEagentfee.Text := FloatToStr(jcdsQrydepartinvoicesotherdetail.fieldbyname
      ('agentfee').AsFloat);

  NovaEdtOtherFee.Text := FloatToStr(jcdsQrydepartinvoicesotherdetail.fieldbyname
      ('othterfee').AsFloat);

  NovaEbalancemoney.Text := FloatToStr
    (jcdsQrydepartinvoicesotherdetail.fieldbyname('balanceamount').AsFloat);

  NvEdtTicketnum.Text := jcdsQrydepartinvoicesotherdetail.fieldbyname
    ('ticketnum').AsString;

  detailcreateby := jcdsQrydepartinvoicesotherdetail.fieldbyname('createby')
    .AsString;

  detailcreatetime := jcdsQrydepartinvoicesotherdetail.fieldbyname('createtime')
    .AsString;

end;

procedure TFrmDepartinvoicesotherAdd.NvDbgridEh1DblClick(Sender: TObject);
begin
  inherited;
  departinvoicesotherdetailid := 0;
  nvhlpdepartstation.id := jcsdQryRoutePrice.fieldbyname('fromstationid')
    .AsLargeInt;
  nvhlpdepartstation.Text := jcsdQryRoutePrice.fieldbyname('fromstationname')
    .AsString;
  nvhlpreachstation.id := jcsdQryRoutePrice.fieldbyname('reachstationid')
    .AsLargeInt;
  nvhlpreachstation.Text := jcsdQryRoutePrice.fieldbyname('reachstationname')
    .AsString;
  edttotalmoney.Text := FloatToStr(jcsdQryRoutePrice.fieldbyname('price')
      .AsFloat);
  NovaEagentfee.clear;
  NovaEstationfee.clear;
  NovaEdtOtherFee.clear;
end;

procedure TFrmDepartinvoicesotherAdd.nvedtbalancepriceChange(Sender: TObject);
begin
  inherited;
  if Trim(NvEdtTicketnum.Text) <> '' then
  begin
    // //结算票价 = 票价 - 站务费
    // nvedtbalanceprice.Text := floattostr
    // (StrToFloat(edttotalmoney.Text)-(StrToFloat(NovaEstationfee.Text)/StrToFloat(NvEdtTicketnum.Text)));
    // 结算金额 = 结算票价 * 人数
    NovaEbalancemoney.Text := FormatCurr('0.00',
      StrToCurr(nvedtbalanceprice.Text) * StrToCurr(NvEdtTicketnum.Text));
  end;
  if (StrToCurr(edttotalmoney.Text) > 0) and
    (StrToCurr(NvEdtTicketnum.Text) > 0) then
  begin
    nvedtbalanceprice.Text := FormatCurr('0.00',
      StrToCurr(edttotalmoney.Text) - (StrToCurr(NovaEstationfee.Text)
          / StrToCurr(NvEdtTicketnum.Text))-
          (StrToCurr(NovaEdtOtherFee.Text)
          / StrToCurr(NvEdtTicketnum.Text)));
    NovaEbalancemoney.Text := FormatCurr('0.00',
      StrToCurr(nvedtbalanceprice.Text) * StrToCurr(NvEdtTicketnum.Text));
  end
  else
  begin
    NovaEbalancemoney.Text := nvedtbalanceprice.Text;
  end;
end;

  procedure TFrmDepartinvoicesotherAdd.NvEdtTicketnumChange(Sender: TObject);
  begin
    inherited;
    if (StrToCurr(edttotalmoney.Text) > 0) and
      (StrToCurr(NvEdtTicketnum.Text) > 0) then
    begin
      if (StrToCurr(NovaEstationfee.Text) = 0) then
      begin
        nvedtbalanceprice.Text := CurrToStr(StrToCurr(edttotalmoney.Text));
        NovaEbalancemoney.Text := CurrToStr(StrToCurr(nvedtbalanceprice.Text)
            * StrToCurr(NvEdtTicketnum.Text));
      end
      else
      begin
        nvedtbalanceprice.Text := CurrToStr
          (StrToCurr(edttotalmoney.Text) - StrToCurr(NovaEstationfee.Text)
              / StrToCurr(NvEdtTicketnum.Text)
              -StrToCurr(self.NovaEdtOtherFee.Text)/ StrToCurr(NvEdtTicketnum.Text)
              );
        NovaEbalancemoney.Text := CurrToStr(StrToCurr(nvedtbalanceprice.Text)
            * StrToCurr(NvEdtTicketnum.Text));

      end;
    end
    else
    begin
      nvedtbalanceprice.Text := '0';
      NovaEbalancemoney.Text := '0';
    end;
  end;

  procedure TFrmDepartinvoicesotherAdd.edttotalmoneyChange(Sender: TObject);
  begin
    inherited;
    if Trim(NovaCobDataFrom.GetSelectValue) = '货物' then
    begin
      nvedtbalanceprice.Text := edttotalmoney.Text;
      NovaEbalancemoney.Text := edttotalmoney.Text;
    end
    else
    begin
      if (StrToCurr(edttotalmoney.Text) > 0) and
        (StrToCurr(NvEdtTicketnum.Text) > 0) then
      begin
        nvedtbalanceprice.Text := CurrToStr
          (StrToCurr(edttotalmoney.Text) - StrToCurr(NovaEstationfee.Text)
              / StrToCurr(NvEdtTicketnum.Text)
             - StrToCurr(NovaEdtOtherFee.Text)/ StrToCurr(NvEdtTicketnum.Text)
              );
      end
      else
      begin
        nvedtbalanceprice.Text := '0';
      end;
    end;
  end;

  procedure TFrmDepartinvoicesotherAdd.nvhlpscheduleExit(Sender: TObject);
  begin
    inherited;
    if Trim(nvhlpschedule.Text) = '' then
    begin

    end
    else
    begin
      nvhlptime.Text := nvhlpschedule.HelpFieldValue['departtime'];
      with jcsdQryRoutePrice do
      begin
        Active := false;
        Params.ParamValues['routeid'] := nvhlpschedule.HelpFieldValue
          ['routeid'];
        Params.ParamValues['scheduleid'] := nvhlpschedule.id;
        Active := True;
        nvhlpdepartstation.id := jcsdQryRoutePrice.fieldbyname('fromstationid')
          .AsLargeInt;
        nvhlpdepartstation.Text := jcsdQryRoutePrice.fieldbyname
          ('fromstationname').AsString;
      end;
      nvhlpvehicle.Text := nvhlpschedule.HelpFieldValue['vehicleno'];
      nvhlpvehicle.id := nvhlpschedule.HelpFieldValue['vehicleid'];
      with jcdsQryvehicleid do
      begin
        Active := false;
        Params.ParamValues['vehicleid'] := nvhlpvehicle.id;
        Active := True;
        nvhelpunit.id := jcdsQryvehicleid.fieldbyname('unitid').AsInteger;
        nvhelpunit.Text := jcdsQryvehicleid.fieldbyname('unitname').AsString;
        nvhelpunit.Enabled := false;
        cbbvehicletype.Text := jcdsQryvehicleid.fieldbyname('value').AsString;
        cbbvehicletype.SetItemIndexByCode(jcdsQryvehicleid.fieldbyname('type')
            .AsString);
        cbbvehicletype.Enabled := false;
      end;

    end;
    edtDepartinvoicesno.SetFocus;
  end;

  procedure TFrmDepartinvoicesotherAdd.nvhlpscheduleIdChange(Sender: TObject);
  var
    id: largeint;
  begin
    inherited;
    if (Trim(nvhlpschedule.Text) <> '') and (nvhlpschedule.id > 0) then
    begin
      if not nvhlpschedule.isactive then
        exit;
      nvhlptime.Text := nvhlpschedule.HelpFieldValue['departtime'];
      id := nvhlpschedule.id;

      try
        nvhlpvehicle.Text := self.nvhlpschedule.HelpFieldValue['vehicleno'];
//        nvhlpvehicle.OnIdChange := nil;
        nvhlpvehicle.id := self.nvhlpschedule.HelpFieldValue['vehicleid'];
      except
        on e: exception do
        begin
          SysLog.WriteErr('补录添加：' + e.Message);
        end;
      end;
      with jcsdQryRoutePrice do
      begin
        Active := false;
        Params.ParamValues['routeid'] := nvhlpschedule.HelpFieldValue
          ['routeid'];
        Params.ParamValues['scheduleid'] := nvhlpschedule.id;
        Params.ParamValues['departdate'] := DateTimeToStr
          (dtpdepartdate.DateTime);
        Active := True;
        nvhlpdepartstation.id := jcsdQryRoutePrice.fieldbyname('fromstationid')
          .AsLargeInt;
        nvhlpdepartstation.Text := jcsdQryRoutePrice.fieldbyname
          ('fromstationname').AsString;
      end;
    end;
//    nvhlpvehicle.OnIdChange := nvhlpvehicleIdChange;
  end;

  procedure TFrmDepartinvoicesotherAdd.nvhlpvehicleIdChange(Sender: TObject);
  begin
    inherited;
    if (nvhlpvehicle.Text <> '') and (nvhlpvehicle.id > 0) then
    begin
      with jcdsqryUnit do
      begin
        Active := false;
        Params.ParamValues['id'] := nvhlpvehicle.id;
        Active := True;
        nvhelpunit.id := jcdsqryUnit.fieldbyname('unitid').AsLargeInt;
        nvhelpunit.Text := jcdsqryUnit.fieldbyname('unitname').AsString;
        nvhelpunit.Enabled := false;
        nvhlp1.id := jcdsqryUnit.fieldbyname('balanceunitid').AsLargeInt;
        nvhlp1.Text := jcdsqryUnit.fieldbyname('balancename').AsString;
        cbbvehicletype.Text := jcdsqryUnit.fieldbyname('value').AsString;
        cbbvehicletype.SetItemIndexByCode(jcdsqryUnit.fieldbyname('type').AsString);
        cbbvehicletype.Enabled := false;
      end;

    end;
  end;

  procedure TFrmDepartinvoicesotherAdd.ToolButton1Click(Sender: TObject);
  begin
    inherited;
    ModalResult := mrok;
  end;

end.
