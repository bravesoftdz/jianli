unit UFrmPackArrive;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, USimpleCRUDForm, DBGridEhGrouping, NvPrnDbgeh, DB, DBClient,
  jsonClientDataSet, ImgList, GridsEh, DBGridEh, NvDbgridEh, StdCtrls, ComCtrls,
  ToolWin, ExtCtrls, NovaEdit, NovaHelp, Menus,Generics.Collections,Services,
  NovaCheckedComboBox;

type
  TFrmPackArrive = class(TSimpleCRUDForm)
    Label1: TLabel;
    NovaPackarriverno: TNovaEdit;
    Label2: TLabel;
    NovaArriverStartdate: TDateTimePicker;
    GroupBox2: TGroupBox;
    Label4: TLabel;
    NovaArriverEnddate: TDateTimePicker;
    Label6: TLabel;
    NovaHelpVehicle: TNovaHelp;
    Nvarrivetotal: TNvDbgridEh;
    Splitter1: TSplitter;
    PopupMenu1: TPopupMenu;
    N1: TMenuItem;
    DataSource1: TDataSource;
    PopupMenu2: TPopupMenu;
    MenuItem1: TMenuItem;
    N2: TMenuItem;
    qrypackarrive: TjsonClientDataSet;
    chkAutoAdd: TCheckBox;
    jcdsResultpackarriverno: TWideStringField;
    jcdsResultroutename: TWideStringField;
    jcdsResultpackfee: TFloatField;
    jcdsResultpackprice: TFloatField;
    jcdsResultpieces: TLargeintField;
    jcdsResultservicefee: TFloatField;
    jcdsResultid: TLargeintField;
    jcdsResultbalancemoney: TFloatField;
    jcdsResultstatus: TWideStringField;
    jcdsResultbalancetime: TWideStringField;
    jcdsResultbalancby: TWideStringField;
    jcdsResultpackstatus: TWideStringField;
    jcdsarrivebalances: TjsonClientDataSet;
    jcdsarrivebalancespackarriverno: TWideStringField;
    jcdsarrivebalancesroutename: TWideStringField;
    jcdsarrivebalancespackfee: TFloatField;
    jcdsarrivebalancespackprice: TFloatField;
    jcdsarrivebalancespieces: TLargeintField;
    jcdsarrivebalancesservicefee: TFloatField;
    jcdsarrivebalancesid: TLargeintField;
    jcdsarrivebalancesbalancemoney: TFloatField;
    jcdsarrivebalancesstatus: TWideStringField;
    jcdsarrivebalancesbalancetime: TWideStringField;
    jcdsarrivebalancesbalanceby: TWideStringField;
    jcdsarrivebalancespackstatus: TWideStringField;
    NvPackbalanceStatus: TNovaCheckedComboBox;
    Label3: TLabel;
    N3: TMenuItem;
    procedure QryPack(departinvoicesno : string);
    procedure NovaPackarrivernoKeyPress(Sender: TObject; var Key: Char);
    procedure FormCreate(Sender: TObject);
    procedure tbtnFilterClick(Sender: TObject);
    procedure FormResize(Sender: TObject);
    procedure N1Click(Sender: TObject);
    procedure rightmove;
    procedure leftmove;
    procedure MenuItem1Click(Sender: TObject);
    procedure N2Click(Sender: TObject);
    procedure tbtnInsertClick(Sender: TObject);
    procedure NvarrivetotalDblClick(Sender: TObject);
    procedure dbgrdhResultDblClick(Sender: TObject);
    procedure tbtnEditClick(Sender: TObject);
    procedure N3Click(Sender: TObject);
  private
    { Private declarations }
    invoicesid,pieces : Int64;
    packarriverno : string;
    packarrivernolist: TList<string>;
    packarriveridlist: TList<Int64>;
    routename :string;
    packfee : Double;
    packprice : Double;
    balancemoney : double;
    servicefee : double;
    balanceby: string;
    balancetime: string;
    isNovaEdtInvoicesnoKeyPress : Boolean;
    status : string;
    packstatus : string;
  public
    { Public declarations }
  end;

var
  FrmPackArrive: TFrmPackArrive;

implementation
 uses
 UFrmPackArriveBalance,PubFn,  UDMPublic;
{$R *.dfm}

procedure TFrmPackArrive.dbgrdhResultDblClick(Sender: TObject);
begin
  inherited;
  leftmove;
end;

procedure TFrmPackArrive.FormCreate(Sender: TObject);
begin
  inherited;
  NovaPackarriverno.Focused;
  GroupBox2.Width:=Trunc((Self.Width-50)/2);
  NvPackbalanceStatus.Active := False;
  NvPackbalanceStatus.Active := True;
  GroupBox2.Refresh;
  chkAutoAdd.Checked := True;
  packarrivernolist := TList<String>.Create;
  packarriveridlist := TList<int64>.Create;
  NovaArriverStartdate.DateTime:= Now;
  NovaArriverEnddate.DateTime:=Now;
  NovaPackarriverno.SetFocus;

end;

procedure TFrmPackArrive.FormResize(Sender: TObject);
begin
  inherited;
  GroupBox2.Width:=Trunc((Self.Width-50)/2);
  GroupBox2.Refresh;
end;

procedure TFrmPackArrive.N1Click(Sender: TObject);
begin
  inherited;
  rightmove;
end;

procedure TFrmPackArrive.N2Click(Sender: TObject);
begin
  inherited;
  if not jcdsarrivebalances.Active then
    Exit;
  if jcdsarrivebalances.RecordCount = 0 then
    Exit;
  jcdsarrivebalances.Close;
  packarrivernolist.clear;
  packarriveridlist.clear;
  tbtnFilterClick(Sender);
end;

procedure TFrmPackArrive.N3Click(Sender: TObject);
begin
  inherited;
  if not jcdsResult.Active then
    Exit;
  if jcdsResult.RecordCount = 0 then
    Exit;
  with jcdsResult do
  begin
    first;
    while (not eof) do
    begin
      rightmove;
      next;
    end;
  end;
end;

procedure TFrmPackArrive.NovaPackarrivernoKeyPress(Sender: TObject;
  var Key: Char);
begin
  if Key = #13 then
  begin
    if NovaPackarriverno.Text = '' then
      Exit;
    if length(trim(NovaPackarriverno.Text)) = sysinfo.curBillLength.Items
      ['PackArrivalBill'] then
    begin
      isNovaEdtInvoicesnoKeyPress := true;
      QryPack(trim(NovaPackarriverno.Text));
    end
    else
    begin
      isNovaEdtInvoicesnoKeyPress := true;
      SysDialogs.ShowMessage('你输入的结算单号码位数不对！');
      NovaPackarriverno.SetFocus;
      Exit;
    end;
  end;
end;

procedure TFrmPackArrive.NvarrivetotalDblClick(Sender: TObject);
begin
  inherited;
  rightmove;
end;


procedure TFrmPackArrive.QryPack(departinvoicesno: string);
var
  i: integer;
  departinvoicesid: int64;
  departinvoicesids, msg: string;
begin
  if (packarrivernolist.IndexOf(departinvoicesno) = -1) then
  begin
    // tbtnFilterClick(nil);
    with jcdsResult do
    begin
      if (not jcdsResult.Active) or (jcdsResult.RecordCount = 0) or
        (not jcdsResult.Locate('packarriverno', departinvoicesno, []))
        then
      begin
        tbtnFilterClick(nil);
      end;
      if jcdsResult.RecordCount > 0 then
      begin
        if (FieldByName('status').AsString = '2') then
        begin
          with qrypackarrive do
          begin
            Active := false;
            Params.ParamValues['departinvoicesno'] := departinvoicesno;
            Params.ParamValues['tflag'] := 0;
            Execute;
            msg := Params.ParamValues['msg'];
            SysDialogs.ShowMessage(msg);
            NovaPackarriverno.SetFocus;
            NovaPackarriverno.clear;
            Exit;
          end;
        end
        else if (FieldByName('status').AsString = '1') then
        begin
          SysDialogs.ShowMessage('该结算单已经注销！');
          NovaPackarriverno.SetFocus;
          NovaPackarriverno.clear;
          Exit;
        end;
      end
      else
      begin
        SysDialogs.ShowMessage('该查询条件中不存在该结算单信息！');
        NovaPackarriverno.clear;
        NovaPackarriverno.SetFocus;
        Exit;
      end;
    end;
    if chkAutoAdd.Checked then
    begin
      if jcdsResult.Locate('packarriverno', departinvoicesno, []) then
      begin
        rightmove;
      end
      else
      begin
        SysDialogs.ShowMessage('该查询条件中不存在该结算单信息！');
        NovaPackarriverno.clear;
        NovaPackarriverno.SetFocus;
        Exit;
      end;
    end
    else
    begin
      if not jcdsResult.Locate('packarriverno', departinvoicesno, []) then
      begin
        SysDialogs.ShowMessage('该查询条件中不存在该结算单信息！');
        NovaPackarriverno.clear;
        NovaPackarriverno.SetFocus;
        Exit;
      end;
    end;
    NovaPackarriverno.clear;
    NovaPackarriverno.SetFocus;
  end
  else
  begin
    SysDialogs.ShowMessage('该结算单已经加入结算列表！');
    NovaPackarriverno.SetFocus;
    NovaPackarriverno.clear;
    Exit;
  end;
end;
procedure TFrmPackArrive.tbtnEditClick(Sender: TObject);
var
  packarriverid : Largeint;
  nResult : Integer;
  sResult,log : String;
begin
  inherited;
  
  with jcdsResult do
  begin
    if RecordCount=0 then
    Exit;
    packarriverid := FieldByName('id').AsLargeInt;
    Active := False;
    Params.ParamValues['packarriverid'] := IntToStr(packarriverid);
    Params.ParamValues['tflag'] := 0;
    Execute;
    //nResult := Params.ParamByName('flag').Value;
    sResult := Params.ParamByName('msg').Value;
    SysDialogs.ShowMessage(sResult);
    tbtnFilterClick(Sender);
  end;
end;

procedure TFrmPackArrive.tbtnFilterClick(Sender: TObject);
var
  inids: widestring;
begin
  inherited;
  with jcdsResult do
  begin
    DisableControls;
    Active := false;
    inids := '';
    with jcdsarrivebalances do
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
    Params.ParamValues['packarriverno'] := NovaPackarriverno.Text;
    Params.ParamValues['arriverdate'] := FormatDateTime('yyyy-mm-dd', NovaArriverStartdate.Date);
    Params.ParamValues['arriverenddate'] := FormatDateTime('yyyy-mm-dd', NovaArriverEnddate.Date+0.99999);
    Params.ParamValues['vehicleid'] := NovaHelpVehicle.Id;
    Params.ParamValues['status'] := NvPackbalanceStatus.GetSelectID;
    try
    Active := True;
    EnableControls;

    except
        on E: exception do
        begin
          SysLog.WriteErr('------->：' + E.Message);
        end;
    end;
  end;
end;

procedure TFrmPackArrive.tbtnInsertClick(Sender: TObject);
var s,i: integer;
x,y : Double;
begin
  inherited;
  if jcdsarrivebalances.RecordCount<=0 then
  Exit;
  try
  FrmPackArriveBalance := TFrmPackArriveBalance.Create(Self);
  with FrmPackArriveBalance do
  begin
        packbalancenum.Caption := IntToStr(jcdsarrivebalances.RecordCount);
        x := StrToFloat(dbgrdhResult.GetFooterValue(0,dbgrdhResult.FieldColumns['packfee']));
        y := StrToFloat(dbgrdhResult.GetFooterValue(0,dbgrdhResult.FieldColumns['servicefee']));
        packfee.Caption := FloatToStr(x+y);   //运费 = 运费+服务费
        packprice.Caption := dbgrdhResult.GetFooterValue(0,
                        dbgrdhResult.FieldColumns['packprice']); //货款
        pieces := StrToInt(dbgrdhResult.GetFooterValue(0,
                        dbgrdhResult.FieldColumns['pieces']));   //件数
    for s := 0 to packarriveridlist.Count-1 do
    begin
      FrmPackArriveBalance.ids := FrmPackArriveBalance.ids + IntToStr(packarriveridlist.Items[s])+',';
    end;
    for i := 0 to packarrivernolist.Count-1 do
    begin
      FrmPackArriveBalance.nos := FrmPackArriveBalance.nos + packarrivernolist.Items[i];
    end;
  end;

    if SysMainForm.showFormModal(FrmPackArriveBalance, false) = mrok then
      begin
        packarrivernolist.clear;
        packarriveridlist.Clear;
        jcdsarrivebalances.Close;
        jcdsResult.Close;
        tbtnFilterClick(Sender);
      end;
  finally
    FreeAndNil(FrmPackArriveBalance);
  end;
end;

procedure TFrmPackArrive.rightmove;
begin
  if not jcdsResult.Active then
    Exit;
  if self.jcdsResult.RecordCount <= 0 then
    Exit;
  if  (jcdsResult.FieldByName('packstatus').AsString <> '2') and
      (jcdsResult.FieldByName('packstatus').AsString <> '7') then
  begin
    SysDialogs.ShowMessage('单号:'+jcdsResult.FieldByName('packarriverno')
        .AsString + '未出库');
    Exit;
  end;
  if (jcdsResult.FieldByName('status').AsString = '1') then
  begin
    SysDialogs.ShowMessage('单号:'+jcdsResult.FieldByName('packarriverno')
        .AsString + '收讫单已经注销！');
    Exit;
  end;
  if (jcdsResult.FieldByName('status').AsString = '2') then
  begin
    SysDialogs.ShowMessage('单号:'+jcdsResult.FieldByName('packarriverno')
        .AsString + '收讫单已经结算！');
    Exit;
  end;
  invoicesid := jcdsResult.FieldByName('id').AsLargeInt;
  packarriverno := jcdsResult.FieldByName('packarriverno').AsString;
  if packarrivernolist.IndexOf(packarriverno) = -1 then
  begin

    with jcdsResult do
    begin
      routename := FieldByName('routename').AsString;
      pieces := FieldByName('pieces').AsLargeInt;
      packfee := FieldByName('packfee').AsFloat;
      packprice := FieldByName('packprice').AsFloat;
      balancemoney := FieldByName('balancemoney').AsFloat;
      servicefee := FieldByName('servicefee').AsFloat;
      balanceby:= FieldByName('balanceby').AsString;
      balancetime:= FieldByName('balancetime').AsString;
      status :=  FieldByName('status').AsString;
      packstatus := FieldByName('packstatus').AsString;
    end;


    if jcdsarrivebalances.Active then
    begin
      jcdsarrivebalances.Edit;
      jcdsarrivebalances.AppendRecord([packarriverno,routename,packfee,packprice,pieces,
        servicefee,invoicesid,balancemoney,status,balancetime,balanceby,packstatus]);
    end
    else
    begin
      try
      jcdsarrivebalances.CreateDataSet;
      jcdsarrivebalances.AppendRecord([packarriverno,routename,packfee,packprice,pieces,
        servicefee,invoicesid,balancemoney,status,balancetime,balanceby,packstatus]);
      except
        on E: exception do
        begin
          SysLog.WriteErr('结算数据失败：' + E.Message);
        end;
      end;
    end;
    packarriveridlist.Add(invoicesid);
    packarrivernolist.Add(packarriverno);
    jcdsResult.Edit;
    jcdsResult.Delete;
  end
  else
  begin
    jcdsResult.Next;
  end;
end;

procedure TFrmPackArrive.leftmove;
var
  isexist: boolean;
begin
  if not jcdsarrivebalances.Active then
    Exit;
  if self.jcdsarrivebalances.RecordCount = 0 then
    Exit;
  invoicesid := jcdsarrivebalances.FieldByName('id').AsLargeInt;
  packarriverno := jcdsarrivebalances.FieldByName('packarriverno').AsString;
  if packarrivernolist.IndexOf(packarriverno) >= 0 then
  begin
    isexist := false;
    with jcdsarrivebalances do
    begin
      routename := FieldByName('routename').AsString;
      pieces := FieldByName('pieces').AsLargeInt;
      packfee := FieldByName('packfee').AsFloat;
      packprice := FieldByName('packprice').AsFloat;
      balancemoney := FieldByName('balancemoney').AsFloat;
      servicefee := FieldByName('servicefee').AsFloat;
      balanceby:= FieldByName('balanceby').AsString;
      balancetime:= FieldByName('balancetime').AsString;
      status :=  FieldByName('status').AsString;
      packstatus := FieldByName('packstatus').AsString;
    end;
    if jcdsResult.Active then
    begin
        jcdsResult.Edit;
        jcdsResult.AppendRecord([packarriverno,routename,packfee,packprice,pieces,
        servicefee,invoicesid,balancemoney,status,balancetime,balanceby,packstatus]);
    end
    else
    begin
      jcdsResult.CreateDataSet;
      jcdsResult.AppendRecord([packarriverno,routename,packfee,packprice,pieces,
        servicefee,invoicesid,balancemoney,status,balancetime,balanceby,packstatus]);
    end;
    packarriveridlist.Remove(invoicesid);
    packarrivernolist.Remove(packarriverno);
    jcdsarrivebalances.Edit;
    jcdsarrivebalances.Delete;
  end
  else
  begin
    jcdsarrivebalances.Next;
  end;
end;
procedure TFrmPackArrive.MenuItem1Click(Sender: TObject);
begin
  inherited;
  leftmove;
end;

end.
