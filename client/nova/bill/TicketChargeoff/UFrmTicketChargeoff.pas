unit UFrmTicketChargeoff;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, USimpleCRUDForm, DBGridEhGrouping, NvPrnDbgeh, DB, DBClient,
  jsonClientDataSet, ImgList, GridsEh, DBGridEh, NvDbgridEh, StdCtrls, ComCtrls,
  ToolWin, ExtCtrls, NovaCheckedComboBox, NovaEdit, NovaHelp,Services,UDMPublic;

type
  TfrmTicketChargeoff = class(TSimpleCRUDForm)
    lbl1: TLabel;
    lbl7: TLabel;
    lbl2: TLabel;
    lbl3: TLabel;
    lbl4: TLabel;
    nvhlpUserid: TNovaHelp;
    dtpBselldate: TDateTimePicker;
    dtpEselldate: TDateTimePicker;
    nvcbbOrgid: TNovaCheckedComboBox;
    edtTicketNo: TNovaEdit;
    jcdsChargeoff: TjsonClientDataSet;
    lblshow: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure FormKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure FormShow(Sender: TObject);
    procedure tbtnFilterClick(Sender: TObject);
    procedure edtTicketNoKeyPress(Sender: TObject; var Key: Char);
    procedure tbtnEditClick(Sender: TObject);
    procedure jcdsResultAfterScroll(DataSet: TDataSet);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmTicketChargeoff: TfrmTicketChargeoff;

implementation
uses PubFn;
{$R *.dfm}

procedure TfrmTicketChargeoff.edtTicketNoKeyPress(Sender: TObject; var Key: Char);
begin
  inherited;
  if Key = #13 then
  begin
    Key:=#0;
    tbtnEditClick(sender);
  end;
end;

procedure TfrmTicketChargeoff.FormCreate(Sender: TObject);
begin
  inherited;
  dtpBselldate.Date := Now;
  dtpEselldate.Date := Now;
  nvcbbOrgid.Active := False;
  nvcbbOrgid.Active := True;
  nvcbbOrgid.CheckById(True, sysinfo.LoginUserInfo.OrgID);
//  edtTicketNo.MaxLength := sysinfo.curBillLength.Items['Ticket'];
end;

procedure TfrmTicketChargeoff.FormKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;
  if (Key = 13) or (Key = 27) then
    Key := 0;
end;

procedure TfrmTicketChargeoff.FormShow(Sender: TObject);
begin
  inherited;
  edtTicketNo.SetFocus;
end;

procedure TfrmTicketChargeoff.jcdsResultAfterScroll(DataSet: TDataSet);
begin
  inherited;
  if not jcdsResult.Active  then exit;
  if jcdsResult.RecordCount=0 then exit;
  //20160323王远媛添加--选择新的记录时应该自动清空核销成功提示
  lblshow.Caption :='';

 { if jcdsResult.FieldByName('chargestatus').AsString='未核销' then
  begin
    edtTicketNo.Text:=jcdsResult.FieldByName('ticketno').AsString;
  end
  else
  begin
     edtTicketNo.Clear;
  end; }
end;

procedure TfrmTicketChargeoff.tbtnEditClick(Sender: TObject);
var ticketlength,templen :Integer;
begin
  inherited;
  if not jcdsResult.active then
      exit;
    if jcdsResult.RecordCount = 0 then
      exit;
    if Trim(edtTicketNo.Text) = '' then
    begin
       //SysDialogs.ShowMessage('核销票号不能为空，请输入！');
       lblshow.Caption:='核销票号不能为空，请输入！';
       edtTicketNo.SetFocus;
       exit;
    end;
    lblshow.Font.Color := clRed;
     ticketlength := Sysinfo.curBillLength.Items['Ticket'] ;
     if length(trim(edtTicketNo.text)) > ticketlength then
    begin
      //如果获取的车票长度大于系统票据长度，则从后面截取到符合系统的票据长度
      templen := length(trim(edtTicketNo.text)) - ticketlength;
      edtTicketNo.text := copy(edtTicketNo.text, templen+1,length(edtTicketNo.text));
    end
    else if length(trim(edtTicketNo.text)) = ticketlength then
    begin    //长度相等不做处理
    end
    else
    begin
      lblshow.Font.Color := clRed;
      lblshow.Caption := '你输入的票号长度不对！';
      SysDialogs.ShowMessage('你输入的票号长度不对！');
      edtTicketNo.SetFocus;
      exit;
    end;

      if jcdsResult.Locate('ticketno', edtTicketNo.Text, []) then
      begin
        dbgrdhResult.SelectedRows.CurrentRowSelected := True;
      end
      else
      begin
        lblshow.Font.Color := clRed;
        lblshow.Caption := '该票号不在选择的日期内,不能核销';
        //SysDialogs.ShowMessage('该票号不在选择的日期内,不能核销!');
        edtTicketNo.SetFocus;
        exit;
      end;

      if jcdsResult.FieldByName('chargestatus').AsString = '已核销' then
      begin
        //SysDialogs.ShowMessage('该票已经核销!');
        lblshow.Caption := '该票已经核销';
        edtTicketNo.SetFocus;
        exit;
      end;
      edtTicketNo.SetFocus;
      with jcdsChargeoff do
      begin
        Active := False;
        Params.ParamByName('ticketchargeoff.sellerid').Value :=
          jcdsResult.FieldByName('userid').AsString;
        Params.ParamByName('ticketchargeoff.ticketno').Value :=
          jcdsResult.FieldByName('ticketno').AsString;
        Params.ParamByName('ticketchargeoff.retrievetime').Value :=
          jcdsResult.FieldByName('actiontime').AsString;
        Params.ParamByName('ticketchargeoff.tickettype').Value :=
          jcdsResult.FieldByName('tickettype').AsString;
        Params.ParamByName('ticketchargeoff.chargerby').Value :=
          sysinfo.LoginUserInfo.UserID;
        execute;

        // 核销成功
        if Params.ParamValues['flag'] = '1' then
        begin
          lblshow.Font.Color := clHighlight;
          lblshow.Caption := Params.ParamValues['msg'];
          //SysDialogs.ShowMessage(Params.ParamValues['msg']);
          jcdsResult.edit;
          jcdsResult.FieldByName('chargestatus').AsString := '已核销';
          jcdsResult.FieldByName('chargetime').AsDateTime := Now;
          jcdsResult.FieldByName('chargername').AsString :=
            sysinfo.LoginUserInfo.UserName;
          edtTicketNo.Clear;
          edtTicketNo.SetFocus();
        end
        else // 核销失败
        begin
          lblshow.Font.Color := clRed;
          lblshow.Caption := Params.ParamValues['msg'];
          //SysDialogs.ShowMessage(Params.ParamValues['msg']);
          edtTicketNo.SetFocus;
        end;
        edtTicketNo.SetFocus;

      end;
      edtTicketNo.SetFocus;
//    end
//    else
//    begin
//      lblshow.Font.Color := clRed;
//      lblshow.Caption := '你输入的票号长度不对！';
//      SysDialogs.ShowMessage('你输入的票号长度不对！');
//      edtTicketNo.SetFocus;
//      exit;
//    end;
end;

procedure TfrmTicketChargeoff.tbtnFilterClick(Sender: TObject);
var
    log: string;
begin
  inherited;
  if nvcbbOrgid.Text='' then
  begin
    SysDialogs.ShowMessage('请选择机构！');
    exit;
  end;
  if dtpBselldate.Checked and (FormatDateTime('yyyymmdd',
      dtpBselldate.Date) > FormatDateTime('yyyymmdd', dtpEselldate.Date)) then
  begin
    SysDialogs.ShowMessage('开始日期不能大于结束日期！');
    exit;
  end;
  if (StrToInt(getParametervalue('0006', sysinfo.LoginUserInfo.OrgID)) <= trunc
      (dtpEselldate.Date - dtpBselldate.Date)) then
  begin
    SysDialogs.Warning('选择日期的天数差超过系统设置的最大可查询天数(' + getParametervalue('0006',
        sysinfo.LoginUserInfo.OrgID) + '),请重新选择');
    exit;
  end;
  with jcdsResult do
  begin
    Active := False;
    Params.ParamByName('orgid').Value := nvcbbOrgid.GetSelectID;
    log := '售票机构:' + nvcbbOrgid.Text;
    Params.ParamValues['begindate'] := FormatDateTime('yyyy-mm-dd hh:mm:ss',
      dtpBselldate.DateTime) + ' 00:00:00';
    Params.ParamValues['enddate'] := FormatDateTime('yyyy-mm-dd hh:mm:ss',
      dtpEselldate.DateTime) + ' 23:59:59';
    log := log + ', 售票日期从' + DateToStr(dtpBselldate.DateTime) + '到' + DateToStr
      (dtpEselldate.DateTime) + ', ';

    if (not(Trim(nvhlpUserid.Text) = '')) and (nvhlpUserid.Id >= 0) then // 售票员
    begin
      Params.ParamValues['userid'] := nvhlpUserid.HelpFieldValue['id'];
      log := log + ' ,售票员;' + nvhlpUserid.Text;
    end
    else
    begin
      Params.ParamValues['userid'] := '';
      // SysDialogs.ShowMessage('请输入售票员！');
    end;
    Active := True;

  end
end;

end.
