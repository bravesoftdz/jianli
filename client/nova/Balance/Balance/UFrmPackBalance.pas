unit UFrmPackBalance;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, USimpleCRUDForm, DBGridEhGrouping, NvPrnDbgeh, DB, DBClient,
  jsonClientDataSet, ImgList, GridsEh, DBGridEh, NvDbgridEh, StdCtrls, ComCtrls,
  ToolWin, ExtCtrls, NovaCheckedComboBox, NovaEdit,UFrmPacFrontkBalance,Generics.Collections ,
  Services, Menus;

type
  TFrmPackBalance = class(TSimpleCRUDForm)
    Label2: TLabel;
    Label4: TLabel;
    NovaArriverStartdate: TDateTimePicker;
    NovaArriverEnddate: TDateTimePicker;
    Label1: TLabel;
    Label3: TLabel;
    NvPackBalanceNo: TNovaEdit;
    NvPackbalanceStatus: TNovaCheckedComboBox;
    GroupBox2: TGroupBox;
    NvDbgridEh1: TNvDbgridEh;
    Splitter1: TSplitter;
    jcdspackbalance: TjsonClientDataSet;
    PopupMenu1: TPopupMenu;
    N1: TMenuItem;
    PopupMenu2: TPopupMenu;
    MenuItem1: TMenuItem;
    N2: TMenuItem;
    DataSource1: TDataSource;
    jcdspackbalancepackmoney: TFloatField;
    jcdspackbalancebalanceamount: TFloatField;
    jcdspackbalancepackprice: TFloatField;
    jcdspackbalancetotalfee: TFloatField;
    jcdspackbalancepieces: TLargeintField;
    jcdspackbalanceid: TLargeintField;
    jcdspackbalancedepartdate: TDateField;
    jcdspackbalancevehicleno: TWideStringField;
    jcdspackbalancedepartinvoicesno: TWideStringField;
    jcdspackbalancestatus: TWideStringField;
    jcdspackbalancebalanceby: TWideStringField;
    jscdQryPackBalances: TjsonClientDataSet;
    jscdQryPackBalancespackmoney: TFloatField;
    jscdQryPackBalancesbalanceamount: TFloatField;
    jscdQryPackBalancespackprice: TFloatField;
    jscdQryPackBalancestotalfee: TFloatField;
    jscdQryPackBalancesdepartdate: TDateField;
    jscdQryPackBalancesdepartinvoicesno: TWideStringField;
    jscdQryPackBalancesvehicleno: TWideStringField;
    jscdQryPackBalancesid: TLargeintField;
    jscdQryPackBalancesstatus: TWideStringField;
    jscdQryPackBalancesbalanceby: TWideStringField;
    jscdQryPackBalancespieces: TLargeintField;
    jscdQryPackBalancesbalancetime: TWideStringField;
    jcdspackbalancebalancetime: TWideStringField;
    chkAutoAdd: TCheckBox;
    jscdQryBalance: TjsonClientDataSet;
    procedure FormShow(Sender: TObject);
    procedure tbtnInsertClick(Sender: TObject);
    procedure rightmove;
    procedure leftmove;
    procedure FormCreate(Sender: TObject);
    procedure N1Click(Sender: TObject);
    procedure MenuItem1Click(Sender: TObject);
    procedure N2Click(Sender: TObject);
    procedure Splitter1CanResize(Sender: TObject; var NewSize: Integer;
      var Accept: Boolean);
    procedure dbgrdhResultDblClick(Sender: TObject);
    procedure NvDbgridEh1DblClick(Sender: TObject);
    procedure NvPackBalanceNoKeyPress(Sender: TObject; var Key: Char);
    procedure qrybalance(departinvoicesno: string);
    procedure tbtnFilterClick(Sender: TObject);
    procedure tbtnDeleteClick(Sender: TObject);
  private
    { Private declarations }
    totalpackprice,packmoney,balanceamount,packprice,totalfee : double;
    invoicesid,pieces : Int64;
    departinvoicesno,balanceby,vehicleno,status : string;
    departinvoicesidlist: TList<int64>;
    departinvoicesnolist: TList<String>;
    departdate : TDate;
    balancetime : String;
    isNovaEdtInvoicesnoKeyPress : Boolean;

  public
    { Public declarations }
  end;

var
  FrmPackBalance: TFrmPackBalance;
  FrmPacFrontkBalance : TFrmPacFrontkBalance;

implementation
uses PubFn,  UDMPublic;
{$R *.dfm}

procedure TFrmPackBalance.dbgrdhResultDblClick(Sender: TObject);
begin
  inherited;
  rightmove;
end;

procedure TFrmPackBalance.FormCreate(Sender: TObject);
begin
  inherited;
  //GroupBox2.Width:=Trunc((Self.Width+50)/2);
  //GroupBox2.Refresh;
  departinvoicesnolist := TList<String>.Create;
  departinvoicesidlist := TList<int64>.Create;
end;

procedure TFrmPackBalance.FormShow(Sender: TObject);
begin
  inherited;
  NvPackbalanceStatus.Active := False;
  NvPackbalanceStatus.Active := True;
  packmoney := 0.0;
  chkAutoAdd.Checked := True;
  NovaArriverStartdate.Date := now;
  NovaArriverEnddate.Date := now;
  NvPackBalanceNo.SetFocus;
end;

procedure TFrmPackBalance.tbtnDeleteClick(Sender: TObject);
var
  packdepartinvoiceid : Largeint;
  nResult : Integer;
  sResult,log : String;
begin
  inherited;
  with jscdQryPackBalances do
  begin
    if RecordCount=0 then
    Exit;
    packdepartinvoiceid :=  FieldByName('id').AsLargeInt ;
    Active := False;
    Params.ParamValues['packdepartinvoiceid'] := IntToStr(packdepartinvoiceid);
    Params.ParamValues['tflag'] := 1;
    Execute;
    //nResult := Params.ParamByName('flag').Value;
    sResult := Params.ParamByName('msg').Value;
    SysDialogs.ShowMessage(sResult);
    tbtnFilterClick(Sender);
  end;

end;

procedure TFrmPackBalance.tbtnFilterClick(Sender: TObject);
var
  inids: widestring;
begin
  inherited;
  with jscdQryPackBalances do
  begin
    DisableControls;
    Active := false;
    inids := '';
    with jcdspackbalance do
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
    Params.ParamValues['ids'] := inids;
    Params.ParamValues['senddepartdate'] := FormatDateTime('yyyy-mm-dd', NovaArriverStartdate.Date);
    Params.ParamValues['sendenddate'] := FormatDateTime('yyyy-mm-dd', NovaArriverEnddate.Date+0.99999);
    Params.ParamValues['status'] := NvPackbalanceStatus.GetSelectID;
    Params.ParamValues['packbalanceno'] := NvPackBalanceNo.Text;
    Active := True;
    EnableControls;
  end;
end;

procedure TFrmPackBalance.tbtnInsertClick(Sender: TObject);
var
 s,i: integer;
begin
  inherited;
  if jcdspackbalance.RecordCount<=0 then
  Exit;
  try
  FrmPacFrontkBalance := TFrmPacFrontkBalance.Create(Self);
  with FrmPacFrontkBalance do
  begin
    FrmPacFrontkBalance.nvnos.Caption := IntToStr(jcdspackbalance.RecordCount);
    FrmPacFrontkBalance.nvpieces.caption := NvDbgridEh1.GetFooterValue
                                          (0,dbgrdhResult.FieldColumns['pieces']);  // 件数
    FrmPacFrontkBalance.nvbalancemoney.caption := NvDbgridEh1.GetFooterValue
                                          (0,dbgrdhResult.FieldColumns['balanceamount']);  //结算金额
    for s := 0 to departinvoicesidlist.Count-1 do
    begin
      FrmPacFrontkBalance.ids := FrmPacFrontkBalance.ids + IntToStr(departinvoicesidlist.Items[s])+',';
    end;
    for i := 0 to departinvoicesnolist.Count-1 do
    begin
      FrmPacFrontkBalance.nos := FrmPacFrontkBalance.nos + departinvoicesnolist.Items[i];
    end;
    //FrmPacFrontkBalance.ids := departinvoicesidlist.ToString;
    //FrmPacFrontkBalance.nos := departinvoicesnolist.ToString;
    FrmPacFrontkBalance.packprice1 := totalpackprice;    //货款
    FrmPacFrontkBalance.packmoney1 := StrToFloat(NvDbgridEh1.GetFooterValue
                                            (0,dbgrdhResult.FieldColumns['packmoney']));   //运费
  end;
  if SysMainForm.showFormModal(FrmPacFrontkBalance, false) = mrok then
      begin
        departinvoicesnolist.Clear;
        departinvoicesidlist.Clear;
        jcdspackbalance.Close;
        jscdQryPackBalances.close;
        tbtnFilterClick(Sender);
      end;
  finally
    FreeAndNil(FrmPacFrontkBalance);
  end;
end;


procedure TFrmPackBalance.rightmove;
begin
  if not jscdQryPackBalances.Active then
    Exit;
  if self.jscdQryPackBalances.RecordCount <= 0 then
    Exit;
  if (jscdQryPackBalances.FieldByName('status').AsString = '1') then
  begin
    SysDialogs.ShowMessage('单号:'+jscdQryPackBalances.FieldByName('departinvoicesno')
        .AsString + ' 已注销！');
    Exit;
  end;
  if (jscdQryPackBalances.FieldByName('status').AsString = '2') then
  begin
    SysDialogs.ShowMessage('单号:'+jscdQryPackBalances.FieldByName('departinvoicesno')
        .AsString + ' 已结算！');
    Exit;
  end;
  invoicesid := jscdQryPackBalances.FieldByName('id').AsLargeInt;
  departinvoicesno := jscdQryPackBalances.FieldByName('departinvoicesno').AsString;
  if departinvoicesnolist.IndexOf(departinvoicesno) = -1  then
  begin
    totalpackprice := totalpackprice + jscdQryPackBalances.FieldByName('packprice').AsFloat;
    //packmoney := packmoney + jcdsResult.FieldByName('packmoney').asfloat;
    with jscdQryPackBalances do
    begin
      departdate := FieldByName('departdate').AsDateTime;
      vehicleno := FieldByName('vehicleno').AsString;
      pieces := FieldByName('pieces').AsInteger;
      packmoney := FieldByName('packmoney').AsFloat;
      totalfee := FieldByName('totalfee').AsFloat;
      balanceamount:= FieldByName('balanceamount').AsFloat;
      balancetime:= FieldByName('balancetime').AsString;
      balanceby:= FieldByName('balanceby').asstring;
      packprice := FieldByName('packprice').AsFloat;
      status :=  FieldByName('status').asstring;
    end;
    if jcdspackbalance.Active then
    begin
      jcdspackbalance.Edit;
      jcdspackbalance.AppendRecord([departdate,departinvoicesno,vehicleno,packmoney,
      totalfee,balanceamount,balancetime,packprice,invoicesid,status,balanceby,pieces]);
    end
    else
    begin
      jcdspackbalance.CreateDataSet;
      jcdspackbalance.AppendRecord([departdate,departinvoicesno,vehicleno,packmoney,
      totalfee,balanceamount,balancetime,packprice,invoicesid,status,balanceby,pieces]);
    end;
    departinvoicesidlist.Add(invoicesid);
    departinvoicesnolist.Add(departinvoicesno);
    jscdQryPackBalances.Edit;
    jscdQryPackBalances.Delete;
  end
  else
  begin
    jscdQryPackBalances.Next;
  end;
end;

procedure TFrmPackBalance.Splitter1CanResize(Sender: TObject;
  var NewSize: Integer; var Accept: Boolean);
begin
  inherited;
 // dbgrdhResult.Refresh;
end;

procedure TFrmPackBalance.leftmove;
var
  isexist: boolean;
begin
  if not jcdspackbalance.Active then
    Exit;
  if self.jcdspackbalance.RecordCount <= 0 then
    Exit;
  invoicesid := jcdspackbalance.FieldByName('id').AsLargeInt;
  departinvoicesno := jcdspackbalance.FieldByName('departinvoicesno').AsString;
  if departinvoicesnolist.IndexOf(departinvoicesno) >= 0 then
  begin
    isexist := false;
    totalpackprice := totalpackprice - jcdspackbalance.FieldByName('packprice').AsFloat;
    //packmoney := packmoney - jcdsResult.FieldByName('packmoney').asfloat;
     with jcdspackbalance do
    begin
      departdate := FieldByName('departdate').AsDateTime;
      vehicleno := FieldByName('vehicleno').AsString;
      pieces := FieldByName('pieces').AsInteger;
      packmoney := FieldByName('packmoney').AsFloat;
      totalfee := FieldByName('totalfee').AsFloat;
      balanceamount:= FieldByName('balanceamount').AsFloat;
      balancetime:= FieldByName('balancetime').AsString;
      balanceby:= FieldByName('balanceby').asstring;
      packprice := FieldByName('packprice').AsFloat;
      status :=  FieldByName('status').asstring;
    end;
    if jscdQryPackBalances.Active then
    begin
      jscdQryPackBalances.Edit;
      jscdQryPackBalances.AppendRecord([departdate,departinvoicesno,vehicleno,packmoney,
      totalfee,balanceamount,balancetime,packprice,invoicesid,status,balanceby,pieces]);
    end
    else
    begin
      jscdQryPackBalances.CreateDataSet;
      jscdQryPackBalances.AppendRecord([departdate,departinvoicesno,vehicleno,packmoney,
      totalfee,balanceamount,balancetime,packprice,invoicesid,status,balanceby,pieces]);
    end;
    departinvoicesidlist.Remove(invoicesid);
    departinvoicesnolist.Remove(departinvoicesno);
    jcdspackbalance.Edit;
    jcdspackbalance.Delete;
    //GroupBox2.Refresh;
  end
  else
  begin
    jcdspackbalance.Next;
  end;
end;


procedure TFrmPackBalance.MenuItem1Click(Sender: TObject);
begin
  inherited;
  leftmove;
end;

procedure TFrmPackBalance.N1Click(Sender: TObject);
begin
  inherited;
  rightmove;
end;

procedure TFrmPackBalance.N2Click(Sender: TObject);
begin
  inherited;
    inherited;
  if not jcdspackbalance.Active then
    Exit;
  if jcdspackbalance.RecordCount = 0 then
    Exit;
  jcdspackbalance.Close;
  departinvoicesidlist.Clear;
  departinvoicesnolist.clear;
  tbtnFilterClick(Sender);
end;


procedure TFrmPackBalance.NvDbgridEh1DblClick(Sender: TObject);
begin
  inherited;
  leftmove;
end;

procedure TFrmPackBalance.NvPackBalanceNoKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  if Key = #13 then
  begin
    if NvPackBalanceNo.Text = '' then
      Exit;
    if length(trim(NvPackBalanceNo.Text)) = sysinfo.curBillLength.Items
      ['PackSgBill'] then
    begin
      isNovaEdtInvoicesnoKeyPress := true;
      qrybalance(trim(NvPackBalanceNo.Text));
    end
    else
    begin
      isNovaEdtInvoicesnoKeyPress := true;
      SysDialogs.ShowMessage('你输入的结算单号码位数不对！');
      NvPackBalanceNo.SetFocus;
      Exit;
    end;
  end;
end;

procedure TFrmPackBalance.qrybalance(departinvoicesno: string);
var
  i: integer;
  departinvoicesid: int64;
  departinvoicesids, msg: string;
begin
  if (departinvoicesnolist.IndexOf(departinvoicesno) = -1) then
  begin
    // tbtnFilterClick(nil);
    with jscdQryPackBalances do
    begin
      if (not jscdQryPackBalances.Active) or (jscdQryPackBalances.RecordCount = 0) or
        (not jscdQryPackBalances.Locate('departinvoicesno', departinvoicesno, []))
        then
      begin
        tbtnFilterClick(nil);
      end;
      if jscdQryPackBalances.RecordCount > 0 then
      begin
        if (FieldByName('status').AsString = '2') then
        begin
          with jscdQryBalance do
          begin
            Active := false;
            Params.ParamValues['departinvoicesno'] := departinvoicesno;
            Params.ParamValues['tflag'] := 1;
            Execute;
            msg := Params.ParamValues['msg'];
            SysDialogs.ShowMessage(msg);
            NvPackBalanceNo.SetFocus;
            NvPackBalanceNo.clear;
            Exit;
          end;
        end
        else if (FieldByName('status').AsString = '1') then
        begin
          SysDialogs.ShowMessage('该结算单已经注销！');
          NvPackBalanceNo.SetFocus;
          NvPackBalanceNo.clear;
          Exit;
        end;
      end
      else
      begin
        SysDialogs.ShowMessage('该查询条件中不存在该结算单信息！');
        NvPackBalanceNo.clear;
        NvPackBalanceNo.SetFocus;
        Exit;
      end;
    end;
    if chkAutoAdd.Checked then
    begin
      if jscdQryPackBalances.Locate('departinvoicesno', departinvoicesno, []) then
      begin
        rightmove;
      end
      else
      begin
        SysDialogs.ShowMessage('该查询条件中不存在该结算单信息！');
        NvPackBalanceNo.clear;
        NvPackBalanceNo.SetFocus;
        Exit;
      end;
    end
    else
    begin
      if not jscdQryPackBalances.Locate('departinvoicesno', departinvoicesno, []) then
      begin
        SysDialogs.ShowMessage('该查询条件中不存在该结算单信息！');
        NvPackBalanceNo.clear;
        NvPackBalanceNo.SetFocus;
        Exit;
      end;
    end;
    NvPackBalanceNo.clear;
    NvPackBalanceNo.SetFocus;
  end
  else
  begin
    SysDialogs.ShowMessage('该结算单已经加入结算列表！');
    NvPackBalanceNo.SetFocus;
    NvPackBalanceNo.clear;
    Exit;
  end;
end;
end.
