unit UFrmTicketsellprint;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, USimpleCRUDForm, DBGridEhGrouping, NvPrnDbgeh, DB, DBClient,
  jsonClientDataSet, ImgList, GridsEh, DBGridEh, NvDbgridEh, StdCtrls, ComCtrls,
  ToolWin, ExtCtrls,FunctionItemIntf,Services, NovaEdit, NovaHelp,
  NovaCheckedComboBox,PubFn;

type
  TFrmTicketsellprint = class(TSimpleCRUDForm)
    lbl1: TLabel;
    dtpstartdepartdate: TDateTimePicker;
    lbl2: TLabel;
    dtpenddepartdate: TDateTimePicker;
    lbl6: TLabel;
    edtticketno: TNovaEdit;
    grpticketno: TGroupBox;
    lblticketno: TLabel;
    Label1: TLabel;
    Label2: TLabel;
    lblleaveticketnum: TLabel;
    tmrleaveticketnum: TTimer;
    tmrRefreshBill: TTimer;
    CombPrintType: TComboBox;
    lbl3: TLabel;
    procedure tbtnFilterClick(Sender: TObject);
    procedure tbtnInsertClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure tmrRefreshBillTimer(Sender: TObject);
    procedure tmrleaveticketnumTimer(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure edtticketnoExit(Sender: TObject);
    procedure dbgrdhResultKeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
  private
    { Private declarations }
    ticketnumhituser: integer;
    procedure printticket(printtype:Integer);

    procedure refreshBill(silent: boolean = false);
    function initTicketNo(): boolean;
  public
    { Public declarations }
  end;

var
  FrmTicketsellprint: TFrmTicketsellprint;

implementation

{$R *.dfm}

procedure TFrmTicketsellprint.dbgrdhResultKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;
  if (Key=13) and (tbtnInsert.Visible) and (tbtnInsert.Enabled) then
  begin
     if CombPrintType.ItemIndex=1 then
       printticket(0)
     else
       printticket(1);
      key:=0;
  end;
end;

procedure TFrmTicketsellprint.edtticketnoExit(Sender: TObject);
begin
  inherited;
  if Trim(edtticketno.Text)='' then
  begin
     exit;
  end;
  tbtnFilterClick(nil);
end;

procedure TFrmTicketsellprint.FormActivate(Sender: TObject);
begin
  inherited;
  edtticketno.SetFocus;
end;

procedure TFrmTicketsellprint.FormCreate(Sender: TObject);
begin
  inherited;
  dtpstartdepartdate.DateTime := Now();
  dtpenddepartdate.DateTime := Now()+30;
  initTicketNo;
end;

procedure TFrmTicketsellprint.FormShow(Sender: TObject);
begin
  inherited;
  CombPrintType.ItemIndex:=0;
  edtticketno.SetFocus;
end;

function TFrmTicketsellprint.initTicketNo: boolean;
var
  functionParm: TFunctionItemParameters;
begin
  Result := SysInfo.LoginUserInfo.curBillNum.ContainsKey('Ticket') and
    (SysInfo.LoginUserInfo.curBillNum.Items['Ticket'] > 0);
  if not Result then
  begin
    functionParm := TFunctionItemParameters.Create;
    functionParm.CommaText := 'Ticket';
    SysFunctionMgr.exec(StringToGUID('{B2ECC99A-7644-452D-9CCB-982A7C81F51E}'),
      functionParm);
    Result := SysInfo.LoginUserInfo.curBillNum.ContainsKey('Ticket') and
      (SysInfo.LoginUserInfo.curBillNum.Items['Ticket'] > 0);
  end;
end;

procedure TFrmTicketsellprint.printticket(printtype: Integer);
var parameters : TFunctionItemParameters;
    isagent:string;
begin
  parameters:= TFunctionItemParameters.Create;

  if (jcdsResult.RecordCount < 1) then
  begin
    SysDialogs.ShowMessage('没有查到该车票，请输入正确的票号！');
    edtticketno.SetFocus;
    Exit; //没有查到车票
  end;

  if jcdsResult.FieldByName('schedulecode').AsString = '' then
  begin
    parameters.CommaText :=jcdsResult.FieldByName('id').AsString + ',true';
  end else
  begin
    parameters.CommaText :=jcdsResult.FieldByName('id').AsString + ',false';
  end;


  if printtype=0  then
  begin
    //添加当前票号参数
    if SysInfo.LoginUserInfo.curBillNo.ContainsKey('Ticket')
      and SysInfo.LoginUserInfo.curBillNum.ContainsKey('Ticket') then
    begin
      parameters.CommaText := parameters.CommaText + ','+ SysInfo.LoginUserInfo.curBillNo.Items['Ticket'];
    end
    else
    begin
       SysDialogs.Warning('票号没有初始化，不允许重打!');
       exit;
    end;
    if not SysDialogs.Ask('提示','确认要新票号重打车票吗？') then exit;
  end
  else
  begin
     if jcdsResult.FieldByName('sellname').AsString <> SysInfo.LoginUserInfo.UserName  then
      begin
       SysDialogs.Warning('不允许重打他人售出的车票！');
       Exit;
      end;

    if not SysDialogs.Ask('提示','确认要原票号重打车票吗？') then exit;
  end;


  SysFunctionMgr.exec(StringToGUID('{ECFCAF62-D9B1-42E8-A5F7-3395FCD94E0C}'), parameters);
end;

procedure TFrmTicketsellprint.refreshBill(silent: boolean);
begin
  if SysInfo.LoginUserInfo.curBillNo.ContainsKey('Ticket')
    and SysInfo.LoginUserInfo.curBillNum.ContainsKey('Ticket') then
  begin
    lblticketno.Caption := SysInfo.LoginUserInfo.curBillNo.Items['Ticket'];
    lblleaveticketnum.Caption := IntToStr
      (SysInfo.LoginUserInfo.curBillNum.Items['Ticket']);
    // 提示用户
    tmrleaveticketnum.Enabled :=
      (ticketnumhituser > SysInfo.LoginUserInfo.curBillNum.Items['Ticket']);
  end
  else
  begin
    tmrleaveticketnum.Enabled := false;
    if not silent then
      SysDialogs.Warning('车票没有初始化，不允许电子票取票！');
    lblticketno.Caption := '0';
    lblleaveticketnum.Caption := '0';
  end;
end;

procedure TFrmTicketsellprint.tbtnFilterClick(Sender: TObject);
var
   ticketno :string;
begin
  inherited;
  if Trunc(dtpenddepartdate.Date)<trunc(dtpstartdepartdate.Date) then
  begin
    SysDialogs.Warning('开始日期不能大于结束日期！');
    exit;
  end;
  if Trim(edtticketno.Text)='' then
  begin
     SysDialogs.Warning('请输入要打印的票号！');
     exit;
  end;
   ticketno:=Trim(edtticketno.Text);
//   重打车票：在后台进行补零操作
//   if Length(ticketno)<Length(SysInfo.LoginUserInfo.curBillNo.Items['Ticket']) then
//   begin
//     if ((SysInfo.LoginUserInfo.curBillNo.ContainsKey('Ticket'))
//     and (SysInfo.LoginUserInfo.curBillNum.Items['Ticket'] > 0)) then
//     begin
//         ticketno:=zerofill(ticketno,Length(SysInfo.LoginUserInfo.curBillNo.Items['Ticket']));
//     end;
//   end;

  {if Trunc(dtpenddepartdate.Date)-trunc(dtpstartdepartdate.Date)>7 then
  begin
    SysDialogs.Warning('发车日期段跨度不能超过7天!');
    exit;
  end;}
  with jcdsResult do
  begin
    Active := False;
      Params.ParamValues['filter_GED_t!departdate'] := FormatDateTime('yyyy-mm-dd',dtpstartdepartdate.Date);
      Params.ParamValues['filter_LED_t!departdate'] := FormatDateTime('yyyy-mm-dd',dtpenddepartdate.Date);
      if Trim(edtticketno.Text) = '' then
      begin
        Params.ParamValues['filter_EQS_t!ticketno'] := null;
      end else
      begin
        Params.ParamValues['filter_EQS_t!ticketno'] := ticketno;
      end;
     { if Trim(edtseatno.Text) = '' then
      begin
        Params.ParamValues['filter_EQR_t!seatno'] := null;
      end else
      begin
        Params.ParamValues['filter_EQR_t!seatno'] := edtseatno.Text;
      end;
      if Trim(nvhlpcode.Text) = '' then
      begin
        Params.ParamValues['filter_EQL_ve!id'] := null;
      end else
      begin
        Params.ParamValues['filter_EQL_ve!id'] := nvhlpcode.Id;
      end;
      if Trim(nvhlpschedule.Text) = '' then
      begin
        Params.ParamValues['filter_EQL_t!scheduleid'] := null;
      end else
      begin
        Params.ParamValues['filter_EQL_t!scheduleid'] := nvhlpschedule.Id;
      end;
      if Trim(nvhlpticket.Text) = '' then
      begin
        Params.ParamValues['filter_EQL_t!ticketoutletsid'] := null;
      end else
      begin
        Params.ParamValues['filter_EQL_t!ticketoutletsid'] := nvhlpticket.Id;
      end; }
    Active := True;
  end;
end;

procedure TFrmTicketsellprint.tbtnInsertClick(Sender: TObject);

begin
  inherited;
  if not dsResult.DataSet.Active then
    exit;
  if dsResult.DataSet.RecordCount < 1 then
    exit;
  if (Sender=tbtnEdit) then
       printticket(0)
  else
       printticket(1);
end;

procedure TFrmTicketsellprint.tmrleaveticketnumTimer(Sender: TObject);
begin
  inherited;
  Randomize;
  lblleaveticketnum.Font.Color := RGB(Random(256), Random(256), Random(256));
end;

procedure TFrmTicketsellprint.tmrRefreshBillTimer(Sender: TObject);
begin
  inherited;
  refreshBill(true);
end;

end.
