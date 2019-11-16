unit UFrmDepartinvoicesother;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, USimpleCRUDForm, DBGridEhGrouping, NvPrnDbgeh, DB, DBClient,
  jsonClientDataSet, ImgList, GridsEh, DBGridEh, NvDbgridEh, StdCtrls, ComCtrls,
  ToolWin, ExtCtrls, NovaEdit, UDMPublic, NovaHelp, NovaCheckedComboBox,
  NovaHComboBox, PubFn, NovaPrint, Generics.Collections,
  Buttons, NovaComboBox, Menus;

type
  TFrmDepartinvoices = class(TSimpleCRUDForm)
    il1: TImageList;
    dataSource: TDataSource;
    jcdsResult1: TjsonClientDataSet;
    jcdsResultDelDepartinvoicesother: TjsonClientDataSet;
    jsonDelDepartinvoicesotherdetail: TjsonClientDataSet;
    lbl2: TLabel;
    dtpstartdate: TDateTimePicker;
    dtpenddate: TDateTimePicker;
    lbl3: TLabel;
    nvhlpvehicle: TNovaHelp;
    Label1: TLabel;
    cbborg: TNovaCheckedComboBox;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    cobworkways: TNovaComboBox;
    Label8: TLabel;
    NHelpRoute: TNovaHelp;
    nvedtno: TNovaEdit;
    nvhlpcreatedby: TNovaHelp;
    jcdsQryvehicleid: TjsonClientDataSet;
    lblschedule: TLabel;
    nvhlpschedule: TNovaHelp;
    Label5: TLabel;
    NovaCobDataFroms: TNovaComboBox;
    Label6: TLabel;
    Label7: TLabel;
    btn1: TToolButton;
    btn2: TToolButton;
    jcdsauditdepartinvoicesother: TjsonClientDataSet;
    jcdscancelauditdepartinvoicesother: TjsonClientDataSet;
    pm1: TPopupMenu;
    N1: TMenuItem;
    N2: TMenuItem;
    N3: TMenuItem;
    lbl4: TLabel;
    nvhlpDeparts: TNovaHelp;
    Label9: TLabel;
    nvhlseller: TNovaHelp;
    btn3: TToolButton;
    jsnclntdtstQrydepartinvoicesotherdetail: TjsonClientDataSet;
    lbl1: TLabel;
    lbl5: TLabel;
    dtpFrom: TDateTimePicker;
    dtpEnd: TDateTimePicker;
    jcdsFindParameters: TjsonClientDataSet;
    btn4: TToolButton;
    NovaHelpUnit: TNovaHelp;
    procedure tbtnInsertClick(Sender: TObject);
    procedure tbtnFilterClick(Sender: TObject);
    procedure jcdsResultAfterScroll(DataSet: TDataSet);
    procedure btnInsertDepClick(Sender: TObject);
    procedure tbtnEditClick(Sender: TObject);
    procedure tbtnDeleteClick(Sender: TObject);
    procedure btndelDepClick(Sender: TObject);
    procedure btnUpdateDepClick(Sender: TObject);
    procedure jcdsResultAfterOpen(DataSet: TDataSet);
    procedure FormShow(Sender: TObject);
    procedure edtticketpriceChange(Sender: TObject);
    procedure edtticketpriceExit(Sender: TObject);
    procedure edtnumChange(Sender: TObject);
    procedure edtnumKeyPress(Sender: TObject; var Key: Char);
    procedure edtstationservicefreeChange(Sender: TObject);
    procedure edtstationservicefreeExit(Sender: TObject);
    procedure edtotherfeeExit(Sender: TObject);
    procedure edtagentfeeChange(Sender: TObject);
    procedure edtagentfeeExit(Sender: TObject);
    procedure edtotherfeeChange(Sender: TObject);
    procedure isEnable(Sender: Boolean);
    procedure btn2Click(Sender: TObject);
    procedure bbtnSaveClick(Sender: TObject);
    procedure reset(Sender: Boolean);
    procedure nvhlpdepartstationEnter(Sender: TObject);
    procedure FormKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure btn1Click(Sender: TObject);
    procedure HandleAuthority(const Key: TGUID; aEnable: Boolean); override;
    procedure N1Click(Sender: TObject);
    procedure N2Click(Sender: TObject);
    procedure N3Click(Sender: TObject);
    procedure btn3Click(Sender: TObject);
    procedure dtpFromClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure btn4Click(Sender: TObject);
  private
    { Private declarations }
    billPinter: TNovaPrint;
    printValue: TDictionary<String, String>; // 输出单变量
    multiplelist: TList < TDictionary < String, String >> ; // 输出数据集
    //参数声明
    param_4050, param_3068 : string;
  public
    { Public declarations }
    id: Int64;
    cbbtickettypeid, templtename: string;
  end;

var
  FrmDepartinvoices: TFrmDepartinvoices;

implementation

uses Services, UFrmDepartinvoicesotherEdit, UFrmDepartinvoicesotherdetail,
  UFrmDepartinvoicesotherAdd, UFrmDptotherDetail;
{$R *.dfm}

procedure TFrmDepartinvoices.isEnable(Sender: Boolean);
begin
  // nvhlpdepartstation.Enabled := Sender;
  // nvhlpendstation.Enabled := Sender;
  // cbbtickettype.Enabled := Sender;
  // edtdistance.Enabled := Sender;
  // edtticketprice.Enabled := Sender;
  // edtnum.Enabled := Sender;
  // edtstationservicefree.Enabled := Sender;
  // edtotherfee.Enabled := Sender;
  // edtagentfee.Enabled := Sender;
end;

procedure TFrmDepartinvoices.reset(Sender: Boolean);
begin
  if Sender then
  begin
    // nvhlpdepartstation.Text := '';
    // nvhlpendstation.Text := '';
    // cbbtickettype.ItemIndex := -1;
    // edtdistance.Text := '0';
    // edtticketprice.Text := '0';
    // edtnum.Text := '0';
    // edtstationservicefree.Text := '0';
    // edtotherfee.Text := '0';
    // edtagentfee.Text := '0';
    // edtbalanceamount.Text := '0';
  end;
end;

procedure TFrmDepartinvoices.bbtnSaveClick(Sender: TObject);
var
  nResult: Int64;
  sResult: string;
begin
  inherited;
  { id := jcdsResult.FieldByName('id').AsInteger;
    if Trim(jcdsResult.FieldByName('statusname').AsString) = '已结算' then
    begin
    SysDialogs.ShowMessage('该补录结算单已经结算，不能添加补录明细!');
    Exit;
    end;
    if (Trim(nvhlpdepartstation.Text) = '' ) then
    begin
    SysDialogs.Warning('请填写上车站点信息！');
    nvhlpdepartstation.SetFocus;
    Exit;
    end;
    if (Trim(nvhlpendstation.Text) = '') then
    begin
    SysDialogs.Warning('请填写到达站的信息！');
    nvhlpendstation.SetFocus;
    Exit;
    end;
    if (Trim(cbbtickettype.Text) = '')  then
    begin
    SysDialogs.Warning('请选择票种！');
    cbbtickettype.SetFocus;
    Exit;
    end;
    if nvhlpdepartstation.Id = nvhlpendstation.Id then
    begin
    SysDialogs.ShowMessage('上车站点与到达站不能相同！');
    nvhlpendstation.SetFocus;
    Exit;
    end;
    if cbbtickettype.ItemIndex < 0 then
    cbbtickettypeid := cbbtickettypeid
    else
    cbbtickettypeid := cbbtickettype.HelpFieldValue['id'];
    if StrToFloat(edtotherfee.Text) < 0 then
    begin
    SysDialogs.ShowMessage('其它金额不能为负，请重新输入！');
    Exit;
    end;
    with jcdsResultSavedepartinvoicesotherdetail do
    begin
    Close;
    Params.ParamValues['departinvoicesotherdetail.id'] := '';
    Params.ParamValues['departinvoicesotherdetail.departinvoicesotherid'] := jcdsResult.FieldByName('id').AsString;
    Params.ParamValues['departinvoicesotherdetail.fromstationid'] := nvhlpdepartstation.Id;
    Params.ParamValues['departinvoicesotherdetail.reachstationid'] := nvhlpendstation.Id;
    Params.ParamValues['departinvoicesotherdetail.tickettypeid'] := cbbtickettypeid;
    Params.ParamValues['departinvoicesotherdetail.distance'] := edtdistance.Text;
    Params.ParamValues['departinvoicesotherdetail.price'] := formatfloat('0.00',StrToFloat(edtticketprice.Text));
    Params.ParamValues['departinvoicesotherdetail.ticketnum'] := edtnum.Text;
    Params.ParamValues['departinvoicesotherdetail.stationservicefee'] := formatfloat('0.00',StrToFloat(edtstationservicefree.Text));
    Params.ParamValues['departinvoicesotherdetail.othterfee'] := formatfloat('0.00',StrToFloat(edtotherfee.Text));
    Params.ParamValues['departinvoicesotherdetail.agentfee'] := formatfloat('0.00',StrToFloat(edtagentfee.Text));
    Params.ParamValues['departinvoicesotherdetail.balanceamount'] := formatfloat('0.00',StrToFloat(edtbalanceamount.Text));
    Params.ParamValues['departinvoicesotherdetail.schedule.id'] := jcdsResult.FieldByName('scheduleid').AsString;
    Params.ParamValues['departinvoicesotherdetail.departtime'] := FormatDateTime('hh:mm', jcdsResult.FieldByName('departtime').AsDateTime);
    Params.ParamValues['departinvoicesotherdetail.departdate'] := jcdsResult.FieldByName('departdate').AsString;
    Params.ParamValues['departinvoicesotherdetail.totalamount'] := (StrToFloat(edtticketprice.Text) * StrToInt(edtnum.Text));
    try
    Execute;
    nResult := Params.ParamByName('flag').Value;
    sResult := Params.ParamByName('msg').Value;
    SysDialogs.ShowMessage(sResult);
    if (nResult <= 0) then
    begin
    nvhlpdepartstation.SetFocus;
    end
    else
    begin
    reset(True);//重置输入框的值
    nvhlpdepartstation.SetFocus;
    tbtnFilterClick(Self);
    jcdsResult.Locate('id', id,[]);
    end;
    except
    on E: Exception do
    begin
    SysLog.WriteErr('结算单补录明细添加失败：' + E.Message);
    end;
    end;
    end; }
end;

procedure TFrmDepartinvoices.btn1Click(Sender: TObject);
var
  nResult: integer;
  sResult: string;
  ids: string;
begin
  inherited;
  if not jcdsResult.Active then
     Exit;
  if jcdsResult.RecordCount<1 then
    Exit;

  with jcdsResult do
  begin
    try
      DisableControls;
      first;
      while not eof do
      begin
        if jcdsResult.fieldbyname('ischoose').AsBoolean then
          ids := ids + jcdsResult.fieldbyname('id').AsString + ',';
        next;
      end;
    finally
      EnableControls;
    end;
  end;
  if ids = '' then
  begin
    SysDialogs.ShowMessage('请勾选要进行审核的对象');
    exit;
  end;
  with jcdsauditdepartinvoicesother do
  begin
    Params.ParamValues['departinvoiceotherid'] := ids;
    try
      Execute;
      sResult := Params.ParamValues['msg'];
      SysDialogs.ShowMessage(sResult);
    except
      on E: Exception do
      begin
        SysLog.WriteErr('补录：' + E.Message);
      end;
    end;
  end;
  tbtnFilterClick(Sender);
end;

procedure TFrmDepartinvoices.btn2Click(Sender: TObject);
var
  nResult: integer;
  sResult: string;
  ids: string;
begin
  inherited;
  if (Trim(jcdsResult.fieldbyname('statusname').AsString) = '已结算') then
  begin
    SysDialogs.ShowMessage('已经结算手工单不能取消审核!');
    exit;
  end;
  with jcdsResult do
  begin
    try
      DisableControls;
      first;
      while not eof do
      begin
        if jcdsResult.fieldbyname('ischoose').AsBoolean then
          ids := ids + jcdsResult.fieldbyname('id').AsString + ',';
        next;
      end;
    finally
      EnableControls;
    end;
  end;
  if ids = '' then
  begin
    SysDialogs.ShowMessage('请勾选要进行取消审核的对象');
    exit;
  end;
  with jcdscancelauditdepartinvoicesother do
  begin
    Params.ParamValues['departinvoiceotherid_cancel'] := ids;
    Execute;
    sResult := Params.ParamValues['msg'];
    SysDialogs.ShowMessage(sResult);
  end;
  tbtnFilterClick(Sender);
end;

procedure TFrmDepartinvoices.btn3Click(Sender: TObject);
var
  multipleValueValue: TDictionary<String, String>;
  totledistance : Double;
begin

  inherited;
  totledistance := 0;
  if not dsResult.DataSet.Active then
    exit;
  if dsResult.DataSet.RecordCount < 1 then
    exit;

    if (Trim(jcdsResult.fieldbyname('statusname').AsString) = '已结算') or
     (Trim(jcdsResult.fieldbyname('isauditvalue').AsString) = '审核') then
    begin
      SysDialogs.ShowMessage('该手工单已结算或者已审核,不允许重打！');
    exit;
    end;

    if templtename='' then
       templtename := TNovaPrint.GetTicketModelName('结算单', '默认结算单');
  if not Assigned(billPinter) then
     billPinter := TNovaPrint.Create(self, templtename);
  if not Assigned(printValue) then
    printValue := TDictionary<String, String>.Create
  else
    printValue.Clear;
  try

    with  jcdsResult do
    begin
        printValue.Add('agentfee', fieldbyname('agentfee').AsString);
        printValue.Add('balanceamount',fieldbyname('balancemoney').AsString);
        printValue.Add('uuname', fieldbyname('unname').AsString);
        printValue.Add('ufname', fieldbyname('unfullname').AsString);
        printValue.Add('departdate', fieldbyname('departdate').AsString);
        printValue.Add('departtime', fieldbyname('departtime').AsString);
        printValue.Add('driver1', fieldbyname('d1name').AsString);
        printValue.Add('driver2', fieldbyname('d2name').AsString);
        printValue.Add('stewardname', fieldbyname('ste1name').AsString);
        printValue.Add('usiname', fieldbyname('seller').AsString);
        printValue.Add('reachstation',
          fieldbyname('reachstationname').AsString);
        printValue.Add('endstation',
          fieldbyname('reachstationname').AsString);
        printValue.Add('fullpeople', fieldbyname('ticketnum').AsString);
        printValue.Add('ticketnum', fieldbyname('ticketnum').AsString);
        printValue.Add('invoicesno',
          fieldbyname('departinvoicesno').AsString);
        printValue.Add('printby', SysInfo.LoginUserInfo.UserName);
        printValue.Add('printtime',FormatDateTime('yyyy-mm-dd HH:mm:ss',now));
        printValue.Add('printstation', SysInfo.LoginUserInfo.stationName);
        printValue.Add('routename', fieldbyname('routename').AsString);
        printValue.Add('distance', fieldbyname('distance').AsString);
        printValue.Add('vehicleno', fieldbyname('vehiclename').AsString);
        printValue.Add('planseatnum', fieldbyname('seatnum').AsString);
        printValue.Add('stationservicefee',
          fieldbyname('stationfee').AsString);
        printValue.Add('ticketoutlet',SysInfo.LoginUserInfo.ticketoutletsname);
        printValue.Add('balanceunit', fieldbyname('balanceunitname').AsString);
        printValue.Add('totalamount', fieldbyname('totalmoney').AsString);
        printValue.Add('schedulecode', fieldbyname('schedulecode').AsString);
        printValue.Add('unit', fieldbyname('unitname').AsString);
        printValue.Add('balanceunitfullname',
          fieldbyname('balanceunitname').AsString);
        printValue.Add('vtname', fieldbyname('vehicletypename').AsString);
        printValue.Add('noagentbalanceprice',FieldByName('balancemoney').AsString);

    end;

  if not Assigned(multiplelist) then
    multiplelist := TList < TDictionary < String, String >> .Create
  else
    multiplelist.Clear;
  with jsnclntdtstQrydepartinvoicesotherdetail do
  begin
    Active := false;
    Params.ParamValues['filter_EQL_t!departinvoicesotherid'] :=
        jcdsResult.fieldbyname('id').AsString;
    Active := true;
    first;
    if RecordCount > 0 then
    begin
      while (not Eof) do
      begin

         multipleValueValue := TDictionary<String, String>.Create;
         multipleValueValue.Add('fromstation', fieldbyname('fromstationname').AsString);
         multipleValueValue.Add('reachstation',
                    FieldByName('reachstationname').AsString);
          multipleValueValue.Add('price',
            FieldByName('price').AsString);
          multipleValueValue.Add('distance',
            FieldByName('distance').AsString);
          multipleValueValue.Add('totalamount',
            FieldByName('totalamount').AsString);
          multipleValueValue.Add('balanceprice',FieldByName('balanceprice').AsString);
          multipleValueValue.Add('balanceamount',FieldByName('balanceamount').AsString);
         //multipleValueValue.Add('noservicestationfee', FieldByName('noservicestationfee').AsString);
//                  multipleValueValue.Add('noservicestationfee',
//                    FloatToStr((FieldByName('noservicestationfee').AsFloat)/(FieldByName('fullpeople').AsInteger)));  //新增只扣除站务费的结算单价，按到达站分组
          multipleValueValue.Add('noagentbalanceamount',FieldByName('balanceamount').AsString);
          multipleValueValue.Add('fullpeople',FieldByName('qticketnum').AsString);
          multipleValueValue.Add('halfpeople',FieldByName('bticketnum').AsString);
          multipleValueValue.Add('psdistance',FieldByName('totaldistance').AsString);
          totledistance := totledistance + FieldByName('totaldistance').AsFloat;
          multiplelist.Add(multipleValueValue);
          Next;
      end;

    end;
  end;
         if totledistance>0 then
            printValue.Add('totalpsdistance',FloatToStr(totledistance));
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

procedure TFrmDepartinvoices.btn4Click(Sender: TObject);
begin
  inherited;
  if not jcdsResult.Active then
    Exit;
  if jcdsResult.RecordCount = 0 then
    Exit;

  FrmDptotherDetail := TFrmDptotherDetail.Create(self);
  with FrmDptotherDetail do
  begin
    caption:='手工单明细';
    with jcdsQrydepartinvoicesotherdetail do
    begin
      Active := False;
      Params.ParamValues['filter_EQL_t!departinvoicesotherid'] := jcdsResult.FieldByName('id').AsInteger;
      Active := true;
    end;
    showModal;
  end;
end;

procedure TFrmDepartinvoices.btndelDepClick(Sender: TObject);
var
  nResult: LongWord;
  sResult, log: string;
begin
  inherited;
  if not dataSource.DataSet.Active then
    exit;
  if dataSource.DataSet.RecordCount < 1 then
    exit;
  if Trim(jcdsResult.fieldbyname('statusname').AsString) = '已结算' then
  begin
    SysDialogs.ShowMessage('该补录结算单已经结算，不能删除!');
    exit;
  end;

end;

procedure TFrmDepartinvoices.btnInsertDepClick(Sender: TObject);
begin
  inherited;
  {
    if not dsResult.DataSet.Active then
    Exit;
    if dsResult.DataSet.RecordCount < 1 then
    Exit;
    if Trim(jcdsResult.FieldByName('statusname').AsString) = '已结算' then
    begin
    SysDialogs.ShowMessage('该补录结算单已经结算，不能添加补录明细!');
    Exit;
    end;
    //grpdetail.Visible := True;
    nvhlpdepartstation.SetFocus;
    //  with FrmDepartinvoicesotherdetail do
    //  begin
    //    FrmDepartinvoicesotherdetail := TFrmDepartinvoicesotherdetail.Create(Self);
    //    Caption := '结算单补录明细';
    //    sign := true;
    //    departinvoicesotherid := jcdsResult.FieldByName('id').AsString;
    //    scheduleid := jcdsResult.FieldByName('scheduleid').AsString;
    //    if jcdsResult.FieldByName('isreturntrip').AsBoolean = False then
    //      departdate := jcdsResult.FieldByName('selfdepartdate').AsString
    //    else
    //      departdate := jcdsResult.FieldByName('departdate').AsString;
    //    departtime := jcdsResult.FieldByName('departtime').AsString;
    //    if jcdsResult.FieldByName('isreturntrip').AsBoolean = True then
    //    begin
    //      edtdeparttime.Enabled := True;
    //    end;
    //    ShowModal;
    //    if ModalResult = mrOk then
    //    begin
    //      tbtnFilterClick(Self);
    //      jcdsResult.Locate('id',departinvoicesotherid,[]);
    //      //jcdsResult1.Locate('id',id, []);
    //    end;
    //  end; }
end;

procedure TFrmDepartinvoices.btnUpdateDepClick(Sender: TObject);
begin
  inherited;
  if not dataSource.DataSet.Active then
    exit;
  if dataSource.DataSet.RecordCount < 1 then
    exit;
  if Trim(jcdsResult.fieldbyname('statusname').AsString) = '已结算' then
  begin
    SysDialogs.ShowMessage('该补录结算单已经结算，不能修改!');
    exit;
  end;
  with FrmDepartinvoicesotherdetail do
  begin
    FrmDepartinvoicesotherdetail := TFrmDepartinvoicesotherdetail.Create(self);
    Caption := '结算单补录明细';
    sign := true;
    id := jcdsResult1.fieldbyname('id').AsString;
    departinvoicesno := jcdsResult1.fieldbyname('departinvoicesno').AsString;
    departinvoicesotherid := jcdsResult1.fieldbyname('departinvoicesotherid')
      .AsString;
    departdate := jcdsResult1.fieldbyname('departdate').AsString;
    departtime := jcdsResult1.fieldbyname('departtime').AsString;
    createby := jcdsResult1.fieldbyname('createby').AsString;
    createtime := jcdsResult1.fieldbyname('createtime').AsString;
    scheduleid := jcdsResult1.fieldbyname('scheduleid').AsString;
    nvhlpdepartstation.Text := jcdsResult1.fieldbyname('fromstationname')
      .AsString;
    departstation := jcdsResult1.fieldbyname('fromstationname').AsString;
    nvhlpdepartstation.id := jcdsResult1.fieldbyname('fromstationid').AsInteger;
    nvhlpendstation.Text := jcdsResult1.fieldbyname('reachstationname')
      .AsString;
    reachestation := jcdsResult1.fieldbyname('reachstationname').AsString;
    nvhlpendstation.id := jcdsResult1.fieldbyname('reachstationid').AsInteger;
    cbbtickettype.Text := jcdsResult1.fieldbyname('ticketname').AsString;
    tickettype := jcdsResult1.fieldbyname('ticketname').AsString;
    cbbtickettypeid := jcdsResult1.fieldbyname('tickettypeid').AsString;
    edtdistance.Text := jcdsResult1.fieldbyname('distance').AsString;
    distance := jcdsResult1.fieldbyname('distance').AsString;
    edtticketprice.Text := jcdsResult1.fieldbyname('price').AsString;
    price := jcdsResult1.fieldbyname('price').AsString;
    edtnum.Text := jcdsResult1.fieldbyname('ticketnum').AsString;
    ticketnum := jcdsResult1.fieldbyname('ticketnum').AsString;
    edtstationservicefree.Text := jcdsResult1.fieldbyname('stationservicefee')
      .AsString;
    stationfee := jcdsResult1.fieldbyname('stationservicefee').AsString;
    edtotherfee.Text := jcdsResult1.fieldbyname('othterfee').AsString;
    otherfee := jcdsResult1.fieldbyname('othterfee').AsString;
    edtagentfee.Text := jcdsResult1.fieldbyname('agentfee').AsString;
    agentfee := jcdsResult1.fieldbyname('agentfee').AsString;
    edtbalanceamount.Text := jcdsResult1.fieldbyname('balanceamount').AsString;
    balancefee := jcdsResult1.fieldbyname('balanceamount').AsString;

    ShowModal;
    if ModalResult = mrOk then
    begin
      tbtnFilterClick(self);
      jcdsResult.Locate('id', departinvoicesotherid, []);
      jcdsResult1.Locate('id', id, [])
    end;
  end;
end;

procedure TFrmDepartinvoices.dtpFromClick(Sender: TObject);
begin
  inherited;
    dtpEnd.Checked:=dtpFrom.Checked;
end;

procedure TFrmDepartinvoices.edtagentfeeChange(Sender: TObject);
begin
  inherited;
  // edtbalanceamount.Text := formatfloat('0.00',StrToFloat(edtticketprice.Text)*StrToInt(edtnum.Text)-
  // StrToFloat(edtstationservicefree.Text)-StrToFloat(edtotherfee.Text)-StrToFloat(edtagentfee.Text));

end;

procedure TFrmDepartinvoices.edtagentfeeExit(Sender: TObject);
begin
  inherited;
  { edtagentfee.Text := formatfloat('0.00', StrToFloat(edtagentfee.Text));
    if Length(Trim(edtagentfee.Text)) > 11 then
    begin
    SysDialogs.ShowMessage('客运代理费只能输入8位整数！');
    edtagentfee.SetFocus;
    Exit;
    end; }
end;

procedure TFrmDepartinvoices.edtnumChange(Sender: TObject);
begin
  inherited;
  // edtbalanceamount.Text := formatfloat('0.00',StrToFloat(edtticketprice.Text)*StrToInt(edtnum.Text)-
  // StrToFloat(edtstationservicefree.Text)-StrToFloat(edtotherfee.Text)-StrToFloat(edtagentfee.Text));
end;

procedure TFrmDepartinvoices.edtnumKeyPress(Sender: TObject; var Key: Char);
begin
  inherited;
  case Key of
    '0' .. '9', #8, #13, #27:
      ;
  else
    begin
      MessageBox(Handle, '请输入数字', PChar('输入错误'), MB_OK + MB_ICONINFORMATION);
      Key := #0;
    end;
  end;
end;

procedure TFrmDepartinvoices.edtotherfeeChange(Sender: TObject);
begin
  inherited;
  // edtbalanceamount.Text := formatfloat('0.00',StrToFloat(edtticketprice.Text)*StrToInt(edtnum.Text)-
  // StrToFloat(edtstationservicefree.Text)-StrToFloat(edtotherfee.Text)-StrToFloat(edtagentfee.Text));

end;

procedure TFrmDepartinvoices.edtotherfeeExit(Sender: TObject);
begin
  inherited;
  // edtbalanceamount.Text := formatfloat('0.00',StrToFloat(edtticketprice.Text)*StrToInt(edtnum.Text)-
  // StrToFloat(edtstationservicefree.Text)-StrToFloat(edtotherfee.Text)-StrToFloat(edtagentfee.Text));
  { edtotherfee.Text := formatfloat('0.00', StrToFloat(edtotherfee.Text));
    if Length(Trim(edtotherfee.Text)) > 11 then
    begin
    SysDialogs.ShowMessage('其他金额只能输入8位整数！');
    edtotherfee.SetFocus;
    Exit;
    end; }
end;

procedure TFrmDepartinvoices.edtstationservicefreeChange(Sender: TObject);
begin
  inherited;
  // edtbalanceamount.Text := formatfloat('0.00',StrToFloat(edtticketprice.Text)*StrToInt(edtnum.Text)-
  // StrToFloat(edtstationservicefree.Text)-StrToFloat(edtotherfee.Text)-StrToFloat(edtagentfee.Text));

end;

procedure TFrmDepartinvoices.edtstationservicefreeExit(Sender: TObject);
begin
  inherited;
  { edtstationservicefree.Text := formatfloat('0.00', StrToFloat(edtstationservicefree.Text));
    if Length(Trim(edtstationservicefree.Text)) > 11 then
    begin
    SysDialogs.ShowMessage('站务费只能输入8位整数！');
    edtstationservicefree.SetFocus;
    Exit;
    end; }
end;

procedure TFrmDepartinvoices.edtticketpriceChange(Sender: TObject);
begin
  inherited;
  // edtbalanceamount.Text := formatfloat('0.00',StrToFloat(edtticketprice.Text)*StrToInt(edtnum.Text)-
  // StrToFloat(edtstationservicefree.Text)-StrToFloat(edtotherfee.Text)-StrToFloat(edtagentfee.Text));
end;

procedure TFrmDepartinvoices.edtticketpriceExit(Sender: TObject);
begin
  inherited;
  // edtticketprice.Text := formatfloat('0.00', StrToFloat(edtticketprice.Text));
end;

procedure TFrmDepartinvoices.FormCreate(Sender: TObject);
begin
  inherited;
  //参数查询
  with jcdsFindParameters do
  begin
    Active := False;
      Params.ParamValues['code'] := '''4050'', ''3068''';

      if sysinfo.LoginUserInfo.orgid <= 0 then
      begin
        Params.ParamValues['orgid'] := null;
      end
      else
      begin
        Params.ParamValues['orgid'] := sysinfo.LoginUserInfo.orgid;
      end;
    Active := True;

    if RecordCount > 0 then
    begin
      param_4050 := FieldByName('4050').AsString; //4050：手工单结算是否需要审核，0不需要，1需要，默认为0
      param_3068 := FieldByName('3068').AsString; //3068:手工结算单是否进行自动结算扣费  0否，1是
    end;
  end;
end;

procedure TFrmDepartinvoices.FormKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  // inherited;

  if (Key = vk_return) then
    Key := 0;
  if (Key = vk_F2) then
  begin
    Key := 0;
    if not dsResult.DataSet.Active then
      exit;
    if dsResult.DataSet.RecordCount < 1 then
      exit;
    if Trim(jcdsResult.fieldbyname('statusname').AsString) = '已结算' then
    begin
      SysDialogs.ShowMessage('该补录结算单已经结算，不能添加补录明细!');
      exit;
    end;
    // grpdetail.Visible := True;
    // self.nvhlpdepartstation.SetFocus;
  end
  else if Key = VK_F1 then
  begin
    tbtnInsertClick(self);
  end;
end;

procedure TFrmDepartinvoices.FormShow(Sender: TObject);
begin
  inherited;
  dtpstartdate.DateTime := Now;
  dtpenddate.DateTime := Now;
  dtpFrom.DateTime:= Now;
  dtpend.DateTime:= Now;
  cbborg.Active := false;
  cbborg.Active := true;
  cobworkways.Active := false;
  cobworkways.Active := true;
  NovaCobDataFroms.Active := false;
  NovaCobDataFroms.Active := true;
  isEnable(false);
//  if getParametervalue('4050', sysinfo.LoginUserInfo.OrgID) = '1' then
  //4050：手工单结算是否需要审核，0不需要，1需要，默认为0
  if param_4050 = '1' then
  begin
    dbgrdhResult.Columns[3].Visible := true;
  end;
  dbgrdhResult.GridUser := sysinfo.LoginUserInfo.UserID;
end;

procedure TFrmDepartinvoices.jcdsResultAfterOpen(DataSet: TDataSet);
begin
  inherited;
  if dsResult.DataSet.RecordCount < 1 then
  begin
    isEnable(false);
    jcdsResult1.close;
  end;
end;

procedure TFrmDepartinvoices.jcdsResultAfterScroll(DataSet: TDataSet);
begin
  inherited;
  { if not dsResult.DataSet.Active then
    Exit;
    if dsResult.DataSet.RecordCount < 1 then
    Exit;
    isEnable(True);
    with jcdsResult1 do
    begin
    Active:=false;
    Params.ParamValues['filter_EQL_t!departinvoicesotherid'] :=jcdsResult.FieldByName('id').AsString;
    Active:=true;
    end; }
end;

procedure TFrmDepartinvoices.N1Click(Sender: TObject);
begin
  inherited;
  with jcdsResult do
  begin
    if Active and (RecordCount > 0) then
    begin
      first;
      while (not eof) do
      begin
        edit;
        fieldbyname('ischoose').value := true;
        next;
      end;
    end;
  end;
end;

procedure TFrmDepartinvoices.N2Click(Sender: TObject);
begin
  inherited;
  with jcdsResult do
  begin
    if Active and (RecordCount > 0) then
    begin
      first;
      while (not eof) do
      begin
        edit;
        fieldbyname('ischoose').value := not fieldbyname('ischoose').AsBoolean;
        next;
      end;
    end;
  end;
end;

procedure TFrmDepartinvoices.N3Click(Sender: TObject);
begin
  inherited;
  with jcdsResult do
  begin
    if Active and (RecordCount > 0) then
    begin
      first;
      while (not eof) do
      begin
        edit;
        fieldbyname('ischoose').value := false;
        next;
      end;
    end;
  end;
end;

procedure TFrmDepartinvoices.nvhlpdepartstationEnter(Sender: TObject);
begin
  inherited;
  if Trim(jcdsResult.fieldbyname('statusname').AsString) = '已结算' then
  begin
    SysDialogs.ShowMessage('该补录结算单已经结算，不能添加补录明细!');
    dbgrdhResult.SetFocus;
    exit;
  end;
end;

procedure TFrmDepartinvoices.tbtnDeleteClick(Sender: TObject);
var
  nResult: LongWord;
  sResult, ids: string;
begin
  inherited;
  if not dsResult.DataSet.Active then
    exit;
  if dsResult.DataSet.RecordCount < 1 then
    exit;
  with jcdsResult do
  begin
    try
      DisableControls;
      first;
      while not eof do
      begin
        if jcdsResult.fieldbyname('ischoose').AsBoolean then
        begin
          ids := ids + jcdsResult.fieldbyname('id').AsString + ',';
          if (Trim(jcdsResult.fieldbyname('statusname').AsString) = '已结算') or
            (Trim(jcdsResult.fieldbyname('isauditvalue').AsString) = '审核') then
          begin
            SysDialogs.ShowMessage('已经结算和审核状态的手工单不能修改!');
            exit;
          end;
        end;
        next;
      end;
    finally
      EnableControls;
    end;
  end;
  if ids = '' then
  begin
    SysDialogs.ShowMessage('请勾选要删除的对象');
    exit;
  end;
  if not SysDialogs.Confirm('信息提示', '确认要删除该记录吗!') then
    exit;
  with jcdsResultDelDepartinvoicesother do
    try
      close;
      Params.ParamByName('departinvoiceotherid_del').value := ids;

      Execute;
      nResult := Params.ParamByName('flag').value;
      sResult := Params.ParamByName('msg').value;
      SysDialogs.ShowMessage(sResult);
      if (nResult = 1) then
      begin
        tbtnFilterClick(Sender);
      end;
    except
      on E: Exception do
      begin
        SysLog.WriteErr('结算单补录信息删除失败：' + E.Message);
      end;
    end;
end;

procedure TFrmDepartinvoices.tbtnEditClick(Sender: TObject);
begin
  inherited;
  if not dsResult.DataSet.Active then
    exit;
  if dsResult.DataSet.RecordCount < 1 then
    exit;
  if (Trim(jcdsResult.fieldbyname('statusname').AsString) = '已结算') or
    (Trim(jcdsResult.fieldbyname('isauditvalue').AsString) = '审核') then
  begin
    SysDialogs.ShowMessage('已经结算和审核状态的手工单不能修改!');
    exit;
  end;

  FrmDepartinvoicesotherAdd := TFrmDepartinvoicesotherAdd.Create(self);
  with FrmDepartinvoicesotherAdd do
  begin

    Caption := '结算单补录';
    p3068 := param_3068;//3068:手工结算单是否进行自动结算扣费  0否，1是
    sign := true;
    // 补开结算单的时候是否填写售票员 0:否 1:是
    {if getParametervalue('3066', sysinfo.LoginUserInfo.OrgID) = '0' then
    begin
      nvhlpseller.Visible := false;
      Label20.Visible := false;
    end
    else
    begin
      nvhlpseller.Visible := true;
      Label20.Visible := true;
    end;  }
    departinvoicesotherid := jcdsResult.fieldbyname('id').AsInteger;
    createby := jcdsResult.fieldbyname('createby').AsString;
    createtime := jcdsResult.fieldbyname('createtime').AsString;
    OrgID := jcdsResult.fieldbyname('orgid').AsString;
    nvhlpvehicle.Text := jcdsResult.fieldbyname('vehiclename').AsString;
    nvhlpvehicle.OnIdChange := nil; // 先关闭车牌控件的onidchange事件
    nvhlpvehicle.id := jcdsResult.fieldbyname('vehicleid').AsInteger;
    nvhlpvehicle.OnIdChange := nvhlpvehicle.OnIdChange; // 打开车牌控件的onidchange事件
    NovaCobDataFrom.SetItemIndexByCode(jcdsResult.fieldbyname('datafrom')
        .AsString);
    with jcdsQryvehicleid do
    begin
      Active := false;
      Params.ParamValues['vehicleid'] := nvhlpvehicle.id;
      Active := true;
      nvhelpunit.id := jcdsQryvehicleid.fieldbyname('unitid').AsInteger;
      nvhelpunit.Text := jcdsQryvehicleid.fieldbyname('unitname').AsString;
      nvhelpunit.Enabled := false;
      cbbvehicletype.Text := jcdsQryvehicleid.fieldbyname('value').AsString;
      cbbvehicletype.SetItemIndexByCode(jcdsQryvehicleid.fieldbyname('type')
          .AsString);
      cbbvehicletype.Enabled := false;
    end;
    nvhlpdepartstation.Text := jcdsResult.fieldbyname('departname').AsString;
    nvhlpdepartstation.id := jcdsResult.fieldbyname('departstationid')
      .AsInteger;
    edtDepartinvoicesno.Text := jcdsResult.fieldbyname('departinvoicesno')
      .AsString;
    // nvhlpschedule.Text := jcdsResult.FieldByName('schedulecode').AsString;
    // scheduleid := jcdsResult.FieldByName('scheduleid').AsInteger;
    dtpdepartdate.DateTime := jcdsResult.fieldbyname('departdate').AsDateTime;
    nvhlptime.Text := jcdsResult.fieldbyname('departtime').AsString;
    // dtpselfdepartdate.DateTime := jcdsResult.FieldByName('selfdepartdate').AsDateTime;
    NovaEbalancemoney.Text := jcdsResult.fieldbyname('balancemoney').AsString;
    if jcdsResult.fieldbyname('isreturntrip').value = 'true' then
    begin
      rgreturntrip.ItemIndex := 1;
      gotoway := '回程';
    end
    else
    begin
      rgreturntrip.ItemIndex := 0;
      gotoway := '去程';
    end;
    {
      if jcdsResult.FieldByName('isoriginator').Value = 'true' then
      begin
      rgoriginator.ItemIndex := 1;
      departway := '始发';
      end
      else
      begin
      rgoriginator.ItemIndex := 0;
      departway := '中途';
      end; }
    // rgreturntrip.ItemIndex := jcdsResult.FieldByName('isreturntrip').AsInteger;
    // rgoriginator.ItemIndex := jcdsResult.FieldByName('isoriginator').AsInteger;
    cbbdriver1id.Text := jcdsResult.fieldbyname('d1name').AsString;
    cbbdriver2id.Text := jcdsResult.fieldbyname('d2name').AsString;
    cbbsteward1id.Text := jcdsResult.fieldbyname('ste1name').AsString;
    driver1id := jcdsResult.fieldbyname('driver1id').AsInteger;
    driver2id := jcdsResult.fieldbyname('driver2id').AsInteger;

    steward1id := jcdsResult.fieldbyname('steward1id').AsInteger;

    nvhlpschedule.Text := jcdsResult.fieldbyname('schedulecode').AsString;
    scheduleid := jcdsResult.fieldbyname('scheduleid').AsInteger;
    nvhlpschedule.id := jcdsResult.fieldbyname('scheduleid').AsInteger;
    // nvhlptime.Text := jcdsResult.FieldByName('starttime').AsString;
    // nvhlpschedule.Enabled := false;

    departdate := jcdsResult.fieldbyname('departdate').AsString;
    vehicleno := jcdsResult.fieldbyname('vehiclename').AsString;
    departno := jcdsResult.fieldbyname('departinvoicesno').AsString;
    departstation := jcdsResult.fieldbyname('departname').AsString;
    driver1 := jcdsResult.fieldbyname('d1name').AsString;
    driver2 := jcdsResult.fieldbyname('d2name').AsString;

    steward1 := jcdsResult.fieldbyname('ste1name').AsString;
    nvhlp1.id := jcdsResult.fieldbyname('balanceunitid').AsLargeInt;
    nvhlp1.Text := jcdsResult.fieldbyname('balanceunitname').AsString;
    nvhlpseller.id := jcdsResult.fieldbyname('sellerid').AsLargeInt;
    nvhlpseller.Text := jcdsResult.fieldbyname('seller').AsString;
    ShowModal;
    if ModalResult = mrOk then
    begin
      tbtnFilterClick(Sender);
      jcdsResult.Locate('id', departinvoicesotherid, []);
    end;
  end;
end;

procedure TFrmDepartinvoices.tbtnFilterClick(Sender: TObject);
begin
  inherited;
  with jcdsResult do
  begin
    Active := false;
    Params.ParamValues['filter_GED_d!departdate'] := DateTimeToStr
      (dtpstartdate.DateTime - 1); // )
    Params.ParamValues['filter_LED_d!departdate'] := DateTimeToStr
      (dtpenddate.DateTime); //
    if dtpFrom.Checked then
    begin
      Params.ParamValues['filter_GED_d!createtime'] :=FormatDateTime('yyyy-mm-dd',dtpFrom.DateTime); // )
      Params.ParamValues['filter_LED_d!createtime'] := FormatDateTime('yyyy-mm-dd',dtpEnd.DateTime+1);
    end
    else
    begin
      Params.ParamValues['filter_GED_d!createtime'] :=null;
      Params.ParamValues['filter_LED_d!createtime'] :=null;
    end;
    if Trim(nvhlpvehicle.Text) = '' then
    begin
      Params.ParamValues['filter_EQL_v!id'] := '';
    end
    else
    begin
      Params.ParamValues['filter_EQL_v!id'] := nvhlpvehicle.id;
    end;
    if cbborg.CheckedCount = 0 then
      Params.ParamValues['filter_INS_d!orgid'] := sysinfo.LoginUserInfo.OrgIDs
    else
      Params.ParamValues['filter_INS_d!orgid'] := cbborg.GetSelectID;

    if cobworkways.ItemIndex > 0 then
      Params.ParamValues['filter_EQS_s!workways'] := inttostr
        (cobworkways.ItemIndex - 1)
    else
      Params.ParamValues['filter_EQS_s!workways'] := '';

    if Trim(nvedtno.Text) = '' then
    begin
      Params.ParamValues['filter_EQS_d!departinvoicesno'] := '';
    end
    else
    begin
      Params.ParamValues['filter_EQS_d!departinvoicesno'] := Trim(nvedtno.Text);
    end;

    if Trim(NHelpRoute.Text) = '' then
    begin
      Params.ParamValues['filter_EQS_s!routeid'] := '';
    end
    else
    begin
      Params.ParamValues['filter_EQS_s!routeid'] := inttostr(NHelpRoute.id);
    end;

    if Trim(nvhlpcreatedby.Text) = '' then
    begin
      Params.ParamValues['filter_EQS_d!createby'] := '';
    end
    else
    begin
      Params.ParamValues['filter_EQS_d!createby'] := inttostr(nvhlpcreatedby.id);
    end;
    //
    if Trim(nvhlseller.Text) = '' then
    begin
      Params.ParamValues['filter_EQS_d!seller'] := '';
    end
    else
    begin
      Params.ParamValues['filter_EQS_d!seller'] := inttostr(nvhlseller.id);
    end;

    if nvhlpschedule.id > 0 then
      Params.ParamValues['filter_EQL_d!scheduleid'] := nvhlpschedule.id
    else
      Params.ParamValues['filter_EQL_d!scheduleid'] := null;
    if NovaCobDataFroms.ItemIndex >= 0 then
    begin
      Params.ParamValues['filter_EQS_d!datafrom'] := NovaCobDataFroms.ItemIndex;
    end
    else
      Params.ParamValues['filter_EQS_d!datafrom'] := null;

    if Trim(nvhlpDeparts.Text) <> '' then
    begin
      Params.ParamValues['filter_EQS_d!departstationid'] := nvhlpDeparts.id;
    end
    else
      Params.ParamValues['filter_EQS_d!departstationid'] := null;
    // if Trim(NovaHelpUnit.HelpFieldValue['id']) <> '' then
    // begin
    // Params.ParamValues['filter_EQS_v!unitid'] := NovaHelpUnit.HelpFieldValue['id'];
    // end
    // else
    // Params.ParamValues['filter_EQS_v!unitid'] := null;

    if NovaHelpUnit.Text<>'' then
      Params.ParamValues['filter_EQS_v!unitid'] := NovaHelpUnit.Id
    else
      Params.ParamValues['filter_EQS_v!unitid'] := '';
    Active := true;
  end;
end;

procedure TFrmDepartinvoices.tbtnInsertClick(Sender: TObject);
begin
  inherited;
  { with FrmDepartinvoicesotherEdit do
    begin
    FrmDepartinvoicesotherEdit := TFrmDepartinvoicesotherEdit.Create(Self);
    Caption := '结算单补录';
    sign := true;
    ShowModal;
    if ModalResult = mrOk then
    begin
    tbtnFilterClick(Self);
    jcdsResult.Locate('id',id,[]);
    //grpdetail.Visible := true;
    end;
    end; }
  FrmDepartinvoicesotherAdd := TFrmDepartinvoicesotherAdd.Create(self);
  with FrmDepartinvoicesotherAdd do
  begin

    Caption := '结算单补录';
    p3068 := param_3068;//3068:手工结算单是否进行自动结算扣费  0否，1是
    sign := true;
    // 补开结算单的时候是否填写售票员 0:否 1:是
    {if getParametervalue('3066', sysinfo.LoginUserInfo.OrgID) = '0' then
    begin
      nvhlpseller.Visible := false;
      Label20.Visible := false;
    end
    else
    begin
      nvhlpseller.Visible := true;
      Label20.Visible := true;
    end;}
    if SysMainForm.showFormModal(FrmDepartinvoicesotherAdd) = mrok then
    begin
      tbtnFilterClick(self);
      jcdsResult.Locate('id', departinvoicesotherid, []);
    end;
  end;

end;

procedure TFrmDepartinvoices.HandleAuthority(const Key: TGUID;
  aEnable: Boolean);
begin
  inherited;
  //
  if GUIDToString(Key) = '{2E6D45A1-815D-43EB-AD91-5D756B7E4B47}' then
  begin
    ToolButton50.Visible := aEnable;
  end;
  if GUIDToString(Key) = '{CF46C104-B4CF-4D2B-AA0B-FD200821A6CD}' then
  begin
    ToolButton51.Visible := aEnable;
  end;
  if GUIDToString(Key) = '{C8F138F2-09BD-496C-94F1-68BF88508ED4}' then
  begin
    btn3.Enabled := true;
  end;
end;

end.
