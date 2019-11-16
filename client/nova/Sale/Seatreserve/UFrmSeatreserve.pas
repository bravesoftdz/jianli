unit UFrmSeatreserve;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, USimpleCRUDForm, DBGridEhGrouping, NvPrnDbgeh, DB, DBClient,
  jsonClientDataSet, ImgList, GridsEh, DBGridEh, NvDbgridEh, StdCtrls, ComCtrls,
  ToolWin, ExtCtrls, NovaEdit, NovaHelp, UFrmSeatreserveEdit, NovaComboBox;

type
  TFrmSeatreserve = class(TSimpleCRUDForm)
    lbldate: TLabel;
    lbl1: TLabel;
    dtpstartdate: TDateTimePicker;
    dtpenddate: TDateTimePicker;
    lblschedule: TLabel;
    nvhlpschedule: TNovaHelp;
    lbl5: TLabel;
    nvhlpstation: TNovaHelp;
    lbl2: TLabel;
    lbl3: TLabel;
    nvhlpreserve: TNovaHelp;
    nvhlpticketoutlet: TNovaHelp;
    jcdsResultCancel: TjsonClientDataSet;
    jcdsResultstatus: TjsonClientDataSet;
    jcdsResultcustomtype: TjsonClientDataSet;
    lrgntfldResultid: TLargeintField;
    wdstrngfldResultorgname: TWideStringField;
    wdstrngfldResultticketoutletname: TWideStringField;
    wdstrngfldResultroutename: TWideStringField;
    wdstrngfldResultschedulecode: TWideStringField;
    wdstrngfldResultreachstationname: TWideStringField;
    wdstrngfldResultdeparttime: TWideStringField;
    wdstrngfldResultseatno: TWideStringField;
    wdstrngfldResultsellstate: TWideStringField;
    wdstrngfldResulttickettypename: TWideStringField;
    wdstrngfldResultfullprice: TWideStringField;
    wdstrngfldResultserviceprice: TWideStringField;
    wdstrngfldResultreservename: TWideStringField;
    wdstrngfldResultcustomername: TWideStringField;
    wdstrngfldResultcertificatetype: TWideStringField;
    wdstrngfldResultcertificateno: TWideStringField;
    wdstrngfldResultfamilyphone: TWideStringField;
    wdstrngfldResultmobilephone: TWideStringField;
    wdstrngfldResultcreatename: TWideStringField;
    wdstrngfldResultupdatename: TWideStringField;
    lrgntfldResultcustomerid: TLargeintField;
    lrgntfldResultscheduleplanid: TLargeintField;
    wdstrngfldResultsellstatename: TWideStringField;
    wdstrngfldResultcertiticatetypename: TWideStringField;
    dtmfldResultdepartdate: TDateTimeField;
    dtmfldResultautocanceltime: TDateTimeField;
    dtmfldResultcanceltime: TDateTimeField;
    dtmfldResultcreatetime: TDateTimeField;
    dtmfldResultupdatetime: TDateTimeField;
    dtmfldResultreservetime: TDateTimeField;
    lbl4: TLabel;
    cbbstatus: TNovaComboBox;
    Label1: TLabel;
    cbbcustomtype: TNovaComboBox;
    lbl6: TLabel;
    edtcertificateno: TNovaEdit;
    blnfldResultisautocancel: TBooleanField;
    procedure tbtnFilterClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure tbtnEditClick(Sender: TObject);
    procedure tbtnDeleteClick(Sender: TObject);
    procedure tbtnInsertClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
    maxqryday:integer;
    function getdeparttime: TDateTime;
  public
    { Public declarations }
  end;

var
  FrmSeatreserve: TFrmSeatreserve;

implementation

uses Services,PubFn, DateUtils;
{$R *.dfm}

procedure TFrmSeatreserve.FormCreate(Sender: TObject);
begin
  inherited;
  dtpstartdate.DateTime := Now();
  dtpenddate.DateTime := Now();
  cbbstatus.Active := False;
  cbbstatus.Active := True;

  cbbcustomtype.Active := False;
  cbbcustomtype.Active := True;
end;

procedure TFrmSeatreserve.tbtnDeleteClick(Sender: TObject);
var nResult : LongWord;
    sResult : string;
    nowdate : TDateTime;
begin
  inherited;
  if not dsResult.DataSet.Active then
    exit;
  if dsResult.DataSet.RecordCount < 1 then
    exit;
  if jcdsResult.FieldByName('sellstatename').AsString <> '留票' then
  begin
    SysDialogs.ShowMessage('该座位号已不是留票状态，不能取消！');
    Exit;
  end;
  if not SysDialogs.Confirm('信息提示', '确认取消这个留位!') then
    exit;
    nowdate := Date;
  if jcdsResult.FieldByName('departdate').AsDateTime < nowdate then
  begin
    SysDialogs.ShowMessage('对不起，该座位票对应的班次已经过了发车时间，不能取消。');
    Exit;
  end
  else if jcdsResult.FieldByName('departtime').AsDateTime = nowdate then
  begin
    if jcdsResult.FieldByName('departtime').AsDateTime < getdeparttime then
      SysDialogs.ShowMessage('对不起，该座位票对应的班次已经过了发车时间，不能取消。');
    Exit;
  end;

  with jcdsResultCancel do
  try
    close;
    Params.ParamByName('seatreserve.id').Value :=jcdsResult.FieldByName('id').AsString;
    Params.ParamByName('seatreserve.seatno').Value :=jcdsResult.FieldByName('seatno').AsString;
    Params.ParamByName('seatreserve.scheduleplanid').Value :=jcdsResult.FieldByName('scheduleplanid').AsString;
    Execute;
    nResult := Params.ParamByName('flag').Value;
    sResult := Params.ParamByName('msg').Value;
    SysDialogs.ShowMessage(sResult);
    if (nResult = 1) then
    begin
      tbtnFilterClick(Sender);
    end;
  except
    on E: Exception do
    begin
      SysLog.WriteErr('订票留位取消失败：' + E.Message);
    end;
  end;
end;

procedure TFrmSeatreserve.tbtnEditClick(Sender: TObject);
begin
  inherited;
  with FrmSeatreserveEdit do
  begin
    FrmSeatreserveEdit := TFrmSeatreserveEdit.Create(Self);
    caption := '取消留位';
    sign := true;


    ShowModal;
    if ModalResult = mrok then
    begin
      tbtnFilterClick(Sender);
    end;
  end;
end;

procedure TFrmSeatreserve.tbtnFilterClick(Sender: TObject);
begin
  inherited;
  if trunc(dtpenddate.Date-dtpstartdate.Date)>maxqryday   then
  begin
      SysDialogs.Warning('选择日期的天数差超过系统设置的最大可查询天数,请重新选择');
      exit;
  end;
  with jcdsResult do
  begin
    Active := False;
      Params.ParamValues['filter_GED_t!departdate'] := FormatDateTime('yyyy-mm-dd',dtpstartdate.DateTime);
      Params.ParamValues['filter_LED_t!departdate'] := FormatDateTime('yyyy-mm-dd',dtpenddate.DateTime);
      if Trim(nvhlpschedule.Text) = '' then
      begin
        Params.ParamValues['filter_EQL_sc!id'] := '';
      end else
      begin
        Params.ParamValues['filter_EQL_sc!id'] := nvhlpschedule.Id;
      end;
      if Trim(nvhlpstation.Text) = '' then
      begin
        Params.ParamValues['filter_EQL_sn!id'] := '';
      end else
      begin
        Params.ParamValues['filter_EQL_sn!id'] := nvhlpstation.Id;
      end;
      if Trim(nvhlpreserve.Text) = '' then
      begin
        Params.ParamValues['filter_EQL_t!reserveby'] := '';
      end else
      begin
        Params.ParamValues['filter_EQL_t!reserveby'] := nvhlpreserve.Id;
      end;
      if Trim(nvhlpticketoutlet.Text) = '' then
      begin
        Params.ParamValues['filter_EQL_ti!id'] := '';
      end else
      begin
        Params.ParamValues['filter_EQL_ti!id'] := nvhlpticketoutlet.Id;
      end;
      if Trim(cbbstatus.Text) = '' then
      begin
        Params.ParamValues['filter_EQS_t!sellstate'] := '';
      end else
      begin
        Params.ParamValues['filter_EQS_t!sellstate'] := cbbstatus.GetSelectCode;
      end;
      if Trim(cbbcustomtype.Text) = '' then
      begin
        Params.ParamValues['filter_EQS_c!certificatetype'] := '';
      end else
      begin
        Params.ParamValues['filter_EQS_c!certificatetype'] := cbbcustomtype.GetSelectCode;
      end;
      if Trim(edtcertificateno.Text) = '' then
        Params.ParamValues['filter_LIKES_c!certificateno'] := ''
      else
        Params.ParamValues['filter_LIKES_c!certificateno'] := edtcertificateno.Text;
    Active := True;
  end;
end;

procedure TFrmSeatreserve.tbtnInsertClick(Sender: TObject);
begin
  inherited;
  if jcdsResult.FieldByName('status').AsString='S' then
  begin
    SysDialogs.ShowMessage('对不起，该座位号已经售出去了！请重新选择');
    Exit;
  end;
  if jcdsResult.FieldByName('sellstate').AsString='C' then
  begin
    SysDialogs.ShowMessage('对不起，该留位座位号已经取消了！请重新选择');
    Exit;
  end;
  with FrmSeatreserveEdit do
  begin
    FrmSeatreserveEdit := TFrmSeatreserveEdit.Create(Self);
    caption := '留位售出';
    sign := true;
    id := jcdsResult.FieldByName('id').AsString;
    edtorg.Text := jcdsResult.FieldByName('orgname').AsString;
    edtticketoutlets.Text := jcdsResult.FieldByName('ticketoutletname').AsString;
    edtroute.Text := jcdsResult.FieldByName('routename').AsString;
    edtschedule.Text := jcdsResult.FieldByName('schedulecode').AsString;
    edtdepartdate.Text := jcdsResult.FieldByName('departdate').AsString;
    edtdeparttime.Text := jcdsResult.FieldByName('departtime').AsString;
    edtreachstation.Text := jcdsResult.FieldByName('reachstationname').AsString;
    edtsellstatus.Text := jcdsResult.FieldByName('statusname').AsString;
    edtseatno.Text := jcdsResult.FieldByName('seatno').AsString;
    edtfull.Text := jcdsResult.FieldByName('fullprice').AsString;
    cbbtickettype.Text := jcdsResult.FieldByName('tickettypename').AsString;

    ShowModal;
    if ModalResult = mrok then
    begin
      tbtnFilterClick(Sender);
    end;
  end;
end;

procedure TFrmSeatreserve.FormShow(Sender: TObject);
begin
  inherited;
  maxqryday:=strtoint(getParametervalue('0007', Sysinfo.LoginUserInfo.OrgID));
end;

function TFrmSeatreserve.getdeparttime: TDateTime;
var nowtime : string;
begin
  nowtime := FormatDateTime('hh:mm',Time);
 // Result:= Trunc(nowtime);
  result:= IncHour(result,StrToInt(Copy(nowtime,1,2)));
  result:= IncMinute(result,StrToInt(Copy(nowtime,4,2)));end;

end.
