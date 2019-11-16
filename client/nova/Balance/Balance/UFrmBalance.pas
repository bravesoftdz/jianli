unit UFrmBalance;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, USimpleCRUDForm, DBGridEhGrouping, NvPrnDbgeh, DB, DBClient,
  jsonClientDataSet, ImgList, GridsEh, DBGridEh, NvDbgridEh, StdCtrls, ComCtrls,
  ToolWin, ExtCtrls, NovaEdit, NovaHelp, NovaCheckedComboBox, Menus,
  Generics.Collections, FunctionItemIntf, Buttons, NovaHComboBox;

type

  TNodeInfo = record
    id: int64;
    arealevel: integer;
    name: string;
    pcode: string;
    code: string;
  end;

  PNodeInfo = ^TNodeInfo;

  TFrmBalance = class(TSimpleCRUDForm)
    GroupBox2: TGroupBox;
    TreeVItem: TTreeView;
    Panel2: TPanel;
    Label1: TLabel;
    NovaCkbOrg: TNovaCheckedComboBox;
    DpFromDepart: TDateTimePicker;
    DptoDepart: TDateTimePicker;
    Label2: TLabel;
    Label3: TLabel;
    Label5: TLabel;
    Label7: TLabel;
    NovaHelpUnit: TNovaHelp;
    Label8: TLabel;
    NovaHelpVehicle: TNovaHelp;
    Label6: TLabel;
    NovaEdtInvoicesno: TNovaEdit;
    ImageList: TImageList;
    PopupMenu1: TPopupMenu;
    N1: TMenuItem;
    N2: TMenuItem;
    jscdCreatetree: TjsonClientDataSet;
    NovaHelpCard: TNovaHelp;
    NHelpRoute: TNovaHelp;
    Label9: TLabel;
    Label10: TLabel;
    NovaHelpSchedule: TNovaHelp;
    jcdsGenData: TjsonClientDataSet;
    jscdDelData: TjsonClientDataSet;
    jcdsResultendstation: TWideStringField;
    jcdsResultdepartinvoicesno: TWideStringField;
    jcdsResultdepartdate: TDateField;
    jcdsResultcode: TWideStringField;
    jcdsResultdeparttime: TWideStringField;
    jcdsResultticketnum: TIntegerField;
    jcdsResulttotalamount: TFloatField;
    jcdsResultbalanceamount: TFloatField;
    jcdsResultprintname: TWideStringField;
    jcdsResultprinttime: TDateTimeField;
    jcdsResultunitname: TWideStringField;
    jcdsResultvehicleno: TWideStringField;
    jcdsResultid: TLargeintField;
    jcdsResultstationservicefee: TFloatField;
    jcdsResultfueladditionfee: TFloatField;
    jcdsResultagentfee: TFloatField;
    jcdsResultothterfee: TFloatField;
    jcdsResultstatus: TWideStringField;
    jcdsQryStatus: TjsonClientDataSet;
    jcdsResultstatusname: TWideStringField;
    jcdsQryDeductDetail: TjsonClientDataSet;
    GroupBox3: TGroupBox;
    NvDbgridEh1: TNvDbgridEh;
    dsDeduct: TDataSource;
    jcdsQryDeductDetaildeducttype: TWideStringField;
    jcdsQryDeductDetailname: TWideStringField;
    jcdsQryDeductDetailisdeductbeforebalance: TBooleanField;
    jcdsQryDeductDetaildeductmoney: TFloatField;
    jcdsQryDeductDetailtarget: TWideStringField;
    jcdsQryDeductDetailstartdate: TDateField;
    jcdsQryDeductDetailenddate: TDateField;
    jcdsQryDeducttype: TjsonClientDataSet;
    jcdsQryDeductDetaildeducttypename: TStringField;
    Splitter1: TSplitter;
    jcdsResultvehicleid: TLargeintField;
    jscdQryBalance: TjsonClientDataSet;
    jcdsResultroutename: TWideStringField;
    ds1: TDataSource;
    jscd1: TjsonClientDataSet;
    jscd1endstation: TWideStringField;
    jscd1departdate: TDateField;
    jscd1vehicleno: TWideStringField;
    jscd1departinvoicesno: TWideStringField;
    jscd1statusname: TWideStringField;
    jscd1code: TWideStringField;
    jscd1departtime: TWideStringField;
    jscd1ticketnum: TIntegerField;
    jscd1unitname: TWideStringField;
    pnl1: TPanel;
    spl1: TSplitter;
    pnl3: TPanel;
    grp1: TGroupBox;
    nvdbgrdh1: TNvDbgridEh;
    jscd1vehicleid: TLargeintField;
    jscd1id: TLargeintField;
    jscd1totalamount: TFloatField;
    jscd1balanceamount: TFloatField;
    jscd1stationservicefee: TFloatField;
    jscd1fueladditionfee: TFloatField;
    jscd1agentfee: TFloatField;
    jscd1othterfee: TFloatField;
    jscd1printname: TWideStringField;
    jscd1printtime: TDateTimeField;
    jscd1status: TWideStringField;
    jscd1routename: TWideStringField;
    pm1: TPopupMenu;
    N3: TMenuItem;
    N4: TMenuItem;
    chkAutoAdd: TCheckBox;
    chkscheduleTypeN: TCheckBox;
    chkscheduleTypeY: TCheckBox;
    jscdReCal: TjsonClientDataSet;
    jcdsResultrouteid: TLargeintField;
    jscd1routeid: TLargeintField;
    jcdsResultbalanceunitid: TLargeintField;
    jcdsResultbalanceunitname: TWideStringField;
    jscd1balanceunitname: TWideStringField;
    jscd1balanceunitid: TLargeintField;
    Label4: TLabel;
    NovachkStatus: TNovaCheckedComboBox;
    tbtnModifyBalance: TToolButton;
    ToolButton1: TToolButton;
    Label11: TLabel;
    nhcbbdepartinvoicestype: TNovaHComboBox;
    jcdsResultiscomputerno: TIntegerField;
    jcdsResultdepartinvoicetypename: TWideStringField;
    jscd1departinvoicetypename: TWideStringField;
    jcdsResultisaudit: TIntegerField;
    jcdsResultdatafrom: TWideStringField;
    jscd1datafrom: TWideStringField;
    procedure FormCreate(Sender: TObject);
    procedure tbtnCancelClick(Sender: TObject);
    procedure tbtnFilterClick(Sender: TObject);
    procedure TreeVItemClick(Sender: TObject);
    procedure tbtnInsertClick(Sender: TObject);
    procedure tbtnEditClick(Sender: TObject);
    procedure dbgrdhResultMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: integer);
    procedure dbgrdhResultMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: integer);
    procedure dbgrdhResultDrawColumnCell(Sender: TObject; const Rect: TRect;
      DataCol: integer; Column: TColumnEh; State: TGridDrawState);
    procedure NovaEdtInvoicesnoKeyPress(Sender: TObject; var Key: Char);
    procedure FormKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure dbgrdhResultDblClick(Sender: TObject);
    procedure nvdbgrdh1DblClick(Sender: TObject);
    procedure N1Click(Sender: TObject);
    procedure N2Click(Sender: TObject);
    procedure N3Click(Sender: TObject);
    procedure N4Click(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure jcdsResultAfterScroll(DataSet: TDataSet);
    procedure DptoDepartChange(Sender: TObject);
    procedure NHelpRouteKeyPress(Sender: TObject; var Key: Char);
    procedure NovaHelpScheduleKeyPress(Sender: TObject; var Key: Char);
    procedure NovaHelpVehicleKeyPress(Sender: TObject; var Key: Char);
    procedure NovaHelpUnitKeyPress(Sender: TObject; var Key: Char);
    procedure ToolButton52Click(Sender: TObject);
    procedure tbtnSaveClick(Sender: TObject);
    procedure ToolButton53Click(Sender: TObject);
    procedure tbtnModifyBalanceClick(Sender: TObject);
    procedure NovaHelpVehicleChange(Sender: TObject);

  private
    { Private declarations }
    vehiceid: int64;
    endstation: String;
    departdate: Tdate;
    vehicleno: String;
    departinvoicesno: string;
    statusname: string;
    code: string;
    departtime: string;
    ticketnum: integer;
    totalamount: Double;
    balanceamount: Double;
    stationservicefee: Double;
    fueladditionfee: Double;
    agentfee: Double;
    othterfee: Double;
    vehicleunitname: string;
    invoicesid: int64;
    printname: string;
    printtime: Tdate;
    status: string;
    routename: string;
    routeid: int64;
    balanceunitid: int64;
    balanceunitname: string;
    departinvoicetypename:string;
    datafrom : string;
    isNovaEdtInvoicesnoKeyPress: boolean;
    departinvoicesnolist: TList<String>;
    departinvoicesidlist: TList<int64>;
    // departinvoicesqryidlist: TList<int64>;
    procedure rightmove;
    procedure leftmove;
    procedure createtree;
    procedure qryDeductdetails(invoicesid: int64);
    procedure qryDepartinvoices(departinvoicesno: string);
  public
    { Public declarations }
    balancetype,packfeerate: string;
    pidiscomputerno: integer;
    procedure HandleAuthority(const Key: TGUID; aEnable: boolean); override;
  end;

var
  FrmBalance: TFrmBalance;

implementation

uses PubFn, Services, UDMPublic, UFrmBalanceInfo, UFrmBalanceEdit;
{$R *.dfm}
{ TFrmBalance }

procedure TFrmBalance.createtree;
var
  i, j, k: integer;
  ChildNode, ParentNode: TTreeNode; // 孩子结点
  ChildNodeInfo: PNodeInfo; // 孩子结点信息
begin
  with jscdCreatetree do
  begin
    Active := true;
    if RecordCount = 0 then
    begin
      TreeVItem.Items.clear;
      TreeVItem.Visible := false;
    end;
    TreeVItem.Items.clear;
    for j := 1 to RecordCount do
    begin
      New(ChildNodeInfo);
      ChildNodeInfo.id := FieldByName('id').AsLargeInt;
      ChildNodeInfo.pcode := FieldByName('pcode').AsString;
      ChildNodeInfo.arealevel := FieldByName('arealevel').AsInteger;
      ChildNodeInfo.name := FieldByName('name').AsString;
      ChildNodeInfo.code := FieldByName('code').AsString;

      if ChildNodeInfo.arealevel = 1 then // 省
      begin
        ParentNode := TreeVItem.Items.AddObject(nil, ChildNodeInfo.name,
          ChildNodeInfo); // 增加根节点（省）
        ParentNode.ImageIndex := 1;
        ParentNode.SelectedIndex := 1;
        ParentNode.OverlayIndex := 0;
      end
      else if ChildNodeInfo.arealevel = 2 then // 地市
      begin
        for i := 0 to TreeVItem.Items.Count - 1 do
        begin
          if (PNodeInfo(TreeVItem.Items.Item[i].Data)
              .code = ChildNodeInfo.pcode) then
          begin
            ChildNode := TreeVItem.Items.AddChildObject
              (TreeVItem.Items.Item[i], ChildNodeInfo.name, ChildNodeInfo);
            // 地市
            ChildNode.ImageIndex := 1;
            ChildNode.SelectedIndex := 1;
            ChildNode.OverlayIndex := 0;
          end;
        end;
      end
      else if ChildNodeInfo.arealevel = 3 then // 车属单位
      begin
        for i := 0 to TreeVItem.Items.Count - 1 do
          for k := 0 to TreeVItem.Items.Item[i].Count - 1 do
          begin
            if (PNodeInfo(TreeVItem.Items.Item[i].Item[k].Data)
                .code = ChildNodeInfo.pcode) then
            begin
              ChildNode := TreeVItem.Items.AddChildObject
                (TreeVItem.Items.Item[i].Item[k], ChildNodeInfo.name,
                ChildNodeInfo);
              ChildNode.ImageIndex := 1;
              ChildNode.SelectedIndex := 1;
              ChildNode.OverlayIndex := 0;
            end;
          end;
      end
      else if ChildNodeInfo.arealevel = 4 then // 车牌
      begin
        for i := 0 to TreeVItem.Items.Count - 1 do
          for k := 0 to TreeVItem.Items.Item[i].Count - 1 do
          begin
            if (PNodeInfo(TreeVItem.Items.Item[i].Item[k].Data)
                .code = ChildNodeInfo.pcode) then
            begin
              ChildNode := TreeVItem.Items.AddChildObject
                (TreeVItem.Items.Item[i].Item[k], ChildNodeInfo.name,
                ChildNodeInfo);
              ChildNode.ImageIndex := 1;
              ChildNode.SelectedIndex := 1;
              ChildNode.OverlayIndex := 0;
            end;
          end;
      end;
      Next;
    end;
    Active := false;
  end;
  TreeVItem.FullExpand;

  { if jscdCreatetree.RecordCount > 0 then
    BuildIDXTree(jscdCreatetree, TreeVItem, True)
    else
    TreeVItem.Items.Clear; }
end;

procedure TFrmBalance.dbgrdhResultDblClick(Sender: TObject);
begin
  inherited;
  rightmove;
end;

procedure TFrmBalance.dbgrdhResultDrawColumnCell(Sender: TObject;
  const Rect: TRect; DataCol: integer; Column: TColumnEh;
  State: TGridDrawState);
begin
  inherited;
  if (jcdsResult.FieldByName('status').AsString = '2') and not
    (gdSelected in State) then
  begin
    dbgrdhResult.Canvas.Font.Color := clGreen;
    dbgrdhResult.DefaultDrawColumnCell(Rect, DataCol, Column, State);
  end;
end;

procedure TFrmBalance.dbgrdhResultMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: integer);
begin
  inherited;
  jcdsResult.AfterScroll := nil;
end;

procedure TFrmBalance.dbgrdhResultMouseUp(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: integer);
begin
  inherited;
  jcdsResult.AfterScroll := jcdsResultAfterScroll;
end;

procedure TFrmBalance.DptoDepartChange(Sender: TObject);
begin
  inherited;
  if formatdatetime('yyyy-mm-dd', DpFromDepart.Date) > formatdatetime
    ('yyyy-mm-dd', DptoDepart.Date) then
  begin
    DpFromDepart.Date := DptoDepart.Date;
  end;
end;

procedure TFrmBalance.FormCreate(Sender: TObject);
var
  i: integer;
begin
  inherited;
  GroupBox2.Visible := false;
  // checkBillno('AccountBill');
  DpFromDepart.Date := now;
  DptoDepart.Date := now;
  NovaCkbOrg.Active := false;
  NovaCkbOrg.Active := true;
  NovaCkbOrg.CheckById(true, sysinfo.LoginUserInfo.OrgID);
  jcdsQryStatus.Active := false;
  jcdsQryStatus.Active := true;
  jcdsQryDeducttype.Active := false;
  jcdsQryDeducttype.Active := true;
  // createtree;
  departinvoicesnolist := TList<String>.Create;
  departinvoicesidlist := TList<int64>.Create;
  // departinvoicesqryidlist := TList<int64>.Create;
  balancetype := getParametervalue('4008', sysinfo.LoginUserInfo.OrgID);
  packfeerate := getParametervalue('8099', sysinfo.LoginUserInfo.OrgID);  //行包结算金额比率
end;

procedure TFrmBalance.FormKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;
  if isNovaEdtInvoicesnoKeyPress then
  begin
    Key := 0;
    isNovaEdtInvoicesnoKeyPress := false;
  end;
end;

procedure TFrmBalance.FormShow(Sender: TObject);
var
  packdeduct: string;
begin
  inherited;
  // 结算时，0：行包作为营收，1：行包作为扣费
  packdeduct := getParametervalue('8020', sysinfo.LoginUserInfo.OrgID);
  if packdeduct = '0' then
  begin
    tbtnInsert.Caption := '结算';
    tbtnEdit.Visible := false;
  end;
  NovaEdtInvoicesno.SetFocus;
  NovachkStatus.Active := false;
  NovachkStatus.Active := true;
  if NovachkStatus.Items.Count > 0 then
  begin
    NovachkStatus.SetCheck(0, true);
    NovachkStatus.SetCheck(3, true);
    // NovachkStatus.SetCheck(0,true);
  end;
end;

procedure TFrmBalance.HandleAuthority(const Key: TGUID; aEnable: boolean);
begin
  inherited;
  if GUIDToString(Key) = '{1BED0B8A-9598-4B94-94DA-49FC18289DB9}' then
  begin
    self.tbtnEdit.Visible := aEnable;
  end;

end;

procedure TFrmBalance.jcdsResultAfterScroll(DataSet: TDataSet);
begin
  inherited;
  qryDeductdetails(jcdsResult.FieldByName('id').AsLargeInt);
end;

procedure TFrmBalance.leftmove;
var
  isexist: boolean;
begin
  if not jscd1.Active then
    Exit;
  if self.jscd1.RecordCount = 0 then
    Exit;

  invoicesid := jscd1.FieldByName('id').AsLargeInt;
  departinvoicesno := jscd1.FieldByName('departinvoicesno').AsString;
  if departinvoicesidlist.IndexOf(invoicesid) >= 0 then
  begin
    isexist := false;
    with jscd1 do
    begin
      endstation := FieldByName('endstation').AsString;
      departdate := FieldByName('departdate').AsDateTime;
      departinvoicetypename := FieldByName('departinvoicetypename').AsString;
      vehicleno := FieldByName('vehicleno').AsString;
      statusname := FieldByName('statusname').AsString;
      code := FieldByName('code').AsString;
      departtime := FieldByName('departtime').AsString;
      ticketnum := FieldByName('ticketnum').AsInteger;
      totalamount := FieldByName('totalamount').Asfloat;
      balanceamount := FieldByName('balanceamount').Asfloat;
      vehicleunitname := FieldByName('unitname').AsString;

      ticketnum := FieldByName('ticketnum').AsInteger;
      stationservicefee := FieldByName('stationservicefee').Asfloat;
      fueladditionfee := FieldByName('fueladditionfee').Asfloat;
      agentfee := FieldByName('agentfee').Asfloat;
      othterfee := FieldByName('othterfee').Asfloat;
      vehiceid := FieldByName('vehicleid').AsLargeInt;
      printname := FieldByName('printname').AsString;
      printtime := FieldByName('printtime').AsDateTime;
      status := FieldByName('status').AsString;
      routename := FieldByName('routename').AsString;
      routeid := FieldByName('routeid').AsLargeInt;
      balanceunitname := FieldByName('balanceunitname').AsString;
      balanceunitid := FieldByName('balanceunitid').AsLargeInt;
      datafrom := FieldByName('datafrom').AsString;
    end;
    if jcdsResult.Active then
    begin
      if (jcdsResult.RecordCount > 0) then
      begin
        jcdsResult.AfterScroll := nil;
        with jcdsResult do
        begin
          DisableControls;
          first;
          while (not eof) do
          begin
            if (FieldByName('id').AsLargeInt) = invoicesid then
            begin
              isexist := true;
              break;
            end;
            Next;
          end;
          EnableControls;
        end;
        jcdsResult.AfterScroll := jcdsResultAfterScroll;
      end;
      if not isexist then
      begin
        jcdsResult.Edit;
        jcdsResult.AppendRecord([endstation, departdate,departinvoicetypename, vehicleno,
          departinvoicesno, statusname, code, departtime, ticketnum,
          totalamount, balanceamount, stationservicefee,
          fueladditionfee, agentfee, othterfee, vehicleunitname, vehiceid,
          invoicesid, printname, printtime, status, routename, routeid,
          balanceunitid, balanceunitname,datafrom]);
      end;

    end
    else
    begin
      jcdsResult.CreateDataSet;
      jcdsResult.AppendRecord([endstation, departdate,departinvoicetypename, vehicleno,
        departinvoicesno, statusname, code, departtime, ticketnum, totalamount,
        balanceamount, stationservicefee, fueladditionfee, agentfee, othterfee,
        vehicleunitname, vehiceid, invoicesid, printname, printtime, status,
        routename, routeid, balanceunitid, balanceunitname,datafrom]);
    end;
    departinvoicesidlist.Remove(invoicesid);
    departinvoicesnolist.Remove(departinvoicesno);
    jscd1.Edit;
    jscd1.Delete;
  end;
end;

procedure TFrmBalance.N1Click(Sender: TObject);
begin
  inherited;
  rightmove;
end;

procedure TFrmBalance.N2Click(Sender: TObject);
begin
  inherited;
  if not jcdsResult.Active then
    Exit;
  if self.jcdsResult.RecordCount = 0 then
    Exit;
  { if jcdsResult.RecordCount >= 500 then
    begin
    SysDialogs.ShowMessage('一次结算结算单不允许操作500张！');
    Exit;
    end; }
  jcdsResult.AfterScroll := nil;
  with jcdsResult do
  begin
    // DisableControls;
    first;
    while (not eof) do
    begin
      rightmove;
    end;
    // enableControls;
  end;
  jcdsResult.AfterScroll := jcdsResultAfterScroll;
end;

procedure TFrmBalance.N3Click(Sender: TObject);
begin
  inherited;
  jcdsResult.AfterScroll := nil;
  leftmove;
  jcdsResult.AfterScroll := jcdsResultAfterScroll;
end;

procedure TFrmBalance.N4Click(Sender: TObject);
begin
  inherited;
  if not jscd1.Active then
    Exit;
  if jscd1.RecordCount = 0 then
    Exit;
  jscd1.Close;
  departinvoicesidlist.clear;
  departinvoicesnolist.clear;
  tbtnFilterClick(Sender);
  { jcdsResult.AfterScroll := nil;
    with jscd1 do
    begin
    first;
    while (not eof) do
    begin
    leftmove; ;
    end;
    end;
    jcdsResult.AfterScroll := jcdsResultAfterScroll; }
end;

procedure TFrmBalance.NHelpRouteKeyPress(Sender: TObject; var Key: Char);
begin
  inherited;
  if Key = #13 then
  begin
    tbtnFilterClick(Sender);
  end;
end;

procedure TFrmBalance.NovaEdtInvoicesnoKeyPress(Sender: TObject; var Key: Char);
begin
  inherited;
  if Key = #13 then
  begin
    if NovaEdtInvoicesno.Text = '' then
      Exit;
    if length(trim(NovaEdtInvoicesno.Text)) = sysinfo.curBillLength.Items
      ['BalanceBill'] then
    begin
      isNovaEdtInvoicesnoKeyPress := true;
      qryDepartinvoices(trim(NovaEdtInvoicesno.Text));
    end
    else
    begin
      isNovaEdtInvoicesnoKeyPress := true;
      SysDialogs.ShowMessage('你输入的结算单号码位数不对！');
      NovaEdtInvoicesno.SetFocus;
      Exit;
    end;
  end;
end;

procedure TFrmBalance.NovaHelpScheduleKeyPress(Sender: TObject; var Key: Char);
begin
  inherited;
  if Key = #13 then
  begin
    tbtnFilterClick(Sender);
  end;
end;

procedure TFrmBalance.NovaHelpUnitKeyPress(Sender: TObject; var Key: Char);
begin
  inherited;
  if Key = #13 then
  begin
    tbtnFilterClick(Sender);
  end;
end;

procedure TFrmBalance.NovaHelpVehicleChange(Sender: TObject);
begin
  inherited;
     with  NovaHelpVehicle do
     begin
        if NovaHelpUnit.Id >0 then
        begin
        Params.ParamValues['filter_EQL_t!unitid'] := NovaHelpUnit.Id;
        end
        else
        begin
         Params.ParamValues['filter_EQL_t!unitid'] := null;
        end;
     end;
end;


procedure TFrmBalance.NovaHelpVehicleKeyPress(Sender: TObject; var Key: Char);
begin
  inherited;
  if Key = #13 then
  begin
    tbtnFilterClick(Sender);
  end;
end;

procedure TFrmBalance.nvdbgrdh1DblClick(Sender: TObject);
begin
  inherited;
  //
  leftmove;
  tbtnFilterClick(Sender );
end;

procedure TFrmBalance.qryDeductdetails(invoicesid: int64);
begin
  with jcdsQryDeductDetail do
  begin
    Active := false;
    Params.ParamValues['departinvoincesid'] := invoicesid;
    Active := true;
  end;
end;

procedure TFrmBalance.qryDepartinvoices(departinvoicesno: string);
var
  i: integer;
  departinvoicesid: int64;
  departinvoicesids, msg: string;
begin
  if (departinvoicesnolist.IndexOf(departinvoicesno) = -1) then
  begin
    // tbtnFilterClick(nil);
    with jcdsResult do
    begin
      if (not jcdsResult.Active) or (jcdsResult.RecordCount = 0) or
        (not jcdsResult.Locate('departinvoicesno', departinvoicesno, []))
        then
      begin
        tbtnFilterClick(nil);
      end;
      if jcdsResult.RecordCount > 0 then
      begin
        if (FieldByName('status').AsString = '2') then
        begin
          with jscdQryBalance do
          begin
            Active := false;
            Params.ParamValues['departinvoicesno'] := departinvoicesno;
            Execute;
            msg := Params.ParamValues['msg'];
            SysDialogs.ShowMessage(msg);
            NovaEdtInvoicesno.SetFocus;
            NovaEdtInvoicesno.clear;
            Exit;
          end;
        end
        else if (FieldByName('status').AsString = '1') then
        begin
          SysDialogs.ShowMessage('该结算单已经注销！');
          NovaEdtInvoicesno.SetFocus;
          NovaEdtInvoicesno.clear;
          Exit;
        end;
      end
      else
      begin
        SysDialogs.ShowMessage('该查询条件中不存在该结算单信息！');
        NovaEdtInvoicesno.clear;
        NovaEdtInvoicesno.SetFocus;
        Exit;
      end;
    end;
    if chkAutoAdd.Checked then
    begin
      if jcdsResult.Locate('departinvoicesno', departinvoicesno, []) then
      begin
        rightmove;
      end
      else
      begin
        SysDialogs.ShowMessage('该查询条件中不存在该结算单信息！');
        NovaEdtInvoicesno.clear;
        NovaEdtInvoicesno.SetFocus;
        Exit;
      end;
    end
    else
    begin
      if not jcdsResult.Locate('departinvoicesno', departinvoicesno, []) then
      begin
        SysDialogs.ShowMessage('该查询条件中不存在该结算单信息！');
        NovaEdtInvoicesno.clear;
        NovaEdtInvoicesno.SetFocus;
        Exit;
      end;
    end;
    NovaEdtInvoicesno.clear;
    NovaEdtInvoicesno.SetFocus;
  end
  else
  begin
    SysDialogs.ShowMessage('该结算单已经加入结算列表！');
    NovaEdtInvoicesno.SetFocus;
    NovaEdtInvoicesno.clear;
    Exit;
  end;
end;

procedure TFrmBalance.rightmove;
begin
  if not jcdsResult.Active then
    Exit;
  if self.jcdsResult.RecordCount = 0 then
    Exit;
  if (jcdsResult.FieldByName('status').AsString = '2') then
  begin
    SysDialogs.ShowMessage(jcdsResult.FieldByName('departinvoicesno')
        .AsString + '结算单已经结算！');
    jcdsResult.Next;
    Exit;
  end;
  if (jcdsResult.FieldByName('status').AsString = '1') then
  begin
    SysDialogs.ShowMessage(jcdsResult.FieldByName('departinvoicesno')
        .AsString + '结算单已经注销！');
    jcdsResult.Next;
    Exit;
  end;

  //新增参数  判断是否已经审核的手工单才可以进行结算
  if getParametervalue('4050', sysinfo.LoginUserInfo.OrgID) = '1' then
  begin
     if (jcdsResult.FieldByName('isaudit').AsString = '0') then
  begin
    SysDialogs.ShowMessage(jcdsResult.FieldByName('departinvoicesno')
        .AsString + '结算单未审核！');
    jcdsResult.Next;
    Exit;
  end;
  end;

  invoicesid := jcdsResult.FieldByName('id').AsLargeInt;
  departinvoicesno := jcdsResult.FieldByName('departinvoicesno').AsString;
  if departinvoicesidlist.IndexOf(invoicesid) = -1 then
  begin
    departinvoicesidlist.Add(invoicesid);
    departinvoicesnolist.Add(departinvoicesno);
    with jcdsResult do
    begin
      endstation := FieldByName('endstation').AsString;
      departdate := FieldByName('departdate').AsDateTime;
      vehicleno := FieldByName('vehicleno').AsString;
      statusname := FieldByName('statusname').AsString;
      code := FieldByName('code').AsString;
      departtime := FieldByName('departtime').AsString;
      ticketnum := FieldByName('ticketnum').AsInteger;
      totalamount := FieldByName('totalamount').Asfloat;
      balanceamount := FieldByName('balanceamount').Asfloat;
      vehicleunitname := FieldByName('unitname').AsString;

      ticketnum := FieldByName('ticketnum').AsInteger;
      stationservicefee := FieldByName('stationservicefee').Asfloat;
      fueladditionfee := FieldByName('fueladditionfee').Asfloat;
      agentfee := FieldByName('agentfee').Asfloat;
      othterfee := FieldByName('othterfee').Asfloat;
      vehiceid := FieldByName('vehicleid').AsLargeInt;
      printname := FieldByName('printname').AsString;
      printtime := FieldByName('printtime').AsDateTime;
      status := FieldByName('status').AsString;
      routename := FieldByName('routename').AsString;
      routeid := FieldByName('routeid').AsLargeInt;
      balanceunitname := FieldByName('balanceunitname').AsString;
      balanceunitid := FieldByName('balanceunitid').AsLargeInt;

      departinvoicetypename := FieldByName('departinvoicetypename').AsString;
      datafrom := FieldByName('datafrom').AsString;
    end;
    if jscd1.Active then
    begin
      { if jscd1.RecordCount >= 1000 then
        begin
        SysDialogs.ShowMessage('一次结算结算单不允许操作1000张！');
        Exit;
        end; }
      jscd1.Edit;
      jscd1.AppendRecord([endstation, departdate,departinvoicetypename, vehicleno, departinvoicesno,
        statusname, code, departtime, ticketnum, totalamount, balanceamount,
        stationservicefee, fueladditionfee, agentfee, othterfee,
        vehicleunitname, vehiceid, invoicesid, printname,
        printtime, status, routename, routeid, balanceunitid, balanceunitname,datafrom]);
    end
    else
    begin
      jscd1.CreateDataSet;
      jscd1.AppendRecord([endstation, departdate,departinvoicetypename, vehicleno, departinvoicesno,
        statusname, code, departtime, ticketnum, totalamount, balanceamount,
        stationservicefee, fueladditionfee, agentfee, othterfee,
        vehicleunitname, vehiceid, invoicesid, printname,
        printtime, status, routename, routeid, balanceunitid, balanceunitname,datafrom]);
    end;
    jcdsResult.Edit;
    jcdsResult.Delete;
    if jcdsResult.RecordCount = 0 then
      jcdsQryDeductDetail.Close;
  end
  else
  begin
    jcdsResult.Next;
  end;
end;

procedure TFrmBalance.tbtnCancelClick(Sender: TObject);
var
  nResult, i: integer;
  sResult, ids: String;
begin
  inherited;
  if not jscd1.Active then
    Exit;
  if jscd1.RecordCount = 0 then
    Exit;

  if not SysDialogs.Confirm('提示信息', '确认要生成结算扣费信息吗？') then
  begin
    Exit;
  end;

  if jscd1.RecordCount >= 500 then
    if not SysDialogs.Confirm('提示信息',
      '生成结算扣费信息大概需要' + inttostr(trunc(jscd1.RecordCount / 3)) + '秒，是否继续？') then
    begin
      Exit;
    end;

  // jscd1.AfterScroll := nil;
  ids := '';
  with jscd1 do
  begin
    DisableControls;
    first;
    while (not eof) do
    begin
      if (FieldByName('status').AsString = '0') or
        (FieldByName('status').AsString = '3') then
        ids := ids + ',' + FieldByName('id').AsString;
      Next;
    end;
    EnableControls;
  end;
  if length(ids) > 0 then
  begin
    // ids:='('+ copy(ids,2,length(ids))+')';
    ids := copy(ids, 2, length(ids));
  end;

  try
    screen.Cursor := crHourGlass;
    with jcdsGenData do
    begin
      Active := false;
      Params.ParamValues['fromdepart'] := formatdatetime('yyyy-mm-dd',
        DpFromDepart.DateTime); ;
      Params.ParamValues['todepart'] := formatdatetime('yyyy-mm-dd',
        DptoDepart.DateTime); ;
      Params.ParamValues['invoicesids'] := ids;
      Execute;
      nResult := Params.ParamByName('flag').Value;
      sResult := Params.ParamByName('msg').Value;
      if (nResult = 1) then
      begin
        SysDialogs.ShowMessage(sResult);
        // tbtnFilterClick(Sender);
      end
      else
        SysDialogs.Warning(sResult);

      // jcdsResult.AfterScroll := jcdsResultAfterScroll;
      screen.Cursor := crDefault;
    end;
  except
    on E: exception do
    begin
      // jcdsResult.AfterScroll := jcdsResultAfterScroll;
      screen.Cursor := crDefault;
      SysLog.WriteErr('生成结算数据失败：' + E.Message);
    end;
  end;
end;

procedure TFrmBalance.tbtnEditClick(Sender: TObject);
var
  i, counts, vehiclenum: integer;
  invoicesnos: string;
  vehiceid, routeid, balanceunitid,ticketcount: int64;
  vehiceidlist: TList<int64>;
  curdepart, temp: String;
  curroutename, curvehicleno: string;
  goodsamountmoney,totalamountmoney : Currency;
begin
  inherited;

  if not jscd1.Active then
    Exit;
  if jscd1.RecordCount = 0 then
  begin
    SysDialogs.Warning('请选择你要结算的结算单！');
    Exit;
  end;
  try
    vehiceidlist := TList<int64>.Create();
    FrmBalanceInfo := TFrmBalanceInfo.Create(self);
    with FrmBalanceInfo do
    begin
      Caption := '结算单结算';
      LabObject.Caption := '结算车辆';
      if NovaCkbOrg.CheckedCount = 1 then
      begin
        temp := NovaCkbOrg.GetSelectID;
        curorgid := strtoint64(copy(temp, 2, length(temp) - 2));
      end
      else
      begin
        curorgid := sysinfo.LoginUserInfo.OrgID;
      end;

      with jscd1 do
      begin
        DisableControls;
        first;
        fromdepart := FieldByName('departdate').AsString;
        todepart := FieldByName('departdate').AsString;
        curroutename := FieldByName('endstation').AsString;
        curvehicleno := FieldByName('vehicleno').AsString;
        vehiclenum := 1;
        balanceunitid := FieldByName('balanceunitid').AsLargeInt;
        balanceunitname := FieldByName('balanceunitname').AsString;
        vehicleunit :=   FieldByName('unitname').AsString;
        isonebalanceunit := true;
        while (not eof) do
        begin
          if (balanceunitid <> FieldByName('balanceunitid').AsLargeInt) then
          begin
            isonebalanceunit := false;
            // EnableControls;
            // SysDialogs.Warning('不同的结算单位不能一起结算！');
            // Exit;
          end;
          invoicesnos := invoicesnos + ',' + FieldByName('departinvoicesno')
            .AsString;
          if trim('微机运量')=FieldByName('departinvoicetypename').AsString then
          begin
              invoicesids := invoicesids + ',' + FieldByName('id').AsString;
          end
          else
          begin
              otherinvoicesids := otherinvoicesids + ',' + FieldByName('id').AsString;
          end;
          vehiceid := FieldByName('vehicleid').AsLargeInt;
          routeid := FieldByName('routeid').AsLargeInt;
          currouteid := routeid;
          if (vehiceidlist.IndexOf(vehiceid) = -1) then
            vehiceidlist.Add(vehiceid);
          if (vehiceidlist.Count > 1) then
          begin
            SysDialogs.Warning('单车结算只能选择一辆车的结算单进行结算！');
            EnableControls;
            Exit;
          end;
          curdepart := FieldByName('departdate').AsString;
          if (curroutename <> FieldByName('endstation').AsString) then
          begin
            curroutename := '';
          end;

          if routeid <> FieldByName('routeid').AsLargeInt then
          begin
            ismoreroute := true;
          end;
          if (curdepart > todepart) then
          begin
            todepart := curdepart;
          end;
          if (curdepart < fromdepart) then
          begin
            fromdepart := curdepart;
          end;
          ticketcount := FieldByName('ticketnum').AsLargeInt;
          totalamountmoney := FieldByName('totalamount').AsCurrency;
          if (trim('手工运量')=FieldByName('departinvoicetypename').AsString) and
               (ticketcount=0)  then
          begin
              goodsamountmoney := goodsamountmoney + totalamountmoney ;  //计算货票金额
          end;
          Next;
        end;
        EnableControls;
      end;
      vehicleids := inttostr(vehiceid);
      curvehicleid := vehiceid;
      // EdtVehicleNo.Text := curvehicleno;
      Label25.Visible := false;
      EdtVehicleNo.Visible := false;
      invoicesids := copy(invoicesids, 2, length(invoicesids));
      otherinvoicesids := copy(otherinvoicesids, 2, length(otherinvoicesids));
      // MeRemark.Text := invoicesids;
      // 赋值
      NovaEdtCount.Text := inttostr(jscd1.RecordCount);
      NovaEdtTicketnum.Text := nvdbgrdh1.GetFooterValue(0,
        nvdbgrdh1.FieldColumns['ticketnum']);
      NovaEdttotalamount.Text := nvdbgrdh1.GetFooterValue(0,
        nvdbgrdh1.FieldColumns['totalamount']);
      NovaEdtstationservicefee.Text := nvdbgrdh1.GetFooterValue(0,
        nvdbgrdh1.FieldColumns['stationservicefee']);
      NovaEdtfueladditionfee.Text := nvdbgrdh1.GetFooterValue(0,
        nvdbgrdh1.FieldColumns['fueladditionfee']);
      if nvdbgrdh1.GetFooterValue(0, nvdbgrdh1.FieldColumns['agentfee'])
        = '0' then
        NovaEdtRate.Enabled := true
      else
      begin
        NovaEdtRate.Enabled := false;
        BtnAddFeeAct.Enabled := false;
      end;
      NovaEdtothterfee.Text := nvdbgrdh1.GetFooterValue(0,
        nvdbgrdh1.FieldColumns['othterfee']);
      balancekind := 1;
      NovaEdtVehiclenum.Text := '1';
      routename := curroutename;
      vehicleno := curvehicleno;
      // NovaEdtDeduct.Text:='0';
      // NovaHUnit.id := balanceunitid;
      // NovaHUnit.Text := balanceunitname;
      NovaEdtbalanceamount.Text := nvdbgrdh1.GetFooterValue(0,
        nvdbgrdh1.FieldColumns['balanceamount']);
      NovaEdtagentfee.Text := nvdbgrdh1.GetFooterValue(0,
        nvdbgrdh1.FieldColumns['agentfee']);
      goodsmoney:=goodsamountmoney;
      PackAgentRate.Text:=packfeerate;

      if balancetype = '0' then
      begin
        Label34.Caption := '违规罚金';
        Label35.Visible := false;
        NovaEdtbackMoney.Text := '0';
        NovaEdtbackMoney.Visible := false;
      end
      else
      begin
        Label34.Caption := '违规暂扣款';
        // Label34.Left:=Label11.Left;
        Label35.Caption := '返还暂扣款';
        // Label35.Left:=Label30.Left;
        Label35.Visible := true;
        // NovaEdtReturnMoney.Text:='0';
        NovaEdtbackMoney.Visible := true;
      end;
      NovaHUnit.Text := curvehicleno;
      NovaHUnit.id := vehiceid;
      if SysMainForm.showFormModal(FrmBalanceInfo, false) = mrok then
      begin
        // tbtnFilterClick(Sender);
        departinvoicesidlist.clear;
        jscd1.Close;
        jcdsResult.Close;
        jcdsQryDeductDetail.Close;
        departinvoicesnolist.clear;
      end;
    end;
  finally
    FreeAndNil(FrmBalanceInfo);
  end;
end;

procedure TFrmBalance.tbtnFilterClick(Sender: TObject);
var
  inids: widestring;
begin
  inherited;
  if FormatDateTime('yyyymmdd',DpFromDepart.Date)>FormatDateTime('yyyymmdd',
    DptoDepart.Date) then
   begin
      SysDialogs.ShowMessage('开始日期不能大于结束日期');
      exit;
   end;

  if (DptoDepart.Date - DpFromDepart.Date) > 100 then
  begin
    if ((NHelpRoute.Text = '') and (NovaHelpSchedule.Text = '') and
        (NovaHelpVehicle.Text = '') and (NovaHelpUnit.Text = '') and
        (NovaEdtInvoicesno.Text = '')) then
    begin
      SysDialogs.Warning('未输入查询条件日期段不允许超过100天！');
      Exit;
    end;
  end;

  with jcdsResult do
  begin
    DisableControls;
    Active := false;
    inids := '';
    with jscd1 do
    begin
      if Active and (RecordCount > 0) then
      begin
        DisableControls;
        first;
        while (not eof) do
        begin
          inids := inids + ',' + FieldByName('id').AsString;
          Next;
        end;
        EnableControls;
        inids := '(' + copy(inids, 2, length(inids)) + ')';
      end
      else
      begin
        inids := '(0)';
      end;
    end;
    Params.ParamValues['invoicesids'] := inids;
    if NovaCkbOrg.CheckedCount = 0 then
      // Params.ParamValues['filter_INS_ds!printorgid'] := sysinfo.LoginUserInfo.OrgIDs
      Params.ParamValues['orgids'] := sysinfo.LoginUserInfo.OrgIDs
    else
      // Params.ParamValues['filter_INS_ds!printorgid'] := NovaCkbOrg.GetSelectID;
      Params.ParamValues['orgids'] := NovaCkbOrg.GetSelectID;
    Params.ParamValues['filter_GED_ds!departdate'] := formatdatetime
      ('yyyy-mm-dd', DpFromDepart.DateTime);
    Params.ParamValues['filter_LED_ds!departdate'] := formatdatetime
      ('yyyy-mm-dd', DptoDepart.DateTime);
    if (trim(NHelpRoute.Text) <> '') and (NHelpRoute.id > 0) then
      Params.ParamValues['filter_EQL_s!routeid'] := NHelpRoute.id
    else
      Params.ParamValues['filter_EQL_s!routeid'] := null;
    if (chkscheduleTypeY.Checked and (not chkscheduleTypeN.Checked)) then
    begin
      Params.ParamValues['filter_EQB_s!isovertime'] := true;
    end
    else if ((not chkscheduleTypeY.Checked) and chkscheduleTypeN.Checked) then
    begin
      Params.ParamValues['filter_EQB_s!isovertime'] := false;
    end
    else
    begin
      Params.ParamValues['filter_EQB_s!isovertime'] := null;
    end;

    if (trim(NovaHelpSchedule.Text) <> '') and (NovaHelpSchedule.id > 0) then
      Params.ParamValues['filter_EQL_s!id'] := NovaHelpSchedule.id
    else
      Params.ParamValues['filter_EQL_s!id'] := null;

    if (trim(NovaHelpVehicle.Text) <> '') and (NovaHelpVehicle.id > 0) then
      Params.ParamValues['filter_EQL_v!id'] := NovaHelpVehicle.id
    else
      Params.ParamValues['filter_EQL_v!id'] := null;

    if (trim(NovaHelpUnit.Text) <> '') and (NovaHelpUnit.id > 0) then
      Params.ParamValues['filter_EQL_u2!id'] := NovaHelpUnit.id
    else
      Params.ParamValues['filter_EQL_u2!id'] := null;
    if (trim(NovaHelpCard.Text) <> '') then
      Params.ParamValues['filter_EQS_u!cardno'] := trim(NovaHelpCard.Text)
    else
      Params.ParamValues['filter_EQS_u!cardno'] := null;

    if NovachkStatus.GetSelectID <> '' then
      Params.ParamValues['filter_INS_ds!status'] := NovachkStatus.GetSelectID
    else
      Params.ParamValues['filter_INS_ds!status'] := null;
    Params.ParamValues['filter_INS_ds!id'] := null;

    if (trim(NovaEdtInvoicesno.Text) <> '') then
    begin
      Params.ParamValues['filter_EQS_ds!departinvoicesno'] := trim
        (NovaEdtInvoicesno.Text);
      { if length(trim(NovaEdtInvoicesno.Text)) = sysinfo.curBillLength.Items
        ['BalanceBill'] then
        begin
        Params.ParamValues['filter_GED_ds!departdate'] := null;
        Params.ParamValues['filter_LED_ds!departdate'] := null;
        Params.ParamValues['filter_INS_ds!status'] := null;
        Params.ParamValues['filter_EQS_u!cardno'] := null;
        Params.ParamValues['filter_EQL_u2!id'] := null;
        Params.ParamValues['filter_EQL_s!id'] := null;
        Params.ParamValues['filter_EQL_v!id'] := null;
        Params.ParamValues['filter_EQL_s!routeid'] := null;
        end; }
    end
    else
      Params.ParamValues['filter_EQS_ds!departinvoicesno'] := null;

    if nhcbbdepartinvoicestype.ItemIndex = 1 then // 微机运量
    begin
      Params.ParamValues['departinvoicestype'] := 1;
    end
    else if nhcbbdepartinvoicestype.ItemIndex = 2 then // 手工运量
    begin
      Params.ParamValues['departinvoicestype'] := 2;
    end
    else
    begin
      Params.ParamValues['departinvoicestype'] := 3; // 全部
    end;

    jcdsResult.AfterScroll := nil;
    // isfirst := false;
    Active := true;
    EnableControls;
    jcdsResult.AfterScroll := jcdsResultAfterScroll;
    if RecordCount > 0 then
    begin
      qryDeductdetails(jcdsResult.FieldByName('id').AsLargeInt);
      dbgrdhResult.SelectedRows.CurrentRowSelected := true;
    end
    else
      jcdsQryDeductDetail.Close;

  end;
end;

procedure TFrmBalance.tbtnInsertClick(Sender: TObject);
var
  i, counts, vehiclenum: integer;
  invoicesnos: string;
  vehiceid, routeid, balanceunitid,ticketcount: int64;
  vehiceidlist: TList<int64>;
  curdepart, temp: String;
  curroutename, curvehicleno,invoicetypename: string;
  goodsamountmoney,totalamountmoney : Currency;
begin
  inherited;

  if not jscd1.Active then
    Exit;
  if jscd1.RecordCount = 0 then
  begin
    SysDialogs.Warning('请选择你要结算的结算单！');
    Exit;
  end;
  try
    vehiceidlist := TList<int64>.Create();
    FrmBalanceInfo := TFrmBalanceInfo.Create(self);
    with FrmBalanceInfo do
    begin
      Caption := '结算单结算';
      if NovaCkbOrg.CheckedCount = 1 then
      begin
        temp := NovaCkbOrg.GetSelectID;
        curorgid := strtoint64(copy(temp, 2, length(temp) - 2));
      end
      else
      begin
        curorgid := sysinfo.LoginUserInfo.OrgID;
      end;

      qryfromdate := FormatDateTime('yyyy-mm-dd',DpFromDepart.DateTime);
      qrytodate := FormatDateTime('yyyy-mm-dd',DptoDepart.DateTime);

      with jscd1 do
      begin
        DisableControls;
        first;
        fromdepart := FieldByName('departdate').AsString;
        todepart := FieldByName('departdate').AsString;
        curroutename := FieldByName('endstation').AsString;
        curvehicleno := FieldByName('vehicleno').AsString;
        vehiclenum := 1;
        balanceunitid := FieldByName('balanceunitid').AsLargeInt;
        balanceunitname := FieldByName('balanceunitname').AsString;
        vehicleunit :=   FieldByName('unitname').AsString;
        isonebalanceunit := true;
        while (not eof) do
        begin
          if  (balanceunitid <> FieldByName('balanceunitid').AsLargeInt) then
          begin
//            isonebalanceunit := false;
//             EnableControls;
//             SysDialogs.Warning('不同的结算单位不能一起结算！');
//             Exit;
          end;
          invoicesnos := invoicesnos + ',' + FieldByName('departinvoicesno')
            .AsString;

          if trim('微机运量')=FieldByName('departinvoicetypename').AsString then
          begin
              invoicesids := invoicesids + ',' + FieldByName('id').AsString;
          end
          else
          begin
              otherinvoicesids := otherinvoicesids + ',' + FieldByName('id').AsString;
          end;

          vehiceid := FieldByName('vehicleid').AsLargeInt;
          routeid := FieldByName('routeid').AsLargeInt;
          currouteid := routeid;
          if (vehiceidlist.IndexOf(vehiceid) = -1) then
            vehiceidlist.Add(vehiceid);
          curdepart := FieldByName('departdate').AsString;
          if (curroutename <> FieldByName('endstation').AsString) then
          begin
            curroutename := '';
          end;
          if (pos(FieldByName('vehicleno').AsString, curvehicleno) = 0) then
          begin
            curvehicleno := curvehicleno + ',' + FieldByName('vehicleno')
              .AsString;
            vehiclenum := vehiclenum + 1;
          end;
          if routeid <> FieldByName('routeid').AsLargeInt then
          begin
            ismoreroute := true;
          end;
          if (curdepart > todepart) then
          begin
            todepart := curdepart;
          end;
          if (curdepart < fromdepart) then
          begin
            fromdepart := curdepart;
          end;
          ticketcount := FieldByName('ticketnum').AsLargeInt;
          totalamountmoney := FieldByName('totalamount').AsCurrency;
          if (trim('手工运量')=FieldByName('departinvoicetypename').AsString) and
               (ticketcount=0) and
              ('8'=FieldByName('datafrom').AsString)  then  //来源为货物
          begin
              goodsamountmoney := goodsamountmoney + totalamountmoney ;  //计算货票金额
          end;
          Next;
        end;
        EnableControls;
      end;
      balancekind := 0;
      curvehicleid := vehiceid;
      EdtVehicleNo.Text := curvehicleno;
      invoicesids := copy(invoicesids, 2, length(invoicesids));
      otherinvoicesids := copy(otherinvoicesids,2,length(otherinvoicesids));
      // MeRemark.Text := invoicesids;
      // 赋值
      NovaEdtCount.Text := inttostr(jscd1.RecordCount);
      NovaEdtTicketnum.Text := nvdbgrdh1.GetFooterValue(0,
        nvdbgrdh1.FieldColumns['ticketnum']);
      NovaEdttotalamount.Text := nvdbgrdh1.GetFooterValue(0,
        nvdbgrdh1.FieldColumns['totalamount']);
      NovaEdtstationservicefee.Text := nvdbgrdh1.GetFooterValue(0,
        nvdbgrdh1.FieldColumns['stationservicefee']);
      NovaEdtfueladditionfee.Text := nvdbgrdh1.GetFooterValue(0,
        nvdbgrdh1.FieldColumns['fueladditionfee']);
      if nvdbgrdh1.GetFooterValue(0, nvdbgrdh1.FieldColumns['agentfee'])
        = '0' then
        // NovaEdtRate.Enabled := true
      else
      begin
        NovaEdtRate.Enabled := false;
        // BtnAddFeeAct.Enabled:=false;
      end;
      NovaEdtothterfee.Text := nvdbgrdh1.GetFooterValue(0,
        nvdbgrdh1.FieldColumns['othterfee']);


      for i := 0 to vehiceidlist.Count - 1 do
      begin
        vehicleids := vehicleids + ',' + inttostr(vehiceidlist.Items[i]);
      end;
      vehicleids := copy(vehicleids, 2, length(vehicleids));
      NovaEdtVehiclenum.Text := inttostr(vehiclenum);
      routename := curroutename;
      vehicleno := curvehicleno;
      // NovaEdtDeduct.Text:='0';
      NovaHUnit.id := balanceunitid;
      NovaHUnit.Text := balanceunitname;
      NovaEdtbalanceamount.Text := nvdbgrdh1.GetFooterValue(0,
        nvdbgrdh1.FieldColumns['balanceamount']);
      NovaEdtagentfee.Text := nvdbgrdh1.GetFooterValue(0,
        nvdbgrdh1.FieldColumns['agentfee']);
      goodsmoney:=goodsamountmoney;
      PackAgentRate.Text:=packfeerate;
      NovaEditPackFee.Text := CurrToStr(goodsmoney);
      if balancetype = '0' then
      begin
        Label34.Caption := '违规罚金';
        Label35.Visible := false;
        NovaEdtbackMoney.Text := '0';
        NovaEdtbackMoney.Visible := false;
      end
      else
      begin
        Label34.Caption := '违规暂扣款';
        // Label34.Left:=Label11.Left;
        Label35.Caption := '返还暂扣款';
        // Label35.Left:=Label30.Left;
        Label35.Visible := true;
        // NovaEdtReturnMoney.Text:='0';
        NovaEdtbackMoney.Visible := true;
      end;
      if SysMainForm.showFormModal(FrmBalanceInfo, false) = mrok then
      begin
        // tbtnFilterClick(Sender);
        departinvoicesidlist.clear;
        jscd1.Close;
        jcdsResult.Close;
        jcdsQryDeductDetail.Close;
        departinvoicesnolist.clear;
      end;
    end;
  finally
    FreeAndNil(FrmBalanceInfo);
  end;
end;

procedure TFrmBalance.tbtnModifyBalanceClick(Sender: TObject);
var
  curid: int64;
begin
  inherited;
  if not dsResult.DataSet.Active then
    Exit;
  if dsResult.DataSet.RecordCount < 1 then
    Exit;
  pidiscomputerno := jcdsResult.FieldByName('iscomputerno').AsInteger;
  if pidiscomputerno <> 1 then
  begin
    SysDialogs.ShowMessage('只能修改微机运量!');
    Exit;
  end;
  FrmBalanceEdit := TFrmBalanceEdit.Create(self);
  with FrmBalanceEdit do
  begin
    Caption := '修改结算单信息';
    departinvoicesid := jcdsResult.FieldByName('id').AsLargeInt;
    curid := departinvoicesid;
    dtpdepartdate.DateTime := jcdsResult.FieldByName('departdate').AsDateTime;
    dtpdepartdate.Enabled := false;
    nvedtdepartinvoicesno.Text := jcdsResult.FieldByName('departinvoicesno')
      .AsString;
    nvedtdepartinvoicesno.Enabled := false;
    nvedtschedulecode.Text := jcdsResult.FieldByName('code').AsString;
    nvedtschedulecode.Enabled := false;
    nvedtdeparttime.Text := jcdsResult.FieldByName('departtime').AsString;
    nvedtdeparttime.Enabled := false;
    nvedtvehiclename.Text := jcdsResult.FieldByName('vehicleno').AsString;
    nvedtvehiclename.Enabled := false;
    nvedtworkunit.Text := jcdsResult.FieldByName('unitname').AsString;
    nvedtworkunit.Enabled := false;
    nvedtbalanceunit.Text := jcdsResult.FieldByName('balanceunitname').AsString;
    nvedtbalanceunit.Enabled := false;

    nvedtticketnum.Text := jcdsResult.FieldByName('ticketnum').AsString;
    nvedtticketnum.Enabled := false;

    nvedttotalamount.Text := jcdsResult.FieldByName('totalamount').AsString;
    nvedttotalamount.Enabled := false;
    nvedtbalanceamount.Text := jcdsResult.FieldByName('balanceamount').AsString;
    nvedtbalanceamount.Enabled := false;
    nvedtstationservicefee.Text := jcdsResult.FieldByName('stationservicefee')
      .AsString;
      nvedtstationservicefee.Enabled :=false;
    nvedtothterfee.Text := jcdsResult.FieldByName('othterfee').AsString;
    nvedtothterfee.Enabled := false;
    nvedtagentfee.Text := jcdsResult.FieldByName('agentfee').AsString;
    nvedtagentfee.Enabled := false;
    nvedtfueladditionfee.Text := jcdsResult.FieldByName('fueladditionfee')
      .AsString;
   nvedtfueladditionfee.Enabled := false;
    with jcdsQrydepartinvoicesdetail do
    begin
      Active := false;
      Params.ParamValues['departinvoicesid'] := curid;
      Active := true;
    end;

    if ShowModal = mrok then
    begin
      tbtnFilterClick(Sender);
      jcdsResult.Locate('id', curid, []);
    end;
  end;

end;

procedure TFrmBalance.tbtnSaveClick(Sender: TObject);
var
  nResult: integer;
  sResult, ids: String;
begin
  inherited;
  if not jcdsResult.Active then
    Exit;
  if jcdsResult.RecordCount = 0 then
    Exit;

  if not SysDialogs.Confirm('提示信息', '确认重新计算结算数据，有可能导致与实际结算单中的金额不一致？') then
  begin
    Exit;
  end;

  if jcdsResult.RecordCount >= 60 then
    if not SysDialogs.Confirm('提示信息',
      '确认重新计算大概需要' + inttostr(jcdsResult.RecordCount) + '秒，是否继续？') then
    begin
      Exit;
    end;

  jcdsResult.AfterScroll := nil;
  ids := '';
  with jcdsResult do
  begin
    first;
    while (not eof) do
    begin
      if (FieldByName('status').AsString = '0') or
        (FieldByName('status').AsString = '3') then
        ids := ids + ',' + FieldByName('id').AsString;
      Next;
    end;
  end;
  if length(ids) > 0 then
  begin
    // ids:='('+ copy(ids,2,length(ids))+')';
    ids := copy(ids, 2, length(ids));
  end;

  try
    screen.Cursor := crHourGlass;

    with jscdReCal do
    begin
      Active := false;
      Params.ParamValues['fromdepart'] := formatdatetime('yyyy-mm-dd',
        DpFromDepart.Date);
      Params.ParamValues['todepart'] := formatdatetime('yyyy-mm-dd',
        DptoDepart.Date);
      Params.ParamValues['invoicesids'] := ids;
      Execute;
      nResult := Params.ParamByName('flag').Value;
      sResult := Params.ParamByName('msg').Value;
      if (nResult = 1) then
      begin
        SysDialogs.ShowMessage(sResult);
        tbtnFilterClick(Sender);
      end
      else
        SysDialogs.Warning(sResult);
      screen.Cursor := crDefault;
      jcdsResult.AfterScroll := jcdsResultAfterScroll;
    end;
  except
    on E: exception do
    begin
      jcdsResult.AfterScroll := jcdsResultAfterScroll;
      screen.Cursor := crDefault;
      SysLog.WriteErr('重新计算结算数据失败：' + E.Message);
    end;
  end;
end;

procedure TFrmBalance.ToolButton52Click(Sender: TObject);
var
  nResult, i: integer;
  sResult, ids: String;
begin
  inherited;
  if not jscd1.Active then
    Exit;
  if jscd1.RecordCount = 0 then
    Exit;

  if not SysDialogs.Confirm('提示信息', '确认要删除已生成结算扣费信息吗？') then
  begin
    Exit;
  end;

  if jscd1.RecordCount >= 500 then
    if not SysDialogs.Confirm('提示信息',
      '删除已生成结算扣费信息大概需要' + inttostr(trunc(jscd1.RecordCount / 4)) + '秒，是否继续？')
      then
    begin
      Exit;
    end;

  // jcdsResult.AfterScroll := nil;
  ids := '';
  with jscd1 do
  begin
    first;
    while (not eof) do
    begin
      if (FieldByName('status').AsString = '0') or
        (FieldByName('status').AsString = '3') then
        ids := ids + ',' + FieldByName('id').AsString;
      Next;
    end;
  end;
  if length(ids) > 0 then
  begin
    // ids:='('+ copy(ids,2,length(ids))+')';
    ids := copy(ids, 2, length(ids));
  end;

  try
    screen.Cursor := crHourGlass;

    with jscdDelData do
    begin
      Active := false;
      Params.ParamValues['fromdepart'] := formatdatetime('yyyy-mm-dd',
        DpFromDepart.DateTime); ;
      Params.ParamValues['todepart'] := formatdatetime('yyyy-mm-dd',
        DptoDepart.DateTime); ;
      Params.ParamValues['invoicesids'] := ids;
      Execute;
      nResult := Params.ParamByName('flag').Value;
      sResult := Params.ParamByName('msg').Value;
      if (nResult = 1) then
      begin
        SysDialogs.ShowMessage(sResult);
        /// tbtnFilterClick(Sender);
      end
      else
        SysDialogs.Warning(sResult);
      // jcdsResult.AfterScroll := jcdsResultAfterScroll;
      screen.Cursor := crDefault;
    end;
  except
    on E: exception do
    begin
      // jcdsResult.AfterScroll := jcdsResultAfterScroll;
      screen.Cursor := crDefault;
      SysLog.WriteErr('删除结算数据失败：' + E.Message);
    end;
  end;

end;

procedure TFrmBalance.ToolButton53Click(Sender: TObject);
begin
  inherited;
  // if not jcdsResult.Active then
  // Exit;
  // if jcdsResult.RecordCount = 0 then
  // Exit;
  // frmticketsInfoOfBalance := TfrmticketsInfoOfBalance.Create(self);
  // with frmticketsInfoOfBalance do
  // begin
  // //departinvoiceid := jcdsResult.FieldByName('id').AsInteger;
  // with jcdsTicketinfo do
  // begin
  // Active := False;
  // Params.ParamValues['departinvoicesid']
  // := jcdsResult.FieldByName('id').AsInteger;
  //
  // Active := true;
  // end;
  // showModal;
  // end;
end;

procedure TFrmBalance.TreeVItemClick(Sender: TObject);
begin
  inherited;
  if TreeVItem.Items.Count <= 0 then
    Exit;

  if PNodeInfo(TreeVItem.Selected.Data).arealevel = 3 then // 选择车属单位
  begin
    NovaHelpUnit.Text := PNodeInfo(TreeVItem.Selected.Data).name;
    NovaHelpUnit.id := PNodeInfo(TreeVItem.Selected.Data).id;
    NovaHelpVehicle.clear;
  end
  else if PNodeInfo(TreeVItem.Selected.Data).arealevel = 4 then
  begin
    NovaHelpVehicle.Text := PNodeInfo(TreeVItem.Selected.Data).name;
    NovaHelpVehicle.id := PNodeInfo(TreeVItem.Selected.Data).id;
    NovaHelpUnit.clear;
  end
  else
  begin
    NovaHelpUnit.clear;
    NovaHelpVehicle.clear;
  end;
  tbtnFilterClick(Sender);
end;

end.
