unit UFrmhirebusaccept;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, USimpleCRUDForm, DBGridEhGrouping, DB, DBClient, jsonClientDataSet,
  PrnDbgeh, ImgList, GridsEh, DBGridEh, ComCtrls, ToolWin, ExtCtrls, StdCtrls,
  NovaComboBox, NovaEdit, NovaHelp, Services, UDMPublic, PubFn,
  NvPrnDbgeh, NvDbgridEh, NovaCheckedComboBox, NovaHComboBox, NovaPrint,
  Generics.Collections;

type
  TFrmHirebusaccept = class(TSimpleCRUDForm)
    ilsmalltools: TImageList;
    splmid: TSplitter;
    Label2: TLabel;
    lbl3: TLabel;
    lbl4: TLabel;
    nvcbborg: TNovaCheckedComboBox;
    jcdsResultorgname: TWideStringField;
    Label8: TLabel;
    nvhlpseller: TNovaHelp;
    Label1: TLabel;
    dtphirestartdate: TDateTimePicker;
    lblunitid: TLabel;
    NovaHelpUnits: TNovaHelp;
    Label3: TLabel;
    jcdsResulthireunit: TWideStringField;
    jcdsResultunitid: TLargeintField;
    jcdsResultunitname: TWideStringField;
    jcdsResultorgid: TLargeintField;
    jcdsResultid: TLargeintField;
    jcdsResultvehicleid: TLargeintField;
    jcdsResultstartstation: TWideStringField;
    jcdsResultendstation: TWideStringField;
    jcdsResultbasefee: TFloatField;
    jcdsResultinsurefee: TFloatField;
    jcdsResultotherfee: TFloatField;
    jcdsResultfeetype: TWideStringField;
    jcdsResultfeerate: TFloatField;
    jcdsResulttotalfee: TFloatField;
    jcdsResultremark: TWideStringField;
    jcdsResultoperater: TLargeintField;
    jcdsResultcreateby: TLargeintField;
    jcdsResultupdateby: TLargeintField;
    jcdsResultsynccode: TWideStringField;
    jcdsResultvehicleno: TWideStringField;
    jcdsResultoperatername: TWideStringField;
    jcdsResultstatus: TWideStringField;
    NvDbgridEh1: TNvDbgridEh;
    jcdsstatusvalue: TjsonClientDataSet;
    jcdsResultstatusvalue: TWideStringField;
    Label4: TLabel;
    nvcbbstatus: TNovaComboBox;
    jcdsResultdistance: TIntegerField;
    jcdsResultactpeople: TIntegerField;
    jcdsResultusehour: TIntegerField;
    nvhlvehicleno: TNovaHelp;
    GroupBox2: TGroupBox;
    lbpackbill: TLabel;
    Label5: TLabel;
    lbbillnum: TLabel;
    jcdsResulthiredate: TDateTimeField;
    jcdsResultstartdate: TDateTimeField;
    jcdsResultenddate: TDateTimeField;
    jcdsResultupdatetime: TDateTimeField;
    jcdsResultcreatetime: TDateTimeField;
    jcdsupdateBillinuse: TjsonClientDataSet;
    jcdswaste: TjsonClientDataSet;
    Label6: TLabel;
    dtphireenddate: TDateTimePicker;
    tmGetCurInvoinNo: TTimer;
    dtpstartdate: TDateTimePicker;
    dtpenddate: TDateTimePicker;
    jcdswhackhirebus: TjsonClientDataSet;
    jcdsResulthirebusno: TWideStringField;
    jcdsResulttype: TWideStringField;
    jcdstype: TjsonClientDataSet;
    jcdsResulttypevalue: TWideStringField;
    jcdsResulttlname: TWideStringField;
    Label7: TLabel;
    nvcbbtype: TNovaComboBox;
    jcdsResultticketoutletsid: TLargeintField;
    Label9: TLabel;
    nvhelpTicketoutlets: TNovaHelp;
    jcdsDISTRICTTYPE: TjsonClientDataSet;
    jcdsResultdistricttype: TWideStringField;
    jcdsResultdistricttypecode: TWideStringField;
    jcdsResultdistrictname: TWideStringField;
    jcdsResultdistrictid: TLargeintField;
    procedure edtnameKeyPress(Sender: TObject; var Key: Char);
    procedure NvHpendstationKeyPress(Sender: TObject; var Key: Char);
    procedure FormShow(Sender: TObject);
    procedure tbtnFilterClick(Sender: TObject);
    procedure tbtnInsertClick(Sender: TObject);
    procedure tbtnEditClick(Sender: TObject);
    procedure tbtnDeleteClick(Sender: TObject);
    procedure tmGetCurInvoinNoTimer(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure dtpstartdateChange(Sender: TObject);
    procedure dtpenddateChange(Sender: TObject);
    procedure ToolButton50Click(Sender: TObject);

  private
    { Private declarations }
    ishirebusbill: Boolean; // 判断前面是否领取过票号来判断用完后重置票号

    procedure printpack;
    procedure refreshBill;
    procedure updatepackbill;
  public
    { Public declarations }
    procedure HandleAuthority(const Key: TGUID; aEnable: Boolean); override;
  end;

var
  FrmHirebusaccept: TFrmHirebusaccept;

implementation

uses UFrmHirebusacceptAdd;
{$R *.dfm}

procedure TFrmHirebusaccept.dtpenddateChange(Sender: TObject);
begin
  inherited;
  dtpstartdate.Checked := dtpenddate.Checked;
end;

procedure TFrmHirebusaccept.dtpstartdateChange(Sender: TObject);
begin
  inherited;
  dtpenddate.Checked := dtpstartdate.Checked;
end;

procedure TFrmHirebusaccept.edtnameKeyPress(Sender: TObject; var Key: Char);
begin
  inherited;
  if Key = #13 then
    tbtnFilterClick(Sender);
end;

procedure TFrmHirebusaccept.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;
  tmGetCurInvoinNo.Enabled := false;
end;

procedure TFrmHirebusaccept.FormCreate(Sender: TObject);
begin
  inherited;
  if not checkBillno('HirebusBill') then
  begin
    SysDialogs.ShowInfo('未领包车单票号,无法进行包车操作！');
  end
  else
  begin

  end;

  refreshBill;
end;

procedure TFrmHirebusaccept.FormShow(Sender: TObject);
begin
  inherited;
  dtphirestartdate.DateTime := Now();
  dtphireenddate.DateTime := Now();
  dtpstartdate.DateTime := Now();
  dtpenddate.DateTime := Now();
  nvcbborg.Active := false;
  nvcbborg.Active := true;
  nvcbbstatus.Active := false;
  nvcbbstatus.Active := true;
  nvcbbtype.Active := false;
  nvcbbtype.Active := true;
  jcdsstatusvalue.Active := false;
  jcdsstatusvalue.Active := true;
  jcdstype.Active := false;
  jcdstype.Active := true;

  tmGetCurInvoinNo.Enabled := true;
end;

procedure TFrmHirebusaccept.HandleAuthority(const Key: TGUID; aEnable: Boolean);
begin
  inherited;
end;

procedure TFrmHirebusaccept.NvHpendstationKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  if Key = #13 then
    tbtnFilterClick(Sender);
end;

procedure TFrmHirebusaccept.tbtnDeleteClick(Sender: TObject);
begin
  inherited;
  if (jcdsResult.Active = true) and (jcdsResult.RecNo > 0) then
  begin
    if not SysDialogs.Confirm('提示', '确定把该信息作废吗？') then
    begin
      exit;
    end;

    with jcdswaste do
    begin

      Active := false;

      if jcdsResult.FieldByName('status').AsString = '1' then
      begin
        SysDialogs.ShowInfo('该包车已结算，无法作废！');
        exit;
      end;

      if jcdsResult.FieldByName('status').AsString = '2' then
      begin
        SysDialogs.ShowInfo('该包车已作废！');
        exit;
      end;

      if (sysinfo.LoginUserInfo.OrgID <> jcdsResult.FieldByName('orgid')
          .AsInteger) then
      begin
        SysDialogs.ShowInfo('只能对本机构的包车信息进行作废操作！');
        exit;
      end;

      Params.ParamValues['hirebus.id'] := jcdsResult.FieldByName('id').AsString;
      Params.ParamValues['hirebus.status'] := '2';

      Execute;
      if Params.ParamValues['msg'] <> '' then
      begin
        SysDialogs.ShowMessage(Params.ParamValues['msg']);
      end;
      if Params.ParamValues['flag'] = 1 then
      begin
        tbtnFilter.Click;
      end;
    end;
    // jcdsResult.Delete;
    jcdsResult.ApplyUpdates(0);
  end
  else
  begin
    SysDialogs.ShowInfo('请先选择需要作废的记录！');
  end;
end;

procedure TFrmHirebusaccept.tbtnEditClick(Sender: TObject);
var
  id: Integer;
begin
  inherited;
  if (jcdsResult.Active = true) and (jcdsResult.RecNo > 0) then
  begin

    if jcdsResult.FieldByName('status').AsString = '1' then
    begin
      SysDialogs.ShowInfo('该包车已结算，不能修改！');
      exit;
    end;

    if jcdsResult.FieldByName('status').AsString = '2' then
    begin
      SysDialogs.ShowInfo('该包车已废弃,不能修改！');
      exit;
    end;

    if (sysinfo.LoginUserInfo.OrgID <> jcdsResult.FieldByName('orgid')
        .AsInteger) then
    begin
      SysDialogs.ShowInfo('只能对本机构的包车信息进行修改操作！');
      exit;
    end;

    { if (SysInfo.LoginUserInfo.UserID <> jcdsResult.FieldByName('sellby').AsInteger)
      or (SysInfo.LoginUserInfo.OrgID <> jcdsResult.FieldByName('orgid').AsInteger) then
      begin
      SysDialogs.ShowMessage('不可以修改他人开的包车信息！');
      exit;
      end; }

    FrmHirebusacceptAdd := TFrmHirebusacceptAdd.Create(self, self.functionItem);
    try
      with FrmHirebusacceptAdd do
      begin
        Caption := '包车修改';
        edittype := Tedittype.update;
        // 包车单位
        nvedthireunit.Text := jcdsResult.FieldByName('hireunit').AsString;

        // 车属单位
        nvhelpunitname.id := jcdsResult.FieldByName('unitid').AsInteger;
        nvhelpunitname.Text := jcdsResult.FieldByName('unitname').AsString;
        // 车辆
        nvhelpvehiclecode.id := jcdsResult.FieldByName('vehicleid').AsInteger;
        nvhelpvehiclecode.Text := jcdsResult.FieldByName('vehicleno').AsString;
        // 用车日期
        dtphiredate.DateTime := jcdsResult.FieldByName('hiredate').AsDateTime;
        // 开始时间
        dtpstartdate.DateTime := jcdsResult.FieldByName('startdate').AsDateTime;
        // 结束时间
        dtpenddate.DateTime := jcdsResult.FieldByName('enddate').AsDateTime;
        // 包车起点
        nvedtstartstation.Text := jcdsResult.FieldByName('startstation')
          .AsString;
        // 包车到站
        nvedtendstation.Text := jcdsResult.FieldByName('endstation').AsString;
        // 实载人数
        nvedtactpeople.Text := jcdsResult.FieldByName('actpeople').AsString;
        // 计费里程
        nvedtdistance.Text := jcdsResult.FieldByName('distance').AsString;
        // 计费时间
        nvedtusehour.Text := jcdsResult.FieldByName('usehour').AsString;
        // 计费方式
        nvedtfeetype.Text := jcdsResult.FieldByName('feetype').AsString;
        // 包车运费
        nvedtbasefee.Text := jcdsResult.FieldByName('basefee').AsString;
        // 保险费
        nvedtinsurefee.Text := jcdsResult.FieldByName('insurefee').AsString;
        // 其它费用
        nvedtotherfee.Text := jcdsResult.FieldByName('otherfee').AsString;
        // 费率
        nvedtfeerate.Text := jcdsResult.FieldByName('feerate').AsString;
        // 总费用
        nvedttotalfee.Text := jcdsResult.FieldByName('totalfee').AsString;
        // 备注
        memremarks.Text := jcdsResult.FieldByName('remark').AsString;

        // 所属区域
        nvhlpdistrictid.id := jcdsResult.FieldByName('districtid').AsInteger;
        nvhlpdistrictid.Text := jcdsResult.FieldByName('districtname').AsString;
        // 经办人
        operater := jcdsResult.FieldByName('operater').AsInteger;
        operatername := jcdsResult.FieldByName('operatername').AsString;
        synccode := self.jcdsResult.FieldByName('synccode').AsString;
        hirebusid := self.jcdsResult.FieldByName('id').AsInteger;
        createtime := self.jcdsResult.FieldByName('createtime').AsDateTime;
        createby := self.jcdsResult.FieldByName('createby').AsInteger;
        OrgID := self.jcdsResult.FieldByName('orgid').AsInteger;
        orgname := self.jcdsResult.FieldByName('orgname').AsString;
        // 单号
        hirebusno := jcdsResult.FieldByName('hirebusno').AsString;
        ticketoutletsid := jcdsResult.FieldByName('ticketoutletsid').AsInteger;
        tlname := jcdsResult.FieldByName('tlname').AsString;
        nvcbbtype.SetItemIndexByCode(jcdsResult.FieldByName('type').AsString);
        CobDISTRICTTYPE.SetItemIndexByCode(jcdsResult.FieldByName('districttype').AsString);

      end;
      if SysMainForm.showFormModal(FrmHirebusacceptAdd, false) = mrOk then
      begin
        id := FrmHirebusacceptAdd.operationid;
        tbtnFilter.Click;
        jcdsResult.Locate('id', id, []);
      end;
    finally
      FreeAndNil(FrmHirebusacceptAdd);
      refreshBill;
    end;
  end
  else
  begin
    SysDialogs.ShowInfo('请先选择需要修改的记录！');
  end;
end;

procedure TFrmHirebusaccept.tbtnFilterClick(Sender: TObject);
begin
  inherited;
  nvcbborg.SetFocus;
  if (nvcbborg.CheckedCount = 0) then
  begin
    SysDialogs.ShowMessage('请选择机构！');
    nvcbborg.SetFocus;
    exit;
  end;

  if dtpstartdate.Checked and (FormatDateTime('yyyymmdd',
      dtpstartdate.Date) > FormatDateTime('yyyymmdd', dtpenddate.Date)) then
  begin
    SysDialogs.ShowMessage('起止日期开始日期不能大于结束日期！');
    exit;
  end;

  if (FormatDateTime('yyyymmdd', dtphirestartdate.Date) > FormatDateTime
      ('yyyymmdd', dtphireenddate.Date)) then
  begin
    SysDialogs.ShowMessage('用车日期开始日期不能大于结束日期！');
    dtphirestartdate.SetFocus;
    exit;
  end;

  with jcdsResult do
  begin
    Active := false;

    Params.ParamValues['filter_INS_h!orgid'] := nvcbborg.GetSelectID;
    Params.ParamValues['filter_GED_h!hiredate'] := FormatDateTime('yyyy-mm-dd',
      dtphirestartdate.DateTime);
    Params.ParamValues['filter_LED_h!hiredate'] := FormatDateTime('yyyy-mm-dd',
      dtphireenddate.DateTime);

    if dtpstartdate.Checked then
    begin
      Params.ParamValues['filter_LED_h!startdate'] := FormatDateTime
        ('yyyy-mm-dd', dtpstartdate.DateTime);
      Params.ParamValues['filter_GED_h!enddate'] := FormatDateTime
        ('yyyy-mm-dd', dtpenddate.DateTime);
    end
    else
    begin
      Params.ParamValues['filter_LED_h!startdate'] := '';
      Params.ParamValues['filter_GED_h!enddate'] := '';
    end;

    if nvcbbstatus.ItemIndex < 0 then
      Params.ParamValues['filter_EQS_h!status'] := ''
    else
      Params.ParamValues['filter_EQS_h!status'] := nvcbbstatus.GetSelectCode;

    if NovaHelpUnits.id <= 0 then
      Params.ParamValues['filter_EQL_h!unitid'] := ''
    else
      Params.ParamValues['filter_EQL_h!unitid'] := NovaHelpUnits.id;

    if nvhlvehicleno.id <= 0 then
      Params.ParamValues['filter_EQL_h!vehicleid'] := ''
    else
      Params.ParamValues['filter_EQL_h!vehicleid'] := nvhlvehicleno.id;
    if nvhlpseller.id <= 0 then
      Params.ParamValues['filter_EQL_h!operater'] := ''
    else
      Params.ParamValues['filter_EQL_h!operater'] := nvhlpseller.id;

    if nvhelpTicketoutlets.id > 0 then // 售票点
    begin
      Params.ParamValues['filter_EQL_h!ticketoutletsid'] :=
        nvhelpTicketoutlets.id;
    end
    else
    begin
      Params.ParamValues['filter_EQL_h!ticketoutletsid'] := '';
    end;

    if nvcbbtype.ItemIndex < 0 then
      Params.ParamValues['filter_EQS_h!type'] := ''
    else
      Params.ParamValues['filter_EQS_h!type'] := nvcbbtype.GetSelectCode;

    Active := true;

  end;
end;

procedure TFrmHirebusaccept.tbtnInsertClick(Sender: TObject);
var
  id: Integer;
begin
  inherited;

  if sysinfo.LoginUserInfo.curBillNo.ContainsKey('HirebusBill')
    and sysinfo.LoginUserInfo.curBillNum.ContainsKey('HirebusBill') and
    (sysinfo.LoginUserInfo.curBillNum.Items['HirebusBill'] > 0) then
  begin

  end
  else
  begin

    if (ishirebusbill = true) and (sysinfo.LoginUserInfo.curBillNum.Items
        ['HirebusBill'] = 0) then
    begin
      if (initBillNo('HirebusBill')) then
      begin
        if (sysinfo.LoginUserInfo.curBillNum.Items['HirebusBill'] = 0) then
        begin
          SysDialogs.Warning('您当前的包车单据已用完，请重新领取单票！');
          exit;
          // result := false;
        end
        else
          refreshBill();
        // result := true;

      end;
    end
    else
    begin
      if not checkBillno('HirebusBill') then
      begin
        SysDialogs.ShowInfo('未领包车单票号,无法进行包车操作！');

        exit;
      end
      else
      begin
        refreshBill();
      end;
    end;

  end;

  FrmHirebusacceptAdd := TFrmHirebusacceptAdd.Create(self, self.functionItem);
  try
    FrmHirebusacceptAdd.Caption := '包车受理';
    if SysMainForm.showFormModal(FrmHirebusacceptAdd, false) = mrOk then
    begin
      id := FrmHirebusacceptAdd.operationid;
      tbtnFilter.Click;
      jcdsResult.Locate('id', id, []);
    end;
  finally
    FreeAndNil(FrmHirebusacceptAdd);
    refreshBill;
  end;
end;

procedure TFrmHirebusaccept.tmGetCurInvoinNoTimer(Sender: TObject);
begin
  inherited;
  refreshBill;
end;

procedure TFrmHirebusaccept.ToolButton50Click(Sender: TObject);
begin
  inherited;
  if (jcdsResult.Active = true) and (jcdsResult.RecNo > 0) then
  begin
    if not SysDialogs.Confirm('提示', '确定要换号重打该信息吗？') then
    begin
      exit;
    end;
    if jcdsResult.FieldByName('status').AsString = '1' then
    begin
      SysDialogs.ShowInfo('该信息已结算，不能重打！');
      exit;
    end;

    if jcdsResult.FieldByName('status').AsString = '2' then
    begin
      SysDialogs.ShowInfo('该信息已废弃,不能重打！');
      exit;
    end;
    printpack;
    try

      with jcdswhackhirebus do
      begin
        Active := false;
        Params.ParamValues['hirebus.id'] := jcdsResult.FieldByName('id')
          .AsString;
        Params.ParamValues['hirebus.operater'] := jcdsResult.FieldByName
          ('operater').AsString;
        Params.ParamValues['hirebus.hirebusno'] :=
          sysinfo.LoginUserInfo.curBillNo.Items['HirebusBill'];

        Execute;

        if Params.ParamValues['msg'] <> '' then
        begin
          SysDialogs.ShowMessage(Params.ParamValues['msg']);
        end;
        if Params.ParamValues['flag'] = 1 then
        begin

        end;
        tbtnFilter.Click;
        jcdsResult.Locate('id', jcdsResult.FieldByName('id').AsInteger, []);
      end;

    finally
      updatepackbill();
      refreshBill();
    end;

  end
  else
  begin
    SysDialogs.ShowInfo('请先选择需要重打的记录！');
  end;
end;

procedure TFrmHirebusaccept.refreshBill();
begin

  if sysinfo.LoginUserInfo.curBillNo.ContainsKey('HirebusBill')
    and sysinfo.LoginUserInfo.curBillNum.ContainsKey('HirebusBill') and
    (sysinfo.LoginUserInfo.curBillNum.Items['HirebusBill'] > 0) then
  begin
    lbpackbill.Caption := sysinfo.LoginUserInfo.curBillNo.Items['HirebusBill'];
    lbbillnum.Caption := IntToStr(sysinfo.LoginUserInfo.curBillNum.Items
        ['HirebusBill']);
    ishirebusbill := true;
  end
  else
  begin
    lbpackbill.Caption := '000000000000';
    lbbillnum.Caption := '0';
    ishirebusbill := false;
  end;

end;

procedure TFrmHirebusaccept.printpack();
var
  billPrint: TNovaPrint;
  printValue: TDictionary<String, String>; // 输出单变量
  templtename: string;
begin

  printValue := TDictionary<String, String>.Create;
  billPrint := TNovaPrint.Create(self, TNovaPrint.GetTicketModelName('包车单',
      '包车单'));
  printValue.Clear;

  with jcdsResult do
  begin
    // 包车单位
    printValue.Add('hireunit', FieldByName('hireunit').AsString);
    // 车属单位
    printValue.Add('unitname', FieldByName('unitname').AsString);
    // 车辆
    printValue.Add('vehiclecode', FieldByName('vehicleno').AsString);
    // 用车日期
    printValue.Add('hiredate', FormatDateTime('yyyy-mm-dd',
        FieldByName('hiredate').AsDateTime));
    // 开始时间
    printValue.Add('startdate', FormatDateTime('yyyy-mm-dd',
        FieldByName('startdate').AsDateTime));
    // 结束时间
    printValue.Add('enddate', FormatDateTime('yyyy-mm-dd',
        FieldByName('enddate').AsDateTime));
    // 包车起点
    printValue.Add('startstation', FieldByName('startstation').AsString);
    // 包车到站
    printValue.Add('endstation', FieldByName('endstation').AsString);
    // 实载人数
    printValue.Add('actpeople', FieldByName('actpeople').AsString);
    // 计费里程
    printValue.Add('distance', FieldByName('distance').AsString);
    // 计费时间
    printValue.Add('usehour', FieldByName('usehour').AsString + '/h');
    // 计费方式
    printValue.Add('feetype', FieldByName('feetype').AsString);
    // 包车运费
    printValue.Add('basefee', FieldByName('basefee').AsString);
    // 保险费
    printValue.Add('insurefee', FieldByName('insurefee').AsString);
    // 其它费用
    printValue.Add('otherfee', FieldByName('otherfee').AsString);
    // 费率
    printValue.Add('feerate', FieldByName('feerate').AsString);
    // 总费用
    printValue.Add('totalfee', FieldByName('totalfee').AsString);
    // 备注
    printValue.Add('remark', FieldByName('remark').AsString);
    // 机构
    printValue.Add('orgname', FieldByName('orgname').AsString);
    // 经办人
    printValue.Add('operatername', FieldByName('operatername').AsString);

    // 单号
    printValue.Add('hirebusno',
      sysinfo.LoginUserInfo.curBillNo.Items['HirebusBill']);

    // 包车类型
    printValue.Add('typevalue', FieldByName('typevalue').AsString);
    // 售票点
    printValue.Add('ticketoutletsname', FieldByName('tlname').AsString);
    //运行区域
    printValue.Add('districttype',FieldByName('districttypecode').AsString);
    //所属区域
    printValue.Add('districtname',FieldByName('districtname').AsString);
  end;

  billPrint.SingleValue := printValue;
  billPrint.Print;

  if Assigned(printValue) then
    printValue.Free;

end;

procedure TFrmHirebusaccept.updatepackbill();
var
  billinusestatus, billinusenextno, billinusenextform: string;
begin

  with sysinfo.LoginUserInfo do
  begin
    billinusenextform := IntToStr
      (strtoint64(sysinfo.LoginUserInfo.curBillNo.Items['HirebusBill']));
    billinusenextno := IntToStr
      (strtoint64(sysinfo.LoginUserInfo.curBillNo.Items['HirebusBill'])
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
