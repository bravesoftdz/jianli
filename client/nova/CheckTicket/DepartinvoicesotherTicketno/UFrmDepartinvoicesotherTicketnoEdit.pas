unit UFrmDepartinvoicesotherTicketnoEdit;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, USimpleEditForm, ImgList, StdCtrls, Buttons, ExtCtrls,
  DBGridEhGrouping, GridsEh, DBGridEh, NvDbgridEh, NovaEdit, NovaHelp, ComCtrls,
  NovaHComboBox, DB, Services, DBClient, jsonClientDataSet, ToolWin,Generics.Collections,UDMPublic,
  Menus;

type
  TFrmDepartinvoicesotherTicketnoEdit = class(TSimpleEditForm)
    lblOrgid: TLabel;
    nvhcbbOrg: TNovaHComboBox;
    lbl6: TLabel;
    dtpdepartdate: TDateTimePicker;
    lbl2: TLabel;
    nvhlpvehicle: TNovaHelp;
    Label19: TLabel;
    lbl1: TLabel;
    edtDepartinvoicesno: TNovaEdit;
    lbl8: TLabel;
    Label17: TLabel;
    Label3: TLabel;
    Label1: TLabel;
    nvhlpreachstation: TNovaHelp;
    Label15: TLabel;
    nvhlpseller: TNovaHelp;
    GroupBox2: TGroupBox;
    ticketpriceinfo: TNvDbgridEh;
    Label20: TLabel;
    Label2: TLabel;
    edtTicketno: TNovaEdit;
    jcsdQryRoutePrice: TjsonClientDataSet;
    grp1: TGroupBox;
    nvdbgrdhdbgrdh1: TNvDbgridEh;
    mmo: TMemo;
    tlb1: TToolBar;
    btnInsertDep: TToolButton;
    btnUpdateDep: TToolButton;
    btn1: TToolButton;
    btndelDep: TToolButton;
    ToolButton1: TToolButton;
    jcdsQrydepartinvoicesotherdetail: TjsonClientDataSet;
    jsonDelDepartinvoicesotherdetail: TjsonClientDataSet;
    jcdsResultSavedepartinvoicesother: TjsonClientDataSet;
    jsonQryTickets: TjsonClientDataSet;
    dsticketResult: TDataSource;
    dsdepartinvoicesotherdetail: TDataSource;
    jsonQryTicket: TjsonClientDataSet;
    jsonQryTicketsticketno: TWideStringField;
    jsonQryTicketticketno: TWideStringField;
    jsonQryTicketsdeparttime: TWideStringField;
    jsonQryTicketdeparttime: TWideStringField;
    jsonQryTicketsdepartstationid: TLargeintField;
    jsonQryTicketsseatno: TIntegerField;
    jsonQryTicketseatno: TIntegerField;
    jsonQryTicketstationservicefee: TFloatField;
    jsonQryTicketprice: TFloatField;
    jsonQryTicketdepartstationid: TLargeintField;
    jsonQryTicketsstationservicefee: TFloatField;
    jsonQryTicketsprice: TFloatField;
    jsnclntcheckinvoiceno: TjsonClientDataSet;
    ToolBar1: TToolBar;
    ToolButton5: TToolButton;
    jsonQryTicketid: TLargeintField;
    jsonQryTicketdepartinvoicesotherid: TLargeintField;
    jsonQryTicketsdepartinvoicesotherid: TLargeintField;
    jsonQryTicketsischecked: TBooleanField;
    jsonQryTicketischecked: TBooleanField;
    jsonQryTicketsid: TLargeintField;
    jsonQryTicketisselect: TBooleanField;
    jsonQryTicketsisselect: TBooleanField;
    pm1: TPopupMenu;
    N1: TMenuItem;
    N2: TMenuItem;
    N3: TMenuItem;
    nvhlpschedule: TNovaHelp;
    procedure FormCreate(Sender: TObject);
    procedure dtpdepartdateChange(Sender: TObject);
    procedure btnUpdateDepClick(Sender: TObject);
    procedure btndelDepClick(Sender: TObject);
    procedure btnInsertDepClick(Sender: TObject);
    procedure edtTicketnoKeyPress(Sender: TObject; var Key: Char);
    procedure edtDepartinvoicesnoExit(Sender: TObject);
    procedure ToolButton5Click(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure nvdbgrdhdbgrdh1DblClick(Sender: TObject);
    procedure nvdbgrdhdbgrdh1CellClick(Column: TColumnEh);
    procedure jsonQryTicketsisselectChange(Sender: TField);
    procedure N1Click(Sender: TObject);
    procedure N2Click(Sender: TObject);
    procedure N3Click(Sender: TObject);
    procedure nvhlpscheduleIdChange(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure FormKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure FormDeactivate(Sender: TObject);
    procedure edtTicketnoChange(Sender: TObject);
  private
    { Private declarations }
    price: Double;
    ticketno: string;
    seatno: int64;
    departtime: string;
    stationservicefee: Double;
    departstationid: int64;
    ticketselllist : TList<int64>;
    selfActiveWhenKeydown:boolean;
    selfKeydowned:boolean;
    ticketsellnolist: TStringList;
  public
    { Public declarations }
    // id: largeint;
    departinvoicesotherid, departinvoicesotherdetailid, scheduleid,reachstationid: int64;
    departdate, departno, vehicleno: string;
  end;

var
  FrmDepartinvoicesotherTicketnoEdit: TFrmDepartinvoicesotherTicketnoEdit;

implementation

{$R *.dfm}

procedure TFrmDepartinvoicesotherTicketnoEdit.btndelDepClick(Sender: TObject);
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
        SysLog.WriteLog('检票管理->结算单补录(票号)', '删除补录明细', log);
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
        SysLog.WriteErr('结算单补录(票号)明细信息删除失败：' + E.Message);
      end;
    end;

end;

procedure TFrmDepartinvoicesotherTicketnoEdit.btnInsertDepClick
  (Sender: TObject);
var
  nResult: Integer;
  balanceunitid: int64;
  sResult, log,ticketsellids, optype: string;
begin
  inherited;
  if Trim(edtDepartinvoicesno.Text) = '' then
  begin
    SysDialogs.Warning('请输入单号');
    edtDepartinvoicesno.SetFocus;
    exit;
  end;
  if nvhlpvehicle.id = 0 then
  begin
    SysDialogs.Warning('请输入车牌号！');
    nvhlpvehicle.SetFocus;
    exit;
  end;

  if (Trim(nvhlpschedule.Text) = '') or (nvhlpschedule.id = 0) then
  begin
    SysDialogs.Warning('请输入班次号');
    nvhlpschedule.SetFocus;
    exit;
  end;
  // 汇总车票信息：
  if not dsticketResult.DataSet.Active then
    exit;
  if dsticketResult.DataSet.RecordCount < 1 then
    begin
    SysDialogs.showmessage('请添加要补录车票!');
    exit;
    end;
  with jsonQryTickets do
  begin
    try
      DisableControls;
      first;
      while not eof do
      begin
        ticketsellids := ticketsellids + jsonQryTickets.fieldbyname('id').AsString + ',';
        next;
      end;
    finally
      EnableControls;
    end;
  end;
  if ticketsellids = '' then
  begin
    SysDialogs.showmessage('请添加要补录车票!');
    exit;
  end;
  // if Trim(edtTicketno.Text) = '' then
  // begin
  // SysDialogs.Warning('请输入票号');
  // edtTicketno.SetFocus;
  // exit;
  // end;
  if Trim(nvhlpschedule.Text) = '' then
  begin
    scheduleid := 0;
  end
  else
  begin
    scheduleid := nvhlpschedule.id;
  end;
  with jcdsResultSavedepartinvoicesother do
  begin
    close;
    if (nvhlpseller.Text <> '') and (nvhlpseller.id > 0) then
    begin
      Params.ParamValues['departinvoicesother.seller'] := nvhlpseller.id;
    end
    else
    begin
      Params.ParamValues['departinvoicesother.seller'] := -1;
      // 售票员如果为空，存为-1，避免不填时存为0异站用户
    end;
    Params.ParamValues['ticketsellids'] := ticketsellids;
    Params.ParamValues['departinvoicesother.id'] := departinvoicesotherid;
    Params.ParamValues['departinvoicesother.departinvoicesotherdetailid'] := departinvoicesotherdetailid;
    Params.ParamValues['departinvoicesother.orgid'] := nvhcbbOrg.HelpFieldValue
      ['id'];

    Params.ParamValues['departinvoicesother.vehicleid'] := nvhlpvehicle.id;
//    Params.ParamValues['departinvoicesother.departstationid'] :=
//      jcsdQryRoutePrice.fieldbyname('departstationid').AsString;
    Params.ParamValues['departinvoicesother.departinvoicesno'] :=
      edtDepartinvoicesno.Text;
    Params.ParamValues['departinvoicesother.departdate'] := DateTimeToStr
      (dtpdepartdate.DateTime);
    Params.ParamValues['departinvoicesother.selfdepartdate'] := DateTimeToStr
      (dtpdepartdate.DateTime);
//    Params.ParamValues['departinvoicesother.departtime'] :=
//      jsonQryTickets.fieldbyname('departtime').AsString;
    // Params.ParamValues['departinvoicesother.balanceprice'] := nvedtbalanceprice.Text;
    // Params.ParamValues['departinvoicesother.othterfee'] := NovaEdtOtherFee.Text;

    Params.ParamValues['departinvoicesother.reachstationid'] := nvhlpreachstation.Id;
//    Params.ParamValues['departinvoicesother.departstationid'] :=
//      jcsdQryRoutePrice.fieldbyname('fromstationid').AsString;
    Params.ParamValues['departinvoicesother.schedule.id'] := scheduleid;
//    Params.ParamValues['departinvoicesother.departinvoicesotherdetailid'] := jcdsQrydepartinvoicesotherdetail.FieldByName('id').AsLargeInt;
    Params.ParamValues['departinvoicesother.ticketnum'] :=
    ticketpriceinfo.GetFooterValue(0, ticketpriceinfo.Columns[3]);
    // Params.ParamValues['departinvoicesother.agentfee'] := NovaEagentfee.Text;
    // Params.ParamValues['departinvoicesother.balancemoney'] :=
    // NovaEbalancemoney.Text;
    Params.ParamValues['departinvoicesother.othterfee'] :=
      ticketpriceinfo.GetFooterValue(0, ticketpriceinfo.Columns[6]);
    Params.ParamValues['departinvoicesother.totalmoney'] :=
      ticketpriceinfo.GetFooterValue(0, ticketpriceinfo.Columns[4]);
    Params.ParamValues['departinvoicesother.price'] :=
      ticketpriceinfo.GetFooterValue(0, ticketpriceinfo.Columns[4]);
    try
      Execute;
      nResult := Params.ParamByName('flag').Value;
      sResult := Params.ParamByName('msg').Value;
      departinvoicesotherid := Params.ParamByName('id').Value;
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
          // if dtpdepartdate <> DateTimeToStr(dtpdepartdate.DateTime) then
          // log := log + ',[发车日期] 由 ' + departdate + '改成' + DateTimeToStr
          // (dtpdepartdate.DateTime);
          // if vehicleno <> nvhlpvehicle.Text then
          // log := log + ',[车牌] 由 ' + vehicleno + ' 改成 ' + nvhlpvehicle.Text;
          // if departno <> edtDepartinvoicesno.Text then
          // log := log + ',[运单号] 由 ' + departno + ' 改成 ' +
          // edtDepartinvoicesno.Text;

        end;

//        departinvoicesotherid := Params.ParamByName('id').Value;
      end;
    except
      on E: Exception do
      begin
        SysLog.WriteErr('结算单补录(票号)添加失败：' + E.Message);
      end;
    end;
  end;
  // NovaEagentfee.Text := '0';
  // NvEdtTicketnum.Text := '0';
  // NovaEstationfee.Text := '0';
  // nvedtbalanceprice.Text := '0';
  // NovaEbalancemoney.Text := '0';
  // edttotalmoney.Text := '0';
  // NovaEdtOtherFee.Text:='0';
  // nvhlpreachstation.Text := '';
  departinvoicesotherdetailid := 0;
  with jcdsQrydepartinvoicesotherdetail do
  begin
    Active := false;
    Params.ParamValues['filter_EQL_t!departinvoicesotherid'] := departinvoicesotherid;
    Active := True;
  end;
  with jsonQryTickets do
  begin
    Active := false;
    Params.ParamValues['ticketno'] := 0;
    Active := True;
  end;
  ticketsellnolist.Clear;
  edtTicketno.SetFocus;
end;

procedure TFrmDepartinvoicesotherTicketnoEdit.btnUpdateDepClick
  (Sender: TObject);
begin
  inherited;
  departinvoicesotherid := 0;
  departinvoicesotherdetailid := 0;
  nvhlpschedule.Text := '';
  nvhlpvehicle.Text := '';
  edtDepartinvoicesno.Text := '';
  edtTicketno.Text := '';
  nvhlpreachstation.Text := '';
  nvhlpseller.Text := '';
  ticketsellnolist.Clear;
  with jsonQryTickets do
  begin
    Active := false;
    Params.ParamValues['ticketno'] := 0;
    Active := True;
  end;

  with jcdsQrydepartinvoicesotherdetail do
  begin
    Active := false;
    Params.ParamValues['filter_EQL_t!departinvoicesotherid'] := 0;
    Active := True;
  end;
  edtDepartinvoicesno.SetFocus;
end;

procedure TFrmDepartinvoicesotherTicketnoEdit.dtpdepartdateChange
  (Sender: TObject);
begin
  inherited;
  nvhlpschedule.Params.ParamValues['departdate'] := FormatDateTime
    ('yyyy-mm-dd', dtpdepartdate.Date);
end;

procedure TFrmDepartinvoicesotherTicketnoEdit.edtDepartinvoicesnoExit
  (Sender: TObject);
var
  nResult: string;
begin
  inherited;
  if (edtDepartinvoicesno.Text <> '') and (departinvoicesotherid = 0) then
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
      end;
    end;
  end;
end;

procedure TFrmDepartinvoicesotherTicketnoEdit.edtTicketnoChange(
  Sender: TObject);
var
  ticketlength: integer;
  choose : Int64;
  id : Largeint;
  ischeck : boolean;
  ticketno : string;
begin
  inherited;
  ticketlength := SysInfo.curBillLength.Items['Ticket'];
//  if edtTicketno.Text = '' then
//      exit;
  ticketno := Trim(edtTicketno.Text);
  if (edtTicketno.Text = '') or (Length(Trim(edtTicketno.Text)) <> ticketlength) then
      exit;
  //判断车票是否已经存在于右侧列表中
  if ticketsellnolist.IndexOf(ticketno) = -1 then
    begin
      ticketsellnolist.Add(ticketno);
    end
  else
  begin
     SysDialogs.showmessage('该车票已经录入【待补录车票明细】车票中,请重新输入:' + edtTicketno.Text);
     edtTicketno.Text := '';
     exit;
  end;
  with jsonQryTicket do
    begin
      Active := false;
//      Params.ParamValues['filter_EQS_t!ticketno'] := Trim(edtTicketno.Text);
//      Params.ParamValues['filter_EQB_t!ischecked'] := False;
      Params.ParamValues['ticketno'] := Trim(edtTicketno.Text);
      Active := True;
      if jsonQryTicket.RecordCount = 0 then
      begin
         SysDialogs.showmessage('车票无效，请重新输入:' + edtTicketno.Text);
         edtTicketno.Text := '';
         exit;
      end
      else
      begin
        ischeck := fieldbyname('ischecked').AsBoolean;
        if (ischeck) then
          begin
            SysDialogs.showmessage('此车票已检，不能补录:' + edtTicketno.Text);
            edtTicketno.Text := '';
            exit;
          end;
         if (fieldbyname('departinvoicesotherid').AsLargeInt <> -1) then
         begin
            SysDialogs.showmessage('此车票已补录，不能重复补录:' + edtTicketno.Text);
            edtTicketno.Text := '';
            exit;
         end;
      end;
      ticketno := fieldbyname('ticketno').AsString;
      seatno := fieldbyname('seatno').AsInteger;
      price := fieldbyname('price').AsFloat;
      departtime := fieldbyname('departtime').AsString;
      stationservicefee := fieldbyname('stationservicefee').AsFloat;
      departstationid := fieldbyname('departstationid').AsLargeInt;
      choose := 0;
      id := fieldbyname('id').AsLargeInt;
      if jsonQryTickets.Active then
      begin
        jsonQryTickets.Edit;
        jsonQryTickets.AppendRecord([id,choose,ticketno, seatno, price, departtime,
          stationservicefee, departstationid]);
      end
      else
      begin
        try
          jsonQryTickets.CreateDataSet;
          jsonQryTickets.AppendRecord([id,choose,ticketno, seatno, price, departtime,
            stationservicefee,departstationid]);
        except
          on E: Exception do
          begin
            SysDialogs.showmessage('赋值失败：' + E.Message);
          end;
        end;
      end;
      edtTicketno.Text := '';
      jsonQryTicket.Edit;
    end;
end;

procedure TFrmDepartinvoicesotherTicketnoEdit.edtTicketnoKeyPress
  (Sender: TObject; var Key: Char);
  var
    choose : Int64;
    id : Largeint;
    ischeck : boolean;
begin
  inherited;
//  if Key = #13 then
//  begin
//    if edtTicketno.Text = '' then
//      exit;
//    with jsonQryTicket do
//    begin
//      Active := false;
////      Params.ParamValues['filter_EQS_t!ticketno'] := Trim(edtTicketno.Text);
////      Params.ParamValues['filter_EQB_t!ischecked'] := False;
//      Params.ParamValues['ticketno'] := Trim(edtTicketno.Text);
//      Active := True;
//      if jsonQryTicket.RecordCount = 0 then
//      begin
//         SysDialogs.showmessage('车票无效，请重新输入:' + edtTicketno.Text);
//         edtTicketno.Text := '';
//         exit;
//      end
//      else
//      begin
//        ischeck := fieldbyname('ischecked').AsBoolean;
//        if (ischeck) then
//          begin
//            SysDialogs.showmessage('此车票已检，不能补录:' + edtTicketno.Text);
//            edtTicketno.Text := '';
//            exit;
//          end;
//         if (fieldbyname('departinvoicesotherid').AsLargeInt <> -1) then
//         begin
//            SysDialogs.showmessage('此车票已补录，不能重复补录:' + edtTicketno.Text);
//            edtTicketno.Text := '';
//            exit;
//         end;
//      end;
//      ticketno := fieldbyname('ticketno').AsString;
//      seatno := fieldbyname('seatno').AsInteger;
//      price := fieldbyname('price').AsFloat;
//      departtime := fieldbyname('departtime').AsString;
//      stationservicefee := fieldbyname('stationservicefee').AsFloat;
//      departstationid := fieldbyname('departstationid').AsLargeInt;
//      choose := 0;
//      id := fieldbyname('id').AsLargeInt;
//      if jsonQryTickets.Active then
//      begin
//        jsonQryTickets.Edit;
//        jsonQryTickets.AppendRecord([id,choose,ticketno, seatno, price, departtime,
//          stationservicefee, departstationid]);
//      end
//      else
//      begin
//        try
//          jsonQryTickets.CreateDataSet;
//          jsonQryTickets.AppendRecord([id,choose,ticketno, seatno, price, departtime,
//            stationservicefee,departstationid]);
//        except
//          on E: Exception do
//          begin
//            SysDialogs.showmessage('赋值失败：' + E.Message);
//          end;
//        end;
//      end;
//      edtTicketno.Text := '';
//      jsonQryTicket.Edit;
//      // jsonQryTicket.Delete;
//      // if jsonQryTicket.RecordCount = 0 then
//      // jcdsQryDeductDetail.Close;
//      // end
//      // else
//      // begin
//      // jsonQryTicket.Next;
//      // end;
//    end;
//  nvhlpschedule.SetFocus;
//  end;
end;

procedure TFrmDepartinvoicesotherTicketnoEdit.FormCreate(Sender: TObject);
begin
  inherited;
  selfActiveWhenKeydown:=false;
  selfKeydowned:=false;
  dtpdepartdate.DateTime := now();
  nvhcbbOrg.Active := false;
  nvhcbbOrg.Active := True;
  nvhcbbOrg.SetItemIndexByField('id', SysInfo.LoginUserInfo.orgid);
  nvhlpschedule.Params.ParamValues['departdate'] := FormatDateTime
    ('yyyy-mm-dd', dtpdepartdate.Date);
  edtDepartinvoicesno.SetFocus;
//  ticketselllist:= TList<Int64>.Create;
//  ticketsellnolist := TStringList.Create;
end;

procedure TFrmDepartinvoicesotherTicketnoEdit.FormDeactivate(Sender: TObject);
begin
  inherited;
  selfActiveWhenKeydown:=false;
  selfKeydowned:=false;
end;

procedure TFrmDepartinvoicesotherTicketnoEdit.FormKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  inherited;
   // selfActiveWhenKeydown:=self.Active;
 // selfKeydowned:=true;
end;

procedure TFrmDepartinvoicesotherTicketnoEdit.FormKeyUp(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  inherited;
{if not selfActiveWhenKeydown then
  begin
    selfKeydowned:=false;
    exit;
  end;
  if not selfKeydowned then  exit;
  selfActiveWhenKeydown:=false;
  selfKeydowned:=false;
  if key=vk_return then
  begin
    if (GetParentForm(self).ActiveControl is Tcombobox) then
      if (GetParentForm(self).ActiveControl as Tcombobox).Style in [csDropDownList,
          csOwnerDrawFixed,csOwnerDrawVariable] then
         key:=0;
      if (GetParentForm(self).ActiveControl is TDBGridEH) then
      begin
        if (GetParentForm(self).ActiveControl as TDBGridEH).DataSource.DataSet.Active
          and (not (GetParentForm(self).ActiveControl as TDBGridEH).DataSource.DataSet.Eof)  then
        begin
         (GetParentForm(self).ActiveControl as TDBGridEH).DataSource.DataSet.Next;
         exit;
        end;
      end;
    selectnext(GetParentForm(self).ActiveControl,true,true);
  end;
  if key=vk_escape then
  begin
    if (GetParentForm(self).ActiveControl is Tcombobox) then
      if (GetParentForm(self).ActiveControl as Tcombobox).Style in [csDropDownList,
         csOwnerDrawFixed,csOwnerDrawVariable] then
         key:=0;
    selectnext(GetParentForm(self).ActiveControl,false,true);
   end;}
end;

procedure TFrmDepartinvoicesotherTicketnoEdit.FormShow(Sender: TObject);
begin
  inherited;
//  ticketpriceinfo.GridUser := Sysinfo.LoginUserInfo.UserID;
ticketselllist := TList<Int64>.Create;
ticketsellnolist := TStringList.Create;
end;

procedure TFrmDepartinvoicesotherTicketnoEdit.jsonQryTicketsisselectChange(
  Sender: TField);
  var
    ticketsellid : Largeint;
  begin
  inherited;
//  ticketsellid := jsonQryTickets.FieldByName('id').AsLargeInt;
//  if jsonQryTickets.FieldByName('isselect').AsBoolean then
//  begin
//    if ticketselllist.IndexOf(ticketsellid) = -1 then
//    begin
//      ticketselllist.Add(ticketsellid);
//    end;
//  end
//  else
//  begin
//    if ticketselllist.IndexOf(ticketsellid) >= 0 then
//    begin
//      ticketselllist.Remove(ticketsellid);
//    end;
//  end;
end;



procedure TFrmDepartinvoicesotherTicketnoEdit.nvdbgrdhdbgrdh1CellClick(
  Column: TColumnEh);
begin
  inherited;
//  edtDepartinvoicesno.ReadOnly := true;
  if not jcdsQrydepartinvoicesotherdetail.Active then
    exit;
  if jcdsQrydepartinvoicesotherdetail.RecordCount <= 0 then
    exit;
    departinvoicesotherdetailid := jcdsQrydepartinvoicesotherdetail.fieldbyname('id').AsLargeInt;
//    edtDepartinvoicesno.Text := jcdsQrydepartinvoicesotherdetail.fieldbyname('departinvoicesno').AsString;
//    departinvoicesotherid := jcdsQrydepartinvoicesotherdetail.fieldbyname('id').AsLargeint;
    nvhlpvehicle.OnIdChange := nil; // 先关闭车牌控件的onidchange事件
    nvhlpvehicle.id := jcdsQrydepartinvoicesotherdetail.fieldbyname('vehicleid').AsInteger;
    nvhlpvehicle.OnIdChange := nvhlpvehicle.OnIdChange; // 打开车牌控件的onidchange事件

    nvhlpvehicle.Text := jcdsQrydepartinvoicesotherdetail.fieldbyname('vehicleno').AsString;
//    nvhlpvehicle.readOnly := true;
    nvhlpreachstation.Text := jcdsQrydepartinvoicesotherdetail.fieldbyname('reachstationname').AsString;
    nvhlpreachstation.readOnly := true;
    reachstationid := jcdsQrydepartinvoicesotherdetail.fieldbyname('reachstationid').AsInteger;
    dtpdepartdate.DateTime := jcdsQrydepartinvoicesotherdetail.fieldbyname('departdate').AsDateTime;
    nvhlpschedule.Text := jcdsQrydepartinvoicesotherdetail.fieldbyname('schedulename').AsString;
    nvhlpschedule.id := jcdsQrydepartinvoicesotherdetail.fieldbyname('scheduleid').AsInteger;
    nvhlpseller.id := jcdsQrydepartinvoicesotherdetail.fieldbyname('seller').AsLargeInt;
    nvhlpseller.Text := jcdsQrydepartinvoicesotherdetail.fieldbyname('sellername').AsString;

  with jsonQryTickets do
  begin
   try
    Active := false;
    Params.ParamValues['departinvoicesotherid'] := jcdsQrydepartinvoicesotherdetail.fieldbyname('id').AsLargeint;
    Active := True;
    except
      on E: Exception do
      begin
        SysDialogs.showmessage('赋值失败：' + E.Message);
      end;
    end;
  end;

end;

procedure TFrmDepartinvoicesotherTicketnoEdit.nvdbgrdhdbgrdh1DblClick(
  Sender: TObject);
begin
  inherited;
if not jcdsQrydepartinvoicesotherdetail.Active then
    exit;
  if jcdsQrydepartinvoicesotherdetail.RecordCount <= 0 then
    exit;
  // Chbisoriginator.Checked:= jcdsQrydepartinvoicesotherdetail.FieldByName('isoriginator').AsBoolean;
  departinvoicesotherdetailid := jcdsQrydepartinvoicesotherdetail.fieldbyname('id').AsLargeInt;
  departstationid := jcdsQrydepartinvoicesotherdetail.fieldbyname
    ('fromstationid').AsLargeInt;
  nvhlpreachstation.id := jcdsQrydepartinvoicesotherdetail.fieldbyname
    ('reachstationid').AsLargeInt;
  nvhlpreachstation.Text := jcdsQrydepartinvoicesotherdetail.fieldbyname
    ('reachstationname').AsString;
  nvhlpseller.Id := jcdsQrydepartinvoicesotherdetail.fieldbyname('seller').AsLargeInt;
  nvhlpseller.Text := jcdsQrydepartinvoicesotherdetail.fieldbyname('sellername').AsString;
end;

procedure TFrmDepartinvoicesotherTicketnoEdit.nvhlpscheduleIdChange
  (Sender: TObject);
var
  id: largeint;
begin
  inherited;
  if (Trim(nvhlpschedule.Text) <> '') and (nvhlpschedule.id > 0) then
  begin
    if not nvhlpschedule.isactive then
      exit;
//    with jcsdQryRoutePrice do
//    begin
//      Active := false;
//      Params.ParamValues['routeid'] := nvhlpschedule.HelpFieldValue['routeid'];
//      Params.ParamValues['scheduleid'] := nvhlpschedule.id;
//      Params.ParamValues['departdate'] := DateTimeToStr(dtpdepartdate.DateTime);
//      Active := True;
      nvhlpreachstation.id := nvhlpschedule.HelpFieldValue['stationid'];
      nvhlpreachstation.Text := nvhlpschedule.HelpFieldValue['endstationname'];;
      reachstationid := nvhlpschedule.HelpFieldValue['stationid'];
//    end;
  end;
  // nvhlpvehicle.OnIdChange := nvhlpvehicleIdChange;
end;

procedure TFrmDepartinvoicesotherTicketnoEdit.ToolButton5Click(Sender: TObject);
var
  nResult: LongWord;
  sResult, ids: string;
begin
  inherited;
  // 删除车票信息：
  if not dsticketResult.DataSet.Active then
    exit;
  if dsticketResult.DataSet.RecordCount < 1 then
    exit;
//  SysDialogs.showmessage(inttostr(jsonQryTickets.RecordCount));
  with jsonQryTickets do
  begin
    try
      DisableControls;
      first;
      while not eof do
      begin
//        first;
//        if ticketselllist.indexof(jsonQryTickets.fieldbyname('id').AsLargeInt) >=0 then
      if jsonQryTickets.fieldbyname('isselect').AsBoolean then
        begin
          ids := ids + jsonQryTickets.fieldbyname('id').AsString + ',';
          jsonQryTickets.Edit;
          jsonQryTickets.Delete;
        end
        else
        begin
          next;
        end;
//        next;
      end;
    finally
      EnableControls;
    end;
  end;
  if ids = '' then
  begin
    SysDialogs.showmessage('请勾选要移除的车票');
    exit;
  end;

//  if not SysDialogs.Confirm('信息提示', '确认要移除所有选择的车票吗!') then
//    exit;
  // with jcdsResultDelDepartinvoicesother do
  // try
  // close;
  // Params.ParamByName('departinvoiceotherid_del').value := ids;
  //
  // Execute;
  // nResult := Params.ParamByName('flag').value;
  // sResult := Params.ParamByName('msg').value;
  // SysDialogs.ShowMessage(sResult);
  // if (nResult = 1) then
  // begin
  // tbtnFilterClick(Sender);
  // end;
  // except
  // on E: Exception do
  // begin
  // SysLog.WriteErr('结算单补录信息删除失败：' + E.Message);
  // end;
  // end;
end;

procedure TFrmDepartinvoicesotherTicketnoEdit.N1Click(Sender: TObject);
begin
  inherited;
  with jsonQryTickets do
  begin
    if Active and (RecordCount > 0) then
    begin
      first;
      while (not eof) do
      begin
        edit;
        fieldbyname('isselect').value := true;
        next;
      end;
    end;
  end;
end;

procedure TFrmDepartinvoicesotherTicketnoEdit.N2Click(Sender: TObject);
begin
  inherited;
  with jsonQryTickets do
  begin
    if Active and (RecordCount > 0) then
    begin
      first;
      while (not eof) do
      begin
        edit;
        fieldbyname('isselect').value := not fieldbyname('isselect').AsBoolean;
        next;
      end;
    end;
  end;
end;

procedure TFrmDepartinvoicesotherTicketnoEdit.N3Click(Sender: TObject);
begin
  inherited;
  with jsonQryTickets do
  begin
    if Active and (RecordCount > 0) then
    begin
      first;
      while (not eof) do
      begin
        edit;
        fieldbyname('isselect').value := false;
        next;
      end;
    end;
  end;
end;

end.
