unit UFrmhirebusacceptAdd;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, USimpleEditForm, StdCtrls, Buttons, ExtCtrls, NovaEdit, NovaHelp,
  NovaComboBox, DB, DBClient, jsonClientDataSet, UDMPublic, Services,
  NovaHComboBox, ImgList, ComCtrls, NovaPrint, Generics.Collections;

type
  TFrmHirebusacceptAdd = class(TSimpleEditForm)
    jcdssave: TjsonClientDataSet;
    Panel1: TPanel;
    memremarks: TMemo;
    Label11: TLabel;
    Label59: TLabel;
    nvedtfeetype: TNovaEdit;
    Label41: TLabel;
    Label34: TLabel;
    nvedtactpeople: TNovaEdit;
    Label33: TLabel;
    Label52: TLabel;
    Label9: TLabel;
    nvedtusehour: TNovaEdit;
    Label8: TLabel;
    nvhelpvehiclecode: TNovaHelp;
    Label5: TLabel;
    Label18: TLabel;
    Label3: TLabel;
    nvedtbasefee: TNovaEdit;
    nvedtdistance: TNovaEdit;
    Label25: TLabel;
    Label24: TLabel;
    Label23: TLabel;
    Label22: TLabel;
    Label4: TLabel;
    Label6: TLabel;
    nvedthireunit: TNovaEdit;
    Label46: TLabel;
    nvedtinsurefee: TNovaEdit;
    Label47: TLabel;
    Label37: TLabel;
    nvedtfeerate: TNovaEdit;
    Label56: TLabel;
    Label50: TLabel;
    nvedttotalfee: TNovaEdit;
    Label53: TLabel;
    Label49: TLabel;
    nvedtotherfee: TNovaEdit;
    Label60: TLabel;
    Label29: TLabel;
    dtphiredate: TDateTimePicker;
    lblunitid: TLabel;
    nvhelpunitname: TNovaHelp;
    Label2: TLabel;
    Label13: TLabel;
    Label7: TLabel;
    Label31: TLabel;
    dtpstartdate: TDateTimePicker;
    Label15: TLabel;
    dtpenddate: TDateTimePicker;
    Label1: TLabel;
    Label10: TLabel;
    jcdsupdateBillinuse: TjsonClientDataSet;
    nvedtstartstation: TNovaHelp;
    nvedtendstation: TNovaHelp;
    Label12: TLabel;
    nvcbbtype: TNovaComboBox;
    Label14: TLabel;
    Label16: TLabel;
    CobDISTRICTTYPE: TNovaComboBox;
    Label17: TLabel;
    lbl1: TLabel;
    nvhlpdistrictid: TNovaHelp;
    Label19: TLabel;
    procedure bbtnSaveClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure nvedtbasefeeChange(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure nvhelpunitnameIdChange(Sender: TObject);
    procedure nvhelpvehiclecodeClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);

  private
    { Private declarations }
    Foperationid: Integer;
    log: string;

    billPrint: TNovaPrint;
    printValue: TDictionary<String, String>; // 输出单变量

    procedure printpack;
    procedure updatepackbill;

  public
    { Public declarations }
    hirebusid: Integer;
    createby: Integer;
    createTime: TDateTime;
    synccode: string;
    operater: Integer;
    orgid: Integer;
    operatername: string;
    orgname: string;
    ticketoutletsid: Integer;

    hireunit, hiredate, unitname, vehiclecode, startstation, endstation,
      distance, basefee, startdate, enddate, usehour, insurefee, actpeople,
      otherfee, feetype, feerate, totalfee, remark, hirebusno, hirebustype,
      tlname,districttype,districtname: string;

    property operationid: Integer read Foperationid;
  end;

var
  FrmHirebusacceptAdd: TFrmHirebusacceptAdd;

implementation

uses PubFn;
{$R *.dfm}

procedure TFrmHirebusacceptAdd.bbtnSaveClick(Sender: TObject);
var
  result: string;
begin
  inherited;

  if trim(nvedthireunit.Text) = '' then
  begin
    SysDialogs.ShowMessage('包车单位不能为空!');
    nvedthireunit.SetFocus;
    exit;
  end;

  if nvhelpunitname.Id <= 0 then
  begin
    SysDialogs.ShowMessage('请选择车属单位!');
    nvhelpunitname.SetFocus;
    exit;
  end;

  if FormatDateTime('yyyymmdd', dtpstartdate.Date) > FormatDateTime('yyyymmdd',
    dtpenddate.Date) then
  begin
    SysDialogs.ShowMessage('开始日期不能大于结束日期！');
    dtpstartdate.SetFocus;
    exit;
  end;

  if trim(nvedtstartstation.Text) = '' then
  begin
    SysDialogs.ShowMessage('包车起点不能为空!');
    nvedtstartstation.SetFocus;
    exit;
  end;

  if trim(nvedtendstation.Text) = '' then
  begin
    SysDialogs.ShowMessage('包车到站不能为空!');
    nvedtendstation.SetFocus;
    exit;
  end;

  if nvcbbtype.ItemIndex < 0 then
  begin
    SysDialogs.ShowMessage('请选择包车类型!');
    nvcbbtype.SetFocus;
    exit;
  end;

  if CobDISTRICTTYPE.ItemIndex < 0 then
  begin
    SysDialogs.ShowMessage('请选择运行区域！');
    CobDISTRICTTYPE.SetFocus;
    exit;
  end;

  if nvhlpdistrictid.Id <= 0 then
  begin
    SysDialogs.ShowMessage('请选择所属区域!');
    nvhlpdistrictid.SetFocus;
    exit;
  end;

  if trim(nvedtactpeople.Text) = '' then
  begin
    SysDialogs.ShowMessage('实载人数不能为空!');
    nvedtactpeople.SetFocus;
    exit;
  end;

  if trim(nvedtdistance.Text) = '' then
  begin
    SysDialogs.ShowMessage('计费里程不能为空!');
    nvedtdistance.SetFocus;
    exit;
  end;

  if (trim(nvedtusehour.Text) = '') then
  begin
    SysDialogs.ShowMessage('计费时间不能为空!');
    nvedtusehour.SetFocus;
    exit;
  end;

  if trim(nvedtfeetype.Text) = '' then
  begin
    SysDialogs.ShowMessage('计费方式不能为空!');
    nvedtfeetype.SetFocus;
    exit;
  end;

  if trim(nvedtbasefee.Text) = '' then
  begin
    SysDialogs.ShowMessage('包车运费不能为空!');
    nvedtbasefee.SetFocus;
    exit;
  end;

  if trim(nvedtinsurefee.Text) = '' then
  begin
    SysDialogs.ShowMessage('保险费不能为空!');
    nvedtinsurefee.SetFocus;
    exit;
  end;

  if (trim(nvedtotherfee.Text) = '') then
  begin
    SysDialogs.ShowMessage('其它费用不能为空!');
    nvedtotherfee.SetFocus;
    exit;
  end;

  if (trim(nvedtfeerate.Text) = '') then
  begin
    SysDialogs.ShowMessage('费率不能为空!');
    nvedtfeerate.SetFocus;
    exit;
  end;

  if (trim(nvedttotalfee.Text) = '') then
  begin
    SysDialogs.ShowMessage('总费用不能为空!');
    nvedttotalfee.SetFocus;
    exit;
  end;

  if StrToFloat(nvedttotalfee.Text) >= 1000000 then
  begin
    SysDialogs.ShowMessage('总费用数值超出范围(0~999999.99)!');
    nvedttotalfee.SetFocus;
    exit;
  end;

  with jcdssave do
  begin
    Active := false;
    if self.edittype = Tedittype.update then
    begin
      Params.ParamValues['hirebus.id'] := IntToStr(hirebusid);
      Params.ParamValues['hirebus.createby'] := IntToStr(createby);
      Params.ParamValues['hirebus.createtime'] := FormatDateTime
        ('yyyy-mm-dd HH:mm:ss', createTime); ;
      // Params.ParamValues['hirebus.orgid'] := IntToStr(orgid);
      // Params.ParamValues['hirebus.operater']:= IntToStr(operater);
      Params.ParamValues['hirebus.synccode'] := synccode;
      Params.ParamValues['hirebus.ticketoutletsid'] := IntToStr
        (ticketoutletsid);

    end
    else
    begin
      orgid := SysInfo.LoginUserInfo.orgid;
      orgname := SysInfo.LoginUserInfo.orgname;
      operater := SysInfo.LoginUserInfo.UserID;
      operatername := SysInfo.LoginUserInfo.UserName;
      hirebusno := SysInfo.LoginUserInfo.curBillNo.Items['HirebusBill'];
      ticketoutletsid := SysInfo.LoginUserInfo.ticketoutletsid;
      tlname := SysInfo.LoginUserInfo.ticketoutletsname;
    end;

    // 包车单位
    hireunit := trim(nvedthireunit.Text);
    // 车属单位
    self.unitname := trim(nvhelpunitname.Text);
    // 车辆
    vehiclecode := trim(nvhelpvehiclecode.Text);
    // 用车日期
    hiredate := FormatDateTime('yyyy-mm-dd', dtphiredate.DateTime);
    // hiredate := FormatDateTime('yyyy-mm-dd', dtpstartdate.DateTime);
    // 开始时间
    startdate := FormatDateTime('yyyy-mm-dd', dtpstartdate.DateTime);
    // 结束时间
    enddate := FormatDateTime('yyyy-mm-dd ', dtpenddate.DateTime);
    // 包车起点
    startstation := trim(nvedtstartstation.Text);
    // 包车到站
    endstation := trim(nvedtendstation.Text);
    // 实载人数
    actpeople := trim(nvedtactpeople.Text);
    // 计费里程
    distance := trim(nvedtdistance.Text);
    // 计费时间
    usehour := trim(nvedtusehour.Text);
    // 计费方式
    feetype := trim(nvedtfeetype.Text);
    // 包车运费
    basefee := trim(nvedtbasefee.Text);
    // 保险费
    insurefee := trim(nvedtinsurefee.Text);
    // 其它费用
    otherfee := trim(nvedtotherfee.Text);
    // 费率
    feerate := trim(nvedtfeerate.Text);
    // 总费用
    totalfee := trim(nvedttotalfee.Text);
    // 备注
    remark := trim(memremarks.Text);
    // 类型
    hirebustype := trim(nvcbbtype.Text);
    districttype := trim(CobDISTRICTTYPE.Text);

    //所属区域
    districtname :=nvhlpdistrictid.Text;


    // 包车单位
    Params.ParamByName('hirebus.hireunit').Value := hireunit;
    // 车属单位
    Params.ParamByName('hirebus.unitid').Value := IntToStr(nvhelpunitname.Id);
    // 车辆
    if nvhelpvehiclecode.Id > 0 then
      Params.ParamByName('hirebus.vehicleid').Value := nvhelpvehiclecode.Id
    else
      Params.ParamByName('hirebus.vehicleid').Value := '';

    // 用车日期
    Params.ParamByName('hirebus.hiredate').Value := hiredate;
    // 开始时间
    Params.ParamByName('hirebus.startdate').Value := startdate;
    // 结束时间
    Params.ParamByName('hirebus.enddate').Value := enddate;
    // 包车起点
    Params.ParamByName('hirebus.startstation').Value := startstation;
    // 包车到站
    Params.ParamByName('hirebus.endstation').Value := endstation;
    // 实载人数
    Params.ParamByName('hirebus.actpeople').Value := actpeople;
    // 计费里程
    Params.ParamByName('hirebus.distance').Value := distance;
    // 计费时间
    Params.ParamByName('hirebus.usehour').Value := usehour;
    // 计费方式
    Params.ParamByName('hirebus.feetype').Value := feetype;
    // 包车运费
    Params.ParamByName('hirebus.basefee').Value := basefee;

    // 保险费
    Params.ParamByName('hirebus.insurefee').Value := insurefee;
    // 其它费用
    Params.ParamByName('hirebus.otherfee').Value := otherfee;
    // 费率
    Params.ParamByName('hirebus.feerate').Value := feerate;
    // 总费用
    Params.ParamByName('hirebus.totalfee').Value := totalfee;
    // 备注
    Params.ParamByName('hirebus.remark').Value := remark;
    // 机构
    Params.ParamByName('hirebus.orgid').Value := orgid;
    // 经办人
    Params.ParamByName('hirebus.operater').Value := operater;
    // 状态
    Params.ParamByName('hirebus.status').Value := '0';
    // 包车单
    Params.ParamByName('hirebus.hirebusno').Value := hirebusno;
    // 包车类型
    Params.ParamByName('hirebus.ticketoutletsid').Value := IntToStr
      (ticketoutletsid);
      //运行区域
    Params.ParamByName('hirebus.districttype').Value := CobDISTRICTTYPE.GetSelectCode;
    // 售票点
    Params.ParamByName('hirebus.type').Value := nvcbbtype.GetSelectCode;
    //所属区域
    Params.ParamByName('hirebus.districtid').Value := nvhlpdistrictid.Id;

    Execute;
    bbtnSave.Enabled := true;
    if Params.ParamValues['msg'] <> '' then
    begin
      SysDialogs.ShowMessage(Params.ParamValues['msg']);
    end;
    if Params.ParamValues['flag'] = 1 then
    begin
      bbtnSave.Enabled := false;
      if self.edittype = Tedittype.update then
        result := '修改'
      else
        result := '添加';
      log := result + VarToStr(Params.ParamValues['hirebusid'])
        + '包车：机构=' + SysInfo.LoginUserInfo.orgname + ',' + result + '人=' +
        SysInfo.LoginUserInfo.UserName + ',单号=' + hirebusno + ',包车类型=' +
        ',运行区域=' +districttype+ ',所属区域='+districtname+
        nvcbbtype.Text + ',售票点=' + tlname + ',包车单位=' + trim(nvedthireunit.Text)
        + ',车属单位=' + nvhelpunitname.Text + ',车牌号=' + nvhelpvehiclecode.Text +
        ',用车日期=' + FormatDateTime('yyyy-mm-dd', dtphiredate.DateTime)
        + ',开始时间=' + FormatDateTime('yyyy-mm-dd',
        dtpstartdate.DateTime) + ',结束时间=' + FormatDateTime('yyyy-mm-dd',
        dtpenddate.DateTime) + ',包车起点=' + nvedtstartstation.Text + ',包车到站' +
        nvedtendstation.Text + ',实载人数=' + nvedtactpeople.Text + ',计费里程=' +
        nvedtdistance.Text + ',计费时间=' + nvedtusehour.Text + ',计费方式=' +
        nvedtfeetype.Text + ',包车运费=' + nvedtbasefee.Text + ',保险费=' +
        nvedtinsurefee.Text + ',其它费用=' + nvedtotherfee.Text + ',费率=' +
        nvedtfeerate.Text + ',总费用=' + nvedttotalfee.Text + ',备注=' +
        memremarks.Text;
      SysLog.WriteLog('包车管理->包车信息', result, log);
      Foperationid := Params.ParamValues['hirebusid'];
      try
        if self.edittype = Tedittype.add then
        begin
          printpack;
          updatepackbill;
        end;
      finally
        self.ModalResult := mrOk;
      end;

    end;

  end;
end;

procedure TFrmHirebusacceptAdd.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;
  if Assigned(printValue) then
    printValue.Free;
end;

procedure TFrmHirebusacceptAdd.FormCreate(Sender: TObject);
begin
  inherited;
  nvcbbtype.Active := false;
  nvcbbtype.Active := true;
  CobDISTRICTTYPE.Active := false;
  CobDISTRICTTYPE.Active := true;
end;

procedure TFrmHirebusacceptAdd.FormShow(Sender: TObject);
begin
  inherited;
  if self.edittype = Tedittype.update then

  else
  begin
    dtphiredate.DateTime := Now();
    dtpstartdate.DateTime := Now();
    dtpenddate.DateTime := Now();
    nvcbbtype.ItemIndex := 3;
  end;

end;

procedure TFrmHirebusacceptAdd.nvedtbasefeeChange(Sender: TObject);
var
  totalfeemoney: Double;
begin
  inherited;
  if (trim(nvedtbasefee.Text) <> '') then
  begin
    // 包车运费
    if StrToFloat(nvedtbasefee.Text) >= 1000000 then
    begin
      SysDialogs.ShowMessage('包车运费金额数值超出范围(0~999999.99)!');
      nvedtbasefee.SetFocus;
      exit;
    end;

    totalfeemoney := totalfeemoney + StrToFloat(trim(nvedtbasefee.Text));
  end;

  if (trim(nvedtinsurefee.Text) <> '') then
  begin
    // 保险费
    if StrToFloat(nvedtinsurefee.Text) >= 1000000 then
    begin
      SysDialogs.ShowMessage('保险费金额数值超出范围(0~999999.99)!');
      nvedtinsurefee.SetFocus;
      exit;
    end;

    totalfeemoney := totalfeemoney + StrToFloat(trim(nvedtinsurefee.Text));
  end;

  if (trim(nvedtotherfee.Text) <> '') then
  begin
    // 其它费用
    if StrToFloat(nvedtotherfee.Text) >= 1000000 then
    begin
      SysDialogs.ShowMessage('其它费用金额数值超出范围(0~999999.99)!');
      nvedtotherfee.SetFocus;
      exit;
    end;
    totalfeemoney := totalfeemoney + StrToFloat(trim(nvedtotherfee.Text));
  end;

  nvedttotalfee.Text := FloatToStr(totalfeemoney);

  if totalfeemoney >= 1000000 then
  begin
    SysDialogs.ShowMessage('合计金额数值超出范围(0~999999.99)!');
    nvedttotalfee.SetFocus;
    exit;
  end;
end;

procedure TFrmHirebusacceptAdd.nvhelpunitnameIdChange(Sender: TObject);
var
  unitid, vehicleid: Integer;
  vehicleno: string;
begin
  inherited;
  if (nvhelpvehiclecode.Id > 0) then
  begin
    vehicleid := nvhelpvehiclecode.Id;
    vehicleno := nvhelpvehiclecode.Text;
  end;

  if (nvhelpunitname.Id > 0) then
  begin
    nvhelpvehiclecode.Params.ParamValues['filter_EQL_t!unitid'] :=
      nvhelpunitname.Id;
    if unitid <> nvhelpunitname.Id then
    begin
      nvhelpvehiclecode.Id := -1;
      nvhelpvehiclecode.Text := '';
    end
    else
    begin
      nvhelpvehiclecode.Id := vehicleid;
      nvhelpvehiclecode.Text := vehicleno;
    end;
    unitid := nvhelpunitname.Id;
  end
  else
  begin
    nvhelpvehiclecode.Id := -1;
    nvhelpvehiclecode.Text := '';
  end;
end;

procedure TFrmHirebusacceptAdd.nvhelpvehiclecodeClick(Sender: TObject);
begin
  inherited;
  if (nvhelpunitname.Id > 0) then
  begin
    nvhelpvehiclecode.Params.ParamValues['filter_EQL_t!unitid'] :=
      nvhelpunitname.Id;
  end
  else
  begin
    SysDialogs.ShowMessage('请先选择车属单位');
    nvhelpunitname.SetFocus;
  end;
end;

procedure TFrmHirebusacceptAdd.printpack();
var
  billPrint: TNovaPrint;
  printValue: TDictionary<String, String>; // 输出单变量
  templtename: string;
begin

  printValue := TDictionary<String, String>.Create;
  billPrint := TNovaPrint.Create(self, TNovaPrint.GetTicketModelName('包车单',
      '包车单'));
  printValue.Clear;

  // 包车单位
  printValue.add('hireunit', hireunit);
  // 车属单位
  printValue.add('unitname', unitname);
  // 车辆
  printValue.add('vehiclecode', vehiclecode);
  // 用车日期
  printValue.add('hiredate', hiredate);
  // 开始时间
  printValue.add('startdate', startdate);
  // 结束时间
  printValue.add('enddate', enddate);
  // 包车起点
  printValue.add('startstation', startstation);
  // 包车到站
  printValue.add('endstation', endstation);
  // 实载人数
  printValue.add('actpeople', actpeople);
  // 计费里程
  printValue.add('distance', distance);
  // 计费时间
  printValue.add('usehour', usehour + '/h');
  // 计费方式
  printValue.add('feetype', feetype);
  // 包车运费
  printValue.add('basefee', basefee);
  // 保险费
  printValue.add('insurefee', insurefee);
  // 其它费用
  printValue.add('otherfee', otherfee);
  // 费率
  printValue.add('feerate', feerate);
  // 总费用
  printValue.add('totalfee', totalfee);
  // 备注
  printValue.add('remark', remark);
  // 机构
  printValue.add('orgname', orgname);
  // 经办人
  printValue.add('operatername', operatername);
  // 包车单
  printValue.add('hirebusno', hirebusno);
  // 包车类型
  printValue.add('typevalue', hirebustype);
  // 售票点
  printValue.add('ticketoutletsname', tlname);
  //运行区域
  printValue.Add('districttype',districttype);
  //所属区域
  printValue.Add('districtname',districtname);

  billPrint.SingleValue := printValue;
  billPrint.Print;

  ModalResult := mrOk;

end;

procedure TFrmHirebusacceptAdd.updatepackbill();
var
  billinusestatus, billinusenextno, billinusenextform: string;
begin

  with SysInfo.LoginUserInfo do
  begin
    billinusenextform := IntToStr
      (strtoint64(SysInfo.LoginUserInfo.curBillNo.Items['HirebusBill']));
    billinusenextno := IntToStr
      (strtoint64(SysInfo.LoginUserInfo.curBillNo.Items['HirebusBill'])
        + 1);

    curBillNo.AddOrSetValue('HirebusBill', zerofill(billinusenextno,
        length(curBillNo.Items['HirebusBill'])));
    curBillNum.AddOrSetValue('HirebusBill',
      curBillNum.Items['HirebusBill'] - 1);

    if curBillNum.Items['HirebusBill'] > 0 then
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
    Params.ParamValues['billtypecode'] := 'HirebusBill';

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
