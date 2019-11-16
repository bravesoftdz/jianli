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
  //20160323��Զ�����--ѡ���µļ�¼ʱӦ���Զ���պ����ɹ���ʾ
  lblshow.Caption :='';

 { if jcdsResult.FieldByName('chargestatus').AsString='δ����' then
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
       //SysDialogs.ShowMessage('����Ʊ�Ų���Ϊ�գ������룡');
       lblshow.Caption:='����Ʊ�Ų���Ϊ�գ������룡';
       edtTicketNo.SetFocus;
       exit;
    end;
    lblshow.Font.Color := clRed;
     ticketlength := Sysinfo.curBillLength.Items['Ticket'] ;
     if length(trim(edtTicketNo.text)) > ticketlength then
    begin
      //�����ȡ�ĳ�Ʊ���ȴ���ϵͳƱ�ݳ��ȣ���Ӻ����ȡ������ϵͳ��Ʊ�ݳ���
      templen := length(trim(edtTicketNo.text)) - ticketlength;
      edtTicketNo.text := copy(edtTicketNo.text, templen+1,length(edtTicketNo.text));
    end
    else if length(trim(edtTicketNo.text)) = ticketlength then
    begin    //������Ȳ�������
    end
    else
    begin
      lblshow.Font.Color := clRed;
      lblshow.Caption := '�������Ʊ�ų��Ȳ��ԣ�';
      SysDialogs.ShowMessage('�������Ʊ�ų��Ȳ��ԣ�');
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
        lblshow.Caption := '��Ʊ�Ų���ѡ���������,���ܺ���';
        //SysDialogs.ShowMessage('��Ʊ�Ų���ѡ���������,���ܺ���!');
        edtTicketNo.SetFocus;
        exit;
      end;

      if jcdsResult.FieldByName('chargestatus').AsString = '�Ѻ���' then
      begin
        //SysDialogs.ShowMessage('��Ʊ�Ѿ�����!');
        lblshow.Caption := '��Ʊ�Ѿ�����';
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

        // �����ɹ�
        if Params.ParamValues['flag'] = '1' then
        begin
          lblshow.Font.Color := clHighlight;
          lblshow.Caption := Params.ParamValues['msg'];
          //SysDialogs.ShowMessage(Params.ParamValues['msg']);
          jcdsResult.edit;
          jcdsResult.FieldByName('chargestatus').AsString := '�Ѻ���';
          jcdsResult.FieldByName('chargetime').AsDateTime := Now;
          jcdsResult.FieldByName('chargername').AsString :=
            sysinfo.LoginUserInfo.UserName;
          edtTicketNo.Clear;
          edtTicketNo.SetFocus();
        end
        else // ����ʧ��
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
//      lblshow.Caption := '�������Ʊ�ų��Ȳ��ԣ�';
//      SysDialogs.ShowMessage('�������Ʊ�ų��Ȳ��ԣ�');
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
    SysDialogs.ShowMessage('��ѡ�������');
    exit;
  end;
  if dtpBselldate.Checked and (FormatDateTime('yyyymmdd',
      dtpBselldate.Date) > FormatDateTime('yyyymmdd', dtpEselldate.Date)) then
  begin
    SysDialogs.ShowMessage('��ʼ���ڲ��ܴ��ڽ������ڣ�');
    exit;
  end;
  if (StrToInt(getParametervalue('0006', sysinfo.LoginUserInfo.OrgID)) <= trunc
      (dtpEselldate.Date - dtpBselldate.Date)) then
  begin
    SysDialogs.Warning('ѡ�����ڵ��������ϵͳ���õ����ɲ�ѯ����(' + getParametervalue('0006',
        sysinfo.LoginUserInfo.OrgID) + '),������ѡ��');
    exit;
  end;
  with jcdsResult do
  begin
    Active := False;
    Params.ParamByName('orgid').Value := nvcbbOrgid.GetSelectID;
    log := '��Ʊ����:' + nvcbbOrgid.Text;
    Params.ParamValues['begindate'] := FormatDateTime('yyyy-mm-dd hh:mm:ss',
      dtpBselldate.DateTime) + ' 00:00:00';
    Params.ParamValues['enddate'] := FormatDateTime('yyyy-mm-dd hh:mm:ss',
      dtpEselldate.DateTime) + ' 23:59:59';
    log := log + ', ��Ʊ���ڴ�' + DateToStr(dtpBselldate.DateTime) + '��' + DateToStr
      (dtpEselldate.DateTime) + ', ';

    if (not(Trim(nvhlpUserid.Text) = '')) and (nvhlpUserid.Id >= 0) then // ��ƱԱ
    begin
      Params.ParamValues['userid'] := nvhlpUserid.HelpFieldValue['id'];
      log := log + ' ,��ƱԱ;' + nvhlpUserid.Text;
    end
    else
    begin
      Params.ParamValues['userid'] := '';
      // SysDialogs.ShowMessage('��������ƱԱ��');
    end;
    Active := True;

  end
end;

end.
